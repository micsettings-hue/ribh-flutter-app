import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/failures/failure.dart';
import '../../core/formatters/taka.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'give_sheet.dart';
import 'services_controllers.dart';

/// Sadaqah: tracker from real contributions, quick give writing ledger plus
/// welfare row, the 30-day habit grid from engagement, and Your Forest from
/// actually pledged and planted trees.
class SadaqahScreen extends ConsumerWidget {
  const SadaqahScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final sadaqah = ref.watch(sadaqahControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.serviceSadaqah)),
      body: sadaqah.when(
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
                  onPressed: () => ref.invalidate(sadaqahControllerProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (data) => _SadaqahBody(data: data),
      ),
    );
  }
}

class _SadaqahBody extends ConsumerWidget {
  const _SadaqahBody({required this.data});

  final SadaqahData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final now = DateTime.now();

    void openGive([int? preset]) => showRibhSheet<void>(
      context: context,
      builder: (_) => GiveSheet(
        title: l10n.giveSadaqahCta,
        projects: data.projects,
        presetAmount: preset,
        onGive: ref.read(sadaqahControllerProvider.notifier).give,
      ),
    );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [tokens.amanahGradientStart, tokens.amanahGradientEnd],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.sadaqahMonthLine(
                  formatTaka(data.monthTotal(now), localeCode: locale),
                ),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.sadaqahLifetimeLine(
                  formatTaka(data.lifetimeTotal, localeCode: locale),
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (final takaAmount in [10, 50, 100]) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: data.projects.isEmpty
                      ? null
                      : () => openGive(takaAmount * 100),
                  child: Text(formatTaka(takaAmount * 100, localeCode: locale)),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: FilledButton(
                onPressed: data.projects.isEmpty ? null : () => openGive(),
                child: Text(l10n.giveSadaqahCta),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(l10n.sadaqahHabitTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        _HabitGrid(data: data, now: now),
        const SizedBox(height: 4),
        Text(
          l10n.sadaqahHabitCount(data.habitCount(now)),
          style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
        ),
        const SizedBox(height: 20),
        Text(l10n.forestTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        if (data.trees.isEmpty)
          Text(
            l10n.forestCount(0),
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          )
        else ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tree in data.trees)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: tree.plantedAt == null
                        ? tokens.mintSoft
                        : tokens.mint,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: tokens.line, width: 1.5),
                  ),
                  child: Tooltip(
                    message: tree.plantedAt == null
                        ? l10n.treePledged
                        : l10n.treePlanted,
                    child: Icon(
                      LucideIcons.sprout,
                      size: 18,
                      color: tree.plantedAt == null
                          ? tokens.inkSoft
                          : tokens.tealDeep,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            l10n.forestCount(data.trees.length),
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          ),
        ],
      ],
    );
  }
}

class _HabitGrid extends StatelessWidget {
  const _HabitGrid({required this.data, required this.now});

  final SadaqahData data;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        // Oldest to newest, ending today.
        for (var back = 29; back >= 0; back--)
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color:
                  data.habitDays.contains(
                    isoDay(now.subtract(Duration(days: back))),
                  )
                  ? tokens.green
                  : tokens.mintSoft,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: tokens.line),
            ),
          ),
      ],
    );
  }
}
