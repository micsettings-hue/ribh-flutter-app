import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

/// Referral records. Rewards are trees only, never cash or fee credit;
/// status moves on sign-up and verification only, never on investing.
class ReferralRepository extends SupabaseRepository {
  const ReferralRepository(super.client);

  Future<Result<List<Referral>>> myReferrals() => guard((db) async {
    final uid = requireUid(db);
    final rows = await db
        .from('referrals')
        .select()
        .eq('referrer_id', uid)
        .order('created_at', ascending: false);
    return rows.map(Referral.fromJson).toList();
  });

  /// The user's referral code for building the invite link.
  Future<Result<String>> myReferralCode() => guard((db) async {
    final uid = requireUid(db);
    final row = await db
        .from('profiles')
        .select('referral_code')
        .eq('id', uid)
        .single();
    return row['referral_code'] as String;
  });

  /// Redeems points for one tree pledge via the server-side conversion
  /// (points math enforced in the RPC; see referral_points.dart).
  Future<Result<String>> redeemTree() => guard((db) async {
    final id = await db.rpc<dynamic>('redeem_referral_tree');
    return id as String;
  });

  /// Trees pledged and planted from all sources (Your Forest shares them).
  Future<Result<List<Tree>>> myTrees() => guard((db) async {
    final rows = await db
        .from('trees')
        .select()
        .order('created_at', ascending: false);
    return rows.map(Tree.fromJson).toList();
  });
}
