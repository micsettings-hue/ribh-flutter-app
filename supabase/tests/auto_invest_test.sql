-- Auto-invest consent rail proof for M6. Run against a dev database with all
-- migrations applied. Runs in one transaction and rolls back.
--
-- Proves:
--   1. propose_queue_items creates pending items for matching active rules
--      only, and never duplicates;
--   2. a pending item deploys nothing;
--   3. approval without both acks fails and deploys nothing;
--   4. approval with both acks writes investment + ledger + approved status
--      in one transaction (balance drops by the rule budget);
--   5. an approved item cannot be approved again;
--   6. declining moves no money.

begin;

do $$
declare
  v_user_id uuid := gen_random_uuid();
  v_wallet_id uuid;
  v_rule_id uuid;
  v_open_campaign uuid;
  v_item_id uuid;
  v_second_item uuid;
  v_balance bigint;
  v_count integer;
  v_blocked boolean;
begin
  insert into auth.users (id, aud, role, email, created_at, updated_at,
                          raw_app_meta_data, raw_user_meta_data)
    values (v_user_id, 'authenticated', 'authenticated',
            'auto-invest-test@example.invalid', now(), now(), '{}', '{}');
  select id into v_wallet_id
    from public.investor_wallets where profile_id = v_user_id;
  update public.profiles set kyc_tier = 1 where id = v_user_id;

  -- Fund the wallet with 200,000 poisha.
  perform public.record_deposit(v_user_id, 200000);

  -- One open short-tenure campaign and one open long-tenure campaign.
  insert into public.campaigns
      (title, contract, sector, pool, raised, profit_per_lac, share, tenure, risk, status)
    values ('Short Trade', 'murabaha', 'test', 100000000, 0, 1400000, 60, 6, 'moderate', 'open')
    returning id into v_open_campaign;
  insert into public.campaigns
      (title, contract, sector, pool, raised, profit_per_lac, share, tenure, risk, status)
    values ('Long Trade', 'musharakah', 'test', 100000000, 0, 1700000, 55, 12, 'elevated', 'open');

  -- Active short-strategy rule, budget 50,000 poisha.
  insert into public.auto_invest_rules (profile_id, strategy, budget, active)
    values (v_user_id, 'short', 50000, true)
    returning id into v_rule_id;

  -- 1. Proposal pass: only the tenure<=6 campaign matches 'short'.
  select public.propose_queue_items() into v_count;
  assert v_count = 1, format('expected 1 proposal, got %s', v_count);
  select public.propose_queue_items() into v_count;
  assert v_count = 0, 'proposal pass duplicated queue items';
  select id into v_item_id
    from public.auto_invest_queue where rule_id = v_rule_id;

  -- 2. Pending deploys nothing.
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 200000,
    format('pending queue item moved money: %s', v_balance);

  perform set_config('request.jwt.claims',
                     json_build_object('sub', v_user_id, 'role', 'authenticated')::text,
                     true);

  -- 3. Approval without both acks fails and deploys nothing.
  v_blocked := false;
  begin
    perform public.approve_queue_item(v_item_id, true, false);
  exception when others then
    v_blocked := true;
    assert sqlerrm = 'risk_acknowledgements_required',
      format('expected risk_acknowledgements_required, got %s', sqlerrm);
  end;
  assert v_blocked, 'approval without both acks was not blocked';
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 200000, 'failed approval moved money';

  -- 4. Approval with both acks: investment + ledger + status together.
  perform public.approve_queue_item(v_item_id, true, true);
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 150000,
    format('after approval: expected 150000, got %s', v_balance);
  assert (select status from public.auto_invest_queue where id = v_item_id)
    = 'approved', 'item not marked approved';
  assert (select count(*) from public.investments
          where profile_id = v_user_id and source = 'auto_invest') = 1,
    'approved deployment missing its investment row';

  -- 5. Approving again must fail.
  v_blocked := false;
  begin
    perform public.approve_queue_item(v_item_id, true, true);
  exception when others then
    v_blocked := true;
    assert sqlerrm = 'request_not_pending',
      format('expected request_not_pending, got %s', sqlerrm);
  end;
  assert v_blocked, 're-approval of a decided item was not blocked';

  -- 6. Declining moves no money. Widen the rule so the long campaign
  -- queues, then decline it.
  update public.auto_invest_rules set strategy = 'diversified'
    where id = v_rule_id;
  select public.propose_queue_items() into v_count;
  assert v_count = 1, format('expected 1 new proposal, got %s', v_count);
  select id into v_second_item
    from public.auto_invest_queue
    where rule_id = v_rule_id and status = 'pending';
  update public.auto_invest_queue set status = 'declined'
    where id = v_second_item;
  select balance into v_balance
    from public.wallet_balances where wallet_id = v_wallet_id;
  assert v_balance = 150000, 'declining moved money';

  raise notice 'auto-invest test: ALL ASSERTIONS PASSED';
end;
$$;

rollback;
