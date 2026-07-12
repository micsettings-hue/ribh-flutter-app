import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../../data/prayer/prayer_service.dart';
import '../../data/prayer/salah_alarms.dart';

part 'prayer_controller.g.dart';

class PrayerData {
  const PrayerData({required this.snapshot, required this.alarms});

  final PrayerSnapshot snapshot;
  final Set<Salah> alarms;
}

@riverpod
class PrayerController extends _$PrayerController {
  @override
  Future<PrayerData> build() async {
    final snapshot = (await ref.watch(prayerServiceProvider).today()).fold(
      (value) => value,
      (failure) => throw failure,
    );
    final alarms = await ref.watch(salahAlarmStoreProvider).enabled();
    return PrayerData(snapshot: snapshot, alarms: alarms);
  }

  /// Enables or disables one salah alarm. Enabling asks for notification
  /// permission and schedules a real daily local notification at the
  /// computed time; refusing permission keeps the alarm off, stated plainly.
  Future<Result<void>> toggleAlarm(
    Salah salah, {
    required bool on,
    required String notificationTitle,
    required String notificationBody,
  }) async {
    final data = switch (state) {
      AsyncData(:final value) => value,
      _ => null,
    };
    if (data == null) return const Ok(null);
    final scheduler = ref.read(salahAlarmSchedulerProvider);
    final store = ref.read(salahAlarmStoreProvider);

    if (on) {
      if (!await scheduler.requestPermission()) {
        return const Err(ValidationFailure('notifications_refused'));
      }
      final time = data.snapshot.times[salah]!;
      final next = time.isAfter(DateTime.now())
          ? time
          : time.add(const Duration(days: 1));
      await scheduler.schedule(
        salah,
        next,
        notificationTitle,
        notificationBody,
      );
    } else {
      await scheduler.cancel(salah);
    }
    await store.setEnabled(salah, on);
    ref.invalidateSelf();
    return const Ok(null);
  }
}
