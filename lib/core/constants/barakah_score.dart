/// The Barakah score. It reflects APP HABITS ONLY: giving through the app,
/// the self-reported prayer check-in, and adhkar counter use. It never
/// measures worship itself, is never punitive, and is never public. The UI
/// must state this wherever the score appears.
library;

/// Daily tasbih target for the adhkar counter.
/// TODO(board): target and adhkar set need board sign-off before launch.
const int tasbihDailyTarget = 33;

/// Score out of 100:
///   giving: 4 points per distinct giving day in the last 30, capped at 40;
///   prayer: 3 points per current self-check streak day, capped at 30;
///   adhkar: 6 points per day with counter use in the last 7, capped at 30.
int barakahScore({
  required int givingDays30,
  required int prayerStreak,
  required int adhkarDays7,
}) {
  int cap(int value, int max) => value > max ? max : (value < 0 ? 0 : value);
  return cap(givingDays30 * 4, 40) +
      cap(prayerStreak * 3, 30) +
      cap(adhkarDays7 * 6, 30);
}

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
