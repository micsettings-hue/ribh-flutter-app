import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

/// Shared plumbing for Zakat and Sadaqah: welfare projects and the
/// `give_welfare` RPC, which writes the contribution row and the ledger row
/// in one database transaction. The full amount reaches the project; Ribh
/// takes no fee out of Zakat (enforced by the RPC, not by UI copy).
abstract class WelfareRepository extends SupabaseRepository {
  const WelfareRepository(super.client);

  WelfareKind get kind;

  Future<Result<List<WelfareProject>>> projects() => guard((db) async {
    final rows = await db
        .from('welfare_projects')
        .select()
        .order('created_at', ascending: false);
    return rows.map(WelfareProject.fromJson).toList();
  });

  /// Returns the welfare contribution id.
  Future<Result<String>> give({
    required String projectId,
    required int amount,
  }) => guard((db) async {
    if (amount <= 0) throw const ValidationFailure('invalid_amount');
    final id = await db.rpc<dynamic>(
      'give_welfare',
      params: {
        'p_project_id': projectId,
        'p_kind': kind.name,
        'p_amount': amount,
      },
    );
    return id as String;
  });

  Future<Result<List<WelfareContribution>>> myContributions() =>
      guard((db) async {
        final rows = await db
            .from('welfare_contributions')
            .select()
            .eq('kind', kind.name)
            .order('created_at', ascending: false);
        return rows.map(WelfareContribution.fromJson).toList();
      });
}

class ZakatRepository extends WelfareRepository {
  const ZakatRepository(super.client);

  @override
  WelfareKind get kind => WelfareKind.zakat;
}

class SadaqahRepository extends WelfareRepository {
  const SadaqahRepository(super.client);

  @override
  WelfareKind get kind => WelfareKind.sadaqah;

  /// Your Forest: trees actually arranged, from both sadaqah and referrals.
  Future<Result<List<Tree>>> myTrees() => guard((db) async {
    final rows = await db
        .from('trees')
        .select()
        .order('created_at', ascending: false);
    return rows.map(Tree.fromJson).toList();
  });
}
