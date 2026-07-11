# RIBH Supabase

## Layout
- `migrations/` — schema, ledger enforcement, and RLS, in order. Apply with the Supabase CLI (`supabase db reset` locally, `supabase db push` to a linked project).
- `seed.sql` — dev and staging sample data only. Never run against production; never bundled in the app.
- `tests/ledger_invariant_test.sql` — proof of the ledger invariant. Runs in a transaction and rolls back.

## Running locally
Requires the Supabase CLI and Docker (neither is installed on this machine yet):

```sh
brew install supabase/tap/supabase
supabase init        # once, to create config.toml
supabase start
supabase db reset    # applies migrations + seed.sql
psql "$(supabase status -o env | grep DB_URL | cut -d= -f2-)" \
  -v ON_ERROR_STOP=1 -f supabase/tests/ledger_invariant_test.sql
```

The test prints `ledger invariant test: ALL ASSERTIONS PASSED` on success and exits non-zero on any failure. It must pass before M1 is considered closed (see docs/PROGRESS.md).

## Invariants enforced here, not in the app
- `wallet_transactions` is append-only: a trigger raises on UPDATE or DELETE for every role, and no update/delete grants or RLS policies exist.
- Balance is always derived: `wallet_balances` view / `my_wallet_balance()` RPC, `SUM` of signed amounts. Positive: deposit, distribution, recovery. Negative: investment, payout, purification, write_down, sadaqah, zakat.
- Money moves only through transactional RPCs (`invest_in_campaign`, `give_welfare` for clients; `record_deposit`, `record_distribution`, `record_payout` for service_role). Each writes the domain row and the ledger row in one transaction. No client-side write path exists for `wallet_transactions`, `investments`, `welfare_contributions`, `distributions`, or `payouts`.
- Consent is structural: `investments` has a CHECK requiring both risk acknowledgements; the invest RPC also refuses unverified (KYC tier 0) users.
