import '../../core/result/result.dart';
import 'supabase_repository.dart';

/// Qard e Hasanah is honestly coming soon: no lending exists in v1 and
/// repayment will be at par when it does. The only live action is
/// registering interest, which moves no money.
class QardRepository extends SupabaseRepository {
  const QardRepository(super.client);

  Future<Result<bool>> hasRegisteredInterest() => guard((db) async {
    final row = await db.from('qard_interest').select('id').maybeSingle();
    return row != null;
  });

  Future<Result<void>> registerInterest() => guard((db) async {
    final uid = requireUid(db);
    await db
        .from('qard_interest')
        .upsert(
          {'profile_id': uid},
          onConflict: 'profile_id',
          ignoreDuplicates: true,
        );
  });
}
