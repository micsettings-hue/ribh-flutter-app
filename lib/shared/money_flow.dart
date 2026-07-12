import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app/l10n/app_localizations.dart';
import '../app/theme/ribh_tokens.dart';
import '../data/models/models.dart';

/// How far along the money-flow a deployment is. Derived from the campaign
/// status ONLY; no stage is ever invented beyond what the data supports.
int moneyFlowStageFor(CampaignStatus status) => switch (status) {
  CampaignStatus.open => 1, // funds committed from wallet
  CampaignStatus.running => 3, // goods with merchant
  CampaignStatus.inRecovery => 3, // stalled at trade; recovery shown by pill
  CampaignStatus.matured => 5, // full cycle complete
};

/// The where's-my-money strip: wallet -> supplier -> goods -> repayment ->
/// profit, with completed steps highlighted.
class MoneyFlow extends StatelessWidget {
  const MoneyFlow({super.key, required this.completedSteps});

  /// Number of completed steps, 0..5. See [moneyFlowStageFor].
  final int completedSteps;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final steps = [
      (LucideIcons.wallet, l10n.flowWallet),
      (LucideIcons.building, l10n.flowSupplierPaid),
      (LucideIcons.box, l10n.flowGoodsWithMerchant),
      (LucideIcons.arrowDown, l10n.flowRepayment),
      (LucideIcons.sprout, l10n.flowProfit),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < steps.length; i++)
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: i < completedSteps ? tokens.teal : tokens.mintSoft,
                    shape: BoxShape.circle,
                    border: Border.all(color: tokens.line, width: 1.5),
                  ),
                  child: Icon(
                    steps[i].$1,
                    size: 14,
                    color: i < completedSteps ? Colors.white : tokens.inkSoft,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  steps[i].$2,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontSize: 10,
                    color: i < completedSteps ? tokens.ink : tokens.inkSoft,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
