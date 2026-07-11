-- Row level security. A user reads and writes only their own rows; campaigns,
-- welfare projects, and lessons are readable by all authenticated users.
-- Money movement has NO direct client write path: wallet_transactions,
-- investments, welfare_contributions, distributions, and payouts get no
-- INSERT/UPDATE/DELETE policies. The security-definer RPCs are the only door.

alter table public.profiles enable row level security;
alter table public.investor_wallets enable row level security;
alter table public.wallet_transactions enable row level security;
alter table public.campaigns enable row level security;
alter table public.investments enable row level security;
alter table public.distributions enable row level security;
alter table public.payouts enable row level security;
alter table public.auto_invest_rules enable row level security;
alter table public.auto_invest_queue enable row level security;
alter table public.goals enable row level security;
alter table public.nominees enable row level security;
alter table public.welfare_projects enable row level security;
alter table public.welfare_contributions enable row level security;
alter table public.engagement enable row level security;
alter table public.lessons enable row level security;
alter table public.lessons_progress enable row level security;
alter table public.referrals enable row level security;
alter table public.trees enable row level security;

-- profiles: own row only. Creation happens via the auth trigger.
create policy profiles_select_own on public.profiles
  for select to authenticated using (id = auth.uid());
create policy profiles_update_own on public.profiles
  for update to authenticated
  using (id = auth.uid()) with check (id = auth.uid());

-- investor_wallets: read own. Created by trigger; never written by clients.
create policy wallets_select_own on public.investor_wallets
  for select to authenticated using (profile_id = auth.uid());

-- wallet_transactions: read own ledger. No write policies at all.
create policy transactions_select_own on public.wallet_transactions
  for select to authenticated
  using (
    exists (
      select 1 from public.investor_wallets w
      where w.id = wallet_transactions.wallet_id
        and w.profile_id = auth.uid()
    )
  );

-- campaigns: public read for authenticated users. Writes are back-office.
create policy campaigns_select_all on public.campaigns
  for select to authenticated using (true);

-- investments: read own. Insert only via invest_in_campaign RPC.
create policy investments_select_own on public.investments
  for select to authenticated using (profile_id = auth.uid());

-- distributions: visible to investors in that campaign.
create policy distributions_select_invested on public.distributions
  for select to authenticated
  using (
    exists (
      select 1 from public.investments i
      where i.campaign_id = distributions.campaign_id
        and i.profile_id = auth.uid()
    )
  );

-- payouts: read own.
create policy payouts_select_own on public.payouts
  for select to authenticated using (profile_id = auth.uid());

-- auto_invest_rules: full ownership.
create policy auto_invest_rules_all_own on public.auto_invest_rules
  for all to authenticated
  using (profile_id = auth.uid()) with check (profile_id = auth.uid());

-- auto_invest_queue: read own items; the only client write is deciding a
-- pending item (approve or decline). Queue items are inserted by the system.
create policy auto_invest_queue_select_own on public.auto_invest_queue
  for select to authenticated
  using (
    exists (
      select 1 from public.auto_invest_rules r
      where r.id = auto_invest_queue.rule_id and r.profile_id = auth.uid()
    )
  );
create policy auto_invest_queue_decide_own on public.auto_invest_queue
  for update to authenticated
  using (
    status = 'pending'
    and exists (
      select 1 from public.auto_invest_rules r
      where r.id = auto_invest_queue.rule_id and r.profile_id = auth.uid()
    )
  )
  with check (
    status in ('approved', 'declined')
    and exists (
      select 1 from public.auto_invest_rules r
      where r.id = auto_invest_queue.rule_id and r.profile_id = auth.uid()
    )
  );

-- goals: full ownership.
create policy goals_all_own on public.goals
  for all to authenticated
  using (profile_id = auth.uid()) with check (profile_id = auth.uid());

-- nominees: full ownership.
create policy nominees_all_own on public.nominees
  for all to authenticated
  using (profile_id = auth.uid()) with check (profile_id = auth.uid());

-- welfare_projects: public read. Writes are back-office.
create policy welfare_projects_select_all on public.welfare_projects
  for select to authenticated using (true);

-- welfare_contributions: read own. Insert only via give_welfare RPC.
create policy welfare_contributions_select_own on public.welfare_contributions
  for select to authenticated using (profile_id = auth.uid());

-- engagement: own row, readable and updatable. Created by trigger.
create policy engagement_select_own on public.engagement
  for select to authenticated using (profile_id = auth.uid());
create policy engagement_update_own on public.engagement
  for update to authenticated
  using (profile_id = auth.uid()) with check (profile_id = auth.uid());

-- lessons: public read.
create policy lessons_select_all on public.lessons
  for select to authenticated using (true);

-- lessons_progress: full ownership.
create policy lessons_progress_all_own on public.lessons_progress
  for all to authenticated
  using (profile_id = auth.uid()) with check (profile_id = auth.uid());

-- referrals: visible to both sides; created by the system at sign-up.
create policy referrals_select_own on public.referrals
  for select to authenticated
  using (referrer_id = auth.uid() or invitee_id = auth.uid());

-- trees: read own forest. Planted by the system (referral/sadaqah flows).
create policy trees_select_own on public.trees
  for select to authenticated using (profile_id = auth.uid());
