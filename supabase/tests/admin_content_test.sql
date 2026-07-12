-- Admin content rail proof for M10 Option A. Run against a dev database
-- with all migrations applied (supabase db reset). Runs in one transaction
-- and rolls back. Uses SET LOCAL ROLE authenticated so RLS actually
-- applies, per the M10 definition of done ("verified by an explicit test,
-- not assumed").
--
-- Proves:
--   1. an admin can create and update campaigns, welfare projects, news
--      items, and banner slides;
--   2. every such write produced a matching admin_audit_log row naming the
--      actor;
--   3. a non-admin user cannot write to any of the four tables;
--   4. a non-admin sees only published news; unpublished stays invisible;
--   5. the audit log is append-only and invisible to non-admins.

begin;

do $$
declare
  v_admin uuid := gen_random_uuid();
  v_user uuid := gen_random_uuid();
  v_campaign uuid;
  v_news uuid;
  v_slide uuid;
  v_count integer;
  v_blocked boolean;
begin
  insert into auth.users (id, aud, role, email, created_at, updated_at,
                          raw_app_meta_data, raw_user_meta_data)
    values (v_admin, 'authenticated', 'authenticated',
            'admin-test@example.invalid', now(), now(), '{}', '{}'),
           (v_user, 'authenticated', 'authenticated',
            'member-test@example.invalid', now(), now(), '{}', '{}');
  update public.profiles set role = 'admin' where id = v_admin;

  -- === As the admin ==========================================================
  perform set_config('request.jwt.claims',
                     json_build_object('sub', v_admin, 'role', 'authenticated')::text,
                     true);
  set local role authenticated;

  assert public.is_admin(), 'is_admin() false for an admin profile';

  -- 1. Creates and updates across all four tables.
  insert into public.campaigns
      (title, contract, sector, pool, raised, profit_per_lac, share, tenure, risk, status)
    values ('Admin Created', 'murabaha', 'test', 100000000, 0, 1400000, 60, 6, 'moderate', 'open')
    returning id into v_campaign;
  update public.campaigns set status = 'matured' where id = v_campaign;

  insert into public.welfare_projects (sector, title, district, target, raised)
    values ('water', 'Admin Well', 'Kurigram', 1000000, 0);

  insert into public.news_items (category, title, summary, published)
    values ('insight', 'Why we show you everything', 'Amanah means trust.', true)
    returning id into v_news;
  insert into public.news_items (category, title, published)
    values ('draft', 'Unpublished draft', false);

  insert into public.banner_slides (surface, title, subtitle, published)
    values ('home', 'Test slide', 'Board-gated copy', false)
    returning id into v_slide;
  update public.banner_slides set board_approved = true where id = v_slide;

  reset role;

  -- 2. Audit rows exist and name the actor.
  select count(*) into v_count from public.admin_audit_log
    where actor_id = v_admin and table_name = 'campaigns'
      and row_id = v_campaign;
  assert v_count = 2, -- insert + update
    format('expected 2 campaign audit rows, got %s', v_count);
  select count(*) into v_count from public.admin_audit_log
    where actor_id = v_admin;
  assert v_count = 7,
    format('expected 7 audit rows for the admin, got %s', v_count);

  -- === As a plain member =====================================================
  perform set_config('request.jwt.claims',
                     json_build_object('sub', v_user, 'role', 'authenticated')::text,
                     true);
  set local role authenticated;

  assert not public.is_admin(), 'is_admin() true for a non-admin';

  -- 3. Every write path is refused.
  v_blocked := false;
  begin
    insert into public.campaigns
        (title, contract, sector, pool, raised, profit_per_lac, share, tenure, risk, status)
      values ('Intruder', 'murabaha', 'x', 1000, 0, 1, 1, 1, 'low', 'open');
  exception when others then
    v_blocked := true;
  end;
  assert v_blocked, 'non-admin inserted a campaign';

  -- RLS UPDATE with no matching policy simply affects zero rows; campaigns
  -- stay readable to all authenticated users, so verify in place.
  update public.campaigns set title = 'Defaced' where id = v_campaign;
  assert (select title from public.campaigns where id = v_campaign)
    is distinct from 'Defaced', 'non-admin updated a campaign';

  v_blocked := false;
  begin
    insert into public.news_items (category, title) values ('x', 'Intruder');
  exception when others then
    v_blocked := true;
  end;
  assert v_blocked, 'non-admin inserted a news item';

  v_blocked := false;
  begin
    insert into public.banner_slides (surface, title) values ('home', 'Intruder');
  exception when others then
    v_blocked := true;
  end;
  assert v_blocked, 'non-admin inserted a banner slide';

  v_blocked := false;
  begin
    insert into public.welfare_projects (sector, title, district, target, raised)
      values ('x', 'Intruder', 'x', 1, 0);
  exception when others then
    v_blocked := true;
  end;
  assert v_blocked, 'non-admin inserted a welfare project';

  -- 4. Non-admin reads: published news only.
  select count(*) into v_count from public.news_items;
  assert v_count = 1,
    format('non-admin should see 1 published news item, saw %s', v_count);

  -- 5. Audit log invisible to non-admins.
  select count(*) into v_count from public.admin_audit_log;
  assert v_count = 0,
    format('non-admin can read the audit log (%s rows)', v_count);

  reset role;

  -- Append-only audit log.
  v_blocked := false;
  begin
    delete from public.admin_audit_log where actor_id = v_admin;
  exception when others then
    v_blocked := true;
  end;
  assert v_blocked, 'audit log DELETE was not blocked';

  raise notice 'admin content test: ALL ASSERTIONS PASSED';
end;
$$;

rollback;
