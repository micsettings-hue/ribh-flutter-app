import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app/l10n/app_localizations.dart';
import '../app/theme/ribh_tokens.dart';
import '../core/formatters/taka.dart';
import '../data/models/models.dart';
import 'icon_chip.dart';

/// One append-only ledger entry: kind, date, signed amount. Credits render
/// in green with a plus; debits in ink with a minus. Nothing here is
/// editable, matching the ledger itself.
class LedgerRow extends StatelessWidget {
  const LedgerRow({super.key, required this.transaction});

  final WalletTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final locale = Localizations.localeOf(context).languageCode;
    final credit = transaction.kind.isCredit;
    final amount = formatTaka(transaction.amount, localeCode: locale);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: RibhIconChip(
        icon: credit ? LucideIcons.arrowDownLeft : LucideIcons.arrowUpRight,
        size: RibhIconChip.sm,
      ),
      title: Text(txKindLabel(l10n, transaction.kind)),
      subtitle: Text(
        DateFormat.yMMMd(locale).format(transaction.createdAt.toLocal()),
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
      ),
      trailing: Text(
        credit ? '+$amount' : '-$amount',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: credit ? tokens.teal : tokens.ink,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

String txKindLabel(AppLocalizations l10n, TxKind kind) => switch (kind) {
  TxKind.deposit => l10n.txDeposit,
  TxKind.investment => l10n.txInvestment,
  TxKind.distribution => l10n.txDistribution,
  TxKind.payout => l10n.txPayout,
  TxKind.purification => l10n.txPurification,
  TxKind.writeDown => l10n.txWriteDown,
  TxKind.recovery => l10n.txRecovery,
  TxKind.sadaqah => l10n.txSadaqah,
  TxKind.zakat => l10n.txZakat,
};
