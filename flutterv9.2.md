# flutterv9.2.md · RIBH Flutter build specification

This is the master build brief for the RIBH Investments Flutter app, derived from prototype v9.2 and the pre-Flutter architecture dossier. Claude Code reads this before starting work. `CLAUDE.md` holds the always-on non-negotiables; this file holds the how.

The prototype is a reference for layout, content, and behaviour, not a source to transliterate. Build a native Flutter app with a genuinely Flutter-grade UI and UX, not an HTML port.

---

## 0. Prime directives

1. **No demo anything.** The HTML prototype used `toast('Opens X')` stubs and hardcoded numbers to fake behaviour. None of that survives. Every button, tile, form, and toggle performs its real action against Supabase or real device APIs. If a feature cannot yet be real (for example bKash settlement without merchant credentials), it is gated behind a clearly labelled feature flag and a real "not yet available" state, not a fake success toast.
2. **The ledger cannot lie.** Wallet balance is never stored as a mutable number. It is always derived from the sum of append-only `wallet_transactions`. Every deposit, investment, distribution, payout, purification, and sadaqah writes exactly one signed row.
3. **Consent is explicit.** No user money is deployed without an approval step. Two risk acknowledgements before any investment commits. Savings flows through the auto-invest approval queue.
4. **Faith content is placeholder.** Every religious string is `// TODO(board)` until Abdullah Jubair signs off. Never generate rulings, fatwas, or translations of Quran or hadith as if final.
5. **Accessibility and honesty are structural.** AA contrast in both themes, 44dp minimum touch targets, a risk disclosure wherever a return appears, no dark patterns.

---

## 1. The Flutter-grade UI/UX upgrade

The prototype proved the information architecture. Flutter lets us make it feel native and alive. Apply these upgrades:

- **Adaptive by platform.** Material 3 on Android, Cupertino-flavoured transitions, scroll physics, and modals on iOS. Use `Theme.of(context).platform` and adaptive widgets rather than one look on both.
- **Real motion, not CSS fakes.** Shared-element (Hero) transitions from a portfolio card to its campaign detail. `AnimatedSwitcher` for state changes. Physics-based list scrolling. The Barakah banner uses a real `PageView` with a timer, pausable on touch, disabled when the OS reduce-motion flag is set (`MediaQuery.disableAnimations`).
- **Skeleton loaders,** not spinners, for every data-backed surface (amanah card, portfolio, campaign list, wallet, ledger). Content appears progressively.
- **Optimistic UI with rollback** for money-adjacent actions: reflect the intent immediately, confirm against Supabase, roll back visibly on failure with a clear message.
- **Haptics** on commit actions (invest, give, plant, deposit) via `HapticFeedback`.
- **Pull-to-refresh** on Home, Invest, Wallet, and the campaign list.
- **Empty states that teach.** Before a user has investments, goals, or trees, each surface explains the concept and offers the first action, rather than showing a blank card.
- **One design language across both themes.** Light and dark are the same system re-tokenised, matching the prototype's Mint Modern palette. See `.claude/rules/design-system.md`.
- **Bengali and English** are first-class from day one. Every string comes from the localisation layer (`flutter_localizations` + ARB files), never a literal in a widget. Numerals render in the user's locale. Anek Bangla for Bengali, Hanken Grotesk and Inter for Latin.

---

## 2. Architecture at a glance

```
lib/
  main.dart
  app/            router (go_router), theme, localization wiring
  core/           result types, formatters (taka, dates, hijri), failures, constants
  data/
    models/       freezed models mirroring the Supabase schema
    repositories/ one repository per aggregate (wallet, campaigns, investments, ...)
    supabase/     client, generated queries, RLS-aware calls
  features/
    home/         widgets + controllers for the Home tab
    invest/       marketplace, filters, auto-invest
    grow/         fund, auto-invest strategy, goals editing
    barakah/      score, adhkar, ayah, streak, learn shortcut
    me/           account, board, security, KYC, statements
    services/     learn, zakat, sadaqah, wallet, prayer, qard, invite
    campaign/     detail, calculator, recovery tracker
    sheets/       shared bottom sheets (deposit, withdraw, kyc, ...)
  shared/         reusable widgets (AmanahCard, RiskDot, LedgerRow, ...)
```

- **State:** Riverpod with code generation. One controller (AsyncNotifier) per screen or aggregate. No business logic in widgets.
- **Navigation:** go_router with typed routes. Tabs via a `StatefulShellRoute`. Service pages and campaign detail are pushed routes with Hero transitions. Sheets are `showModalBottomSheet` with a shared scaffold.
- **Data:** every read and write goes through a repository that returns a `Result<T, Failure>`. Repositories talk to Supabase. Widgets never touch Supabase directly.
- Full detail in `.claude/rules/architecture.md`.

---

## 3. Screens and features (all real, all actionable)

Detailed acceptance criteria per screen live in `.claude/rules/screens.md`. Summary of scope:

**Home (hub):** amanah summary card (balance derived from ledger), Portfolio row (real investments), auto-advancing Barakah banner, open-campaign list with live funding percent and working watchlist bookmarks, "where's my money" flow reflecting the user's largest live deployment, goals summary, the six-tile services grid, News and Insight. Pull-to-refresh. Every tile navigates to a real destination.

**Invest:** real campaign marketplace from Supabase with All / Open / Matured / Saved filters and search, the auto-invest strategy entry (opens strategy plus approval queue), and campaign cards that Hero-transition into detail.

