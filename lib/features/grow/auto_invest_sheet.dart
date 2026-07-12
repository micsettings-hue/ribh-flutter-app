import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/constants/risk_tiers.dart';
import '../../core/formatters/taka.dart';
import '../../data/models/models.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/haptics.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'grow_controller.dart';

/// Strategy picker writing `auto_invest_rules`. Strategies are the risk
/// tiers; budget is the amount proposed per deployment. Activating a rule
/// deploys nothing by itself: proposals land in the approval queue and
/// each one needs explicit consent.
class AutoInvestSheet extends ConsumerStatefulWidget {
  const AutoInvestSheet({super.key, this.existing});

  final AutoInvestRule? existing;

  @override
  ConsumerState<AutoInvestSheet> createState() => _AutoInvestSheetState();
}

class _AutoInvestSheetState extends ConsumerState<AutoInvestSheet> {
  late RiskTier _strategy =
      RiskTier.fromDb(widget.existing?.strategy) ?? RiskTier.balanced;
  late final _budgetController = TextEditingController(
    text: widget.existing == null
        ? ''
        : (widget.existing!.budget ~/ 100).toString(),
  );
  late bool _active = widget.existing?.active ?? true;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  String _strategyName(AppLocalizations l10n, RiskTier tier) => switch (tier) {
    RiskTier.short => l10n.riskTierShort,
    RiskTier.balanced => l10n.riskTierBalanced,
    RiskTier.diversified => l10n.riskTierDiversified,
  };

  String _strategyDesc(AppLocalizations l10n, RiskTier tier) => switch (tier) {
    RiskTier.short => l10n.strategyShortDesc,
    RiskTier.balanced => l10n.strategyBalancedDesc,
    RiskTier.diversified => l10n.strategyDiversifiedDesc,
  };

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    final budget = parseTakaToPoisha(_budgetController.text);
    if (budget == null) {
      setState(() => _error = l10n.invalidAmount);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final result = await ref
        .read(growControllerProvider.notifier)
        .saveRule(strategy: _strategy.dbValue, budget: budget, active: _active);
    if (!mounted) return;
    result.fold(
      (_) => Navigator.of(context).pop(),
      (failure) => setState(() {
        _saving = false;
        _error = failureText(l10n, failure);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;

    return RibhSheetScaffold(
      title: l10n.growAutoInvestTitle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final tier in RiskTier.values)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  RibhHaptics.select();
                  setState(() => _strategy = tier);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _strategy == tier ? tokens.mintSoft : tokens.card,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _strategy == tier ? tokens.teal : tokens.line,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          _strategy == tier
                              ? LucideIcons.circleCheck
                              : LucideIcons.circle,
                          size: 20,
                          color: _strategy == tier
                              ? tokens.teal
                              : tokens.inkSoft,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _strategyName(l10n, tier),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              _strategyDesc(l10n, tier),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: tokens.inkSoft),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          TextField(
            controller: _budgetController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.autoInvestBudgetLabel,
              prefixText: takaSign,
            ),
          ),
          SwitchListTile(
            value: _active,
            onChanged: (value) {
              RibhHaptics.select();
              setState(() => _active = value);
            },
            contentPadding: EdgeInsets.zero,
            title: Text(
              l10n.autoInvestActiveLabel,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            l10n.autoInvestConsentNote,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
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
            onPressed: _saving ? null : _save,
            child: Text(_saving ? l10n.submitting : l10n.autoInvestSave),
          ),
        ],
      ),
    );
  }
}
