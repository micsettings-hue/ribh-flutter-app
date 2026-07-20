# M10 — Admin and content management

Added after the pre-Flutter dossier and flutterv9.2.md. This milestone does not touch payment processing. It gives Muzahid (and later, trusted staff) a real way to manage campaigns, welfare projects, banners, and news content without hand-editing Supabase tables.

## Does this involve real payment?

No. M10 writes and edits content rows (campaigns, welfare projects, news items, banner slides). It does not create, move, or touch money. The money rail (deposit, withdraw, investment, ledger) was built in M3 and M4 and is untouched by this milestone. The only relationship: a campaign created here becomes something a real user can invest real money into later, through the flows M3/M4 already built. M10 is upstream content management, not a financial feature.

## Why this milestone exists

Supabase Studio (the web dashboard at supabase.com) already lets you edit any table directly, that works today with zero extra build. M10 exists because raw table editing is workable for one founder short-term but is not durable: it has no role separation, no audit trail, no image upload flow, and no protection against a typo taking down a live campaign. M10 builds a proper, minimal admin surface instead.

## Scope

**In scope:**
- An `admin` role on `profiles`, and RLS write policies scoped to that role for `campaigns`, `welfare_projects`, `news_items`, `banner_slides`.
- A CRUD interface for: campaigns (create, edit funding figures and status, close/mark matured/mark in_recovery), welfare projects (create, edit progress), news and insight items, and Barakah/home banner slides.
- Image upload for banner and news thumbnails, via Supabase Storage.
- An audit log: every admin write records who changed what and when, in a separate `admin_audit_log` table. This matters specifically because campaign and welfare data drives what real users see and invest in.
- Basic role-gated login: only accounts with `role = 'admin'` in `profiles` can reach this surface at all.

**Out of scope (explicitly not this milestone):**
- Any change to payment processing, deposits, withdrawals, or the ledger.
- Approving individual user KYC or investments (that stays in the main app's existing flows).
- Any Shariah content authoring tool. Faith copy still goes through Abdullah Jubair directly, not through this panel, until the board defines its own review workflow.

## Two build options, pick one before starting

**Option A: separate lightweight web tool (recommended to start).** Use Retool, Appsmith, or a similarly quick form-builder connected directly to the Supabase Postgres database. Fastest to have working, no Flutter code, easiest to hand to non-technical staff later. Downside: another vendor, another login, not native to the codebase.

**Option B: a small Flutter web admin app in the same repo.** A second Flutter target (`flutter create --platforms=web` in a separate `admin/` folder or package) reusing the existing repositories from `lib/data/`, gated by the admin role. More consistent with the existing codebase and design system, more build time, and something Claude Code can build and test the same way as the rest of the app.

Recommendation: start with Option A to unblock content management immediately, revisit Option B later if the team grows and a fully integrated tool becomes worth the investment.

## Definition of done
- `flutter analyze` clean (Option B) or the tool is connected and a test campaign can be created, edited, and closed end to end (Option A).
- RLS confirmed: a non-admin user account cannot write to `campaigns`, `welfare_projects`, `news_items`, or `banner_slides`, verified by an explicit test, not assumed.
- Every write to those four tables produces a matching `admin_audit_log` row.
- `docs/PROGRESS.md` updated noting M10 is done and which option was built.
