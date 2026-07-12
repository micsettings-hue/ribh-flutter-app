import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/result/result.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';
import '../home/home_controllers.dart';

part 'campaign_detail_controller.g.dart';

@riverpod
class CampaignDetailController extends _$CampaignDetailController {
  @override
  Future<Campaign> build(String campaignId) async {
    final repo = ref.watch(campaignRepositoryProvider);
    return (await repo.campaignById(
      campaignId,
    )).fold((value) => value, (failure) => throw failure);
  }

  /// Commits the investment through the one-transaction RPC. On success the
  /// campaign (funding), portfolio, marketplace, and wallet all reload so
  /// every surface reflects the ledger. Returns the result so the sheet can
  /// render the real error (insufficient funds, not verified, ...).
  Future<Result<String>> invest({
    required int amountPoisha,
    required bool riskAck1,
    required bool riskAck2,
  }) async {
    final result = await ref
        .read(investmentRepositoryProvider)
        .invest(
          campaignId: campaignId,
          amount: amountPoisha,
          riskAck1: riskAck1,
          riskAck2: riskAck2,
        );
    if (result.isOk) {
      ref.invalidateSelf();
      refreshMoneySurfaces(ref);
    }
    return result;
  }
}
