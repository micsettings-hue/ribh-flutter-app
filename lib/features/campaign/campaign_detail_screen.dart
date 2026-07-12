import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/constants/profit_formula.dart';
import '../../core/failures/failure.dart';
import '../../core/formatters/taka.dart';
import '../../data/models/models.dart';
import '../../shared/campaign_list_row.dart' show campaignHeroTag;
import '../../shared/failure_l10n.dart';
import '../../shared/pills.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'campaign_detail_controller.dart';
import 'invest_sheet.dart';

/// Campaign detail: live funding, real terms, the canonical calculator
/// (always labelled projected, always with the risk disclosure), contract
/// basis explainer, recovery tracker when in recovery, and the invest flow.
class CampaignDetailScreen extends ConsumerWidget {
  const CampaignDetailScreen({
    super.key,
    required this.campaignId,
    this.heroTag,
  });

  final String campaignId;

  /// The tag of the card that pushed this route, so the Hero flies from
  /// whichever surface the user actually tapped.
  final String? heroTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final detail = ref.watch(campaignDetailControllerProvider(campaignId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.campaignDetailTitle)),
      body: detail.when(
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  failureText(
                    l10n,
                    error is Failure ? error : UnknownFailure('$error'),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => ref.invalidate(
                    campaignDetailControllerProvider(campaignId),
                  ),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (campaign) => _DetailBody(campaign: campaign, heroTag: heroTag),
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.campaign, this.heroTag});

  final Campaign campaign;
  final String? heroTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Hero(
          tag: heroTag ?? campaignHeroTag(campaign.id),
          // During the flight this card is laid out at interpolated sizes
          // between the source card and its own; the non-scrolling scroll
          // view lets the content clip for those frames instead of
          // overflowing the flex.
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.title.isEmpty ? campaign.sector : campaign.title,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        StatusPill(status: campaign.status),
                        const SizedBox(width: 8),
                        ContractPill(contract: campaign.contract),
                        const SizedBox(width: 8),
                        RiskDot(risk: campaign.risk),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: campaign.fundingPercent / 100,
                        minHeight: 8,
                        backgroundColor: tokens.mintSoft,
                        color: tokens.teal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.campaignRaisedOfPool(
                        formatTaka(campaign.raised, localeCode: locale),
                        formatTaka(campaign.pool, localeCode: locale),
                        campaign.fundingPercent.toStringAsFixed(0),
                      ),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: tokens.inkSoft,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (campaign.status == CampaignStatus.inRecovery) ...[
          _RecoveryTracker(campaign: campaign),
          const SizedBox(height: 12),
        ],
        _TermsCard(campaign: campaign),
        const SizedBox(height: 12),
        _Calculator(campaign: campaign),
        const SizedBox(height: 12),
        _ContractExplainer(contract: campaign.contract),
        const SizedBox(height: 20),
        if (campaign.status == CampaignStatus.open)
          FilledButton.icon(
            icon: const Icon(LucideIcons.handCoins, size: 18),
            label: Text(l10n.campaignInvestCta),
            onPressed: () => showRibhSheet<void>(
              context: context,
              builder: (_) => InvestSheet(campaign: campaign),
            ),
          )
        else
          Text(
            l10n.campaignNotOpen,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          ),
        const SizedBox(height: 8),
        Text(
          l10n.riskDisclosure,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
        ),
      ],
    );
  }
}

class _TermsCard extends StatelessWidget {
  const _TermsCard({required this.campaign});

  final Campaign campaign;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final rate = projectedAnnualisedRatePercent(
      profitPerLacPoisha: campaign.profitPerLac,
      sharePercent: campaign.share,
      tenureMonths: campaign.tenure,
    );

    Widget row(String label, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.campaignTermsTitle, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            row(
              l10n.campaignProfitPerLac,
              formatTaka(campaign.profitPerLac, localeCode: locale),
            ),
            row(
              l10n.campaignInvestorShare,
              '${campaign.share.toStringAsFixed(0)}%',
            ),
            row(
              l10n.campaignTenureLabel,
              l10n.campaignTenureMonths(campaign.tenure),
            ),
            row(
              l10n.campaignProjectedAnnualised,
              l10n.marketProjectedRate(rate.toStringAsFixed(1)),
            ),
          ],
        ),
      ),
    );
  }
}

class _Calculator extends StatefulWidget {
  const _Calculator({required this.campaign});

  final Campaign campaign;

  @override
  State<_Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<_Calculator> {
  final _controller = TextEditingController(text: '100000');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final amountPoisha = parseTakaToPoisha(_controller.text);
    final projected = amountPoisha == null
        ? null
        : investorProfitPoisha(
            investedPoisha: amountPoisha,
            profitPerLacPoisha: widget.campaign.profitPerLac,
            sharePercent: widget.campaign.share,
          );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.campaignCalculatorTitle,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: l10n.amountLabel,
                prefixText: takaSign,
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              projected == null
                  ? l10n.invalidAmount
                  : l10n.campaignCalculatorResult(
                      formatTaka(projected, localeCode: locale),
                      widget.campaign.tenure,
                    ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: projected == null ? tokens.danger : tokens.tealDeep,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.riskDisclosure,
              style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContractExplainer extends StatelessWidget {
  const _ContractExplainer({required this.contract});

  final String contract;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final body = switch (contract) {
      'murabaha' => l10n.contractExplainerMurabaha,
      'musharakah' => l10n.contractExplainerMusharakah,
      _ => l10n.contractExplainerGeneric,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.campaignContractBasis,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: theme.textTheme.bodySmall?.copyWith(color: tokens.ink),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecoveryTracker extends StatelessWidget {
  const _RecoveryTracker({required this.campaign});

  final Campaign campaign;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tokens.amberSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tokens.amber, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.triangleAlert, size: 18, color: tokens.amber),
              const SizedBox(width: 8),
              Text(
                l10n.campaignRecoveryTitle,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: tokens.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.campaignRecoveryBody,
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.ink),
          ),
        ],
      ),
    );
  }
}
