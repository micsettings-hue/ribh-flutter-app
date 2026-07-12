import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'prayer_service.dart';

/// Which salah alarms the user enabled. A device-local preference, not
/// server state.
abstract class SalahAlarmStore {
  Future<Set<Salah>> enabled();
  Future<void> setEnabled(Salah salah, bool on);
}

class PrefsSalahAlarmStore implements SalahAlarmStore {
  static const _key = 'salah_alarms_enabled';

  @override
  Future<Set<Salah>> enabled() async {
    final prefs = await SharedPreferences.getInstance();
    final names = prefs.getStringList(_key) ?? const [];
    return {for (final name in names) ?Salah.values.asNameMap()[name]};
  }

  @override
  Future<void> setEnabled(Salah salah, bool on) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await enabled();
    final next = on ? {...current, salah} : ({...current}..remove(salah));
    await prefs.setStringList(_key, [for (final s in next) s.name]);
  }
}

/// Schedules real local notifications for salah times. The user toggles and
/// times them; nothing is scheduled without an explicit enable.
abstract class SalahAlarmScheduler {
  Future<bool> requestPermission();
  Future<void> schedule(Salah salah, DateTime at, String title, String body);
  Future<void> cancel(Salah salah);
}

class LocalNotificationsSalahScheduler implements SalahAlarmScheduler {
  LocalNotificationsSalahScheduler();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    tzdata.initializeTimeZones();
    final localZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localZone.identifier));
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
    _initialized = true;
  }

  @override
  Future<bool> requestPermission() async {
    await _ensureInitialized();
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, sound: true) ?? false;
    }
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    return false;
  }

  @override
  Future<void> schedule(
    Salah salah,
    DateTime at,
    String title,
    String body,
  ) async {
    await _ensureInitialized();
    await _plugin.zonedSchedule(
      id: salah.index,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(at, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'salah_alarms',
          'Salah alarms',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> cancel(Salah salah) async {
    await _ensureInitialized();
    await _plugin.cancel(id: salah.index);
  }
}

final salahAlarmStoreProvider = Provider<SalahAlarmStore>(
  (ref) => PrefsSalahAlarmStore(),
);

final salahAlarmSchedulerProvider = Provider<SalahAlarmScheduler>(
  (ref) => LocalNotificationsSalahScheduler(),
);
