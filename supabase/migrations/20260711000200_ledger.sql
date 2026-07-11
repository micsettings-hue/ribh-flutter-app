-- The ledger invariant. wallet_transactions is append-only and balance is
-- always derived: SELECT COALESCE(SUM(signed_amount), 0). No code path may
-- store a balance.

-- Sign convention: deposits, distributions, and recovery are positive;
-- investments, payouts, purification, sadaqah, zakat, and write_down are
-- negative. Mirrored by the Dart-side derivation in
-- lib/data/models/wallet_transaction.dart; keep them in lockstep.
create function public.ledger_signed_amount(p_kind public.tx_kind, p_amount bigint)
returns bigint
language sql
immutable
as $$
  select case p_kind
    when 'deposit' then p_amount
    when 'distribution' then p_amount
    when 'recovery' then p_amount
    else -p_amount
  end;
$$;

-- Append-only enforcement: any UPDATE or DELETE fails, for every role.
create function public.raise_append_only()
returns trigger
language plpgsql
as $$
begin
  raise exception 'wallet_transactions is append-only'
    using errcode = 'P0001';
end;
$$;

create trigger wallet_transactions_append_only
  before update or delete on public.wallet_transactions
  for each row execute function public.raise_append_only();

-- Belt and braces: no grants either.
revoke update, delete on public.wallet_transactions from anon, authenticated;

-- Derived balances. security_invoker so RLS on the underlying tables applies.
create view public.wallet_balances
with (security_invoker = true)
as
select
  w.id as wallet_id,
  w.profile_id,
  coalesce(sum(public.ledger_signed_amount(t.kind, t.amount)), 0) as balance
from public.investor_wallets w
left join public.wallet_transactions t on t.wallet_id = w.id
group by w.id, w.profile_id;

create function public.my_wallet_balance()
returns bigint
language sql
stable
security invoker
set search_path = public
as $$
  select coalesce(
    (select balance from public.wallet_balances where profile_id = auth.uid()),
    0
  );
$$;

grant execute on function public.my_wallet_balance() to authenticated;

-- Internal: locked balance read used by the money-moving RPCs. Serialises
-- concurrent spends from one wallet via FOR UPDATE on the wallet row.
create function public.locked_balance(p_wallet_id uuid)
returns bigint
language plpgsql
as $$
declare
  v_balance bigint;
begin
  perform 1 from public.investor_wallets where id = p_wallet_id for update;
  select coalesce(sum(public.ledger_signed_amount(kind, amount)), 0)
    into v_balance
    from public.wallet_transactions
    where wallet_id = p_wallet_id;
  return v_balance;
end;
$$;

-- Money-moving RPCs ----------------------------------------------------------
-- Every money-moving action writes its domain row and its ledger row inside
-- one function, therefore one transaction. The client never writes either
-- table directly.

