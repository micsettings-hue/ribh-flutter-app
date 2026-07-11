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
}
