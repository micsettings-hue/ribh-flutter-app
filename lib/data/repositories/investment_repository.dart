import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

class InvestmentRepository extends SupabaseRepository {
  const InvestmentRepository(super.client);

  Future<Result<List<Investment>>> myInvestments() => guard((db) async {
    final rows = await db
        .from('investments')
        .select()
        .order('created_at', ascending: false);
    return rows.map(Investment.fromJson).toList();
  });

  /// Commits an investment through the `invest_in_campaign` RPC: the
  /// `investments` row and the ledger row are written in ONE database
  /// transaction, never as two client calls. Returns the investment id.
  ///
  /// Both risk acknowledgements are required; the database enforces this
  /// again, along with KYC tier, campaign status, pool headroom, and the
  /// derived balance check.
  Future<Result<String>> invest({
    required String campaignId,
    required int amount,
    required bool riskAck1,
    required bool riskAck2,
    String source = 'wallet',
  }) => guard((db) async {
    if (!(riskAck1 && riskAck2)) {
      throw const ValidationFailure('risk_acknowledgements_required');
    }
    if (amount <= 0) {
      throw const ValidationFailure('invalid_amount');
    }
    final id = await db.rpc<dynamic>(
      'invest_in_campaign',
      params: {
        'p_campaign_id': campaignId,
        'p_amount': amount,
        'p_ack1': riskAck1,
        'p_ack2': riskAck2,
        'p_source': source,
      },
    );
    return id as String;
  });
}
