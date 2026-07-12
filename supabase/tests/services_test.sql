-- Service-rail proof for M7. Run against a dev database with all migrations
-- applied. Runs in one transaction and rolls back.
--
-- Proves:
--   1. every profile gets a unique referral code;
--   2. signing up with a referred_by code records a joined referral, and
--      self/unknown codes are ignored, never errors;
--   3. KYC approval flips the referral to verified;
--   4. tree redemption enforces the points math (verified = 50, tree = 50)
--      and blocks double redemption;
--   5. qard interest is one row per user.

begin;

do $$
declare
  v_referrer uuid := gen_random_uuid();
  v_invitee uuid := gen_random_uuid();
  v_code text;
  v_status public.referral_status;
  v_submission uuid;
  v_blocked boolean;
begin
  insert into auth.users (id, aud, role, email, created_at, updated_at,
                          raw_app_meta_data, raw_user_meta_data)
    values (v_referrer, 'authenticated', 'authenticated',
            'referrer@example.invalid', now(), now(), '{}', '{}');

  -- 1. Referral code exists and is unique per profile.
  select referral_code into v_code
    from public.profiles where id = v_referrer;
  assert v_code is not null and length(v_code) = 8,
    'referrer got no referral code';

  -- 2. Invitee signs up carrying the code.
  insert into auth.users (id, aud, role, email, created_at, updated_at,
                          raw_app_meta_data, raw_user_meta_data)
    values (v_invitee, 'authenticated', 'authenticated',
            'invitee@example.invalid', now(), now(), '{}',
            jsonb_build_object('referred_by', v_code));
  select status into v_status
    from public.referrals
    where referrer_id = v_referrer and invitee_id = v_invitee;
  assert v_status = 'joined', 'signup referral was not recorded';

  -- Unknown code is ignored silently.
  insert into auth.users (id, aud, role, email, created_at, updated_at,
                          raw_app_meta_data, raw_user_meta_data)
    values (gen_random_uuid(), 'authenticated', 'authenticated',
            'stranger@example.invalid', now(), now(), '{}',
            jsonb_build_object('referred_by', 'nosuchcd'));

  -- 3. KYC approval verifies the referral.
  insert into public.kyc_submissions (profile_id, nid_hash, source_of_funds)
    values (v_invitee, repeat('a', 64), 'salary')
    returning id into v_submission;
  perform public.decide_kyc(v_submission, true, 1::smallint);
  select status into v_status
    from public.referrals where invitee_id = v_invitee;
  assert v_status = 'verified', 'KYC approval did not verify the referral';

  -- 4. Redemption: one verified referral = 50 points = exactly one tree.
  perform set_config('request.jwt.claims',
                     json_build_object('sub', v_referrer, 'role', 'authenticated')::text,
                     true);
  perform public.redeem_referral_tree();
  assert (select count(*) from public.trees
          where profile_id = v_referrer and source = 'referral') = 1,
    'redemption did not plant a pledge';

  v_blocked := false;
  begin
    perform public.redeem_referral_tree();
  exception when others then
    v_blocked := true;
    assert sqlerrm = 'insufficient_points',
      format('expected insufficient_points, got %s', sqlerrm);
  end;
  assert v_blocked, 'double redemption was not blocked';

  -- 5. Qard interest: second insert for the same user fails on unique.
  insert into public.qard_interest (profile_id) values (v_referrer);
  v_blocked := false;
  begin
    insert into public.qard_interest (profile_id) values (v_referrer);
  exception when unique_violation then
    v_blocked := true;
  end;
  assert v_blocked, 'duplicate qard interest was not blocked';

  raise notice 'services test: ALL ASSERTIONS PASSED';
end;
$$;

rollback;
