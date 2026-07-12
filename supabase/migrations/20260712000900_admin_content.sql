-- M10 Option A: the admin content rail. No payment surface is touched; this
-- manages the content rows (campaigns, welfare projects, news, banners)
-- that users later act on through the M3/M4 money flows.
--
-- 1. is_admin(): the role check behind every policy here. Roles move only
--    via service_role (protect_profile_columns, M2); clients cannot
--    self-promote.
-- 2. news_items and banner_slides: the two content tables that did not
--    exist yet (News and Insight finally has its real source).
-- 3. Admin write policies on the four content tables. No DELETE on
--    campaigns or welfare_projects: investments and contributions reference
--    them, and status changes are the honest way to retire a campaign.
-- 4. admin_audit_log: every admin write records who changed what and when,
--    written by triggers so no tool can forget to log.

-- 1. Role check. security definer so it can read profiles regardless of the
-- caller's own-row RLS; stable so policies can call it cheaply.
create function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

grant execute on function public.is_admin() to authenticated;

-- 2. Content tables --------------------------------------------------------

create table public.news_items (
  id uuid primary key default gen_random_uuid(),
  category text not null,
  title text not null,
  summary text not null default '',
  -- Optional deep link: a campaign id, a route, or an external URL.
  link text,
  -- Supabase Storage path for the thumbnail; upload flow is the tool's job.
  thumbnail_path text,
  published boolean not null default false,
  sort smallint not null default 0,
  created_at timestamptz not null default now()
);

create table public.banner_slides (
  id uuid primary key default gen_random_uuid(),
  -- Which surface shows it: 'home' or 'zakat' today.
  surface text not null check (surface in ('home', 'zakat')),
  title text not null,
  subtitle text not null default '',
  icon text not null default 'sprout',
  thumbnail_path text,
  -- Faith-facing copy stays board-gated: nothing publishes without this
  -- flag, which the board's reviewer flips deliberately.
  board_approved boolean not null default false,
  published boolean not null default false,
  sort smallint not null default 0,
  created_at timestamptz not null default now()
);

alter table public.news_items enable row level security;
alter table public.banner_slides enable row level security;

-- Users read published content; admins read everything.
create policy news_items_select on public.news_items
  for select to authenticated
  using (published or public.is_admin());
create policy banner_slides_select on public.banner_slides
  for select to authenticated
  using (published or public.is_admin());

-- 3. Admin write policies ---------------------------------------------------

-- campaigns: insert and update only. Retirement is a status change; DELETE
-- stays impossible because investments reference campaign rows.
create policy campaigns_admin_insert on public.campaigns
  for insert to authenticated with check (public.is_admin());
create policy campaigns_admin_update on public.campaigns
  for update to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- welfare_projects: same shape; contributions reference project rows.
create policy welfare_projects_admin_insert on public.welfare_projects
  for insert to authenticated with check (public.is_admin());
create policy welfare_projects_admin_update on public.welfare_projects
  for update to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- news and banners: full CRUD, nothing references them.
create policy news_items_admin_write on public.news_items
  for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy banner_slides_admin_write on public.banner_slides
  for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- 4. Audit log --------------------------------------------------------------

create table public.admin_audit_log (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid references public.profiles (id),
  table_name text not null,
  row_id uuid not null,
  action text not null check (action in ('insert', 'update', 'delete')),
  old_data jsonb,
  new_data jsonb,
  created_at timestamptz not null default now()
);

create index admin_audit_log_row_idx
  on public.admin_audit_log (table_name, row_id);

alter table public.admin_audit_log enable row level security;

-- Admins read the log; nobody writes it directly (triggers only), and like
-- the ledger it is append-only.
create policy admin_audit_log_select on public.admin_audit_log
  for select to authenticated using (public.is_admin());

create function public.raise_audit_append_only()
returns trigger
language plpgsql
as $$
begin
  raise exception 'admin_audit_log is append-only' using errcode = 'P0001';
end;
$$;

create trigger admin_audit_log_append_only
  before update or delete on public.admin_audit_log
  for each row execute function public.raise_audit_append_only();

revoke update, delete on public.admin_audit_log from anon, authenticated;

create function public.log_admin_write()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_row_id uuid := coalesce(new.id, old.id);
begin
  insert into public.admin_audit_log
      (actor_id, table_name, row_id, action, old_data, new_data)
    values (
      auth.uid(),
      tg_table_name,
      v_row_id,
      lower(tg_op),
      case when tg_op in ('UPDATE', 'DELETE') then to_jsonb(old) end,
      case when tg_op in ('INSERT', 'UPDATE') then to_jsonb(new) end
    );
  return coalesce(new, old);
end;
$$;

create trigger campaigns_audit
  after insert or update or delete on public.campaigns
  for each row execute function public.log_admin_write();
create trigger welfare_projects_audit
  after insert or update or delete on public.welfare_projects
  for each row execute function public.log_admin_write();
create trigger news_items_audit
  after insert or update or delete on public.news_items
  for each row execute function public.log_admin_write();
create trigger banner_slides_audit
  after insert or update or delete on public.banner_slides
  for each row execute function public.log_admin_write();
