import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/router/routes.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/failures/failure.dart';
import '../../shared/campaign_list_row.dart';
import '../../shared/failure_l10n.dart';
import 'marketplace_controller.dart';

/// The marketplace: every campaign with live funding, filters, search, and
/// the persisted watchlist. Cards Hero into campaign detail.
class InvestScreen extends ConsumerStatefulWidget {
  const InvestScreen({super.key});

  @override
  ConsumerState<InvestScreen> createState() => _InvestScreenState();
}

class _InvestScreenState extends ConsumerState<InvestScreen> {
  MarketFilter _filter = MarketFilter.all;
  String _query = '';

  String _filterLabel(AppLocalizations l10n, MarketFilter filter) =>
      switch (filter) {
        MarketFilter.all => l10n.marketFilterAll,
        MarketFilter.open => l10n.marketFilterOpen,
        MarketFilter.matured => l10n.marketFilterMatured,
        MarketFilter.saved => l10n.marketFilterSaved,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final market = ref.watch(marketplaceControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabInvest)),
      body: market.when(
        skipLoadingOnRefresh: false,
        loading: () => const _MarketSkeleton(),
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(marketplaceControllerProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (data) {
          final visible = data.visible(_filter, _query);
          return RefreshIndicator(
            onRefresh: () => ref.refresh(marketplaceControllerProvider.future),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: [
                TextField(
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: l10n.marketSearchHint,
                    prefixIcon: const Icon(LucideIcons.search, size: 18),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final filter in MarketFilter.values)
                      ChoiceChip(
                        label: Text(_filterLabel(l10n, filter)),
                        selected: _filter == filter,
                        onSelected: (_) => setState(() => _filter = filter),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (visible.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      l10n.marketEmpty,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: tokens.inkSoft),
                    ),
                  )
                else
                  for (final campaign in visible) ...[
                    CampaignListRow(
                      campaign: campaign,
                      saved: data.savedIds.contains(campaign.id),
                      onTap: () =>
                          context.push(RibhRoutes.campaign(campaign.id)),
                      onToggleSaved: () => ref
                          .read(marketplaceControllerProvider.notifier)
                          .toggleSaved(campaign.id),
                    ),
                    const SizedBox(height: 4),
                  ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MarketSkeleton extends StatelessWidget {
  const _MarketSkeleton();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        for (var i = 0; i < 4; i++) ...[
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: tokens.mintSoft,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
