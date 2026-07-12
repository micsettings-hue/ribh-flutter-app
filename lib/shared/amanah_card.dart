import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app/l10n/app_localizations.dart';
import '../app/theme/ribh_tokens.dart';
import '../core/formatters/taka.dart';

/// The Amanah summary card: available, deployed, and in-recovery, all
/// derived figures handed in by the caller (never stored, never literals).
/// Dumb widget: actions are callbacks so Home wires the real sheets.
class AmanahCard extends StatelessWidget {
  const AmanahCard({
    super.key,
    required this.available,
    required this.deployed,
    required this.inRecovery,
    required this.onAddFunds,
    required this.onWithdraw,
    required this.onOpenLedger,
  });

  final int available;
  final int deployed;
  final int inRecovery;
  final VoidCallback onAddFunds;
  final VoidCallback onWithdraw;
  final VoidCallback onOpenLedger;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final onGradient = Colors.white;

    Widget figure(String label, int poisha) => Expanded(
      child: Column(
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
            style: theme.textTheme.titleSmall?.copyWith(
              color: onGradient,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );

    return Container(
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
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.amanahTitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: onGradient.withValues(alpha: 0.85),
                  ),
                ),
              ),
              InkWell(
                onTap: onOpenLedger,
                borderRadius: BorderRadius.circular(999),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.amanahLedgerLink,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: onGradient,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        LucideIcons.chevronRight,
                        size: 14,
                        color: onGradient,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            formatTaka(available, localeCode: locale),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: onGradient,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            l10n.amanahAvailableLabel,
            style: theme.textTheme.labelSmall?.copyWith(
              color: onGradient.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              figure(l10n.amanahDeployedLabel, deployed),
              figure(l10n.amanahInRecoveryLabel, inRecovery),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(
                    backgroundColor: onGradient,
                    foregroundColor: tokens.amanahGradientEnd,
                  ),
                  icon: const Icon(LucideIcons.plus, size: 16),
                  label: Text(l10n.walletAddFunds),
                  onPressed: onAddFunds,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: onGradient,
                    side: BorderSide(
                      color: onGradient.withValues(alpha: 0.6),
                      width: 1.5,
                    ),
                  ),
                  icon: const Icon(LucideIcons.arrowUpRight, size: 16),
                  label: Text(l10n.walletWithdraw),
                  onPressed: onWithdraw,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
