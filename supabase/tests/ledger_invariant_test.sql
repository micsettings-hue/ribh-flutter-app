-- Ledger invariant proof. Run against a dev database that has the migrations
-- applied (see supabase/README.md). Everything runs inside one transaction
-- and rolls back; the database is left unchanged.
--
-- Proves, as required by .claude/rules/data-model.md:
--   1. deposit -> invest -> distribution -> payout yields the arithmetically
--      correct derived balance at every step;
--   2. any attempt to UPDATE or DELETE a wallet transaction fails.

begin;

do $$
declare
  v_user_id uuid := gen_random_uuid();
  v_wallet_id uuid;
  v_campaign_id uuid;
  v_balance bigint;
  v_distribution_id uuid;
  v_tx_id uuid;
  v_blocked boolean;
begin
  -- Test user (auth trigger creates profile; profile trigger creates wallet).
  insert into auth.users (id, aud, role, email, created_at, updated_at,
                          raw_app_meta_data, raw_user_meta_data)
    values (v_user_id, 'authenticated', 'authenticated',
            'ledger-test@example.invalid', now(), now(), '{}', '{}');

  select id into v_wallet_id
    from public.investor_wallets where profile_id = v_user_id;
  assert v_wallet_id is not null, 'wallet was not auto-created for profile';

  -- KYC tier 1 so the invest RPC accepts the user.
  update public.profiles set kyc_tier = 1 where id = v_user_id;

  -- Open test campaign.
  insert into public.campaigns
      (contract, sector, pool, raised, profit_per_lac, share, tenure, risk, status)
    values ('murabaha', 'test', 100000000, 0, 1500000, 60.00, 6, 'moderate', 'open')
    returning id into v_campaign_id;

  -- Simulate the authenticated user for auth.uid().
  perform set_config('request.jwt.claims',
                     json_build_object('sub', v_user_id, 'role', 'authenticated')::text,
                     true);

  -- 1. Deposit 100,000 poisha.
  perform public.record_deposit(v_user_id, 100000);
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 100000,
    format('after deposit: expected 100000, got %s', v_balance);

  -- 2. Invest 40,000. Balance: 100000 - 40000 = 60000.
  perform public.invest_in_campaign(v_campaign_id, 40000, true, true, 'wallet');
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 60000,
    format('after investment: expected 60000, got %s', v_balance);

  -- Guard: an over-balance investment must fail with insufficient_funds.
  v_blocked := false;
  begin
    perform public.invest_in_campaign(v_campaign_id, 999999, true, true, 'wallet');
  exception when others then
    v_blocked := true;
    assert sqlerrm = 'insufficient_funds',
      format('expected insufficient_funds, got %s', sqlerrm);
  end;
  assert v_blocked, 'over-balance investment was not blocked';

  -- Guard: missing acknowledgements must fail.
  v_blocked := false;
  begin
    perform public.invest_in_campaign(v_campaign_id, 1000, true, false, 'wallet');
  exception when others then
    v_blocked := true;
    assert sqlerrm = 'risk_acknowledgements_required',
      format('expected risk_acknowledgements_required, got %s', sqlerrm);
  end;
  assert v_blocked, 'investment without both acknowledgements was not blocked';

  -- 3. Distribution: gross 10000, fee 2000, investor share 8000. This user is
  -- the only investor, so the full 8000 lands in their ledger.
  -- Balance: 60000 + 8000 = 68000.
  select public.record_distribution(v_campaign_id, 10000, 2000)
    into v_distribution_id;
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 68000,
    format('after distribution: expected 68000, got %s', v_balance);

  -- 4. Payout 3,000 to bank. Balance: 68000 - 3000 = 65000.
  perform public.record_payout(v_user_id, v_distribution_id, 'bank', 3000);
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 65000,
    format('after payout: expected 65000, got %s', v_balance);

  -- Cross-check the RPC agrees with the view.
  assert public.my_wallet_balance() = 65000,
    'my_wallet_balance() disagrees with wallet_balances view';

  -- 5. Append-only: UPDATE must fail.
  select id into v_tx_id
    from public.wallet_transactions where wallet_id = v_wallet_id limit 1;
  v_blocked := false;
  begin
    update public.wallet_transactions set amount = 1 where id = v_tx_id;
  exception when others then
    v_blocked := true;
  end;
  assert v_blocked, 'UPDATE on wallet_transactions was not blocked';

  -- 6. Append-only: DELETE must fail.
  v_blocked := false;
  begin
    delete from public.wallet_transactions where id = v_tx_id;
  exception when others then
    v_blocked := true;
  end;
  assert v_blocked, 'DELETE on wallet_transactions was not blocked';

  raise notice 'ledger invariant test: ALL ASSERTIONS PASSED';
end;
$$;

rollback;
