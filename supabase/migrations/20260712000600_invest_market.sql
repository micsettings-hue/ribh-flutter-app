-- M4: marketplace support.
--
-- 1. Campaigns get a display title. The ER diagram carried the prototype
--    names only as a comment; the marketplace needs them as data.
-- 2. A per-user watchlist backs the Saved filter and the bookmark on
--    campaign cards.

alter table public.campaigns add column title text not null default '';

create table public.campaign_watchlist (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles (id) on delete cascade,
  campaign_id uuid not null references public.campaigns (id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (profile_id, campaign_id)
);

create index campaign_watchlist_profile_id_idx
  on public.campaign_watchlist (profile_id);

alter table public.campaign_watchlist enable row level security;

-- The watchlist moves no money, so unlike the money tables it is plain
-- own-rows CRUD: no RPC needed.
create policy campaign_watchlist_select_own on public.campaign_watchlist
  for select to authenticated using (profile_id = auth.uid());
create policy campaign_watchlist_insert_own on public.campaign_watchlist
  for insert to authenticated with check (profile_id = auth.uid());
create policy campaign_watchlist_delete_own on public.campaign_watchlist
  for delete to authenticated using (profile_id = auth.uid());
