import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/constants/risk_tiers.dart';
import '../../core/failures/failure.dart';
import '../../core/formatters/taka.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/goal_row.dart';
import '../../shared/empty_state.dart';
import '../../shared/skeleton_box.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import '../home/home_controllers.dart';
import 'approve_queue_sheet.dart';
import 'auto_invest_sheet.dart';
import 'goal_sheet.dart';
import 'grow_controller.dart';

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
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final rule = data.rule;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
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
                l10n.growFundTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.growFundBody,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(LucideIcons.refreshCw),
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
        const SizedBox(height: 20),
        Text(l10n.growQueueTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        if (data.pendingQueue.isEmpty)
          EmptyState(
            icon: LucideIcons.inbox,
            title: l10n.emptyTitle,
            body: l10n.growQueueEmpty,
          )
        else
          for (final entry in data.pendingQueue)
            Card(
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
                    const SizedBox(height: 2),
                    Text(
                      l10n.growQueueProposal(
                        formatTaka(rule?.budget ?? 0, localeCode: locale),
                      ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: tokens.inkSoft,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: rule == null
                                ? null
                                : () => showRibhSheet<void>(
                                    context: context,
                                    builder: (_) => ApproveQueueSheet(
                                      entry: entry,
                                      budget: rule.budget,
                                    ),
                                  ),
                            child: Text(l10n.growQueueApprove),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => ref
                                .read(growControllerProvider.notifier)
                                .decline(entry.item.id),
                            child: Text(l10n.growQueueDecline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        const SizedBox(height: 20),
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
