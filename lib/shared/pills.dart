import 'package:flutter/material.dart';

import '../app/l10n/app_localizations.dart';
import '../app/theme/ribh_tokens.dart';
import '../data/models/models.dart';

/// StatusPill, ContractPill, and RiskDot from the design system. All are
/// token-themed and AA-safe in both themes (gold as text uses goldText).

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status});

  final CampaignStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final (label, foreground, background) = switch (status) {
      CampaignStatus.open => (l10n.statusOpen, tokens.tealDeep, tokens.mint),
      CampaignStatus.running => (
        l10n.statusRunning,
        tokens.tealDeep,
        tokens.mintSoft,
      ),
      CampaignStatus.matured => (
        l10n.statusMatured,
        tokens.goldText,
        tokens.amberSoft,
      ),
      CampaignStatus.inRecovery => (
        l10n.statusRecovery,
        tokens.amber,
        tokens.amberSoft,
      ),
    };
    return _Pill(label: label, foreground: foreground, background: background);
  }
}

class ContractPill extends StatelessWidget {
  const ContractPill({super.key, required this.contract});

  /// Raw contract name from the database, e.g. 'murabaha'.
  final String contract;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final label = contract.isEmpty
        ? contract
        : contract[0].toUpperCase() + contract.substring(1);
    return _Pill(
      label: label,
      foreground: tokens.inkSoft,
      background: Colors.transparent,
      border: tokens.line,
    );
  }
}

class RiskDot extends StatelessWidget {
  const RiskDot({super.key, required this.risk});

  /// Raw risk band from the database ('low', 'moderate', 'elevated').
  final String risk;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final (label, color) = switch (risk) {
      'low' => (l10n.riskLow, tokens.teal),
      'moderate' => (l10n.riskModerate, tokens.amber),
      'elevated' => (l10n.riskElevated, tokens.danger),
      _ => (risk, tokens.inkSoft),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.foreground,
    required this.background,
    this.border,
  });

  final String label;
  final Color foreground;
  final Color background;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        border: border == null ? null : Border.all(color: border!, width: 1.5),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
