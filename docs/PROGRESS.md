# RIBH Flutter progress

## Done

### M1 Data spine (2026-07-11)
- Supabase schema in `supabase/migrations/20260711000100_schema.sql`: all tables from the ER diagram (`profiles`, `investor_wallets` with no balance column, `wallet_transactions`, `campaigns`, `investments`, `distributions`, `payouts`, `auto_invest_rules`, `auto_invest_queue`, `goals`, `nominees`, `welfare_projects`, `welfare_contributions`, `engagement`, `lessons` + `lessons_progress`, `referrals`, `trees`), money in integer poisha, enums for kinds and statuses (`campaign_status` also includes `running` for deployed campaigns), bootstrap triggers (auth user -> profile -> wallet + engagement). `investments` carries a CHECK that both risk acknowledgements are true.
- Ledger invariant in `...000200_ledger.sql`, enforced in the database: a trigger raises on any UPDATE or DELETE of `wallet_transactions` (plus revoked grants); `ledger_signed_amount` defines the sign convention; `wallet_balances` view and `my_wallet_balance()` derive balance as SUM over the ledger. Money moves only through transactional RPCs that write the domain row and ledger row in one transaction: `invest_in_campaign` and `give_welfare` for clients (KYC, campaign status, pool headroom, both acks, and derived-balance checks inside), `record_deposit` / `record_distribution` / `record_payout` for service_role only. `give_welfare` sends the full amount to the project: no fee out of Zakat, structurally.
- RLS in `...000300_rls.sql`: own-rows policies everywhere; `campaigns`, `welfare_projects`, `lessons` readable by all authenticated users; NO client write policies on `wallet_transactions`, `investments`, `welfare_contributions`, `distributions`, `payouts`, so the RPCs are the only write path. Auto-invest queue items can only be decided (pending -> approved/declined) by their owner; nothing deploys while pending.
- `supabase/seed.sql`: prototype campaign set, welfare projects, lesson catalogue; dev/staging only, faith-facing titles marked TODO(board).
- SQL invariant proof in `supabase/tests/ledger_invariant_test.sql`: deposit -> invest -> distribution -> payout asserting the derived balance at each step (100000 -> 60000 -> 68000 -> 65000), plus assertions that over-balance and single-ack investments fail and that UPDATE/DELETE on the ledger raise. Runs in a transaction and rolls back.
- Dart core: sealed `Result<T>` (`lib/core/result/`), typed `Failure`s (`lib/core/failures/`), and the canonical profit formula as a pure unit-tested function in `lib/core/constants/profit_formula.dart`.
- Freezed models for all 18 tables (`lib/data/models/`, snake_case via build.yaml, `risk_ack_1`/`risk_ack_2` mapped explicitly), with `deriveBalance` mirroring the SQL sign convention.
- Repositories (`lib/data/repositories/`): Auth (profile only; auth flows are M2), Wallet, Campaign, Investment, Goal, Engagement, Zakat, Sadaqah (shared `WelfareRepository` base), Referral. All return `Result<T, Failure>`, never throw across the boundary; a null (unconfigured) client yields `NotConfiguredFailure` from every call. RPC raise messages map to typed failures (`insufficient_funds`, `not_verified`, validation set). Riverpod providers in `repositories/providers.dart`.
- Tests: 29 passing. Profit formula, ledger sign convention and `deriveBalance` (same row set as the SQL test), model JSON parsing (including `write_down`, `in_recovery`, numeric share as int), and repository behaviour against a real `SupabaseClient` over a mocked HTTP layer: invest RPC params, insufficient-funds and not-verified mapping, local refusal without both acks, status filter emitting `eq.in_recovery`, ledger list parsing. `flutter analyze` clean.

### M1 open items (block M1 sign-off, not M2 development)
- The SQL migrations and the ledger invariant test are WRITTEN BUT NOT EXECUTED: this machine has no Supabase CLI, Docker, or psql. Before M1 is closed, run `supabase db reset` plus `supabase/tests/ledger_invariant_test.sql` per `supabase/README.md` and fix anything it surfaces.
- `PrayerRepository` from the architecture list is deliberately deferred to M7: prayer times and qibla are device-API driven and have no Supabase table in the data model.

### M0 Foundation (2026-07-11)
- Flutter project created in place (`ribh`, org `com.ribhinvestments`, Android and iOS). All packages from `.claude/rules/architecture.md` added and version-pinned in `pubspec.yaml`. Note: the unmaintained `lucide_icons` package is incompatible with current Flutter (extends the now-final `IconData`), so the maintained `lucide_icons_flutter` is used instead; same stroke icon set.
- Theming: Mint Modern tokens as a `RibhTokens` `ThemeExtension` (`lib/app/theme/ribh_tokens.dart`) with the full light and dark palettes from `.claude/rules/design-system.md`, wired into `RibhTheme` (`lib/app/theme/ribh_theme.dart`): ColorScheme mapping, Hanken Grotesk display and Inter body via `google_fonts`, Anek Bangla when the locale is Bengali, card radius 16 with 1.5dp line borders, 24 top-radius sheets, themed NavigationBar.
- Localization scaffold: ARB files (`lib/app/l10n/app_en.arb`, `app_bn.arb`) with `flutter gen-l10n` output; every string in the app comes from the ARB layer. The Bengali "Barakah" tab label is marked TODO(board) pending Shariah board sign-off.
- Navigation: go_router `StatefulShellRoute.indexedStack` with five branches (Home, Invest, Grow, Barakah, Me) so tab state persists; typed path constants in `lib/app/router/routes.dart`; no raw paths in widgets. Each tab renders an honest `MilestonePlaceholder` (no demo content, states plainly that nothing is live yet).
- Supabase client (`lib/data/supabase/supabase_client.dart`): initialized from `--dart-define` `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` (nothing committed). When unconfigured the app still launches; `supabaseClientProvider` throws a real error rather than faking a backend.
- State: Riverpod `ProviderScope` at the root, `routerProvider`, and a `localeProvider` (`Notifier<Locale?>`) that the Me tab's language toggle will drive in a later milestone.
- CI: `.github/workflows/ci.yml` runs `dart format --set-exit-if-changed`, `flutter analyze`, and `flutter test` on push to main and on PRs.
- Verification: `flutter analyze` clean (zero issues), `dart format` applied, 4 widget tests passing in `test/app/shell_test.dart`: launch to themed shell, tab switching across all five tabs, dark theme token application, and Bengali rendering when the device locale is bn.

## Notes and follow-ups
- The repo still contains the earlier React Native prototype files (`App.tsx`, `src/`, `package.json`, `node_modules`). Left untouched; decide whether to remove them before M1.
- Generated l10n Dart files are committed alongside the ARBs; `flutter pub get` regenerates them (`generate: true`).
- `CLAUDE.md` still says the stack is React Native + Expo; the actual build is Flutter per `flutterv9.2.md`. Worth correcting in `CLAUDE.md`.

## Next
- Close M1: install Supabase CLI + Docker, run the migrations and `supabase/tests/ledger_invariant_test.sql`, fix anything it surfaces.
- M2 Auth and KYC: Supabase Auth, onboarding, the real KYC flow, risk profiling.
