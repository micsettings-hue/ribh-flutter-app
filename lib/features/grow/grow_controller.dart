import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/result/result.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';
import '../home/home_controllers.dart';
import '../home/portfolio_controller.dart';
import '../wallet/wallet_controller.dart';

part 'grow_controller.g.dart';

/// A pending queue item joined to its campaign for display.
class QueueEntry {
  const QueueEntry({required this.item, required this.campaign});

  final AutoInvestQueueItem item;
  final Campaign campaign;
}

class GrowData {
  const GrowData({required this.rule, required this.pendingQueue});

  /// Null when auto-invest was never set up.
  final AutoInvestRule? rule;
  final List<QueueEntry> pendingQueue;
}

@riverpod
class GrowController extends _$GrowController {
  @override
  Future<GrowData> build() async {
    final autoInvest = ref.watch(autoInvestRepositoryProvider);
    final campaignsRepo = ref.watch(campaignRepositoryProvider);

    final rule = (await autoInvest.myRule()).fold(
      (value) => value,
      (failure) => throw failure,
    );
    if (rule == null) return const GrowData(rule: null, pendingQueue: []);

    final queue = (await autoInvest.myQueue()).fold(
      (value) => value,
      (failure) => throw failure,
    );
    final pending = queue
        .where((item) => item.status == QueueStatus.pending)
        .toList();
    if (pending.isEmpty) return GrowData(rule: rule, pendingQueue: const []);

    final campaigns = (await campaignsRepo.campaigns()).fold(
      (value) => value,
      (failure) => throw failure,
    );
    final byId = {for (final c in campaigns) c.id: c};
    return GrowData(
      rule: rule,
      pendingQueue: [
        for (final item in pending)
          if (byId[item.campaignId] case final campaign?)
            QueueEntry(item: item, campaign: campaign),
      ],
    );
  }

  Future<Result<AutoInvestRule>> saveRule({
    required String strategy,
    required int budget,
    required bool active,
  }) async {
    final existing = switch (state) {
      AsyncData(:final value) => value.rule?.id,
      _ => null,
    };
    final result = await ref
        .read(autoInvestRepositoryProvider)
        .saveRule(
          existingId: existing,
          strategy: strategy,
          budget: budget,
          active: active,
        );
    if (result.isOk) ref.invalidateSelf();
    return result;
  }

  /// Approves a pending proposal: server-side this deploys the rule budget
  /// and marks the item approved in one transaction. Everything money-
  /// related reloads on success.
  Future<Result<String>> approve({
    required String itemId,
    required bool riskAck1,
    required bool riskAck2,
  }) async {
    final result = await ref
        .read(autoInvestRepositoryProvider)
        .approveQueueItem(
          itemId: itemId,
          riskAck1: riskAck1,
          riskAck2: riskAck2,
        );
    if (result.isOk) {
      ref
        ..invalidateSelf()
        ..invalidate(portfolioControllerProvider)
        ..invalidate(amanahSummaryProvider)
        ..invalidate(walletControllerProvider);
    }
    return result;
  }

  Future<Result<void>> decline(String itemId) async {
    final result = await ref
        .read(autoInvestRepositoryProvider)
        .declineQueueItem(itemId);
    if (result.isOk) ref.invalidateSelf();
    return result;
  }
}

/// Goal mutations for Grow. Reads reuse [homeGoalsProvider] so Home and
/// Grow always show the same list. keepAlive: nothing watches this
/// mutation-only controller, and autoDispose would unmount its Ref while a
/// sheet's write is still in flight.
@Riverpod(keepAlive: true)
class GoalsController extends _$GoalsController {
  @override
  Future<void> build() async {}

  Future<Result<Goal>> createGoal({
    required String title,
    required String icon,
    required int target,
  }) async {
    final result = await ref
        .read(goalRepositoryProvider)
        .createGoal(title: title, icon: icon, target: target);
    if (result.isOk) ref.invalidate(homeGoalsProvider);
    return result;
  }

  Future<Result<Goal>> updateGoal(
    String id, {
    String? title,
    String? icon,
    int? target,
  }) async {
    final result = await ref
        .read(goalRepositoryProvider)
        .updateGoal(id, title: title, icon: icon, target: target);
    if (result.isOk) ref.invalidate(homeGoalsProvider);
    return result;
  }

  Future<Result<void>> deleteGoal(String id) async {
    final result = await ref.read(goalRepositoryProvider).deleteGoal(id);
    if (result.isOk) ref.invalidate(homeGoalsProvider);
    return result;
  }
}
