import 'package:flutter/material.dart';

import '../app/l10n/app_localizations.dart';
import '../app/theme/ribh_tokens.dart';
import '../core/formatters/taka.dart';
import '../data/models/models.dart';
import 'campaign_list_row.dart' show campaignHeroTag;
import 'pills.dart';

/// One holding on the Home portfolio row: campaign title, invested amount,
/// and status. Hero-transitions into the campaign detail.
class PortfolioCard extends StatelessWidget {
  const PortfolioCard({
    super.key,
    required this.investment,
    required this.campaign,
    required this.onTap,
  });

  final Investment investment;
  final Campaign campaign;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return Hero(
      tag: campaignHeroTag(campaign.id),
      child: SizedBox(
        width: 220,
        child: Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    campaign.title.isEmpty ? campaign.sector : campaign.title,
                    style: theme.textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.portfolioInvested(
                      formatTaka(investment.amount, localeCode: locale),
                    ),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.inkSoft,
                    ),
                  ),
                  const SizedBox(height: 10),
                  StatusPill(status: campaign.status),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
