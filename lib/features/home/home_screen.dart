import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/router/routes.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/failures/failure.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/portfolio_card.dart';
import 'portfolio_controller.dart';

/// Home becomes the full hub in M5. It carries what already exists for
/// real: the Amanah wallet entry (M3) and the portfolio row (M4).
/// Everything else stays an honest placeholder, no demo content.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabHome)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(portfolioControllerProvider.future),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              child: ListTile(
                leading: const Icon(LucideIcons.wallet),
                title: Text(l10n.homeWalletEntry),
                subtitle: Text(l10n.homeWalletEntrySubtitle),
                trailing: const Icon(LucideIcons.chevronRight),
                onTap: () => context.push(RibhRoutes.wallet),
              ),
            ),
            const SizedBox(height: 20),
            const _PortfolioRow(),
            const SizedBox(height: 20),
            Text(
              l10n.milestonePlaceholderBody,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortfolioRow extends ConsumerWidget {
  const _PortfolioRow();

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
          loading: () => Container(
            height: 110,
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
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.inkSoft,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => ref.invalidate(portfolioControllerProvider),
                child: Text(l10n.retry),
              ),
            ],
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
