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
}