-- Investment: the only client-reachable deployment path. Requires an
-- authenticated, KYC-verified user and both risk acknowledgements.
create function public.invest_in_campaign(
  p_campaign_id uuid,
  p_amount bigint,
  p_ack1 boolean,
  p_ack2 boolean,
  p_source text default 'wallet'
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := auth.uid();
  v_wallet_id uuid;
  v_kyc smallint;
  v_status public.campaign_status;
  v_pool bigint;
  v_raised bigint;
  v_balance bigint;
  v_investment_id uuid;
begin
  if v_profile_id is null then
    raise exception 'not_authenticated' using errcode = 'P0001';
  end if;
  if p_amount is null or p_amount <= 0 then
    raise exception 'invalid_amount' using errcode = 'P0001';
  end if;
  if not (coalesce(p_ack1, false) and coalesce(p_ack2, false)) then
    raise exception 'risk_acknowledgements_required' using errcode = 'P0001';
  end if;

  select kyc_tier into v_kyc from public.profiles where id = v_profile_id;
  if v_kyc is null or v_kyc < 1 then
    raise exception 'not_verified' using errcode = 'P0001';
  end if;

  select id into v_wallet_id
    from public.investor_wallets where profile_id = v_profile_id;
  if v_wallet_id is null then
    raise exception 'wallet_not_found' using errcode = 'P0001';
  end if;

  select status, pool, raised into v_status, v_pool, v_raised
    from public.campaigns where id = p_campaign_id for update;
  if v_status is null then
    raise exception 'campaign_not_found' using errcode = 'P0001';
  end if;
  if v_status <> 'open' then
    raise exception 'campaign_not_open' using errcode = 'P0001';
  end if;
  if v_raised + p_amount > v_pool then
    raise exception 'exceeds_pool' using errcode = 'P0001';
  end if;

  v_balance := public.locked_balance(v_wallet_id);
  if v_balance < p_amount then
    raise exception 'insufficient_funds' using errcode = 'P0001';
  end if;

  insert into public.investments
      (profile_id, campaign_id, amount, risk_ack_1, risk_ack_2, source)
    values (v_profile_id, p_campaign_id, p_amount, p_ack1, p_ack2, p_source)
    returning id into v_investment_id;

  insert into public.wallet_transactions (wallet_id, kind, amount, ref_type, ref_id)
    values (v_wallet_id, 'investment', p_amount, 'investment', v_investment_id);

  update public.campaigns
    set raised = raised + p_amount
    where id = p_campaign_id;

  return v_investment_id;
end;
$$;

grant execute on function public.invest_in_campaign(uuid, bigint, boolean, boolean, text)
  to authenticated;

-- Welfare giving (zakat or sadaqah). Full amount goes to the project:
-- Ribh takes no fee out of Zakat, structurally.
create function public.give_welfare(
  p_project_id uuid,
  p_kind public.welfare_kind,
  p_amount bigint
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := auth.uid();
  v_wallet_id uuid;
  v_balance bigint;
  v_contribution_id uuid;
begin
  if v_profile_id is null then
    raise exception 'not_authenticated' using errcode = 'P0001';
  end if;
  if p_amount is null or p_amount <= 0 then
    raise exception 'invalid_amount' using errcode = 'P0001';
  end if;
  if not exists (select 1 from public.welfare_projects where id = p_project_id) then
    raise exception 'project_not_found' using errcode = 'P0001';
  end if;

  select id into v_wallet_id
    from public.investor_wallets where profile_id = v_profile_id;
  if v_wallet_id is null then
    raise exception 'wallet_not_found' using errcode = 'P0001';
  end if;

  v_balance := public.locked_balance(v_wallet_id);
  if v_balance < p_amount then
    raise exception 'insufficient_funds' using errcode = 'P0001';
  end if;

  insert into public.welfare_contributions (profile_id, project_id, kind, amount)
    values (v_profile_id, p_project_id, p_kind, p_amount)
    returning id into v_contribution_id;

  insert into public.wallet_transactions (wallet_id, kind, amount, ref_type, ref_id)
    values (v_wallet_id, p_kind::text::public.tx_kind, p_amount,
            'welfare_contribution', v_contribution_id);

  update public.welfare_projects
    set raised = raised + p_amount
    where id = p_project_id;

  return v_contribution_id;
end;
$$;

grant execute on function public.give_welfare(uuid, public.welfare_kind, bigint)
  to authenticated;

-- Server-side rails. NOT callable by app users: deposits are credited only
-- after real payment confirmation (M3), distributions and payouts only by
-- back-office processes. Executable by service_role only.

create function public.record_deposit(
  p_profile_id uuid,
  p_amount bigint,
  p_ref_type text default 'payment',
  p_ref_id uuid default null
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_wallet_id uuid;
  v_tx_id uuid;
begin
  if p_amount is null or p_amount <= 0 then
    raise exception 'invalid_amount' using errcode = 'P0001';
  end if;
  select id into v_wallet_id
    from public.investor_wallets where profile_id = p_profile_id;
  if v_wallet_id is null then
    raise exception 'wallet_not_found' using errcode = 'P0001';
  end if;
  insert into public.wallet_transactions (wallet_id, kind, amount, ref_type, ref_id)
    values (v_wallet_id, 'deposit', p_amount, p_ref_type, p_ref_id)
    returning id into v_tx_id;
  return v_tx_id;
end;
$$;

create function public.record_distribution(
  p_campaign_id uuid,
  p_gross bigint,
  p_ribh_fee bigint
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_distribution_id uuid;
  v_investor_share bigint := p_gross - p_ribh_fee;
  v_total_invested bigint;
begin
  if p_gross is null or p_gross < 0 or p_ribh_fee is null
      or p_ribh_fee < 0 or v_investor_share < 0 then
    raise exception 'invalid_amount' using errcode = 'P0001';
  end if;

  insert into public.distributions (campaign_id, gross, ribh_fee, investor_share)
    values (p_campaign_id, p_gross, p_ribh_fee, v_investor_share)
    returning id into v_distribution_id;

  select coalesce(sum(amount), 0) into v_total_invested
    from public.investments where campaign_id = p_campaign_id;

  -- Pro-rata credit to every investor's ledger. Floor division; the
  -- remainder stays with the distribution record and is settled at maturity.
  insert into public.wallet_transactions (wallet_id, kind, amount, ref_type, ref_id)
    select w.id, 'distribution',
           (v_investor_share * i.total / v_total_invested),
           'distribution', v_distribution_id
    from (
      select profile_id, sum(amount) as total
      from public.investments
      where campaign_id = p_campaign_id
      group by profile_id
    ) i
    join public.investor_wallets w on w.profile_id = i.profile_id
    where v_total_invested > 0
      and (v_investor_share * i.total / v_total_invested) > 0;

  return v_distribution_id;
end;
$$;

create function public.record_payout(
  p_profile_id uuid,
  p_distribution_id uuid,
  p_route public.payout_route,
  p_amount bigint
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_wallet_id uuid;
  v_balance bigint;
  v_payout_id uuid;
begin
  if p_amount is null or p_amount <= 0 then
    raise exception 'invalid_amount' using errcode = 'P0001';
  end if;
  select id into v_wallet_id
    from public.investor_wallets where profile_id = p_profile_id;
  if v_wallet_id is null then
    raise exception 'wallet_not_found' using errcode = 'P0001';
  end if;
  v_balance := public.locked_balance(v_wallet_id);
  if v_balance < p_amount then
    raise exception 'insufficient_funds' using errcode = 'P0001';
  end if;

  insert into public.payouts (profile_id, distribution_id, route)
    values (p_profile_id, p_distribution_id, p_route)
    returning id into v_payout_id;

  insert into public.wallet_transactions (wallet_id, kind, amount, ref_type, ref_id)
    values (v_wallet_id, 'payout', p_amount, 'payout', v_payout_id);

  return v_payout_id;
end;
$$;

revoke execute on function public.record_deposit(uuid, bigint, text, uuid)
  from public, anon, authenticated;
revoke execute on function public.record_distribution(uuid, bigint, bigint)
  from public, anon, authenticated;
revoke execute on function public.record_payout(uuid, uuid, public.payout_route, bigint)
  from public, anon, authenticated;
grant execute on function public.record_deposit(uuid, bigint, text, uuid)
  to service_role;
grant execute on function public.record_distribution(uuid, bigint, bigint)
  to service_role;
grant execute on function public.record_payout(uuid, uuid, public.payout_route, bigint)
  to service_role;