**Campaign detail:** live funding, profit calculator using `investor_profit = (invested / 100000) * profit_per_lac * investor_share%`, contract basis explainer, and the recovery tracker for campaigns in recovery. Invest action requires two risk acknowledgements, then writes an `investments` row and a ledger transaction inside one transaction.

**Grow:** the Ribh Fund, the auto-invest strategy picker, and goal creation and editing (goals display on Home, are edited here).

**Barakah (enriched per dossier):** consistency score (never scores worship itself), adhkar and tasbih with a real tap counter and target, daily ayah or hadith (board placeholder) with save, gentle prayer streak self-check, a Learn shortcut to the next unread module, and a sadaqah nudge that links to the Sadaqah page. No leaderboards, no public worship display.

**Me:** account, the named Shariah board, security and 2FA, KYC status and flow, nominee, statements, language and theme, help and disputes. This tab is the only home for account and profile. No profile avatar appears in any other tab header.

**Service pages (open from Home grid, Learn pattern, real back navigation):**
- **Learn:** real modules with per-user progress persisted to Supabase.
- **Zakat:** working calculator, live Nisab status against a silver-standard threshold from a real metals price source, a three-slide educational banner, and Ribh Welfare project cards with real funding progress. Giving routes to eligible recipients; Ribh takes no fee from Zakat.
- **Sadaqah:** tracker, one-tap daily give (10, 20, 50, 100) to Ribh Welfare writing a real ledger and welfare-contribution row, habit grid, and Your Forest (real trees earned).
- **Wallet:** financial state (all derived), performance chart of cumulative invested plus profit by month with a date range (no fake stock-style volatility), Savings via the approval queue, real payouts list, add funds, withdraw (2FA gated), and the append-only ledger view.
- **Prayer:** real prayer times for the device location using a stated calculation method (Karachi convention for Bangladesh), a Qibla dial driven by the device magnetometer with a graceful fallback, and salah alarms backed by real local notifications.
- **Qard e Hasanah:** the education and a real "notify me" that records interest, honestly labelled coming soon.
- **Invite:** real referral link and share, points earned on sign-up plus verification only (never on investing), and points-to-trees with real conversion; trees are arranged by the Ribh Welfare and community team.

**Sheet layer:** deposit (bKash, Nagad, bank), withdraw (2FA), KYC steps, auto-invest strategy, purification, notifications, and the rest, all shared and all writing real state.

---

## 4. Payments reality

Neither bKash nor Nagad offers an official Flutter SDK. Integrate their published merchant APIs (tokenized checkout) behind a `PaymentGateway` interface, using a secure in-app WebView or the merchant REST flow, with real credentials injected from Supabase secrets, never committed. Until merchant credentials exist, the deposit sheet shows a real, honest pending state, not a fake success. Bank transfer uses manual reference plus reconciliation.

---

## 5. Build order (milestones)

Work one milestone at a time. Do not start the next until the current one's acceptance tests pass and `flutter analyze` is clean.

- **M0 Foundation:** project, theming (both modes), localization scaffold, go_router shell with five empty tabs, Supabase client, CI running analyze plus test. Definition of done: app launches to a themed empty shell in both locales.
- **M1 Data spine:** Supabase schema and RLS from `.claude/rules/data-model.md`, models, repositories, the ledger invariant with a Postgres check that balance equals SUM(transactions). Seed script (separate from app code).
- **M2 Auth and KYC:** Supabase Auth, onboarding, the real KYC flow, risk profiling.
- **M3 Wallet and money rail:** wallet, ledger view, deposit and withdraw sheets, PaymentGateway interface with the honest pending state.
- **M4 Invest core:** marketplace, campaign detail, calculator, the two-acknowledgement invest flow writing investment plus ledger atomically, portfolio on Home.
- **M5 Home hub:** amanah summary, portfolio row, open list, where's-my-money, banner, services grid, news.
- **M6 Grow and auto-invest:** fund, strategy picker, approval queue, goals.
- **M7 Service pages:** Learn, Zakat, Sadaqah, Wallet performance, Prayer, Qard, Invite.
- **M8 Barakah enrichment:** the six blocks.
- **M9 Polish:** motion, skeletons, empty states, haptics, accessibility audit, localization completeness, store prep.

---

## 6. Definition of done (every feature)

- `flutter analyze` clean, zero warnings.
- `dart format .` applied.
- A widget or integration test drives the feature end to end and passes.
- No hardcoded strings; all copy from ARB files in both languages (Bengali faith copy may be `TODO(board)` but the key exists).
- No demo stubs. Every action is wired to a real repository call.
- Money features: verified that the ledger row is written and the derived balance matches.
- `docs/PROGRESS.md` updated.

---

## 7. Explicit non-goals for v1

- No discretionary fund management until a signed Wakalah mandate and licence exist. Savings stays in the approval-queue model.
- No in-app Zakat distribution beyond Ribh Welfare projects until the board approves the structure.
- No secondary market or withdrawal of live (deployed) capital.
- No cash referral rewards, ever. Trees only.

---

## 8. Where the truth lives

- Product and religious decisions: Muzahid and the Shariah board. Claude Code does not invent them.
- Layout and content reference: `docs/ribh-app-prototype-v9-2.html`.
- Architecture and diagrams: `docs/ribh-pre-flutter-dossier.html`.
- The launch-gating rules: `.claude/rules/shariah-and-compliance.md`.
