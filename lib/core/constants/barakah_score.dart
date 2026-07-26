/// The Barakah score. It reflects APP HABITS ONLY: giving through the app,
/// the self-reported prayer check-in, and adhkar counter use. It never
/// measures worship itself, is never punitive, and is never public. The UI
/// must state this wherever the score appears.
library;

/// Daily tasbih target for the adhkar counter.
/// TODO(board): target and adhkar set need board sign-off before launch.
const int tasbihDailyTarget = 33;

/// The point ceiling of each score component. They sum to 100.
const int barakahGivingCap = 40;
const int barakahPrayerCap = 30;
const int barakahAdhkarCap = 30;

int _cap(int value, int max) => value > max ? max : (value < 0 ? 0 : value);

/// Points from giving: 4 per distinct giving day in the last 30, up to 40.
int barakahGivingPoints(int givingDays30) => _cap(givingDays30 * 4, barakahGivingCap);

/// Points from the self-check streak: 3 per current streak day, up to 30.
int barakahPrayerPoints(int prayerStreak) => _cap(prayerStreak * 3, barakahPrayerCap);

/// Points from adhkar: 6 per day with counter use in the last 7, up to 30.
int barakahAdhkarPoints(int adhkarDays7) => _cap(adhkarDays7 * 6, barakahAdhkarCap);

/// Score out of 100, the sum of the three app-habit components. Kept in
/// lockstep with the per-component functions above so a breakdown UI and the
/// score can never disagree.
int barakahScore({
  required int givingDays30,
  required int prayerStreak,
  required int adhkarDays7,
}) =>
    barakahGivingPoints(givingDays30) +
    barakahPrayerPoints(prayerStreak) +
    barakahAdhkarPoints(adhkarDays7);

/// The prayer self-check streak transition. Never punitive: a gap simply
/// starts again at one, with no penalty state and no negative messaging.
/// Checking twice on one day changes nothing.
int nextPrayerStreak({
  required int current,
  required DateTime? lastCheck,
  required DateTime today,
}) {
  if (lastCheck == null) return 1;
  final last = DateTime(lastCheck.year, lastCheck.month, lastCheck.day);
  final day = DateTime(today.year, today.month, today.day);
  final gap = day.difference(last).inDays;
  if (gap == 0) return current;
  if (gap == 1) return current + 1;
  return 1;
}
