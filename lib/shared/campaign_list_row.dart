import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app/l10n/app_localizations.dart';
import '../app/theme/ribh_tokens.dart';
import '../core/constants/profit_formula.dart';
import '../data/models/models.dart';
import 'pills.dart';

/// Hero tag shared by the marketplace card and the campaign detail header.
String campaignHeroTag(String campaignId) => 'campaign-$campaignId';

/// One marketplace campaign card: title, contract and status pills, live
/// funding, and the projected annualised rate computed from real terms and
/// labelled projected. The bookmark persists to the user's watchlist.
class CampaignListRow extends StatelessWidget {
  const CampaignListRow({
    super.key,
    required this.campaign,
    required this.saved,
    required this.onTap,
    required this.onToggleSaved,
  });

  final Campaign campaign;
  final bool saved;
  final VoidCallback onTap;
  final VoidCallback onToggleSaved;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final rate = projectedAnnualisedRatePercent(
      profitPerLacPoisha: campaign.profitPerLac,
      sharePercent: campaign.share,
      tenureMonths: campaign.tenure,
    );

    return Hero(
      tag: campaignHeroTag(campaign.id),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        campaign.title.isEmpty
                            ? campaign.sector
                            : campaign.title,
                        style: theme.textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: onToggleSaved,
                      tooltip: saved
                          ? l10n.marketUnsaveTooltip
                          : l10n.marketSaveTooltip,
                      icon: Icon(
                        saved
                            ? LucideIcons.bookmarkCheck
                            : LucideIcons.bookmark,
                        size: 20,
                        color: saved ? tokens.teal : tokens.inkSoft,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [_CampaignPills(campaign: campaign)],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: campaign.fundingPercent / 100,
                    minHeight: 6,
                    backgroundColor: tokens.mintSoft,
                    color: tokens.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.marketFundedPercent(
                        campaign.fundingPercent.toStringAsFixed(0),
                      ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: tokens.inkSoft,
                      ),
                    ),
                    Text(
                      l10n.marketProjectedRate(rate.toStringAsFixed(1)),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: tokens.tealDeep,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CampaignPills extends StatelessWidget {
  const _CampaignPills({required this.campaign});

  final Campaign campaign;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatusPill(status: campaign.status),
        const SizedBox(width: 8),
        ContractPill(contract: campaign.contract),
        const SizedBox(width: 8),
        RiskDot(risk: campaign.risk),
      ],
    );
  }
}
