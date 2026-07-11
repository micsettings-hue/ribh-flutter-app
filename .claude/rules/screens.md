# Screens and acceptance criteria

Each screen is done when its criteria pass, `flutter analyze` is clean, and a widget test drives the happy path plus one failure path. No demo stubs: every listed action is a real repository call.

## Home
- Amanah summary: balance derived from the ledger, never a literal. Available, deployed, in-recovery shown. Add funds and Withdraw open real sheets. Ledger link opens Wallet.
- Portfolio row: real `investments` for the user, ordered running, matured, recovery. Card Hero-transitions to campaign detail.
- Barakah banner: real PageView, auto-advance, pause on touch, off under reduce-motion.
- Open campaigns list: real open campaigns, live funding percent, contract and projected annualised rate (computed from real terms, marked projected), working watchlist bookmark persisted to the user's saved set.
- Where's my money: reflects the user's largest live deployment with the real current stage.
- Goals summary: real goals, read-only here.
- Services grid: six tiles, each navigates to its real page.
- News and Insight: real content items.
- Pull-to-refresh reloads all Home providers.

## Invest
- Real marketplace with All, Open, Matured, Saved filters and working search.
- Auto-invest entry opens the strategy and approval queue.
- Cards Hero into detail.

## Campaign detail
- Live funding and metadata from Supabase.
- Calculator uses the canonical formula (core constant), updates live.
- Contract basis explainer, and recovery tracker when status is in_recovery.
- Invest requires both risk acknowledgements ticked; commit writes `investments` plus a `wallet_transactions` row via one RPC, then updates portfolio. Insufficient balance shows a real error, not a crash.

## Grow
- Ribh Fund view, auto-invest strategy picker writing `auto_invest_rules`, goal create and edit writing `goals`.

## Barakah
- Score from `engagement`, with the explicit line that it never measures worship itself.
- Adhkar and tasbih with a real persisted tap counter and target.
- Daily ayah or hadith (TODO board) with save to favourites.
- Prayer streak self-check feeding the score, never punitive, never public.
- Learn shortcut to the next unread module.
- Sadaqah nudge linking to the Sadaqah page.

## Me
- Account, Shariah board (real member records, two are TODO board placeholders that must be replaced before launch), security and 2FA, KYC status and flow, nominee, statements, language and theme toggles that persist, help and disputes.
- The only tab with profile access. No avatar in any other tab header.

## Service pages
- Learn: modules with per-user progress persisted.
- Zakat: calculator with live derived total and due; Nisab status against a real silver-standard threshold from a metals price source; three-slide banner; Ribh Welfare project cards with real progress; giving records a `welfare_contribution` and ledger row; no fee taken from Zakat.
- Sadaqah: tracker from real contributions; daily give writes ledger plus welfare row; habit grid from `engagement`; Your Forest from `trees`.
- Wallet: all figures derived; performance chart of cumulative invested plus profit by month with a real date range, no fake volatility; Savings routes to the approval queue; real payouts; add and withdraw (2FA); append-only ledger list.
- Prayer: real times for device location (Karachi method), Qibla dial from magnetometer with fallback, salah alarms via real local notifications the user can toggle and time.
- Qard: education plus a real notify-me that records interest; honestly labelled coming soon.
- Invite: real referral link and share; points on sign-up plus verification only; points-to-trees with real conversion and provenance.

## Sheets
Deposit, withdraw (2FA), KYC steps, auto-invest strategy, purification, notifications, dispute. Shared scaffold, all writing real state.
