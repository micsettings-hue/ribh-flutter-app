import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/result/result.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

part 'wallet_controller.g.dart';

class WalletData {
  const WalletData({
    required this.balance,
    required this.transactions,
    required this.requests,
  });

  /// Derived server-side over the append-only ledger, in poisha.
  final int balance;
  final List<WalletTransaction> transactions;
  final List<MoneyRequest> requests;

  List<MoneyRequest> get pendingRequests => requests
      .where((r) => r.status == MoneyRequestStatus.pending)
      .toList(growable: false);

  /// What a new withdrawal may draw on: the derived balance minus
  /// withdrawals already requested but not yet decided. Mirrors the check
  /// inside the request_withdrawal RPC.
  int get availableForWithdrawal =>
      balance -
      pendingRequests
          .where((r) => r.kind == MoneyRequestKind.withdrawal)
          .fold(0, (sum, r) => sum + r.amount);
}

@riverpod
class WalletController extends _$WalletController {
  @override
  Future<WalletData> build() async {
    final repo = ref.watch(walletRepositoryProvider);
    final results = await Future.wait([
      repo.myBalance(),
      repo.myTransactions(),
      repo.myMoneyRequests(),
    ]);
    T unwrap<T>(Result<dynamic> result) =>
        result.fold((value) => value as T, (failure) => throw failure);
    return WalletData(
      balance: unwrap<int>(results[0]),
      transactions: unwrap<List<WalletTransaction>>(results[1]),
      requests: unwrap<List<MoneyRequest>>(results[2]),
    );
  }

  /// Records a deposit request; refreshes on success. Returns the result so
  /// the sheet renders a real inline error.
  Future<Result<String>> requestDeposit({
    required PaymentMethod method,
    required int amount,
    String? reference,
  }) async {
    final result = await ref
        .read(walletRepositoryProvider)
        .requestDeposit(method: method, amount: amount, reference: reference);
    if (result.isOk) ref.invalidateSelf();
    return result;
  }

  Future<Result<String>> requestWithdrawal({
    required PaymentMethod method,
    required int amount,
  }) async {
    final result = await ref
        .read(walletRepositoryProvider)
        .requestWithdrawal(method: method, amount: amount);
    if (result.isOk) ref.invalidateSelf();
    return result;
  }

  Future<Result<void>> cancelRequest(String requestId) async {
    final result = await ref
        .read(walletRepositoryProvider)
        .cancelMoneyRequest(requestId);
    if (result.isOk) ref.invalidateSelf();
    return result;
  }
}
