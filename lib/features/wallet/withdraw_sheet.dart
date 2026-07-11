import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/formatters/taka.dart';
import '../../data/models/models.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'labels.dart';
import 'wallet_controller.dart';

/// Withdraw from the available balance. Records a real withdrawal request;
/// the transfer itself is sent by the back office and only then does the
/// ledger row appear. 2FA confirmation is added with the Me milestone and
/// is stated here rather than silently missing.
class WithdrawSheet extends ConsumerStatefulWidget {
  const WithdrawSheet({super.key, required this.available});

  /// Available for withdrawal in poisha: derived balance minus withdrawals
  /// already pending.
  final int available;

  @override
  ConsumerState<WithdrawSheet> createState() => _WithdrawSheetState();
}

class _WithdrawSheetState extends ConsumerState<WithdrawSheet> {
  final _amountController = TextEditingController();
  PaymentMethod _method = PaymentMethod.bank;
  bool _submitting = false;
  String? _error;
  bool _recorded = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final amount = parseTakaToPoisha(_amountController.text);
    if (amount == null) {
      setState(() => _error = l10n.invalidAmount);
      return;
    }
    if (amount > widget.available) {
      setState(() => _error = l10n.errorInsufficientFunds);
      return;
    }

    setState(() {
      _submitting = true;
      _error = null;
    });
    final result = await ref
        .read(walletControllerProvider.notifier)
        .requestWithdrawal(method: _method, amount: amount);
    if (!mounted) return;
    setState(() {
      _submitting = false;
      result.fold(
        (_) => _recorded = true,
        (failure) => _error = failureText(l10n, failure),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return RibhSheetScaffold(
      title: l10n.withdrawTitle,
      child: _recorded ? _recordedView(l10n) : _formView(l10n),
    );
  }

  Widget _formView(AppLocalizations l10n) {
    final tokens = context.tokens;
    final locale = Localizations.localeOf(context).languageCode;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.withdrawAvailable(
            formatTaka(widget.available, localeCode: locale),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        SegmentedButton<PaymentMethod>(
          segments: [
            for (final method in PaymentMethod.values)
              ButtonSegment(
                value: method,
                label: Text(paymentMethodLabel(l10n, method)),
              ),
          ],
          selected: {_method},
          onSelectionChanged: (selection) =>
              setState(() => _method = selection.first),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: l10n.amountLabel,
            prefixText: takaSign,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.withdrawTwoFaNote,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(
            _error!,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: tokens.danger),
          ),
        ],
        const SizedBox(height: 16),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: Text(_submitting ? l10n.submitting : l10n.withdrawSubmit),
        ),
      ],
    );
  }

  Widget _recordedView(AppLocalizations l10n) {
    final tokens = context.tokens;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(LucideIcons.clock, size: 40, color: tokens.amber),
        const SizedBox(height: 12),
        Text(
          l10n.requestRecordedTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.withdrawPendingBody,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.done),
        ),
      ],
    );
  }
}
