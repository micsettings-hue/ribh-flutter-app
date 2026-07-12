-- M7: service-page rails.
--
-- 1. Referral codes and the signup hook (referrals stay system-created).
-- 2. KYC approval also verifies a pending referral (points move on sign-up
--    and verification only, never on investing).
-- 3. Qard interest registration (no money, coming-soon page records real
--    interest).
-- 4. Points-to-trees redemption: the only client-reachable tree write, with
--    the conversion enforced server-side. Rewards are trees, never cash.

-- Referral codes: short, unique, non-guessable enough for links.
alter table public.profiles
  add column referral_code text unique
  default substr(replace(gen_random_uuid()::text, '-', ''), 1, 8);

update public.profiles
  set referral_code = substr(replace(gen_random_uuid()::text, '-', ''), 1, 8)
  where referral_code is null;

-- Signup hook: when a new profile appears and the auth user carried a
-- referred_by code in its metadata, record the referral (system insert;
-- clients have no write policy on referrals).
create function public.handle_referral_signup()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_code text;
  v_referrer uuid;
begin
  select raw_user_meta_data ->> 'referred_by' into v_code
    from auth.users where id = new.id;
  if v_code is null or v_code = '' then
    return new;
  end if;
  select id into v_referrer
    from public.profiles where referral_code = v_code;
  if v_referrer is null or v_referrer = new.id then
    return new; -- unknown or self-referral: silently ignored, never an error
  end if;
  insert into public.referrals (referrer_id, invitee_id, status)
    values (v_referrer, new.id, 'joined')
    on conflict (invitee_id) do nothing;
  return new;
end;
$$;

create trigger profiles_referral_signup
  after insert on public.profiles
  for each row execute function public.handle_referral_signup();

-- KYC approval verifies the referral. Replaces M2's decide_kyc.
create or replace function public.decide_kyc(
  p_submission_id uuid,
  p_approve boolean,
  p_tier smallint default 1
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid;
begin
  update public.kyc_submissions
    set status = case when p_approve then 'approved' else 'rejected' end::public.kyc_status
    where id = p_submission_id and status = 'pending'
    returning profile_id into v_profile_id;
  if v_profile_id is null then
    raise exception 'submission_not_found' using errcode = 'P0001';
  end if;
  if p_approve then
    update public.profiles set kyc_tier = p_tier where id = v_profile_id;
    update public.referrals
      set status = 'verified'
      where invitee_id = v_profile_id and status = 'joined';
  end if;
end;
$$;

-- Qard interest: one row per user, no money involved.
create table public.qard_interest (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null unique references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now()
);

alter table public.qard_interest enable row level security;

create policy qard_interest_select_own on public.qard_interest
  for select to authenticated using (profile_id = auth.uid());
create policy qard_interest_insert_own on public.qard_interest
  for insert to authenticated with check (profile_id = auth.uid());

-- Points-to-trees conversion. The vocabulary:
--   joined referral  = 10 points
--   verified referral = 40 more points (50 total once verified)
--   one tree costs    50 points
-- Mirrored by lib/core/constants/referral_points.dart; keep in lockstep.
-- The tree row is created with planted_at null: it is a pledge until a real
-- drive plants it and back-office fills drive, district, planted_at.
create function public.redeem_referral_tree()
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := auth.uid();
  v_joined integer;
  v_verified integer;
  v_points integer;
  v_redeemed integer;
  v_tree_id uuid;
begin
  if v_profile_id is null then
    raise exception 'not_authenticated' using errcode = 'P0001';
  end if;

  select
      count(*) filter (where status = 'joined'),
      count(*) filter (where status = 'verified')
    into v_joined, v_verified
    from public.referrals where referrer_id = v_profile_id;
  v_points := v_joined * 10 + v_verified * 50;

  select count(*) into v_redeemed
    from public.trees
    where profile_id = v_profile_id and source = 'referral';

  if (v_points / 50) - v_redeemed < 1 then
    raise exception 'insufficient_points' using errcode = 'P0001';
  end if;

  insert into public.trees (profile_id, source)
    values (v_profile_id, 'referral')
    returning id into v_tree_id;
  return v_tree_id;
end;
$$;

grant execute on function public.redeem_referral_tree() to authenticated;
