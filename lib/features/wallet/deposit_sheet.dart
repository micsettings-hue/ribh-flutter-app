import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/formatters/taka.dart';
import '../../data/models/models.dart';
import '../../data/payments/payment_gateway.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/haptics.dart';
import '../../shared/motion.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'labels.dart';
import 'wallet_controller.dart';

/// Add funds. Records a real deposit request and then tells the truth about
/// what happens next: no checkout is connected in this build, so nothing is
/// charged and the request stays pending until reconciliation confirms it.
class DepositSheet extends ConsumerStatefulWidget {
  const DepositSheet({super.key});

  @override
  ConsumerState<DepositSheet> createState() => _DepositSheetState();
}

class _DepositSheetState extends ConsumerState<DepositSheet> {
  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();
  PaymentMethod _method = PaymentMethod.bkash;
  bool _submitting = false;
  String? _error;
  bool _recorded = false;

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final amount = parseTakaToPoisha(_amountController.text);
    if (amount == null) {
      setState(() => _error = l10n.invalidAmount);
      return;
    }
    final reference = _referenceController.text.trim();
    if (_method == PaymentMethod.bank && reference.isEmpty) {
      setState(() => _error = l10n.depositReferenceMissing);
      return;
    }

    setState(() {
      _submitting = true;
      _error = null;
    });
    final result = await ref
        .read(walletControllerProvider.notifier)
        .requestDeposit(
          method: _method,
          amount: amount,
          reference: _method == PaymentMethod.bank ? reference : null,
        );
    if (!mounted) return;
    setState(() {
      _submitting = false;
      result.fold((_) {
        RibhHaptics.commit();
        _recorded = true;
      }, (failure) => _error = failureText(l10n, failure));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return RibhSheetScaffold(
      title: l10n.depositTitle,
      child: RibhSwap(
        child: _recorded
            ? KeyedSubtree(
                key: const ValueKey('done'),
                child: _recordedView(l10n),
              )
            : KeyedSubtree(key: const ValueKey('form'), child: _formView(l10n)),
      ),
    );
  }

  Widget _formView(AppLocalizations l10n) {
    final tokens = context.tokens;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        if (_method == PaymentMethod.bank) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _referenceController,
            decoration: InputDecoration(
              labelText: l10n.depositReferenceLabel,
              helperText: l10n.depositReferenceHelp,
              helperMaxLines: 3,
            ),
          ),
        ],
        const SizedBox(height: 12),
        Text(
          l10n.depositOwnAccountNote,
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
          child: Text(_submitting ? l10n.submitting : l10n.depositSubmit),
        ),
      ],
    );
  }

  /// The honest pending state. No success theatre: the copy says exactly
  /// what has and has not happened.
  Widget _recordedView(AppLocalizations l10n) {
    final tokens = context.tokens;
    final gateway = ref.read(paymentGatewayProvider);
    final body = _method == PaymentMethod.bank
        ? l10n.depositPendingBank(_referenceController.text.trim())
        : gateway.isCheckoutAvailable(_method)
        ? l10n.depositPendingCheckout
        : l10n.depositPendingNoCheckout(paymentMethodLabel(l10n, _method));

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
          body,
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
