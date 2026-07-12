import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/constants/risk_tiers.dart';
import '../../core/failures/failure.dart';
import '../../data/models/models.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import '../../shared/skeleton_box.dart';
import 'kyc_flow_sheet.dart';
import 'me_controller.dart';
import 'risk_quiz_sheet.dart';

/// The only tab with profile and account access.
class MeScreen extends ConsumerWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final me = ref.watch(meControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabMe)),
      body: me.when(
        skipLoadingOnRefresh: false,
        loading: () => const _MeSkeleton(),
        error: (error, _) => _MeError(
          failure: error is Failure ? error : UnknownFailure('$error'),
          onRetry: () => ref.invalidate(meControllerProvider),
        ),
        data: (data) => _MeBody(data: data),
      ),
    );
  }
}

class _MeSkeleton extends StatelessWidget {
  const _MeSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        for (var i = 0; i < 3; i++) ...[
          const SkeletonBox(height: 72),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _MeError extends StatelessWidget {
  const _MeError({required this.failure, required this.onRetry});

  final Failure failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              failureText(l10n, failure),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: Text(l10n.retry)),
          ],
        ),
      ),
    );
  }
}

class _MeBody extends ConsumerWidget {
  const _MeBody({required this.data});

  final MeData data;

  String _kycSubtitle(AppLocalizations l10n) {
    final kyc = data.kyc;
    if (kyc == null) return l10n.kycStatusNone;
    return switch (kyc.status) {
      KycStatus.pending => l10n.kycStatusPending,
      KycStatus.approved => l10n.kycStatusApproved(data.profile.kycTier),
      KycStatus.rejected => l10n.kycStatusRejected,
    };
  }

  String _riskSubtitle(AppLocalizations l10n) =>
      switch (RiskTier.fromDb(data.profile.riskTier)) {
        RiskTier.short => l10n.riskTierShort,
        RiskTier.balanced => l10n.riskTierBalanced,
        RiskTier.diversified => l10n.riskTierDiversified,
        null => l10n.riskTierUnset,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final kycDecided = data.kyc?.status == KycStatus.approved;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(LucideIcons.user),
            title: Text(l10n.meAccount),
            subtitle: Text(data.email ?? data.profile.id),
            trailing: TextButton(
              onPressed: () =>
                  ref.read(meControllerProvider.notifier).signOut(),
              child: Text(l10n.meSignOut),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(LucideIcons.idCard),
            title: Text(l10n.meKycRow),
            subtitle: Text(_kycSubtitle(l10n)),
            trailing: kycDecided ? null : const Icon(LucideIcons.chevronRight),
            onTap: kycDecided
                ? null
                : () => showRibhSheet<void>(
                    context: context,
                    builder: (_) => const KycFlowSheet(),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(LucideIcons.gauge),
            title: Text(l10n.meRiskRow),
            subtitle: Text(_riskSubtitle(l10n)),
            trailing: const Icon(LucideIcons.chevronRight),
            onTap: () => showRibhSheet<void>(
              context: context,
              builder: (_) => const RiskQuizSheet(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.meMoreComing,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
        ),
      ],
    );
  }
}
