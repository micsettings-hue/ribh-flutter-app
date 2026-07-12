import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

part 'portfolio_controller.g.dart';

class PortfolioHolding {
  const PortfolioHolding({required this.investment, required this.campaign});

  final Investment investment;
  final Campaign campaign;
}

/// The user's holdings joined to their campaigns, ordered running, matured,
/// recovery (then open), per the Home portfolio-row spec.
@riverpod
class PortfolioController extends _$PortfolioController {
  static const _order = [
    CampaignStatus.running,
    CampaignStatus.matured,
    CampaignStatus.inRecovery,
    CampaignStatus.open,
  ];

  @override
  Future<List<PortfolioHolding>> build() async {
    final investments =
        (await ref.watch(investmentRepositoryProvider).myInvestments()).fold(
          (value) => value,
          (failure) => throw failure,
        );
    if (investments.isEmpty) return const [];

    final campaigns = (await ref.watch(campaignRepositoryProvider).campaigns())
        .fold((value) => value, (failure) => throw failure);
    final byId = {for (final c in campaigns) c.id: c};

    final holdings = [
      for (final investment in investments)
        if (byId[investment.campaignId] case final campaign?)
          PortfolioHolding(investment: investment, campaign: campaign),
    ];
    holdings.sort(
      (a, b) => _order
          .indexOf(a.campaign.status)
          .compareTo(_order.indexOf(b.campaign.status)),
    );
    return holdings;
  }
}
