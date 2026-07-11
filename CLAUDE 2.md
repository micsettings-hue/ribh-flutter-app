# RIBH Investments · Flutter app

AAOIFI-aligned halal trade-financing platform (Murabaha and Wakalah), Dhaka. This is the production Flutter build. The reference prototype is `docs/ribh-app-prototype-v9-2.html` and the architecture is `docs/ribh-pre-flutter-dossier.html`. The full build spec is `flutterv9.2.md`; read it before starting any feature.

## What this app is
Investors deposit funds, invest in real trade-finance campaigns, track where their money physically is, receive profit distributions, and give Zakat and Sadaqah. Five bottom tabs: Home, Invest, Grow, Barakah, Me. Six service pages open from Home. One append-only ledger underpins all money movement.

## Non-negotiables (never violate)
- Say "AAOIFI-aligned", never "certified" or "compliant-guaranteed".
- Never promise capital protection or guaranteed returns. Show a risk disclosure wherever a return or projection appears.
- The ledger is append-only. Every money movement writes exactly one signed transaction. Wallet balance always equals SUM(ledger). Corrections are new entries, never edits or deletes.
- Per-deal consent: no deployment of user funds without explicit approval. Savings routes through the auto-invest approval queue, never silent discretion.
- No em-dashes, no emoji anywhere in code, copy, or comments. Stroke-style icons only.
- All faith-facing copy (Zakat, Nisab, Sadaqah, Qard, prayer, adhkar, any ayah or hadith) is placeholder pending Shariah board sign-off. Mark it `// TODO(board)` and never invent religious rulings.
- No demo scaffolding. No demo tier, demo banners, demo-only buttons, fake toasts that do nothing, or hardcoded fake balances in shipped code. Every control performs its real action against the real data layer. Seed data lives only in Supabase seed scripts, clearly separated from app code.

## Stack
Flutter (stable channel) + Dart, Riverpod for state, go_router for navigation, Supabase (Postgres, Auth, RLS, Storage) as backend. Material 3 base with Cupertino-adaptive touches. See `.claude/rules/` for detail.

## Rules index (load on demand)
- `.claude/rules/design-system.md` design tokens, both themes, typography, motion
- `.claude/rules/architecture.md` folders, state, navigation, data layer
- `.claude/rules/data-model.md` Supabase schema, RLS, the ledger invariant
- `.claude/rules/screens.md` every screen and its acceptance criteria
- `.claude/rules/shariah-and-compliance.md` the rules that gate launch

## Commands
- Install: `flutter pub get`
- Run: `flutter run`
- Analyze (must pass, zero warnings): `flutter analyze`
- Format: `dart format .`
- Test: `flutter test`
- Codegen (Riverpod, models): `dart run build_runner build --delete-conflicting-outputs`

## Working rules
- Read `flutterv9.2.md` and the relevant `.claude/rules/` file before each feature.
- One feature at a time. Mark it done only after `flutter analyze` is clean and its widget test passes end to end, not when the code is written.
- Update `docs/PROGRESS.md` at the end of every session: what is done, what is next.
- Minimal changes. Do not refactor unrelated code. One logical commit per change.
- When two approaches are reasonable, explain both and let Muzahid choose. Do not invent product or religious decisions.
