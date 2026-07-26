import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/barakah_score.dart';
import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../../data/local/favourites_store.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';
import '../services/services_controllers.dart' show isoDay;

part 'barakah_controller.g.dart';

/// Layout inside engagement.adhkar_counts (jsonb):
///   { "tasbih": { "yyyy-mm-dd": count }, "prayer_check": { "yyyy-mm-dd": true } }
/// habit_days stays what Sadaqah writes: { "yyyy-mm-dd": true } for giving.
Map<String, dynamic> _section(Map<String, dynamic> counts, String key) =>
    switch (counts[key]) {
      final Map<String, dynamic> map => map,
      _ => const <String, dynamic>{},
    };

/// The daily ayah/hadith rotation: citation ids only. The texts themselves
/// are board-gated; ids stay stable so favourites survive review.
const dailyItemIds = ['quran-2-261', 'hadith-consistency', 'quran-13-28'];

String dailyItemIdFor(DateTime day) {
  final dayOfYear = day.difference(DateTime(day.year)).inDays;
  return dailyItemIds[dayOfYear % dailyItemIds.length];
}

class BarakahData {
  const BarakahData({
    required this.engagement,
    required this.favourites,
    required this.nextUnreadLesson,
    required this.now,
  });

  final Engagement engagement;
  final Set<String> favourites;
  final Lesson? nextUnreadLesson;
  final DateTime now;

  Map<String, dynamic> get _tasbih =>
      _section(engagement.adhkarCounts, 'tasbih');
  Map<String, dynamic> get _prayerChecks =>
      _section(engagement.adhkarCounts, 'prayer_check');

  int get tasbihToday => switch (_tasbih[isoDay(now)]) {
    final num value => value.toInt(),
    _ => 0,
  };

  bool get checkedToday => _prayerChecks.containsKey(isoDay(now));

  DateTime? get lastPrayerCheck {
    DateTime? latest;
    for (final key in _prayerChecks.keys) {
      final day = DateTime.tryParse(key);
      if (day != null && (latest == null || day.isAfter(latest))) {
        latest = day;
      }
    }
    return latest;
  }

  int _daysWithin(Iterable<String> isoDays, int window) => isoDays.where((iso) {
    final day = DateTime.tryParse(iso);
    if (day == null) return false;
    final age = now.difference(day).inDays;
    return age >= 0 && age < window;
  }).length;

  int get givingDays30 => _daysWithin(engagement.habitDays.keys, 30);
  int get adhkarDays7 => _daysWithin(_tasbih.keys, 7);

  /// Whether each of the last 7 days had adhkar counter use, oldest first
  /// (index 6 is today). Drives the consistency row; feeds nothing punitive.
  List<bool> get adhkarLast7Days {
    final days = _tasbih.keys.toSet();
    return [
      for (var back = 6; back >= 0; back--)
        days.contains(isoDay(now.subtract(Duration(days: back)))),
    ];
  }

  int get score => barakahScore(
    givingDays30: givingDays30,
    prayerStreak: engagement.prayerStreak,
    adhkarDays7: adhkarDays7,
  );

  String get dailyItemId => dailyItemIdFor(now);
}

@riverpod
class BarakahController extends _$BarakahController {
  @override
  Future<BarakahData> build() async {
    final engagement =
        (await ref.watch(engagementRepositoryProvider).myEngagement()).fold(
          (value) => value,
          (failure) => throw failure,
        );
    final favourites = await ref.watch(favouritesStoreProvider).favourites();

    final learn = ref.watch(learnRepositoryProvider);
    final lessons = (await learn.lessons()).fold(
      (value) => value,
      (_) => const <Lesson>[],
    );
    final progress = (await learn.myProgress()).fold(
      (value) => value,
      (_) => const <String, LessonProgress>{},
    );
    Lesson? nextUnread;
    for (final lesson in lessons) {
      if (!(progress[lesson.id]?.completed ?? false)) {
        nextUnread = lesson;
        break;
      }
    }

    return BarakahData(
      engagement: engagement,
      favourites: favourites,
      nextUnreadLesson: nextUnread,
      now: DateTime.now(),
    );
  }

  /// One tasbih tap: counts persist per day; the score follows the formula.
  Future<Result<Engagement>> tapTasbih() => _mutate((data) {
    final today = isoDay(data.now);
    final tasbih = {
      ..._section(data.engagement.adhkarCounts, 'tasbih'),
      today: data.tasbihToday + 1,
    };
    return (
      adhkarCounts: {...data.engagement.adhkarCounts, 'tasbih': tasbih},
      prayerStreak: data.engagement.prayerStreak,
    );
  });

  /// The prayer self-check. Once per day; a gap restarts at one with no
  /// penalty. This is self-reported and feeds the score only.
  Future<Result<Engagement>> checkPrayerToday() => _mutate((data) {
    if (data.checkedToday) {
      return (
        adhkarCounts: data.engagement.adhkarCounts,
        prayerStreak: data.engagement.prayerStreak,
      );
    }
    final streak = nextPrayerStreak(
      current: data.engagement.prayerStreak,
      lastCheck: data.lastPrayerCheck,
      today: data.now,
    );
    final checks = {
      ..._section(data.engagement.adhkarCounts, 'prayer_check'),
      isoDay(data.now): true,
    };
    return (
      adhkarCounts: {...data.engagement.adhkarCounts, 'prayer_check': checks},
      prayerStreak: streak,
    );
  });

  Future<Result<Engagement>> _mutate(
    ({Map<String, dynamic> adhkarCounts, int prayerStreak}) Function(
      BarakahData data,
    )
    change,
  ) async {
    final data = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (data == null) return const Err(UnknownFailure('no_state'));
    final next = change(data);
    final updatedData = BarakahData(
      engagement: Engagement(
        profileId: data.engagement.profileId,
        adhkarCounts: next.adhkarCounts,
        habitDays: data.engagement.habitDays,
        prayerStreak: next.prayerStreak,
        score: data.engagement.score,
        updatedAt: data.engagement.updatedAt,
      ),
      favourites: data.favourites,
      nextUnreadLesson: data.nextUnreadLesson,
      now: data.now,
    );
    // Optimistic: taps feel immediate; a failed save reloads the truth.
    state = AsyncData(updatedData);
    final result = await ref
        .read(engagementRepositoryProvider)
        .saveEngagement(
          adhkarCounts: next.adhkarCounts,
          prayerStreak: next.prayerStreak,
          score: updatedData.score,
        );
    if (!result.isOk) ref.invalidateSelf();
    return result;
  }

  Future<void> toggleFavourite(String id) async {
    await ref.read(favouritesStoreProvider).toggle(id);
    final data = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (data == null) return;
    final favourites = data.favourites.contains(id)
        ? ({...data.favourites}..remove(id))
        : {...data.favourites, id};
    state = AsyncData(
      BarakahData(
        engagement: data.engagement,
        favourites: favourites,
        nextUnreadLesson: data.nextUnreadLesson,
        now: data.now,
      ),
    );
  }
}
