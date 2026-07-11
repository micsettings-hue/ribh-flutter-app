# RIBH Investments — Pre-Launch Feature Roadmap & Specification Register

**Document status:** Draft v1.0 for team review
**Owner:** MIC
**Last updated:** 8 July 2026
**Purpose:** A single agreed reference for the features to add before public launch, sourced from a competitor benchmark (Wahed, bKash, Kestrl). This is the register we build against and verify against later. Nothing here is built yet; this document defines the scope.

---

## How to read this document

Each feature has four fields kept deliberately short so this stays a working reference, not a wall of text:

- **Feature** — the name we use across the team.
- **Action** — what the user does, or what the system does.
- **Result** — the outcome, why it earns its place.
- **Condition** — the Shariah, brand, or compliance guardrail it must respect. Non-negotiable items are marked.

Every feature also carries a **Status** (`Not started` at creation) and a **Source** (which competitor proved it works). Update the Status column as work progresses so this doubles as a verification checklist.

**Standing conditions that apply to every feature below:**
- Always say "AAOIFI-aligned," never "AAOIFI-certified."
- No guaranteed capital or returns anywhere; risk disclosure required wherever returns appear.
- No em-dashes, no emoji, minimal stroke icons only.
- Anything touching Shariah-facing copy or worship must be reviewed by Abdullah Jubair before launch.

---

## Priority summary

The recommended pre-launch build order, so the team knows what blocks what.

| Rank | Feature | Why this order |
|---|---|---|
| 1 | Real deposit rail (bKash / Nagad) | Hard blocker. No real rail, no launch. |
| 2 | Weekly micro-deposit from Tk250 | The core growth engine; depends on the rail. |
| 3 | Named Shariah board | Biggest credibility gap on paper; can proceed in parallel. |
| 4 | Nominee assignment | Compliance and trust expectation for any BD financial product. |
| 5 | Risk profiling questionnaire | Activation; feeds strategy tiers already built. |
| 6 | Onboarding walkthrough | Makes the honesty of the model land instead of confusing. |
| 7 | Referral program | Growth; the tree hook already exists. |
| 8 | Everything else below | Launch-phase polish, sequenced after the above. |

---

## Group A — From Wahed (managed product and credibility)

| Feature | Action | Result | Condition | Source | Status |
|---|---|---|---|---|---|
| Risk profiling questionnaire | User answers a short onboarding quiz | Recommends a strategy tier so first-timers are not dropped straight into picking campaigns | Recommendation only, never advice; each deployment still needs its own risk acknowledgement | Wahed | Not started |
| In-app risk-level switching | User changes their strategy tier anytime from the app | No support contact needed; removes the friction Wahed's own users complained about | Change applies to future queued deployments only, not retroactively to live capital | Wahed | Not started |
| Annual purification and Zakat report | User downloads one yearly statement | Summarizes zakatable holdings; turns the Zakat calculator into a real deliverable | Guidance not fatwa; figures labelled and dated; scholar review of methodology | Wahed | Not started |
| Named Shariah board | Display 2-3 named scholars around Abdullah Jubair in-app | Closes the single biggest credibility gap vs. Wahed's full-time board | **Non-negotiable.** Real, consenting, named scholars only; no implied endorsement without sign-off | Wahed | Not started |

## Group B — From bKash (recurring-habit engine and trust)

| Feature | Action | Result | Condition | Source | Status |
|---|---|---|---|---|---|
| Real deposit rail | User funds the wallet via live bKash and Nagad | Replaces the simulated flow; the one hard blocker to a real launch | **Non-negotiable.** Funds must arrive from the user's own verified, name-matched account (AML) | bKash | Not started |
| Weekly micro-deposit from Tk250 | User sets a recurring auto-save into the Ribh Fund | Mirrors the DPS habit millions already have; the most important growth mechanic | Recurring deposit is fine; recurring *deployment* still routes through per-deal approval | bKash | Not started |
| Nominee assignment | User names a beneficiary during KYC | Expected of any BD financial product; a trust and succession signal | Ties to Faraid rules; nominee is custodial, not a substitute for Islamic inheritance | bKash | Not started |
| Account statement with spending insight | User downloads a transaction statement with a simple visual history | Extends the append-only ledger into a familiar, exportable format | Read-only view of the ledger; never editable | bKash | Not started |
| Auto-pay style reminders | System sends due-date and campaign-closing reminders | Timely nudges without nagging; reuses the salah-aware notification system | Respects quiet hours around prayer times; no pressure or urgency framing | bKash | Not started |

