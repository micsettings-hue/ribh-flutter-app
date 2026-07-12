-- SEED DATA. Dev and staging only. Never run against production and never
-- bundled in the app. Campaign names come from the prototype and are clearly
-- seed, not real offerings. Amounts are in poisha (1 taka = 100 poisha).

-- Sample campaigns (prototype set). business_id is null in seed; real
-- campaigns require a real business profile.
insert into public.campaigns
  (id, business_id, title, contract, sector, pool, raised, profit_per_lac, share, tenure, risk, status)
values
  ('11111111-1111-4111-8111-111111111101', null, 'Printing Zone', 'murabaha', 'printing',
   500000000, 210000000, 1450000, 60.00, 6, 'moderate', 'open'),
  ('11111111-1111-4111-8111-111111111102', null, 'Machinery Purchase', 'murabaha', 'machinery',
   800000000, 800000000, 1600000, 60.00, 9, 'moderate', 'running'),
  ('11111111-1111-4111-8111-111111111103', null, 'Machinery Trading', 'musharakah', 'machinery',
   600000000, 600000000, 1750000, 55.00, 12, 'elevated', 'matured'),
  ('11111111-1111-4111-8111-111111111104', null, 'Musannif Cement', 'murabaha', 'construction',
   1000000000, 1000000000, 1500000, 60.00, 12, 'elevated', 'in_recovery')
on conflict (id) do nothing;

comment on table public.campaigns is
  'Seed rows are the prototype sample set (Printing Zone, Machinery Purchase, Machinery Trading, Musannif Cement). Dev/staging only.';

-- Ribh Welfare projects (seed).
insert into public.welfare_projects (id, sector, title, district, target, raised)
values
  ('22222222-2222-4222-8222-222222222201', 'water', 'Tube wells for char villages', 'Kurigram', 120000000, 45000000),
  ('22222222-2222-4222-8222-222222222202', 'education', 'Primary school repair', 'Sunamganj', 200000000, 80000000),
  ('22222222-2222-4222-8222-222222222203', 'trees', 'Coastal tree drive', 'Satkhira', 60000000, 22000000)
on conflict (id) do nothing;

-- Lesson catalogue (seed). Titles are placeholders; all faith-facing lesson
-- content is TODO(board) and lives in the app's ARB files for review.
insert into public.lessons (id, slug, title, sort)
values
  ('33333333-3333-4333-8333-333333333301', 'halal-investing-basics', 'TODO(board): Halal investing basics', 1),
  ('33333333-3333-4333-8333-333333333302', 'murabaha-explained', 'TODO(board): Murabaha explained', 2),
  ('33333333-3333-4333-8333-333333333303', 'understanding-risk', 'Understanding risk', 3),
  ('33333333-3333-4333-8333-333333333304', 'zakat-on-investments', 'TODO(board): Zakat on investments', 4)
on conflict (id) do nothing;
