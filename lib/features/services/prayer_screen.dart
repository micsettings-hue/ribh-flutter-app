import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/failures/failure.dart';
import '../../data/prayer/prayer_service.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/haptics.dart';
import '../../shared/icon_chip.dart';
import 'prayer_controller.dart';

/// Prayer: real times for the device location (Karachi method, board-gated),
/// a qibla dial from the magnetometer with an honest numeric fallback, and
/// salah alarms as real local notifications the user toggles.
class PrayerScreen extends ConsumerWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final prayer = ref.watch(prayerControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.servicePrayer)),
      body: prayer.when(
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  failureText(
                    l10n,
                    error is Failure ? error : UnknownFailure('$error'),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => ref.invalidate(prayerControllerProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (data) => _PrayerBody(data: data),
      ),
    );
  }
}

String salahLabel(AppLocalizations l10n, Salah salah) => switch (salah) {
  Salah.fajr => l10n.salahFajr,
  Salah.dhuhr => l10n.salahDhuhr,
  Salah.asr => l10n.salahAsr,
  Salah.maghrib => l10n.salahMaghrib,
  Salah.isha => l10n.salahIsha,
};

class _PrayerBody extends ConsumerStatefulWidget {
  const _PrayerBody({required this.data});

  final PrayerData data;

  @override
  ConsumerState<_PrayerBody> createState() => _PrayerBodyState();
}

class _PrayerBodyState extends ConsumerState<_PrayerBody> {
  StreamSubscription<MagnetometerEvent>? _magnetometer;

  /// Degrees from north the device is facing, or null when no magnetometer
  /// events arrive (the honest fallback).
  double? _heading;
  String? _alarmError;

  @override
  void initState() {
    super.initState();
    _magnetometer = magnetometerEventStream().listen(
      (event) {
        final heading =
            (math.atan2(event.y, event.x) * 180 / math.pi + 360) % 360;
        if (mounted) setState(() => _heading = heading);
      },
      onError: (Object _) {},
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    unawaited(_magnetometer?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final data = widget.data;
    final snapshot = data.snapshot;
    final now = DateTime.now();
    final next = snapshot.nextSalah(now);
    final timeFormat = DateFormat.jm(locale);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          l10n.prayerLocationLine(
            snapshot.latitude.toStringAsFixed(2),
            snapshot.longitude.toStringAsFixed(2),
          ),
          style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                for (final salah in Salah.values)
                  ListTile(
                    dense: true,
                    leading: Icon(
                      salah == next
                          ? LucideIcons.circleDot
                          : LucideIcons.circle,
                      size: 16,
                      color: salah == next ? tokens.teal : tokens.inkSoft,
                    ),
                    title: Text(salahLabel(l10n, salah)),
                    subtitle: salah == next ? Text(l10n.prayerNext) : null,
                    trailing: Text(
                      timeFormat.format(snapshot.times[salah]!),
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.prayerMethodNote,
          style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
        ),
        const SizedBox(height: 20),
        Text(l10n.qiblaTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Semantics(
                  label: l10n.qiblaBearingLine(
                    snapshot.qiblaBearing.toStringAsFixed(0),
                  ),
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: tokens.line, width: 1.5),
                            color: tokens.mintSoft,
                          ),
                        ),
                        Transform.rotate(
                          angle:
                              (snapshot.qiblaBearing - (_heading ?? 0)) *
                              math.pi /
                              180,
                          child: Icon(
                            LucideIcons.navigation,
                            size: 44,
                            color: tokens.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.qiblaBearingLine(
                    snapshot.qiblaBearing.toStringAsFixed(0),
                  ),
                  style: theme.textTheme.titleSmall,
                ),
                if (_heading == null) ...[
                  const SizedBox(height: 4),
                  Text(
                    l10n.qiblaFallbackNote,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.inkSoft,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(l10n.prayerAlarmsTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        if (_alarmError != null)
          Text(
            _alarmError!,
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.danger),
          ),
        for (final salah in Salah.values)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const RibhIconChip(
              icon: LucideIcons.bellRing,
              size: RibhIconChip.sm,
            ),
            value: data.alarms.contains(salah),
            title: Text(salahLabel(l10n, salah)),
            subtitle: Text(timeFormat.format(snapshot.times[salah]!)),
            onChanged: (on) async {
              RibhHaptics.select();
              setState(() => _alarmError = null);
              final result = await ref
                  .read(prayerControllerProvider.notifier)
                  .toggleAlarm(
                    salah,
                    on: on,
                    notificationTitle: l10n.salahAlarmTitle(
                      salahLabel(l10n, salah),
                    ),
                    notificationBody: l10n.salahAlarmBody,
                  );
              if (!mounted) return;
              result.fold(
                (_) {},
                (_) => setState(
                  () => _alarmError = l10n.prayerAlarmPermissionDenied,
                ),
              );
            },
          ),
      ],
    );
  }
}
