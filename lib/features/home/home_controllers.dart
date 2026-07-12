import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';
import 'portfolio_controller.dart';

part 'home_controllers.g.dart';

/// The Amanah summary. Every figure is derived, never stored:
/// - [available] is the server-derived ledger balance;
/// - [deployed] sums investments whose campaign is open, running, or
///   matured (capital stays deployed until a settlement ledger row returns
///   it; maturity alone moves nothing);
/// - [inRecovery] sums investments whose campaign is in recovery.
class AmanahSummary {
  const AmanahSummary({
    required this.available,
    required this.deployed,
    required this.inRecovery,
  });

  final int available;
  final int deployed;
  final int inRecovery;
}

@riverpod
Future<AmanahSummary> amanahSummary(Ref ref) async {
  final balance = (await ref.watch(walletRepositoryProvider).myBalance()).fold(
    (value) => value,
    (failure) => throw failure,
  );
  final holdings = await ref.watch(portfolioControllerProvider.future);

  var deployed = 0;
  var inRecovery = 0;
  for (final holding in holdings) {
    if (holding.campaign.status == CampaignStatus.inRecovery) {
      inRecovery += holding.investment.amount;
    } else {
      deployed += holding.investment.amount;
    }
  }
  return AmanahSummary(
    available: balance,
    deployed: deployed,
    inRecovery: inRecovery,
  );
}

@riverpod
Future<List<Goal>> homeGoals(Ref ref) async {
  return (await ref.watch(goalRepositoryProvider).myGoals()).fold(
    (value) => value,
    (failure) => throw failure,
  );
}

/// The user's largest deployment in a running campaign, for the
/// where's-my-money card. Null when nothing is running.
@riverpod
Future<PortfolioHolding?> largestLiveDeployment(Ref ref) async {
  final holdings = await ref.watch(portfolioControllerProvider.future);
  PortfolioHolding? largest;
  for (final holding in holdings) {
    if (holding.campaign.status != CampaignStatus.running) continue;
    if (largest == null ||
        holding.investment.amount > largest.investment.amount) {
      largest = holding;
    }
  }
  return largest;
}
