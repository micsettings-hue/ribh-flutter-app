import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

class WalletRepository extends SupabaseRepository {
  const WalletRepository(super.client);

  Future<Result<InvestorWallet>> myWallet() => guard((db) async {
    final uid = requireUid(db);
    final json = await db
        .from('investor_wallets')
        .select()
        .eq('profile_id', uid)
        .single();
    return InvestorWallet.fromJson(json);
  });

  /// Balance derived server-side over the append-only ledger. Never stored.
  Future<Result<int>> myBalance() => guard((db) async {
    final value = await db.rpc<dynamic>('my_wallet_balance');
    return (value as num).toInt();
  });

  /// Ledger rows, newest first. [before] pages further back in time.
  Future<Result<List<WalletTransaction>>> myTransactions({
    int limit = 50,
    DateTime? before,
  }) => guard((db) async {
    var query = db.from('wallet_transactions').select();
    if (before != null) {
      query = query.lt('created_at', before.toIso8601String());
    }
    final rows = await query.order('created_at', ascending: false).limit(limit);
    return rows.map(WalletTransaction.fromJson).toList();
  });

  /// Records a deposit request. Nothing is credited until back-office
  /// confirmation; the returned request is honestly pending.
  Future<Result<String>> requestDeposit({
    required PaymentMethod method,
    required int amount,
    String? reference,
  }) => guard((db) async {
    final id = await db.rpc<dynamic>(
      'request_deposit',
      params: {
        'p_method': method.name,
        'p_amount': amount,
        'p_reference': reference,
      },
    );
    return id as String;
  });

  /// Records a withdrawal request against the available balance (derived
  /// balance minus withdrawals already pending, enforced server-side).
  Future<Result<String>> requestWithdrawal({
    required PaymentMethod method,
    required int amount,
  }) => guard((db) async {
    final id = await db.rpc<dynamic>(
      'request_withdrawal',
      params: {'p_method': method.name, 'p_amount': amount},
    );
    return id as String;
  });

  /// Cancels one of the user's own requests while it is still pending.
  Future<Result<void>> cancelMoneyRequest(String requestId) => guard(
    (db) => db.rpc<void>(
      'cancel_money_request',
      params: {'p_request_id': requestId},
    ),
  );

  /// The user's deposit and withdrawal requests, newest first.
  Future<Result<List<MoneyRequest>>> myMoneyRequests({int limit = 20}) =>
      guard((db) async {
        final rows = await db
            .from('money_requests')
            .select()
            .order('created_at', ascending: false)
            .limit(limit);
        return rows.map(MoneyRequest.fromJson).toList();
      });
}
