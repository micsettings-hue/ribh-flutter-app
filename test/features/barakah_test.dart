import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/shared/animated_progress.dart';
import 'package:ribh/core/constants/barakah_score.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/local/favourites_store.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/engagement_repository.dart';
import 'package:ribh/data/repositories/learn_repository.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/features/barakah/barakah_controller.dart';
import 'package:ribh/features/barakah/barakah_screen.dart';
import 'package:ribh/features/services/services_controllers.dart' show isoDay;

class FakeEngagementRepository extends EngagementRepository {
  FakeEngagementRepository({Engagement? initial})
    : engagement =
          initial ??
          Engagement(
            profileId: 'u1',
            adhkarCounts: const {},
            habitDays: const {},
            prayerStreak: 0,
            score: 0,
            updatedAt: DateTime.utc(2026, 7, 12),
          ),
      super(null);

  Engagement engagement;
  int? savedScore;

  @override
  Future<Result<Engagement>> myEngagement() async => Ok(engagement);

  @override
  Future<Result<Engagement>> saveEngagement({
    Map<String, dynamic>? adhkarCounts,
    Map<String, dynamic>? habitDays,
    int? prayerStreak,
    int? score,
  }) async {
    engagement = Engagement(
      profileId: engagement.profileId,
      adhkarCounts: adhkarCounts ?? engagement.adhkarCounts,
      habitDays: habitDays ?? engagement.habitDays,
      prayerStreak: prayerStreak ?? engagement.prayerStreak,
      score: score ?? engagement.score,
      updatedAt: DateTime.utc(2026, 7, 12),
    );
    savedScore = score;
    return Ok(engagement);
  }
}

class FakeLearnRepository extends LearnRepository {
  FakeLearnRepository() : super(null);

  @override
  Future<Result<List<Lesson>>> lessons() async => Ok([
    Lesson(
      id: 'l1',
      slug: 'halal-investing-basics',
      title: 'Halal investing basics (pending Shariah review)',
      sort: 1,
      createdAt: DateTime.utc(2026, 6, 1),
    ),
  ]);

  @override
  Future<Result<Map<String, LessonProgress>>> myProgress() async =>
      const Ok({});
}

class MemoryFavouritesStore implements FavouritesStore {
  final _favourites = <String>{};

  @override
  Future<Set<String>> favourites() async => Set.of(_favourites);

  @override
  Future<void> toggle(String id) async {
    _favourites.contains(id) ? _favourites.remove(id) : _favourites.add(id);
  }
}

Future<void> pumpBarakah(
  WidgetTester tester, {
  FakeEngagementRepository? engagement,
  MemoryFavouritesStore? favourites,
}) async {
  tester.view.physicalSize = const Size(800, 2800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      retry: (retryCount, error) => null,
      overrides: [
        engagementRepositoryProvider.overrideWithValue(
          engagement ?? FakeEngagementRepository(),
        ),
        learnRepositoryProvider.overrideWithValue(FakeLearnRepository()),
        favouritesStoreProvider.overrideWithValue(
          favourites ?? MemoryFavouritesStore(),
        ),
      ],
      child: MaterialApp(
        theme: RibhTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const BarakahScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('barakahScore', () {
    test('weights and caps per component, 100 max', () {
      expect(barakahScore(givingDays30: 0, prayerStreak: 0, adhkarDays7: 0), 0);
      expect(
        barakahScore(givingDays30: 5, prayerStreak: 4, adhkarDays7: 2),
        20 + 12 + 12,
      );
      expect(
        barakahScore(givingDays30: 30, prayerStreak: 30, adhkarDays7: 7),
        100,
      );
    });
  });

  group('nextPrayerStreak (never punitive)', () {
    final today = DateTime(2026, 7, 12);

    test('first check starts at one', () {
      expect(nextPrayerStreak(current: 0, lastCheck: null, today: today), 1);
    });

    test('consecutive day increments', () {
      expect(
        nextPrayerStreak(
          current: 4,
          lastCheck: DateTime(2026, 7, 11),
          today: today,
        ),
        5,
      );
    });

    test('same day is a no-op', () {
      expect(nextPrayerStreak(current: 4, lastCheck: today, today: today), 4);
    });

    test('a gap simply starts again at one', () {
      expect(
        nextPrayerStreak(
          current: 9,
          lastCheck: DateTime(2026, 7, 8),
          today: today,
        ),
        1,
      );
    });
  });

  testWidgets('score renders with the never-measures-worship line and all '
      'six blocks are present', (tester) async {
    await pumpBarakah(tester);

    expect(find.byType(RibhScoreRing), findsOneWidget);
    expect(tester.widget<RibhScoreRing>(find.byType(RibhScoreRing)).score, 0);
    expect(
      find.textContaining('It never measures worship itself'),
      findsOneWidget,
    );
    expect(find.text('Adhkar and tasbih'), findsOneWidget);
    expect(find.text('Daily reflection'), findsOneWidget);
    expect(find.text('Prayer check-in'), findsOneWidget);
    expect(find.text('Continue learning'), findsOneWidget);
    expect(find.text("Today's sadaqah"), findsOneWidget);
  });

  testWidgets('tasbih taps persist per day and feed the score', (tester) async {
    final engagement = FakeEngagementRepository();
    await pumpBarakah(tester, engagement: engagement);

    // Target the tasbih button specifically; the score ring also shows a
    // number now, so a bare find.text('0') would be ambiguous.
    await tester.tap(find.widgetWithText(FilledButton, '0'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '1'));
    await tester.pumpAndSettle();

    expect(find.text('2 of 33 today'), findsOneWidget);
    final tasbih =
        engagement.engagement.adhkarCounts['tasbih'] as Map<String, dynamic>;
    expect(tasbih[isoDay(DateTime.now())], 2);
    // One adhkar day = 6 points.
    expect(engagement.savedScore, 6);
    expect(tester.widget<RibhScoreRing>(find.byType(RibhScoreRing)).score, 6);
  });

  testWidgets('prayer check-in works once per day and never punishes', (
    tester,
  ) async {
    final engagement = FakeEngagementRepository();
    await pumpBarakah(tester, engagement: engagement);

    await tester.tap(find.text('I prayed today'));
    await tester.pumpAndSettle();

    expect(engagement.engagement.prayerStreak, 1);
    expect(find.text('Checked in for today.'), findsOneWidget);
    expect(find.text('I prayed today'), findsNothing);
    expect(find.text('Current streak: 1 days'), findsOneWidget);
    expect(
      find.textContaining('A missed day simply starts again'),
      findsOneWidget,
    );
  });

  testWidgets('daily item favourite toggle persists to the store', (
    tester,
  ) async {
    final store = MemoryFavouritesStore();
    await pumpBarakah(tester, favourites: store);

    await tester.tap(find.byTooltip('Save to favourites'));
    await tester.pumpAndSettle();

    expect(await store.favourites(), {dailyItemIdFor(DateTime.now())});
    // The board-gated line stays: mechanics work, text awaits review.
    expect(find.textContaining('after Shariah board review'), findsOneWidget);
  });

  testWidgets('capture: barakah', (tester) async {
    await pumpBarakah(tester);
    await expectLater(
      find.byType(BarakahScreen),
      matchesGoldenFile('captures/barakah.png'),
    );
  });
}
