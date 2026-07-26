import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../app/theme/spacing.dart';
import '../../core/constants/risk_tiers.dart';
import '../../core/failures/failure.dart';
import '../../core/formatters/taka.dart';
import '../../shared/chart_palette.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/goal_row.dart';
import '../../shared/empty_state.dart';
import '../../shared/icon_chip.dart';
import '../../shared/skeleton_box.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import '../home/home_controllers.dart';
import 'approve_queue_sheet.dart';
import 'auto_invest_sheet.dart';
import 'goal_sheet.dart';
import 'grow_controller.dart';
import 'ribh_fund_controller.dart';

/// Grow (M6): the Ribh Fund view under the approval-queue consent model,
/// the auto-invest strategy, the pending-proposal queue, and goals.
class GrowScreen extends ConsumerWidget {
  const GrowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final grow = ref.watch(growControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabGrow)),
      body: grow.when(
        skipLoadingOnRefresh: false,
        loading: () => const _GrowSkeleton(),
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
                  onPressed: () => ref.invalidate(growControllerProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (data) => RefreshIndicator(
          onRefresh: () async {
            ref
              ..invalidate(growControllerProvider)
              ..invalidate(homeGoalsProvider);
            await ref.read(growControllerProvider.future);
          },
          child: _GrowBody(data: data),
        ),
      ),
    );
  }
}

class _GrowSkeleton extends StatelessWidget {
  const _GrowSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        for (final height in [120.0, 84.0, 84.0]) ...[
          SkeletonBox(height: height),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _GrowBody extends ConsumerWidget {
  const _GrowBody({required this.data});

  final GrowData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final rule = data.rule;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        const _RibhFundCard(),
        const SizedBox(height: RibhSpace.lg),
        Card(
          child: ListTile(
            leading: const RibhIconChip(
              icon: LucideIcons.refreshCw,
              size: RibhIconChip.sm,
            ),
            title: Text(l10n.growAutoInvestTitle),
            subtitle: Text(
              rule == null
                  ? l10n.growAutoInvestOff
                  : rule.active
                  ? l10n.growAutoInvestOn(
                      _strategyName(l10n, rule.strategy),
                      formatTaka(rule.budget, localeCode: locale),
                    )
                  : l10n.growAutoInvestPaused,
            ),
            trailing: const Icon(LucideIcons.chevronRight),
            onTap: () => showRibhSheet<void>(
              context: context,
              builder: (_) => AutoInvestSheet(existing: rule),
            ),
          ),
        ),
        const SizedBox(height: RibhSpace.xxl),
        Text(l10n.growQueueTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: RibhSpace.sm),
        if (data.pendingQueue.isEmpty)
          EmptyState(
            icon: LucideIcons.inbox,
            title: l10n.emptyTitle,
            body: l10n.growQueueEmpty,
          )
        else
          for (final entry in data.pendingQueue)
            _QueueCard(entry: entry, budget: rule?.budget),
        const SizedBox(height: RibhSpace.xxl),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.homeGoalsTitle,
                style: theme.textTheme.titleMedium,
              ),
            ),
            TextButton.icon(
              icon: const Icon(LucideIcons.plus, size: 16),
              label: Text(l10n.growGoalsAdd),
              onPressed: () => showRibhSheet<void>(
                context: context,
                builder: (_) => const GoalSheet(),
              ),
            ),
          ],
        ),
        const _GrowGoals(),
      ],
    );
  }

  String _strategyName(AppLocalizations l10n, String strategy) =>
      switch (RiskTier.fromDb(strategy)) {
        RiskTier.short => l10n.riskTierShort,
        RiskTier.balanced => l10n.riskTierBalanced,
        RiskTier.diversified => l10n.riskTierDiversified,
        null => strategy,
      };
}

/// One pending auto-invest proposal. Approve opens the consent sheet (which
/// morphs to a checkmark on success); decline plays a slide-out before the
/// list drops the row, so neither path is an instant cut. Gated on
/// reduce-motion.
class _QueueCard extends ConsumerStatefulWidget {
  const _QueueCard({required this.entry, required this.budget});

  final QueueEntry entry;

  /// The rule budget in poisha; null when no rule exists (approve disabled).
  final int? budget;

  @override
  ConsumerState<_QueueCard> createState() => _QueueCardState();
}

class _QueueCardState extends ConsumerState<_QueueCard> {
  bool _declining = false;

  Future<void> _decline() async {
    setState(() => _declining = true);
    if (!MediaQuery.of(context).disableAnimations) {
      await Future<void>.delayed(const Duration(milliseconds: 260));
    }
    if (!mounted) return;
    await ref
        .read(growControllerProvider.notifier)
        .decline(widget.entry.item.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final entry = widget.entry;
    final budget = widget.budget;

    Widget card = Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.campaign.title.isEmpty
                  ? entry.campaign.sector
                  : entry.campaign.title,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: RibhSpace.xs),
            Text(
              l10n.growQueueProposal(
                formatTaka(budget ?? 0, localeCode: locale),
              ),
              style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
            ),
            const SizedBox(height: RibhSpace.sm),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: (budget == null || _declining)
                        ? null
                        : () => showRibhSheet<void>(
                            context: context,
                            builder: (_) => ApproveQueueSheet(
                              entry: entry,
                              budget: budget,
                            ),
                          ),
                    child: Text(l10n.growQueueApprove),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _declining ? null : _decline,
                    child: Text(l10n.growQueueDecline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (_declining && !MediaQuery.of(context).disableAnimations) {
      card = card
          .animate()
          .slideX(begin: 0, end: 1.05, duration: 260.ms, curve: Curves.easeIn)
          .fadeOut(duration: 260.ms);
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: RibhSpace.sm),
      child: card,
    );
  }
}

