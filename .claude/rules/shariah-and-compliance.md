# Shariah and compliance (launch gates)

These do not block development, but they block launch. Claude Code must keep the code honest so these can be satisfied, and must never fake them.

## Shariah
- All faith-facing copy is placeholder until Abdullah Jubair (board chair) signs off: Zakat guidance, Nisab standard and threshold, Sadaqah framing, Qard content, prayer calculation method, adhkar, and any ayah or hadith. Mark every such string `// TODO(board)` and keep it in the ARB file so translation and review are trackable.
- The two additional board members in the prototype are placeholders. Real, consenting scholars must replace them before launch. Never present placeholders as real.
- Never generate a fatwa, ruling, or scriptural translation as final output.
- Riba guardrails in product logic: referral rewards are trees, never cash or fee credit. Qard repayment is at par. Ribh takes no fee out of Zakat.

## Consent and discretion
- No deployment of user funds without an explicit approval step.
- Savings uses the auto-invest approval queue. True discretionary management requires a signed Wakalah mandate and the relevant licence, which is out of scope for v1.

## Regulatory
- BSEC and Bangladesh Bank registration must be complete before real funds move. Until then, the money rail runs against sandbox or is gated. Do not ship a path that moves real public money pre-registration.
- KYC and AML: deposits only from the user's own verified accounts. Source-of-funds captured at KYC.

## Honesty in UI
- Risk disclosure wherever a return or projection appears. Projections are labelled projected and never guaranteed.
- No claim of certification. The wording is AAOIFI-aligned.
- The performance chart never implies daily tradable volatility.

## Accessibility
- AA contrast both themes, 44dp targets, reduce-motion respected, full Bengali and English parity before launch.
