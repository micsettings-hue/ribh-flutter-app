-- M2: KYC submissions and profile column protection.
--
-- KYC reality: NID verification against the national register and the
-- liveness match require a verification provider (back-office / M-later
-- integration). The app submits real data; the tier is upgraded only by
-- service_role after verification. No fake "verified" state exists.

create type public.kyc_status as enum ('pending', 'approved', 'rejected');

create table public.kyc_submissions (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  nid_hash text not null,
  source_of_funds text not null check (
    source_of_funds in ('salary', 'business_income', 'savings', 'remittance')
  ),
  selfie_captured boolean not null default false,
  status public.kyc_status not null default 'pending',
  created_at timestamptz not null default now()
);

create index kyc_submissions_profile_id_idx
  on public.kyc_submissions (profile_id);

alter table public.kyc_submissions enable row level security;

-- Read own submissions. Writes only via the submit_kyc RPC; approval and
-- rejection only by service_role.
create policy kyc_submissions_select_own on public.kyc_submissions
  for select to authenticated using (profile_id = auth.uid());

-- Clients may update their own profile row (lang, theme, risk_tier, ...) but
-- never the trust columns. Tier and role move only through service_role.
create function public.protect_profile_columns()
returns trigger
language plpgsql
as $$
begin
  if current_user in ('anon', 'authenticated') then
    if new.kyc_tier is distinct from old.kyc_tier
        or new.role is distinct from old.role
        or new.nid_hash is distinct from old.nid_hash then
      raise exception 'column_protected' using errcode = 'P0001';
    end if;
  end if;
  return new;
end;
$$;

create trigger profiles_protect_columns
  before update on public.profiles
  for each row execute function public.protect_profile_columns();

-- Records a KYC submission for the signed-in user. Overwrites a previous
-- pending submission (resubmission); an approved profile does not resubmit.
create function public.submit_kyc(
  p_nid_hash text,
  p_source_of_funds text,
  p_selfie_captured boolean default false
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := auth.uid();
  v_submission_id uuid;
begin
  if v_profile_id is null then
    raise exception 'not_authenticated' using errcode = 'P0001';
  end if;
  if p_nid_hash is null or length(p_nid_hash) <> 64 then
    -- sha-256 hex digest of the NID number; the raw NID never leaves the device.
    raise exception 'invalid_nid_hash' using errcode = 'P0001';
  end if;
  if p_source_of_funds not in ('salary', 'business_income', 'savings', 'remittance') then
    raise exception 'invalid_source_of_funds' using errcode = 'P0001';
  end if;
  if exists (
    select 1 from public.kyc_submissions
    where profile_id = v_profile_id and status = 'approved'
  ) then
    raise exception 'already_verified' using errcode = 'P0001';
  end if;

  delete from public.kyc_submissions
    where profile_id = v_profile_id and status = 'pending';

  insert into public.kyc_submissions
      (profile_id, nid_hash, source_of_funds, selfie_captured)
    values (v_profile_id, p_nid_hash, p_source_of_funds, p_selfie_captured)
    returning id into v_submission_id;

  update public.profiles set nid_hash = p_nid_hash where id = v_profile_id;

  return v_submission_id;
end;
$$;

grant execute on function public.submit_kyc(text, text, boolean) to authenticated;

-- Back-office decision: approves or rejects a submission and moves the tier.
-- service_role only.
create function public.decide_kyc(
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
  end if;
end;
$$;

revoke execute on function public.decide_kyc(uuid, boolean, smallint)
  from public, anon, authenticated;
grant execute on function public.decide_kyc(uuid, boolean, smallint)
  to service_role;