/// Deployed capital by sector as a donut with a labelled legend. Colour
/// encodes sector identity from the validated categorical palette (fixed
/// order); the legend carries name + share so identity is never colour-alone
/// and the share is directly labelled. A 7th+ sector folds into "Other".
class _DiversificationDonut extends StatelessWidget {
  const _DiversificationDonut({required this.sectors});

  final List<SectorSlice> sectors;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final palette = categoricalPalette(context);
    final reduce = MediaQuery.of(context).disableAnimations;

    // Fold any sectors beyond the palette into a single "Other" slice.
    final max = palette.length;
    final display = <({String label, double share, Color color})>[];
    if (sectors.length <= max) {
      for (var i = 0; i < sectors.length; i++) {
        display.add((
          label: _RibhFundCard._titleCase(sectors[i].sector),
          share: sectors[i].share,
          color: palette[i],
        ));
      }
    } else {
      for (var i = 0; i < max - 1; i++) {
        display.add((
          label: _RibhFundCard._titleCase(sectors[i].sector),
          share: sectors[i].share,
          color: palette[i],
        ));
      }
      final rest = sectors
          .skip(max - 1)
          .fold<double>(0, (sum, s) => sum + s.share);
      display.add((label: 'Other', share: rest, color: tokens.inkSoft));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 108,
          height: 108,
          child: PieChart(
            duration: reduce
                ? Duration.zero
                : const Duration(milliseconds: 700),
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 30,
              startDegreeOffset: -90,
              sections: [
                for (final d in display)
                  PieChartSectionData(
                    value: d.share * 100,
                    color: d.color,
                    radius: 20,
                    showTitle: false,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: RibhSpace.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final d in display)
                Padding(
                  padding: const EdgeInsets.only(bottom: RibhSpace.sm),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: d.color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: RibhSpace.sm),
                      Expanded(
                        child: Text(
                          l10nSectorShare(context, d.label, d.share),
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Sector · NN%" from the shared ARB string.
String l10nSectorShare(BuildContext context, String label, double share) {
  final l10n = AppLocalizations.of(context)!;
  return l10n.growFundSectorShare(label, (share * 100).toStringAsFixed(0));
}

/// The Ribh Fund view: the educational gradient header, plus a live picture
/// of the user's participation derived from real holdings. Deployed and
/// in-recovery mirror the Amanah summary; the blended rate is a projection
/// carrying its own disclosure. Empty and error states are honest.
class _RibhFundCard extends ConsumerWidget {
  const _RibhFundCard();

  static String _titleCase(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final onGradient = Colors.white;
    final fund = ref.watch(ribhFundSummaryProvider);

    Widget figure(String label, int poisha) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: onGradient.withValues(alpha: 0.75),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          formatTaka(poisha, localeCode: locale),
          style: theme.textTheme.titleMedium?.copyWith(
            color: onGradient,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );

    Widget header(Widget? footer) => Container(
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
            l10n.growFundTitle,
            style: theme.textTheme.titleMedium?.copyWith(color: onGradient),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.growFundBody,
            style: theme.textTheme.bodySmall?.copyWith(
              color: onGradient.withValues(alpha: 0.85),
            ),
          ),
          if (footer != null) ...[const SizedBox(height: 16), footer],
        ],
      ),
    );

    return fund.when(
      skipLoadingOnRefresh: false,
      loading: () => header(
        Row(
          children: [
            Expanded(child: figure(l10n.amanahDeployedLabel, 0)),
            const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
      error: (_, _) => header(
        Text(
          l10n.growFundBlendedNote,
          style: theme.textTheme.bodySmall?.copyWith(
            color: onGradient.withValues(alpha: 0.85),
          ),
        ),
      ),
      data: (data) {
        if (data.isEmpty) {
          return header(
            Text(
              l10n.growFundEmpty,
              style: theme.textTheme.bodySmall?.copyWith(
                color: onGradient.withValues(alpha: 0.9),
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header(
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: figure(l10n.amanahDeployedLabel, data.deployed)),
                  if (data.inRecovery > 0)
                    Expanded(
                      child: figure(l10n.amanahInRecoveryLabel, data.inRecovery),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.blendedProjectedRate case final rate?) ...[
                      Text(
                        l10n.growFundBlendedRate,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: tokens.inkSoft,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.marketProjectedRate(rate.toStringAsFixed(1)),
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: tokens.tealDeep,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.growFundBlendedNote,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.inkSoft,
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                    Text(
                      l10n.growFundSpread(data.deploymentCount, data.sectorCount),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.growFundDiversification,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: tokens.inkSoft,
                      ),
                    ),
                    const SizedBox(height: RibhSpace.md),
                    _DiversificationDonut(sectors: data.sectors),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GrowGoals extends ConsumerWidget {
  const _GrowGoals();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final goals = ref.watch(homeGoalsProvider);

    return goals.when(
      skipLoadingOnRefresh: false,
      loading: () => Container(
        height: 56,
        decoration: BoxDecoration(
          color: tokens.mintSoft,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      error: (error, _) => Row(
        children: [
          Expanded(
            child: Text(
              failureText(
                l10n,
                error is Failure ? error : UnknownFailure('$error'),
              ),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
            ),
          ),
          TextButton(
            onPressed: () => ref.invalidate(homeGoalsProvider),
            child: Text(l10n.retry),
          ),
        ],
      ),
      data: (list) => list.isEmpty
          ? Text(
              l10n.growGoalsEmpty,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
            )
          : Column(
              children: [
                for (final goal in list)
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => showRibhSheet<void>(
                      context: context,
                      builder: (_) => GoalSheet(existing: goal),
                    ),
                    child: GoalRow(goal: goal),
                  ),
              ],
            ),
    );
  }
}
