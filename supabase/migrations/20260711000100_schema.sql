-- RIBH schema, from .claude/rules/data-model.md (dossier ER diagram).
-- Money is stored in integer minor units (poisha). Never float.

create extension if not exists pgcrypto;

-- Enums
create type public.user_role as enum ('investor', 'business', 'admin');
create type public.tx_kind as enum (
  'deposit', 'investment', 'distribution', 'payout', 'purification',
  'write_down', 'recovery', 'sadaqah', 'zakat'
);
create type public.campaign_status as enum ('open', 'running', 'matured', 'in_recovery');
create type public.payout_route as enum ('bank', 'reinvest');
create type public.queue_status as enum ('pending', 'approved', 'declined');
create type public.welfare_kind as enum ('zakat', 'sadaqah');
create type public.referral_status as enum ('joined', 'verified');
create type public.tree_source as enum ('referral', 'sadaqah');

-- Core money spine ----------------------------------------------------------

create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  role public.user_role not null default 'investor',
  kyc_tier smallint not null default 0 check (kyc_tier between 0 and 3),
  nid_hash text,
  risk_tier text,
  lang text not null default 'bn',
  theme text not null default 'system',
  twofa_enabled boolean not null default false,
  nominee_id uuid,
  created_at timestamptz not null default now()
);

create table public.investor_wallets (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null unique references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now()
);
-- No balance column, ever. Balance is derived from wallet_transactions.

create table public.wallet_transactions (
  id uuid primary key default gen_random_uuid(),
  wallet_id uuid not null references public.investor_wallets (id),
  kind public.tx_kind not null,
  amount bigint not null check (amount > 0),
  ref_type text,
  ref_id uuid,
  signature text,
  created_at timestamptz not null default now()
);
-- APPEND ONLY: enforced by trigger + revoked grants in the ledger migration.

create table public.campaigns (
  id uuid primary key default gen_random_uuid(),
  business_id uuid references public.profiles (id),
  contract text not null,
  sector text not null,
  pool bigint not null check (pool > 0),
  raised bigint not null default 0 check (raised >= 0),
  profit_per_lac bigint not null check (profit_per_lac >= 0),
  share numeric(5, 2) not null check (share > 0 and share <= 100),
  tenure smallint not null check (tenure > 0),
  risk text not null,
  status public.campaign_status not null default 'open',
  created_at timestamptz not null default now(),
  check (raised <= pool)
);

create table public.investments (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id),
  campaign_id uuid not null references public.campaigns (id),
  amount bigint not null check (amount > 0),
  risk_ack_1 boolean not null,
  risk_ack_2 boolean not null,
  source text not null default 'wallet',
  created_at timestamptz not null default now(),
  -- Consent is explicit: an investment row cannot exist without both
  -- acknowledgements. The RPC checks this too; this is the backstop.
  check (risk_ack_1 and risk_ack_2)
);

create table public.distributions (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.campaigns (id),
  gross bigint not null check (gross >= 0),
  ribh_fee bigint not null check (ribh_fee >= 0),
  investor_share bigint not null check (investor_share >= 0),
  created_at timestamptz not null default now(),
  check (ribh_fee + investor_share <= gross)
);

create table public.payouts (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id),
  distribution_id uuid not null references public.distributions (id),
  route public.payout_route not null,
  created_at timestamptz not null default now()
);

-- Investing satellites -------------------------------------------------------

create table public.auto_invest_rules (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  strategy text not null,
  budget bigint not null check (budget > 0),
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.auto_invest_queue (
  id uuid primary key default gen_random_uuid(),
  rule_id uuid not null references public.auto_invest_rules (id) on delete cascade,
  campaign_id uuid not null references public.campaigns (id),
  status public.queue_status not null default 'pending',
  created_at timestamptz not null default now()
);
-- Nothing deploys while pending: deployment only happens through the invest
-- RPC, which is only called after explicit user approval of a queue item.

create table public.goals (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  title text not null,
  icon text not null default 'target',
  target bigint not null check (target > 0),
  saved bigint not null default 0 check (saved >= 0),
  created_at timestamptz not null default now()
);

create table public.nominees (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  name text not null,
  relation text not null,
  nid_hash text,
  created_at timestamptz not null default now()
);

alter table public.profiles
  add constraint profiles_nominee_id_fkey
  foreign key (nominee_id) references public.nominees (id) on delete set null;

-- Faith, welfare, engagement -------------------------------------------------

create table public.welfare_projects (
  id uuid primary key default gen_random_uuid(),
  sector text not null,
  title text not null,
  district text not null,
  target bigint not null check (target > 0),
  raised bigint not null default 0 check (raised >= 0),
  created_at timestamptz not null default now()
);

create table public.welfare_contributions (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id),
  project_id uuid not null references public.welfare_projects (id),
  kind public.welfare_kind not null,
  amount bigint not null check (amount > 0),
  created_at timestamptz not null default now()
);

create table public.engagement (
  profile_id uuid primary key references public.profiles (id) on delete cascade,
  adhkar_counts jsonb not null default '{}',
  habit_days jsonb not null default '{}',
  prayer_streak integer not null default 0 check (prayer_streak >= 0),
  score integer not null default 0 check (score >= 0),
  updated_at timestamptz not null default now()
);

-- Lesson catalogue (content rows are dev seed; faith copy is TODO(board)).
create table public.lessons (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  sort smallint not null default 0,
  created_at timestamptz not null default now()
);

create table public.lessons_progress (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  module_id text not null,
  read_count integer not null default 0 check (read_count >= 0),
  completed boolean not null default false,
  created_at timestamptz not null default now(),
  unique (profile_id, module_id)
);

create table public.referrals (
  id uuid primary key default gen_random_uuid(),
  referrer_id uuid not null references public.profiles (id),
  invitee_id uuid not null unique references public.profiles (id),
  status public.referral_status not null default 'joined',
  created_at timestamptz not null default now(),
  check (referrer_id <> invitee_id)
);

create table public.trees (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id),
  source public.tree_source not null,
  drive text,
  district text,
  planted_at timestamptz,
  created_at timestamptz not null default now()
);

-- Indexes for the hot paths
create index wallet_transactions_wallet_id_created_at_idx
  on public.wallet_transactions (wallet_id, created_at desc);
create index investments_profile_id_idx on public.investments (profile_id);
create index investments_campaign_id_idx on public.investments (campaign_id);
create index campaigns_status_idx on public.campaigns (status);
create index welfare_contributions_profile_id_idx
  on public.welfare_contributions (profile_id);
create index trees_profile_id_idx on public.trees (profile_id);

-- Bootstrap triggers ---------------------------------------------------------

-- New auth user gets a profile; new profile gets a wallet and engagement row.
create function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id) values (new.id) on conflict do nothing;
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

create function public.handle_new_profile()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.investor_wallets (profile_id) values (new.id)
    on conflict do nothing;
  insert into public.engagement (profile_id) values (new.id)
    on conflict do nothing;
  return new;
end;
$$;

create trigger on_profile_created
  after insert on public.profiles
  for each row execute function public.handle_new_profile();

create function public.touch_engagement_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create trigger engagement_touch_updated_at
  before update on public.engagement
  for each row execute function public.touch_engagement_updated_at();
