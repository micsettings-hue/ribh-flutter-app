-- Long-form lesson bodies. Board-gated placeholder content lives in the row
-- (like the title), so scholars edit data, not app builds. Empty until seeded.
alter table public.lessons
  add column if not exists body text not null default '';
