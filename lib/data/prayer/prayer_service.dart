import 'package:adhan/adhan.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/failures/failure.dart';
import '../../core/result/result.dart';

enum Salah { fajr, dhuhr, asr, maghrib, isha }

/// One day's computed times plus the qibla bearing for the same location.
/// Times come from the adhan library with the Karachi method.
/// TODO(board): the calculation method needs board sign-off before launch.
class PrayerSnapshot {
  const PrayerSnapshot({
    required this.latitude,
    required this.longitude,
    required this.times,
    required this.sunrise,
    required this.qiblaBearing,
  });

  final double latitude;
  final double longitude;
  final Map<Salah, DateTime> times;
  final DateTime sunrise;

  /// Degrees from true north to the Kaaba.
  final double qiblaBearing;

  /// The next upcoming salah after [now], or null when today is done.
  Salah? nextSalah(DateTime now) {
    for (final salah in Salah.values) {
      if (times[salah]!.isAfter(now)) return salah;
    }
    return null;
  }
}

/// Pure calculation from coordinates, shared by the device service and the
/// unit tests: Karachi method times for [day] plus the qibla bearing.
PrayerSnapshot computePrayerSnapshot({
  required double latitude,
  required double longitude,
  required DateTime day,
}) {
  final coordinates = Coordinates(latitude, longitude);
  final params = CalculationMethod.karachi.getParameters();
  final prayerTimes = PrayerTimes(
    coordinates,
    DateComponents.from(day),
    params,
  );
  return PrayerSnapshot(
    latitude: latitude,
    longitude: longitude,
    times: {
      Salah.fajr: prayerTimes.fajr.toLocal(),
      Salah.dhuhr: prayerTimes.dhuhr.toLocal(),
      Salah.asr: prayerTimes.asr.toLocal(),
      Salah.maghrib: prayerTimes.maghrib.toLocal(),
      Salah.isha: prayerTimes.isha.toLocal(),
    },
    sunrise: prayerTimes.sunrise.toLocal(),
    qiblaBearing: Qibla(coordinates).direction,
  );
}

abstract class PrayerService {
  /// Today's times and qibla for the real device location. Fails typed when
  /// location services or permission are unavailable; nothing is estimated.
  Future<Result<PrayerSnapshot>> today();
}

class DevicePrayerService implements PrayerService {
  const DevicePrayerService();

  @override
  Future<Result<PrayerSnapshot>> today() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return const Err(LocationUnavailableFailure('location_disabled'));
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return const Err(LocationUnavailableFailure());
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );
      return Ok(
        computePrayerSnapshot(
          latitude: position.latitude,
          longitude: position.longitude,
          day: DateTime.now(),
        ),
      );
    } catch (e) {
      return Err(LocationUnavailableFailure(e.toString()));
    }
  }
}

final prayerServiceProvider = Provider<PrayerService>(
  (ref) => const DevicePrayerService(),
);
