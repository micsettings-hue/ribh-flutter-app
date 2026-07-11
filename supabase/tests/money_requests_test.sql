-- Money-rail proof for M3. Run against a dev database with all migrations
-- applied (see supabase/README.md). Runs in one transaction and rolls back.
--
-- Proves:
--   1. a request alone never changes the derived balance (honest pending);
--   2. only confirmation writes the ledger row, and the balance then matches;
--   3. pending withdrawals reserve balance so requests cannot double-spend;
--   4. bank deposits require a reference; unverified users are refused;
--   5. cancel works only while pending.

begin;

do $$
declare
  v_user_id uuid := gen_random_uuid();
  v_wallet_id uuid;
  v_deposit_id uuid;
  v_withdrawal_id uuid;
  v_balance bigint;
  v_status public.money_request_status;
  v_tx_id uuid;
  v_blocked boolean;
begin
  insert into auth.users (id, aud, role, email, created_at, updated_at,
                          raw_app_meta_data, raw_user_meta_data)
    values (v_user_id, 'authenticated', 'authenticated',
            'money-rail-test@example.invalid', now(), now(), '{}', '{}');

  select id into v_wallet_id
    from public.investor_wallets where profile_id = v_user_id;

  perform set_config('request.jwt.claims',
                     json_build_object('sub', v_user_id, 'role', 'authenticated')::text,
                     true);

  -- Guard: no KYC, no deposit request.
  v_blocked := false;
  begin
    perform public.request_deposit('bkash', 50000);
  exception when others then
    v_blocked := true;
    assert sqlerrm = 'not_verified',
      format('expected not_verified, got %s', sqlerrm);
  end;
  assert v_blocked, 'unverified deposit request was not blocked';

  update public.profiles set kyc_tier = 1 where id = v_user_id;

  -- Guard: bank deposits need a manual reference.
  v_blocked := false;
  begin
    perform public.request_deposit('bank', 50000);
  exception when others then
    v_blocked := true;
    assert sqlerrm = 'reference_required',
      format('expected reference_required, got %s', sqlerrm);
  end;
  assert v_blocked, 'bank deposit without reference was not blocked';

  -- 1. A deposit request changes nothing on the ledger.
  select public.request_deposit('bkash', 100000) into v_deposit_id;
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 0,
    format('pending deposit leaked into balance: %s', v_balance);

  -- 2. Confirmation writes the ledger row; balance becomes 100000.
  perform public.decide_money_request(v_deposit_id, true);
  select status, tx_id into v_status, v_tx_id
    from public.money_requests where id = v_deposit_id;
  assert v_status = 'confirmed', 'deposit was not confirmed';
  assert v_tx_id is not null, 'confirmed deposit has no ledger row';
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 100000,
    format('after confirmed deposit: expected 100000, got %s', v_balance);

  -- 3. Withdrawal requests reserve balance while pending.
  select public.request_withdrawal('bank', 70000) into v_withdrawal_id;
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 100000,
    format('pending withdrawal leaked into balance: %s', v_balance);
  v_blocked := false;
  begin
    perform public.request_withdrawal('bank', 40000);
  exception when others then
    v_blocked := true;
    assert sqlerrm = 'insufficient_funds',
      format('expected insufficient_funds, got %s', sqlerrm);
  end;
  assert v_blocked, 'second withdrawal exceeding available was not blocked';

  -- Confirmation debits the ledger: 100000 - 70000 = 30000.
  perform public.decide_money_request(v_withdrawal_id, true);
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 30000,
    format('after confirmed withdrawal: expected 30000, got %s', v_balance);

  -- 4. Cancel works while pending, and only then.
  select public.request_withdrawal('bkash', 10000) into v_withdrawal_id;
  perform public.cancel_money_request(v_withdrawal_id);
  select status into v_status
    from public.money_requests where id = v_withdrawal_id;
  assert v_status = 'cancelled', 'pending withdrawal was not cancelled';
  v_blocked := false;
  begin
    perform public.cancel_money_request(v_deposit_id); -- already confirmed
  exception when others then
    v_blocked := true;
    assert sqlerrm = 'request_not_pending',
      format('expected request_not_pending, got %s', sqlerrm);
  end;
  assert v_blocked, 'cancel of a decided request was not blocked';

  -- 5. Rejection never touches the ledger.
  select public.request_deposit('nagad', 5000) into v_deposit_id;
  perform public.decide_money_request(v_deposit_id, false);
  select status, tx_id into v_status, v_tx_id
    from public.money_requests where id = v_deposit_id;
  assert v_status = 'rejected' and v_tx_id is null,
    'rejected request touched the ledger';
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 30000,
    format('after rejection: expected 30000, got %s', v_balance);

  raise notice 'money requests test: ALL ASSERTIONS PASSED';
end;
$$;

rollback;
