import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/constants/risk_tiers.dart';
import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'me_controller.dart';

/// The 3-question risk quiz from the prototype. The outcome is a
/// recommendation, not advice; saving it never authorises any deployment.
class RiskQuizSheet extends ConsumerStatefulWidget {
  const RiskQuizSheet({super.key});

  @override
  ConsumerState<RiskQuizSheet> createState() => _RiskQuizSheetState();
}

class _RiskQuizSheetState extends ConsumerState<RiskQuizSheet> {
  final _answers = <RiskTier>[];
  Failure? _failure;
  var _saving = false;

  Future<void> _save(RiskTier tier) async {
    setState(() {
      _saving = true;
      _failure = null;
    });
    final result = await ref
        .read(meControllerProvider.notifier)
        .saveRiskTier(tier);
    if (!mounted) return;
    switch (result) {
      case Ok():
        Navigator.of(context).pop();
      case Err(:final failure):
        setState(() {
          _saving = false;
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

    final questions = [
      (l10n.riskQ1, [l10n.riskQ1A1, l10n.riskQ1A2, l10n.riskQ1A3]),
      (l10n.riskQ2, [l10n.riskQ2A1, l10n.riskQ2A2, l10n.riskQ2A3]),
      (l10n.riskQ3, [l10n.riskQ3A1, l10n.riskQ3A2, l10n.riskQ3A3]),
    ];
    const optionTiers = [
      RiskTier.short,
      RiskTier.balanced,
      RiskTier.diversified,
    ];
    final step = _answers.length;
    final done = step >= questions.length;
    final recommended = done ? recommendTier(_answers) : null;

    return RibhSheetScaffold(
      title: l10n.riskQuizTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!done) ...[
            Text(
              questions[step].$1,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            for (var i = 0; i < questions[step].$2.length; i++)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: OutlinedButton(
                  onPressed: () => setState(() => _answers.add(optionTiers[i])),
                  child: Text(questions[step].$2[i]),
                ),
              ),
          ] else ...[
            Text(
              l10n.riskResultTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(switch (recommended!) {
              RiskTier.short => l10n.riskTierShort,
              RiskTier.balanced => l10n.riskTierBalanced,
              RiskTier.diversified => l10n.riskTierDiversified,
            }, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(l10n.riskResultBody, style: bodyStyle),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _saving ? null : () => _save(recommended),
              child: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.riskSave),
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
