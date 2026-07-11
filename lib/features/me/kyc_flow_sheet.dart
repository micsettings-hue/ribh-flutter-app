import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../../data/models/models.dart';
import '../../data/repositories/kyc_repository.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'me_controller.dart';

/// The 3-step KYC flow from the prototype: NID, liveness, source of funds.
/// The liveness step is honestly disabled until a verification provider is
/// connected; the submission is recorded as pending and the tier only moves
/// after real verification.
class KycFlowSheet extends ConsumerStatefulWidget {
  const KycFlowSheet({super.key});

  @override
  ConsumerState<KycFlowSheet> createState() => _KycFlowSheetState();
}

class _KycFlowSheetState extends ConsumerState<KycFlowSheet> {
  final _nidController = TextEditingController();
  var _step = 0;
  String? _nidError;
  KycSource _source = KycSource.salary;
  Failure? _failure;
  var _submitting = false;

  @override
  void dispose() {
    _nidController.dispose();
    super.dispose();
  }

  void _continueFromNid() {
    final l10n = AppLocalizations.of(context)!;
    if (!isValidNidNumber(_nidController.text.trim())) {
      setState(() => _nidError = l10n.kycNidInvalid);
      return;
    }
    setState(() {
      _nidError = null;
      _step = 1;
    });
  }

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
      _failure = null;
    });
    final result = await ref
        .read(meControllerProvider.notifier)
        .submitKyc(
          nidNumber: _nidController.text.trim(),
          sourceOfFunds: _source,
        );
    if (!mounted) return;
    switch (result) {
      case Ok():
        final l10n = AppLocalizations.of(context)!;
        final messenger = ScaffoldMessenger.of(context);
        Navigator.of(context).pop();
        messenger.showSnackBar(SnackBar(content: Text(l10n.kycSubmitted)));
      case Err(:final failure):
        setState(() {
          _submitting = false;
          _failure = failure;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final bodyStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: tokens.inkSoft);

    return RibhSheetScaffold(
      title: '${l10n.kycTitle} · ${l10n.kycStepLabel(_step + 1)}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_step == 0) ...[
            Text(l10n.kycStep1Body, style: bodyStyle),
            const SizedBox(height: 16),
            TextField(
              controller: _nidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.kycNidLabel,
                errorText: _nidError,
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _continueFromNid(),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _continueFromNid,
              child: Text(l10n.kycContinue),
            ),
          ],
          if (_step == 1) ...[
            Text(l10n.kycStep2Body, style: bodyStyle),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => setState(() => _step = 2),
              child: Text(l10n.kycStep2Continue),
            ),
          ],
          if (_step == 2) ...[
            Text(l10n.kycStep3Body, style: bodyStyle),
            const SizedBox(height: 8),
            RadioGroup<KycSource>(
              groupValue: _source,
              onChanged: _submitting
                  ? (_) {}
                  : (value) => setState(() => _source = value!),
              child: Column(
                children: [
                  for (final source in KycSource.values)
                    RadioListTile<KycSource>(
                      value: source,
                      title: Text(switch (source) {
                        KycSource.salary => l10n.kycSourceSalary,
                        KycSource.businessIncome => l10n.kycSourceBusiness,
                        KycSource.savings => l10n.kycSourceSavings,
                        KycSource.remittance => l10n.kycSourceRemittance,
                      }),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.kycSubmit),
            ),
          ],
          if (_failure case final failure?) ...[
            const SizedBox(height: 12),
            Text(
              failureText(l10n, failure),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: tokens.danger),
            ),
          ],
        ],
      ),
    );
  }
}
