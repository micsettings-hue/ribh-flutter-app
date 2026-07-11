# Design system

Mint Modern, re-tokenised for Flutter. One system, two themes. Define in `lib/app/theme/` as a `RibhTheme` with `ColorScheme` plus custom token extensions (`ThemeExtension`).

## Color tokens

Light:
- teal `#0FA67A`, teal-deep `#06342A`, green `#14C48A`
- mint `#C8F5E2`, mint-soft `#EAFBF3`
- gold `#C99A2E`, gold-text `#8A6210` (use gold-text for any gold used as text, it passes AA)
- ink `#0B1A15`, ink-soft `#4C6960`, line `#D6ECE2`
- paper `#F7FBF9`, card `#FFFFFF`
- danger `#C2412E`, amber `#8C5E0E`, amber-soft `#FBF1DC`
- amanah gradient: `#0F6E56` to `#0A4C3B`

Dark:
- teal `#18C48A`, teal-deep `#0FA67A`, green `#3FE0A8`
- mint `#123A2C`, mint-soft `#0C2A20`
- gold and gold-text `#E0B84B`
- ink `#E8F7EF`, ink-soft `#8FB6A6`, line `#1C4133`
- paper `#061710`, card `#0E241B`
- danger `#E88C7A`, amber and amber-soft `#E0B84B` / `#332912`

Every text-on-background pair must pass WCAG AA in both themes. This is verified in the prototype; keep it.

## Typography
- Display and headings: Hanken Grotesk (600 to 800).
- Body and UI: Inter (400 to 600).
- Bengali: Anek Bangla. Wire via `google_fonts` or bundled fonts, selected by locale.
- Taka amounts use the `\u09F3` sign and locale-aware grouping (Indian grouping for bn, for example 1,28,400).

## Shape and elevation
- Card radius 15 to 18. Pills 999. Bottom sheets 24 top radius.
- Soft shadow only: subtle, low-opacity, matching the prototype. No hard Material elevation lines.
- 1.5dp borders on cards using the line token.

## Motion
- Page push: shared-element Hero on card-to-detail, 380ms, standard ease.
- Barakah banner: `PageView` auto-advancing every 4.2s, pauses on touch, off when `MediaQuery.of(context).disableAnimations`.
- State changes: `AnimatedSwitcher` 200 to 300ms.
- Respect reduce-motion everywhere: gate every non-essential animation on `disableAnimations`.

## Components to build in `lib/shared/`
AmanahCard, RiskDot, ContractPill, StatusPill (running/matured/recovery), CampaignListRow, PortfolioCard, BarakahBanner, ServiceTile, NewsCard, GoalRow, LedgerRow, MoneyFlow, SkeletonBox, RibhButton (primary/ghost), SectionHeader. Each themed via tokens, each with a golden test.

## Icons
Stroke-style only. Use a single icon set (for example `lucide_icons` or a bundled custom set matching the prototype's stroke SVGs). No filled or emoji icons.