## Group C — From Kestrl (goals, screening, and B2B seed)

| Feature | Action | Result | Condition | Source | Status |
|---|---|---|---|---|---|
| Named goal sub-accounts | User creates named pots (Hajj, Qurbani, Marriage) with recurring auto-fund | Extends existing goal pots with the naming and auto-fund Kestrl proves users love | Capital at risk; targets aspirational, never guaranteed | Kestrl | Not started |
| Interest-purification tool | User calculates incidental haram income and routes it to charity | Covers a core Muslim-money expectation RIBH does not yet address | Methodology reviewed by scholar; charity destination transparent | Kestrl | Not started |
| Transparency screening explainer | User taps "why this campaign is halal" on any deal | Deepens the per-contract Shariah note into a point-of-decision trust feature | Plain language; must reflect the actual contract, not marketing | Kestrl | Not started |

## Group D — Cross-cutting (table stakes, appears in all three)

| Feature | Action | Result | Condition | Source | Status |
|---|---|---|---|---|---|
| Onboarding walkthrough | First-run explainer of amanah, contracts, and risk | The honesty of the model lands instead of confusing new users | Must state capital-at-risk clearly up front | All three | Not started |
| Referral program | User invites others; both are rewarded | Growth channel every one of these apps grew on; the tree hook already exists | Reward must not be framed as guaranteed return or riba | All three | Not started |
| Live chat and dispute entry | User reaches a human and can open a dispute | Trust in Islamic finance is fragile; users expect real support | Dispute path: negotiation, then arbitration, then Shariah arbitration | All three | Not started |

---

## Already built in the prototype (v0.7) — for reference, do not rebuild

So the register is complete and we do not duplicate effort, these benchmarked capabilities already exist in the prototype: amanah custody tracker, append-only signed ledger, live recovery tracker, auto-invest strategy menu with per-deal approval queue, goal pots with ledger-backed refunds, Zakat calculator, Nisab tracker, round-up saving, daily micro-save (Tk10/day), Knowledge Hub and lessons, KYC with source-of-funds, security controls, bilingual English/Bangla, light and dark themes, and the local database mirroring the future Supabase schema.

---

## Structural gaps not solved by any single feature above

Flagged so they stay visible; these are business and regulatory, not screens to build.

- **Regulatory registration.** BSEC and Bangladesh Bank registration still under process. Blocks nothing in the prototype but blocks real fund custody at launch.
- **Asset concentration.** One asset class (trade campaigns) today. Gold and sukuk exposure is a launch-phase moat, not pre-launch.
- **Single Shariah reviewer.** Addressed on paper by the Named Shariah Board feature, but the underlying governance (board charter, review cadence, published opinions) needs setting up alongside it.
- **B2B licensing.** The Kestrl "Values-as-a-Service" play (licensing the amanah tracker and screening stack to Islamic banks) is a future revenue line, noted here so it is not forgotten.

---

## Verification checklist (use at build sign-off)

Before any feature above is marked done, confirm:

- [ ] Meets its stated Condition, and any non-negotiable is fully honoured.
- [ ] Shariah-facing copy reviewed and signed off by Abdullah Jubair.
- [ ] Risk disclosure present wherever returns or projections appear.
- [ ] Terminology uses "AAOIFI-aligned," not "certified."
- [ ] No em-dashes, no emoji, stroke icons only.
- [ ] Bilingual strings (English and Bangla) complete.
- [ ] Money-moving actions write to the append-only ledger.
- [ ] AML rule enforced where funds enter (own verified, name-matched source).

---

*Prepared for RIBH Investments / RIBH Capital Group. Competitor facts in the benchmark were drawn from public sources as of July 2026 and should be re-verified before any external use, since fintech features and fees change often.*
