# Architecture

## Packages (pin versions at M0)
- `flutter_riverpod` + `riverpod_annotation` + `riverpod_generator` (state)
- `go_router` (navigation)
- `supabase_flutter` (backend)
- `freezed` + `json_serializable` (models)
- `flutter_localizations` + `intl` (i18n, ARB)
- `google_fonts` (or bundled fonts)
- `fl_chart` (wallet performance line)
- `flutter_local_notifications` (salah alarms)
- `geolocator` + `flutter_qiblah` or a magnetometer approach (prayer, qibla)
- `webview_flutter` (payment checkout)
- Testing: `flutter_test`, `mocktail`

## State (Riverpod, code-gen)
- One `AsyncNotifier` controller per screen or aggregate, e.g. `walletController`, `campaignsController`, `investmentController`.
- Controllers depend on repositories, never on Supabase directly.
- No business logic in widgets. Widgets watch providers and render.
- Use `AsyncValue` for loading, error, and data. Loading renders skeletons; error renders a real retry state.

## Navigation (go_router)
- `StatefulShellRoute.indexedStack` for the five tabs so tab state persists.
- Service pages (`/services/zakat`, `/services/sadaqah`, ...) and `/campaign/:id` are pushed routes with Hero transitions.
- Sheets are not routes; they are `showModalBottomSheet` on a shared `RibhSheetScaffold`.
- Typed route helpers; no raw string paths in widgets.

## Data layer
- `Result<T, Failure>` (sealed) returned by every repository method. No throwing across the repository boundary.
- One repository per aggregate: `WalletRepository`, `CampaignRepository`, `InvestmentRepository`, `GoalRepository`, `EngagementRepository`, `ZakatRepository`, `SadaqahRepository`, `ReferralRepository`, `PrayerRepository`, `AuthRepository`.
- All Supabase access is RLS-aware; the client only ever sees the current user's rows (plus public campaign and welfare data).
- Money writes are transactional: an investment writes the `investments` row and the `wallet_transactions` row in one Postgres RPC, never two separate client calls.

## Formatting and core
- `core/formatters`: taka formatter (locale grouping), date formatter, a real Hijri converter (use a maintained package, not the prototype's approximation).
- `core/failures`: typed failures (network, auth, validation, insufficientFunds, notVerified).
- `core/constants`: the profit formula lives here as a pure function and is unit-tested.

## Testing
- Unit tests for formatters, the profit formula, and the ledger-balance derivation.
- Widget tests for each screen's happy path and one failure path.
- One integration test for the first-investment journey end to end (from the activity diagram in the dossier).
