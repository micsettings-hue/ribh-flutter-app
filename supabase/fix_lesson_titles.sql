-- One-off data fix: the live dev DB was seeded before the TODO(board) title
-- fix, so lesson rows still carry the raw dev marker. seed.sql already has the
-- corrected titles for fresh seeds; this patches the already-seeded rows.
-- Idempotent: safe to run more than once.
update public.lessons
   set title = 'Halal investing basics (pending Shariah review)'
 where slug = 'halal-investing-basics';

update public.lessons
   set title = 'Murabaha explained (pending Shariah review)'
 where slug = 'murabaha-explained';

update public.lessons
   set title = 'Zakat on investments (pending Shariah review)'
 where slug = 'zakat-on-investments';

-- Verify: no title should contain the raw dev marker.
select slug, title from public.lessons order by sort;
