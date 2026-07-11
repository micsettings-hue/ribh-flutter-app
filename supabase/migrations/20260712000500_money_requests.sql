-- M3: the money rail's honest pending state.
--
-- Deposits and withdrawals are requests first. A request never touches the
-- ledger; only service_role confirmation (real payment confirmation for
-- deposits, an actually-sent transfer for withdrawals) writes the
-- wallet_transactions row. No fake success state exists, and no real public
-- money moves pre-registration because nothing confirms automatically.

create type public.money_request_kind as enum ('deposit', 'withdrawal');
create type public.payment_method as enum ('bkash', 'nagad', 'bank');
create type public.money_request_status as enum
  ('pending', 'confirmed', 'rejected', 'cancelled');

create table public.money_requests (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  kind public.money_request_kind not null,
  method public.payment_method not null,
  amount bigint not null check (amount > 0),
  -- Manual reference for bank-transfer reconciliation.
  reference text,
  status public.money_request_status not null default 'pending',
  -- The ledger row written at confirmation. Null until then.
  tx_id uuid references public.wallet_transactions (id),
  decided_at timestamptz,
  created_at timestamptz not null default now()
);

create index money_requests_profile_id_idx
  on public.money_requests (profile_id);

alter table public.money_requests enable row level security;

-- Read own requests. All writes go through the RPCs below; there is no
-- insert, update, or delete policy.
create policy money_requests_select_own on public.money_requests
  for select to authenticated using (profile_id = auth.uid());

-- Records a deposit request. Requires KYC (deposits only from the user's own
-- verified accounts); bank transfers carry a manual reference.
create function public.request_deposit(
  p_method public.payment_method,
  p_amount bigint,
  p_reference text default null
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := auth.uid();
  v_kyc smallint;
  v_request_id uuid;
begin
  if v_profile_id is null then
    raise exception 'not_authenticated' using errcode = 'P0001';
  end if;
  if p_amount is null or p_amount <= 0 then
    raise exception 'invalid_amount' using errcode = 'P0001';
  end if;
  select kyc_tier into v_kyc from public.profiles where id = v_profile_id;
  if v_kyc is null or v_kyc < 1 then
    raise exception 'not_verified' using errcode = 'P0001';
  end if;
  if p_method = 'bank' and coalesce(trim(p_reference), '') = '' then
    raise exception 'reference_required' using errcode = 'P0001';
  end if;

  insert into public.money_requests (profile_id, kind, method, amount, reference)
    values (v_profile_id, 'deposit', p_method, p_amount, nullif(trim(p_reference), ''))
    returning id into v_request_id;

  return v_request_id;
end;
$$;

grant execute on function public.request_deposit(public.payment_method, bigint, text)
  to authenticated;

-- Records a withdrawal request against the available balance. Available means
-- the derived ledger balance minus withdrawals already requested but not yet
-- decided, so pending requests cannot double-spend.
create function public.request_withdrawal(
  p_method public.payment_method,
  p_amount bigint
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := auth.uid();
  v_kyc smallint;
  v_wallet_id uuid;
  v_available bigint;
  v_request_id uuid;
begin
  if v_profile_id is null then
    raise exception 'not_authenticated' using errcode = 'P0001';
  end if;
  if p_amount is null or p_amount <= 0 then
    raise exception 'invalid_amount' using errcode = 'P0001';
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

  v_available := public.locked_balance(v_wallet_id)
    - coalesce((
        select sum(amount) from public.money_requests
        where profile_id = v_profile_id
          and kind = 'withdrawal' and status = 'pending'
      ), 0);
  if v_available < p_amount then
    raise exception 'insufficient_funds' using errcode = 'P0001';
  end if;

  insert into public.money_requests (profile_id, kind, method, amount)
    values (v_profile_id, 'withdrawal', p_method, p_amount)
    returning id into v_request_id;

  return v_request_id;
end;
$$;

grant execute on function public.request_withdrawal(public.payment_method, bigint)
  to authenticated;

-- A user may cancel their own request while it is still pending.
create function public.cancel_money_request(p_request_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_updated uuid;
begin
  if auth.uid() is null then
    raise exception 'not_authenticated' using errcode = 'P0001';
  end if;
  update public.money_requests
    set status = 'cancelled', decided_at = now()
    where id = p_request_id and profile_id = auth.uid() and status = 'pending'
    returning id into v_updated;
  if v_updated is null then
    raise exception 'request_not_pending' using errcode = 'P0001';
  end if;
end;
$$;

grant execute on function public.cancel_money_request(uuid) to authenticated;

-- Back-office decision, service_role only. Confirmation is the single point
-- where a request becomes money: it writes the ledger row (deposit credit or
-- payout debit) and the request in one transaction.
create function public.decide_money_request(
  p_request_id uuid,
  p_approve boolean
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_request public.money_requests%rowtype;
  v_wallet_id uuid;
  v_tx_id uuid;
begin
  select * into v_request
    from public.money_requests
    where id = p_request_id
    for update;
  if v_request.id is null or v_request.status <> 'pending' then
    raise exception 'request_not_pending' using errcode = 'P0001';
  end if;

  if not p_approve then
    update public.money_requests
      set status = 'rejected', decided_at = now()
      where id = p_request_id;
    return;
  end if;

  select id into v_wallet_id
    from public.investor_wallets where profile_id = v_request.profile_id;
  if v_wallet_id is null then
    raise exception 'wallet_not_found' using errcode = 'P0001';
  end if;

  if v_request.kind = 'deposit' then
    insert into public.wallet_transactions (wallet_id, kind, amount, ref_type, ref_id)
      values (v_wallet_id, 'deposit', v_request.amount, 'money_request', v_request.id)
      returning id into v_tx_id;
  else
    if public.locked_balance(v_wallet_id) < v_request.amount then
      raise exception 'insufficient_funds' using errcode = 'P0001';
    end if;
    insert into public.wallet_transactions (wallet_id, kind, amount, ref_type, ref_id)
      values (v_wallet_id, 'payout', v_request.amount, 'money_request', v_request.id)
      returning id into v_tx_id;
  end if;

  update public.money_requests
    set status = 'confirmed', tx_id = v_tx_id, decided_at = now()
    where id = p_request_id;
end;
$$;

revoke execute on function public.decide_money_request(uuid, boolean)
  from public, anon, authenticated;
grant execute on function public.decide_money_request(uuid, boolean)
  to service_role;
