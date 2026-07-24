import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/router/routes.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../app/theme/spacing.dart';
import '../../core/constants/barakah_score.dart';
import '../../core/failures/failure.dart';
import '../../shared/animated_progress.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/haptics.dart';
import '../../shared/motion.dart';
import 'barakah_controller.dart';

/// Barakah (M8): the six blocks. The score reflects app habits only and the
/// screen says so; the prayer check is self-reported, never punitive, never
/// public; the daily item's text is board-gated while its mechanics work.
class BarakahScreen extends ConsumerWidget {
  const BarakahScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final barakah = ref.watch(barakahControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabBarakah)),
      body: barakah.when(
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
                  onPressed: () => ref.invalidate(barakahControllerProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (data) => RefreshIndicator(
          onRefresh: () => ref.refresh(barakahControllerProvider.future),
          child: _BarakahBody(data: data),
        ),
      ),
    );
  }
}

class _BarakahBody extends ConsumerWidget {
  const _BarakahBody({required this.data});

  final BarakahData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final notifier = ref.read(barakahControllerProvider.notifier);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        // 1. Score, with the honesty line.
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RibhScoreRing(
                score: data.score,
                max: 100,
                size: 96,
                stroke: 8,
                trackColor: Colors.white.withValues(alpha: 0.22),
                progressColor: Colors.white,
                textColor: Colors.white,
              ),
              const SizedBox(width: RibhSpace.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.tabBarakah,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.barakahScoreHonesty,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // 2. Adhkar and tasbih counter.
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.tasbihTitle, style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  l10n.tasbihProgress(data.tasbihToday, tasbihDailyTarget),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.inkSoft,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Semantics(
                    button: true,
                    label: l10n.tasbihProgress(
                      data.tasbihToday,
                      tasbihDailyTarget,
                    ),
                    child: _TasbihButton(
                      count: data.tasbihToday,
                      onTap: () {
                        final reachedTarget =
                            data.tasbihToday + 1 == tasbihDailyTarget;
                        reachedTarget
                            ? RibhHaptics.success()
                            : RibhHaptics.tap();
                        notifier.tapTasbih();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                RibhProgressBar(
                  value: (data.tasbihToday / tasbihDailyTarget).clamp(0.0, 1.0),
                  color: tokens.green,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // 3. Daily ayah/hadith with save to favourites; text board-gated.
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.dailyItemTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.dailyItemFavourite,
                      onPressed: () =>
                          notifier.toggleFavourite(data.dailyItemId),
                      icon: Icon(
                        data.favourites.contains(data.dailyItemId)
                            ? LucideIcons.bookmarkCheck
                            : LucideIcons.bookmark,
                        size: 20,
                        color: data.favourites.contains(data.dailyItemId)
                            ? tokens.teal
                            : tokens.inkSoft,
                      ),
                    ),
                  ],
                ),
                Text(
                  dailyItemCitation(l10n, data.dailyItemId),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: tokens.tealDeep,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.dailyItemBoardGated,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.inkSoft,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // 4. Prayer streak self-check.
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.prayerCheckTitle, style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  l10n.prayerCheckStreak(data.engagement.prayerStreak),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.inkSoft,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.prayerCheckHonesty,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.inkSoft,
                  ),
                ),
                const SizedBox(height: 10),
                data.checkedToday
                    ? Row(
                        children: [
                          Icon(
                            LucideIcons.circleCheck,
                            size: 18,
                            color: tokens.teal,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.prayerCheckDone,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      )
                    : OutlinedButton(
                        onPressed: () => notifier.checkPrayerToday(),
                        child: Text(l10n.prayerCheckCta),
                      ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // 5. Learn shortcut to the next unread module.
        if (data.nextUnreadLesson case final lesson?)
          Card(
            child: ListTile(
              leading: const Icon(LucideIcons.bookOpen),
              title: Text(l10n.barakahLearnNext),
              subtitle: Text(lesson.title),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () => context.push(RibhRoutes.service('learn')),
            ),
          ),
        const SizedBox(height: 12),
        // 6. Sadaqah nudge.
        Card(
          child: ListTile(
            leading: const Icon(LucideIcons.heart),
            title: Text(l10n.barakahSadaqahNudge),
            subtitle: Text(l10n.bannerSlide3Sub),
            trailing: const Icon(LucideIcons.chevronRight),
            onTap: () => context.push(RibhRoutes.service('sadaqah')),
          ),
        ),
      ],
    );
  }
}

/// The tasbih tap target: a circular button whose number swaps on each tap
/// and which pops with a small scale-bounce (gated on reduce-motion). Haptics
/// are wired by the caller so the target tap can feel stronger.
class _TasbihButton extends StatelessWidget {
  const _TasbihButton({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final button = SizedBox(
      width: 120,
      height: 120,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: tokens.teal,
        ),
        onPressed: onTap,
        child: RibhSwap(
          child: Text(
            '$count',
            key: ValueKey(count),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
    if (MediaQuery.of(context).disableAnimations) return button;
    return button
        .animate(key: ValueKey(count))
        .scaleXY(begin: 0.92, end: 1, duration: 220.ms, curve: Curves.easeOutBack);
  }
}

String dailyItemCitation(AppLocalizations l10n, String id) => switch (id) {
  'quran-2-261' => l10n.dailyItemQuran2261,
  'hadith-consistency' => l10n.dailyItemHadithConsistency,
  'quran-13-28' => l10n.dailyItemQuran1328,
  _ => id,
};
