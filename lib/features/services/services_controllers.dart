import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/result/result.dart';
import '../../data/metals/metals_price_source.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';
import '../home/home_controllers.dart';
import '../wallet/wallet_controller.dart';

part 'services_controllers.g.dart';

T _unwrap<T>(Result<T> result) =>
    result.fold((value) => value, (failure) => throw failure);

// Learn ----------------------------------------------------------------------

class LearnData {
  const LearnData({required this.lessons, required this.progress});

  final List<Lesson> lessons;
  final Map<String, LessonProgress> progress;

  int get completedCount =>
      lessons.where((l) => progress[l.id]?.completed ?? false).length;
}

@riverpod
class LearnController extends _$LearnController {
  @override
  Future<LearnData> build() async {
    final repo = ref.watch(learnRepositoryProvider);
    return LearnData(
      lessons: _unwrap(await repo.lessons()),
      progress: _unwrap(await repo.myProgress()),
    );
  }

  Future<Result<LessonProgress>> markRead(String moduleId) async {
    final result = await ref.read(learnRepositoryProvider).markRead(moduleId);
    if (result.isOk) ref.invalidateSelf();
    return result;
  }
}

// Zakat and Sadaqah ------------------------------------------------------------

class ZakatData {
  const ZakatData({required this.projects, required this.silverPrice});

  final List<WelfareProject> projects;

  /// Null when the metals price source is not connected; the Nisab status
  /// then renders as honestly unavailable, never estimated.
  final SilverPrice? silverPrice;
}

@riverpod
class ZakatController extends _$ZakatController {
  @override
  Future<ZakatData> build() async {
    final projects = _unwrap(
      await ref.watch(zakatRepositoryProvider).projects(),
    );
    final price = (await ref.watch(metalsPriceSourceProvider).silverPrice())
        .fold<SilverPrice?>((value) => value, (_) => null);
    return ZakatData(projects: projects, silverPrice: price);
  }

  Future<Result<String>> give({
    required String projectId,
    required int amount,
  }) async {
    final result = await ref
        .read(zakatRepositoryProvider)
        .give(projectId: projectId, amount: amount);
    if (result.isOk) {
      ref
        ..invalidateSelf()
        ..invalidate(walletControllerProvider)
        ..invalidate(amanahSummaryProvider);
    }
    return result;
  }
}

class SadaqahData {
  const SadaqahData({
    required this.projects,
    required this.contributions,
    required this.habitDays,
    required this.trees,
  });

  final List<WelfareProject> projects;
  final List<WelfareContribution> contributions;

  /// ISO date strings (yyyy-mm-dd) with a giving action, from engagement.
  final Set<String> habitDays;
  final List<Tree> trees;

  int get lifetimeTotal => contributions.fold(0, (sum, c) => sum + c.amount);

  int monthTotal(DateTime now) => contributions
      .where(
        (c) => c.createdAt.year == now.year && c.createdAt.month == now.month,
      )
      .fold(0, (sum, c) => sum + c.amount);

  /// Distinct habit days within the past 30 days.
  int habitCount(DateTime now) => habitDays.where((iso) {
    final day = DateTime.tryParse(iso);
    if (day == null) return false;
    final age = now.difference(day).inDays;
    return age >= 0 && age < 30;
  }).length;
}

String isoDay(DateTime day) =>
    '${day.year.toString().padLeft(4, '0')}-'
    '${day.month.toString().padLeft(2, '0')}-'
    '${day.day.toString().padLeft(2, '0')}';

@riverpod
class SadaqahController extends _$SadaqahController {
  @override
  Future<SadaqahData> build() async {
    final repo = ref.watch(sadaqahRepositoryProvider);
    final engagement = _unwrap(
      await ref.watch(engagementRepositoryProvider).myEngagement(),
    );
    return SadaqahData(
      projects: _unwrap(await repo.projects()),
      contributions: _unwrap(await repo.myContributions()),
      habitDays: engagement.habitDays.keys.toSet(),
      trees: _unwrap(await repo.myTrees()),
    );
  }

  /// Gives sadaqah and records today in the habit grid. The habit write is
  /// best-effort bookkeeping; the money movement is the RPC's transaction.
  Future<Result<String>> give({
    required String projectId,
    required int amount,
  }) async {
    final result = await ref
        .read(sadaqahRepositoryProvider)
        .give(projectId: projectId, amount: amount);
    if (result.isOk) {
      final data = switch (state) {
        AsyncData(:final value) => value,
        _ => null,
      };
      final today = isoDay(DateTime.now());
      if (data != null && !data.habitDays.contains(today)) {
        await ref
            .read(engagementRepositoryProvider)
            .saveEngagement(
              habitDays: {
                for (final day in data.habitDays) day: true,
                today: true,
              },
            );
      }
      ref
        ..invalidateSelf()
        ..invalidate(walletControllerProvider)
        ..invalidate(amanahSummaryProvider);
    }
    return result;
  }
}

// Qard -------------------------------------------------------------------------

@riverpod
class QardController extends _$QardController {
  @override
  Future<bool> build() async =>
      _unwrap(await ref.watch(qardRepositoryProvider).hasRegisteredInterest());

  Future<Result<void>> registerInterest() async {
    final result = await ref.read(qardRepositoryProvider).registerInterest();
    if (result.isOk) ref.invalidateSelf();
    return result;
  }
}

// Invite -----------------------------------------------------------------------

class InviteData {
  const InviteData({
    required this.code,
    required this.referrals,
    required this.trees,
  });

  final String code;
  final List<Referral> referrals;
  final List<Tree> trees;

  int get joined =>
      referrals.where((r) => r.status == ReferralStatus.joined).length;
  int get verified =>
      referrals.where((r) => r.status == ReferralStatus.verified).length;
  int get redeemedTrees =>
      trees.where((t) => t.source == TreeSource.referral).length;

  String get link => 'https://ribh.app/r/$code';
}

@riverpod
class InviteController extends _$InviteController {
  @override
  Future<InviteData> build() async {
    final repo = ref.watch(referralRepositoryProvider);
    return InviteData(
      code: _unwrap(await repo.myReferralCode()),
      referrals: _unwrap(await repo.myReferrals()),
      trees: _unwrap(await repo.myTrees()),
    );
  }

  Future<Result<String>> redeemTree() async {
    final result = await ref.read(referralRepositoryProvider).redeemTree();
    if (result.isOk) ref.invalidateSelf();
    return result;
  }
}
