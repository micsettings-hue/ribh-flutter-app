import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/prayer/prayer_service.dart';
import 'package:ribh/data/prayer/salah_alarms.dart';
import 'package:ribh/features/services/prayer_screen.dart';

// Dhaka.
const _lat = 23.8103;
const _lng = 90.4125;

class FakePrayerService implements PrayerService {
  FakePrayerService({this.failure});

  final Failure? failure;

  @override
  Future<Result<PrayerSnapshot>> today() async => failure == null
      ? Ok(
          computePrayerSnapshot(
            latitude: _lat,
            longitude: _lng,
            day: DateTime(2026, 7, 12),
          ),
        )
      : Err(failure!);
}

class MemorySalahAlarmStore implements SalahAlarmStore {
  final _enabled = <Salah>{};

  @override
  Future<Set<Salah>> enabled() async => Set.of(_enabled);

  @override
  Future<void> setEnabled(Salah salah, bool on) async {
    on ? _enabled.add(salah) : _enabled.remove(salah);
  }
}

class FakeSalahScheduler implements SalahAlarmScheduler {
  FakeSalahScheduler({this.permissionGranted = true});

  final bool permissionGranted;
  final scheduled = <Salah, DateTime>{};
  final cancelled = <Salah>[];

  @override
  Future<bool> requestPermission() async => permissionGranted;

  @override
  Future<void> schedule(
    Salah salah,
    DateTime at,
    String title,
    String body,
  ) async {
    scheduled[salah] = at;
  }

  @override
  Future<void> cancel(Salah salah) async {
    cancelled.add(salah);
  }
}

Future<void> pumpPrayer(
  WidgetTester tester, {
  FakePrayerService? service,
  FakeSalahScheduler? scheduler,
  MemorySalahAlarmStore? store,
}) async {
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      retry: (retryCount, error) => null,
      overrides: [
        prayerServiceProvider.overrideWithValue(service ?? FakePrayerService()),
        salahAlarmSchedulerProvider.overrideWithValue(
          scheduler ?? FakeSalahScheduler(),
        ),
        salahAlarmStoreProvider.overrideWithValue(
          store ?? MemorySalahAlarmStore(),
        ),
      ],
      child: MaterialApp(
        theme: RibhTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PrayerScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('computePrayerSnapshot (Karachi method, Dhaka)', () {
    final snapshot = computePrayerSnapshot(
      latitude: _lat,
      longitude: _lng,
      day: DateTime(2026, 7, 12),
    );

    test('times are strictly ordered through the day', () {
      final times = snapshot.times;
      expect(
        times[Salah.fajr]!.isBefore(snapshot.sunrise) &&
            snapshot.sunrise.isBefore(times[Salah.dhuhr]!) &&
            times[Salah.dhuhr]!.isBefore(times[Salah.asr]!) &&
            times[Salah.asr]!.isBefore(times[Salah.maghrib]!) &&
            times[Salah.maghrib]!.isBefore(times[Salah.isha]!),
        isTrue,
      );
    });

    test('qibla bearing from Dhaka is west-northwest, near 278 degrees', () {
      expect(snapshot.qiblaBearing, closeTo(278.5, 1.5));
    });

    test('nextSalah walks the day and returns null after Isha', () {
      final fajr = snapshot.times[Salah.fajr]!;
      expect(
        snapshot.nextSalah(fajr.subtract(const Duration(minutes: 1))),
        Salah.fajr,
      );
      final isha = snapshot.times[Salah.isha]!;
      expect(snapshot.nextSalah(isha.add(const Duration(minutes: 1))), isNull);
    });
  });

  testWidgets('prayer screen: five real times, qibla bearing with honest '
      'compass fallback', (tester) async {
    await pumpPrayer(tester);

    for (final salah in ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha']) {
      expect(find.text(salah), findsWidgets);
    }
    expect(find.textContaining('° from north'), findsOneWidget);
    // No magnetometer events in tests: the fallback note must show.
    expect(
      find.textContaining('No compass reading is available'),
      findsOneWidget,
    );
    expect(find.textContaining('Karachi calculation method'), findsOneWidget);
  });

  testWidgets('alarm toggle schedules a real notification and persists', (
    tester,
  ) async {
    final scheduler = FakeSalahScheduler();
    final store = MemorySalahAlarmStore();
    await pumpPrayer(tester, scheduler: scheduler, store: store);

    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();

    expect(scheduler.scheduled.containsKey(Salah.fajr), isTrue);
    expect(await store.enabled(), {Salah.fajr});

    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();
    expect(scheduler.cancelled, [Salah.fajr]);
    expect(await store.enabled(), isEmpty);
  });

  testWidgets('refused notification permission keeps the alarm off, stated '
      'plainly', (tester) async {
    final scheduler = FakeSalahScheduler(permissionGranted: false);
    final store = MemorySalahAlarmStore();
    await pumpPrayer(tester, scheduler: scheduler, store: store);

    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();

    expect(scheduler.scheduled, isEmpty);
    expect(await store.enabled(), isEmpty);
    expect(
      find.text('Notification permission was refused, so the alarm stays off.'),
      findsOneWidget,
    );
  });

  testWidgets('location unavailable is an honest error state with retry', (
    tester,
  ) async {
    await pumpPrayer(
      tester,
      service: FakePrayerService(failure: const LocationUnavailableFailure()),
    );

    expect(
      find.textContaining('Location is off or permission was refused'),
      findsOneWidget,
    );
    expect(find.text('Retry'), findsOneWidget);
  });
}
