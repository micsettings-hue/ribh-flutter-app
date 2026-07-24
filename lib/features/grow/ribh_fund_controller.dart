import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/profit_formula.dart';
import '../../data/models/models.dart';
import '../home/portfolio_controller.dart';

part 'ribh_fund_controller.g.dart';

/// One sector's slice of deployed fund capital.
class SectorSlice {
  const SectorSlice({
    required this.sector,
    required this.amount,
    required this.share,
  });

  final String sector;

  /// Poisha deployed in this sector.
  final int amount;

  /// Fraction of total deployed capital, 0..1.
  final double share;
}

/// The Ribh Fund view, derived entirely from the user's real holdings.
/// Nothing here is stored: deployed and in-recovery mirror the Amanah
/// summary's convention, and the blended rate is computed from real campaign
/// terms with the canonical formula. It is a projection, never a guarantee.
class RibhFundSummary {
  const RibhFundSummary({
    required this.deployed,
    required this.inRecovery,
    required this.deploymentCount,
    required this.sectorCount,
    required this.sectors,
    required this.blendedProjectedRate,
  });

  /// Capital working in the fund: holdings not in recovery (running, open,
  /// matured), in poisha.
  final int deployed;

  /// Capital in campaigns whose repayment is behind plan, in poisha.
  final int inRecovery;

  /// Number of deployed (non-recovery) holdings.
  final int deploymentCount;

  /// Distinct sectors across deployed holdings.
  final int sectorCount;

  /// Deployed capital by sector, largest first.
  final List<SectorSlice> sectors;

  /// Amount-weighted projected annualised rate across still-earning
  /// (running or open) holdings, in percent. Null when nothing is earning.
  /// Projected, never guaranteed.
  final double? blendedProjectedRate;

  bool get isEmpty => deployed == 0 && inRecovery == 0;

  /// Pure aggregation over holdings so it is unit-testable without Riverpod.
  factory RibhFundSummary.fromHoldings(List<PortfolioHolding> holdings) {
    var deployed = 0;
    var inRecovery = 0;
    var deploymentCount = 0;
    final bySector = <String, int>{};

    var earningAmount = 0;
    var weightedRate = 0.0;

    for (final holding in holdings) {
      final amount = holding.investment.amount;
      final campaign = holding.campaign;
      if (campaign.status == CampaignStatus.inRecovery) {
        inRecovery += amount;
        continue;
      }
      deployed += amount;
      deploymentCount += 1;
      bySector.update(
        campaign.sector,
        (value) => value + amount,
        ifAbsent: () => amount,
      );
      final stillEarning =
          campaign.status == CampaignStatus.running ||
          campaign.status == CampaignStatus.open;
      if (stillEarning) {
        earningAmount += amount;
        weightedRate +=
            amount *
            projectedAnnualisedRatePercent(
              profitPerLacPoisha: campaign.profitPerLac,
              sharePercent: campaign.share,
              tenureMonths: campaign.tenure,
            );
      }
    }

    final sectors =
        bySector.entries
            .map(
              (e) => SectorSlice(
                sector: e.key,
                amount: e.value,
                share: deployed == 0 ? 0 : e.value / deployed,
              ),
            )
            .toList()
          ..sort((a, b) => b.amount.compareTo(a.amount));

    return RibhFundSummary(
      deployed: deployed,
      inRecovery: inRecovery,
      deploymentCount: deploymentCount,
      sectorCount: bySector.length,
      sectors: sectors,
      blendedProjectedRate: earningAmount == 0
          ? null
          : weightedRate / earningAmount,
    );
  }
}

/// Reuses [portfolioControllerProvider], so the fund view reflects the same
/// holdings as Home and reloads whenever money moves.
@riverpod
Future<RibhFundSummary> ribhFundSummary(Ref ref) async {
  final holdings = await ref.watch(portfolioControllerProvider.future);
  return RibhFundSummary.fromHoldings(holdings);
}
