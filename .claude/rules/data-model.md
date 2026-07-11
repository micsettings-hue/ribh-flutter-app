# Data model (Supabase)

Target schema from the dossier ER diagram. Postgres with row level security. Every table has `id uuid default gen_random_uuid()`, `created_at timestamptz default now()`. Money is stored in integer minor units (poisha) to avoid float error, or `numeric`, never float.

## Core money spine
- `profiles` (id = auth uid, role, kyc_tier, nid_hash, risk_tier, lang, theme, twofa_enabled, nominee_id)
- `investor_wallets` (id, profile_id FK unique). No balance column. Balance is derived.
- `wallet_transactions` (id, wallet_id FK, kind, amount, ref_type, ref_id, signature, created_at). APPEND ONLY.
  - kinds: `deposit`, `investment`, `distribution`, `payout`, `purification`, `write_down`, `recovery`, `sadaqah`, `zakat`.
  - No UPDATE or DELETE permitted. Enforce with a trigger that raises on update or delete, and RLS with no update or delete policy.
- `campaigns` (id, business_id FK, contract, sector, pool, raised, profit_per_lac, share, tenure, risk, status). status includes `open`, `matured`, `in_recovery`.
- `investments` (id, profile_id, campaign_id, amount, risk_ack_1, risk_ack_2, source, created_at)
- `distributions` (id, campaign_id, gross, ribh_fee, investor_share)
- `payouts` (id, profile_id, distribution_id, route) route in (`bank`, `reinvest`)

## Investing satellites
- `auto_invest_rules` (id, profile_id, strategy, budget, active)
- `auto_invest_queue` (id, rule_id, campaign_id, status) status in (`pending`, `approved`, `declined`). Nothing deploys while pending.
- `goals` (id, profile_id, title, icon, target, saved)
- `nominees` (id, profile_id, name, relation, nid_hash)

## Faith, welfare, engagement
- `welfare_projects` (id, sector, title, district, target, raised)
- `welfare_contributions` (id, profile_id, project_id, kind, amount) kind in (`zakat`, `sadaqah`)
- `engagement` (profile_id, adhkar_counts jsonb, habit_days jsonb, prayer_streak, score, updated_at)
- `lessons_progress` (id, profile_id, module_id, read_count, completed)
- `referrals` (id, referrer_id, invitee_id, status) status in (`joined`, `verified`)
- `trees` (id, profile_id, source, drive, district, planted_at) source in (`referral`, `sadaqah`)

## The ledger invariant (must be enforced in the database)
- `investor_wallets` exposes balance via a view or RPC: `SELECT COALESCE(SUM(signed_amount),0)` over `wallet_transactions` for that wallet, where deposits, distributions, and recovery are positive and investments, payouts to bank, purification, sadaqah, zakat, and write_down are negative.
- A test row set must prove: deposit then invest then distribution then payout yields the arithmetically correct balance, and any attempt to UPDATE or DELETE a transaction fails.

## RLS
- A user reads and writes only rows where `profile_id = auth.uid()`.
- `campaigns` and `welfare_projects` are readable by all authenticated users.
- No client-side write path can bypass the transactional RPCs for money movement.

## Seeds
- Seed campaigns, welfare projects, and lessons live in `supabase/seed.sql`, run only against dev and staging, never bundled in the app. The prototype's sample campaigns (Printing Zone, Machinery Purchase, Machinery Trading, Musannif Cement) are acceptable dev seed data, clearly marked as seed.
