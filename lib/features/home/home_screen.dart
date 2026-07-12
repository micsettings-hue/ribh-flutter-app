import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/router/routes.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/failures/failure.dart';
import '../../core/formatters/taka.dart';
import '../../shared/amanah_card.dart';
import '../../shared/barakah_banner.dart';
import '../../shared/campaign_list_row.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/goal_row.dart';
import '../../shared/money_flow.dart';
import '../../shared/portfolio_card.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import '../../shared/service_tile.dart';
import '../invest/marketplace_controller.dart';
import '../wallet/deposit_sheet.dart';
import '../wallet/wallet_controller.dart';
import '../wallet/withdraw_sheet.dart';
import 'home_controllers.dart';
import 'portfolio_controller.dart';

/// The Home hub (M5). Every figure is derived from real repositories; the
/// only absent block is News and Insight, which needs a content source and
/// is stated honestly at the end of the list.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabHome)),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(amanahSummaryProvider)
            ..invalidate(portfolioControllerProvider)
            ..invalidate(marketplaceControllerProvider)
            ..invalidate(homeGoalsProvider)
            ..invalidate(walletControllerProvider);
          await ref.read(amanahSummaryProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            const _AmanahSection(),
            const SizedBox(height: 20),
            const _PortfolioSection(),
            const SizedBox(height: 20),
            BarakahBanner(
              onTap: () => context.go(RibhRoutes.barakah),
              slides: [
                BarakahSlide(
                  icon: LucideIcons.sprout,
                  title: l10n.bannerSlide1Title,
                  subtitle: l10n.bannerSlide1Sub,
                ),
                BarakahSlide(
                  icon: LucideIcons.moon,
                  title: l10n.bannerSlide2Title,
                  subtitle: l10n.bannerSlide2Sub,
                ),
                BarakahSlide(
                  icon: LucideIcons.heart,
                  title: l10n.bannerSlide3Title,
                  subtitle: l10n.bannerSlide3Sub,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const _OpenCampaignsSection(),
            const SizedBox(height: 20),
            const _WheresMyMoneySection(),
            const _GoalsSection(),
            const SizedBox(height: 20),
            Text(l10n.homeServicesTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            const _ServicesGrid(),
            const SizedBox(height: 16),
            Text(
              l10n.homeNewsComing,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.homeFooterDisclaimer,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                color: tokens.inkSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionError extends StatelessWidget {
  const _SectionError({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    return Row(
      children: [
        Expanded(
          child: Text(
            failureText(
              l10n,
              error is Failure ? error as Failure : UnknownFailure('$error'),
            ),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          ),
        ),
        TextButton(onPressed: onRetry, child: Text(l10n.retry)),
      ],
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: context.tokens.mintSoft,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class _AmanahSection extends ConsumerWidget {
  const _AmanahSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(amanahSummaryProvider);
    return summary.when(
      skipLoadingOnRefresh: false,
      loading: () => const _SkeletonBox(height: 190),
      error: (error, _) => _SectionError(
        error: error,
        onRetry: () => ref.invalidate(amanahSummaryProvider),
      ),
      data: (data) => AmanahCard(
        available: data.available,
        deployed: data.deployed,
        inRecovery: data.inRecovery,
        onOpenLedger: () => context.push(RibhRoutes.wallet),
        onAddFunds: () => showRibhSheet<void>(
          context: context,
          builder: (_) => const DepositSheet(),
        ),
        onWithdraw: () async {
          final wallet = await ref.read(walletControllerProvider.future);
          if (!context.mounted) return;
          await showRibhSheet<void>(
            context: context,
            builder: (_) =>
                WithdrawSheet(available: wallet.availableForWithdrawal),
          );
        },
      ),
    );
  }
}

class _PortfolioSection extends ConsumerWidget {
  const _PortfolioSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final portfolio = ref.watch(portfolioControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.homePortfolioTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        portfolio.when(
          skipLoadingOnRefresh: false,
          loading: () => const _SkeletonBox(height: 110),
          error: (error, _) => _SectionError(
            error: error,
            onRetry: () => ref.invalidate(portfolioControllerProvider),
          ),
          data: (holdings) => holdings.isEmpty
              ? Text(
                  l10n.homePortfolioEmpty,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.inkSoft,
                  ),
                )
              : SizedBox(
                  height: 128,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: holdings.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final holding = holdings[index];
                      return PortfolioCard(
                        investment: holding.investment,
                        campaign: holding.campaign,
                        onTap: () => context.push(
                          RibhRoutes.campaign(holding.campaign.id),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

class _OpenCampaignsSection extends ConsumerWidget {
  const _OpenCampaignsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final market = ref.watch(marketplaceControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.homeOpenCampaigns,
                style: theme.textTheme.titleMedium,
              ),
            ),
            TextButton(
              onPressed: () => context.go(RibhRoutes.invest),
              child: Text(l10n.homeSeeAll),
            ),
          ],
        ),
        market.when(
          skipLoadingOnRefresh: false,
          loading: () => const _SkeletonBox(height: 140),
          error: (error, _) => _SectionError(
            error: error,
            onRetry: () => ref.invalidate(marketplaceControllerProvider),
          ),
          data: (data) {
            final open = data.visible(MarketFilter.open, '');
            if (open.isEmpty) {
              return Text(
                l10n.homeOpenCampaignsEmpty,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: tokens.inkSoft,
                ),
              );
            }
            return Column(
              children: [
                for (final campaign in open)
                  CampaignListRow(
                    campaign: campaign,
                    saved: data.savedIds.contains(campaign.id),
                    onTap: () => context.push(RibhRoutes.campaign(campaign.id)),
                    onToggleSaved: () => ref
                        .read(marketplaceControllerProvider.notifier)
                        .toggleSaved(campaign.id),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _WheresMyMoneySection extends ConsumerWidget {
  const _WheresMyMoneySection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final largest = ref.watch(largestLiveDeploymentProvider);

    // Errors on this data already surface in the portfolio section, which
    // shares the provider; here absence just hides the card.
    final holding = largest.value;
    if (holding == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => context.push(RibhRoutes.campaign(holding.campaign.id)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeWheresMyMoney,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${formatTaka(holding.investment.amount, localeCode: locale)}'
                    ' · ${holding.campaign.title}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 14),
                  MoneyFlow(
                    completedSteps: moneyFlowStageFor(holding.campaign.status),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _GoalsSection extends ConsumerWidget {
  const _GoalsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final goals = ref.watch(homeGoalsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.homeGoalsTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        goals.when(
          skipLoadingOnRefresh: false,
          loading: () => const _SkeletonBox(height: 56),
          error: (error, _) => _SectionError(
            error: error,
            onRetry: () => ref.invalidate(homeGoalsProvider),
          ),
          data: (list) => list.isEmpty
              ? Text(
                  l10n.homeGoalsEmpty,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.inkSoft,
                  ),
                )
              : Column(
                  children: [for (final goal in list) GoalRow(goal: goal)],
                ),
        ),
      ],
    );
  }
}

class _ServicesGrid extends StatelessWidget {
  const _ServicesGrid();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tiles = [
      (LucideIcons.scale, l10n.serviceZakat, RibhRoutes.service('zakat'), null),
      (
        LucideIcons.heart,
        l10n.serviceSadaqah,
        RibhRoutes.service('sadaqah'),
        null,
      ),
      (LucideIcons.wallet, l10n.serviceWallet, RibhRoutes.wallet, null),
      (
        LucideIcons.moonStar,
        l10n.servicePrayer,
        RibhRoutes.service('prayer'),
        null,
      ),
      (
        LucideIcons.handCoins,
        l10n.serviceQard,
        RibhRoutes.service('qard'),
        l10n.serviceSoon,
      ),
      (
        LucideIcons.gift,
        l10n.serviceInvite,
        RibhRoutes.service('invite'),
        null,
      ),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.15,
      children: [
        for (final (icon, label, route, badge) in tiles)
          ServiceTile(
            icon: icon,
            label: label,
            soonBadge: badge,
            onTap: () => context.push(route),
          ),
      ],
    );
  }
}
