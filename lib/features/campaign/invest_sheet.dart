import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/formatters/taka.dart';
import '../../data/models/models.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'campaign_detail_controller.dart';

/// The commit step. Both risk acknowledgements are hard requirements: the
/// button stays disabled without them, the repository refuses without them,
/// and the database CHECK refuses without them. The commit writes the
/// investments row and the ledger row in one transaction via the RPC.
class InvestSheet extends ConsumerStatefulWidget {
  const InvestSheet({super.key, required this.campaign});

  final Campaign campaign;

  @override
  ConsumerState<InvestSheet> createState() => _InvestSheetState();
}

class _InvestSheetState extends ConsumerState<InvestSheet> {
  final _amountController = TextEditingController();
  bool _ack1 = false;
  bool _ack2 = false;
  bool _submitting = false;
  String? _error;
  bool _committed = false;

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

    setState(() {
      _submitting = true;
      _error = null;
    });
    final result = await ref
        .read(campaignDetailControllerProvider(widget.campaign.id).notifier)
        .invest(amountPoisha: amount, riskAck1: _ack1, riskAck2: _ack2);
    if (!mounted) return;
    setState(() {
      _submitting = false;
      result.fold(
        (_) => _committed = true,
        (failure) => _error = failureText(l10n, failure),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return RibhSheetScaffold(
      title: l10n.investSheetTitle,
      child: _committed ? _committedView(l10n) : _formView(l10n),
    );
  }

  Widget _formView(AppLocalizations l10n) {
    final tokens = context.tokens;
    final bothAcked = _ack1 && _ack2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.campaign.title.isEmpty
              ? widget.campaign.sector
              : widget.campaign.title,
          style: Theme.of(context).textTheme.titleMedium,
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
        const SizedBox(height: 8),
        CheckboxListTile(
          value: _ack1,
          onChanged: (value) => setState(() => _ack1 = value ?? false),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          title: Text(
            l10n.investAck1,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        CheckboxListTile(
          value: _ack2,
          onChanged: (value) => setState(() => _ack2 = value ?? false),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          title: Text(
            l10n.investAck2,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: 8),
          Text(
            _error!,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: tokens.danger),
          ),
        ],
        const SizedBox(height: 12),
        FilledButton(
          onPressed: bothAcked && !_submitting ? _submit : null,
          child: Text(_submitting ? l10n.submitting : l10n.investCommit),
        ),
        if (!bothAcked) ...[
          const SizedBox(height: 8),
          Text(
            l10n.investAcksRequired,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          ),
        ],
      ],
    );
  }

  Widget _committedView(AppLocalizations l10n) {
    final tokens = context.tokens;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(LucideIcons.circleCheck, size: 40, color: tokens.teal),
        const SizedBox(height: 12),
        Text(
          l10n.investCommittedTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.investCommittedBody,
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
