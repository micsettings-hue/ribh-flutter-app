import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

class AutoInvestRepository extends SupabaseRepository {
  const AutoInvestRepository(super.client);

  /// The user's rule, or null when auto-invest was never set up.
  /// One rule per user in v1 (the newest wins if legacy rows exist).
  Future<Result<AutoInvestRule?>> myRule() => guard((db) async {
    final rows = await db
        .from('auto_invest_rules')
        .select()
        .order('created_at', ascending: false)
        .limit(1);
    return rows.isEmpty ? null : AutoInvestRule.fromJson(rows.first);
  });

  /// Creates or updates the rule. Strategy is a RiskTier dbValue; budget is
  /// poisha per deployment.
  Future<Result<AutoInvestRule>> saveRule({
    String? existingId,
    required String strategy,
    required int budget,
    required bool active,
  }) => guard((db) async {
    if (budget <= 0) throw const ValidationFailure('invalid_amount');
    final values = {'strategy': strategy, 'budget': budget, 'active': active};
    final Map<String, dynamic> json;
    if (existingId == null) {
      final uid = requireUid(db);
      json = await db
          .from('auto_invest_rules')
          .insert({...values, 'profile_id': uid})
          .select()
          .single();
    } else {
      json = await db
          .from('auto_invest_rules')
          .update(values)
          .eq('id', existingId)
          .select()
          .single();
    }
    return AutoInvestRule.fromJson(json);
  });

  /// Queue items for the user's rules, newest first. All statuses; the
  /// controller separates pending from decided.
  Future<Result<List<AutoInvestQueueItem>>> myQueue({int limit = 30}) =>
      guard((db) async {
        final rows = await db
            .from('auto_invest_queue')
            .select()
            .order('created_at', ascending: false)
            .limit(limit);
        return rows.map(AutoInvestQueueItem.fromJson).toList();
      });

  /// Approves a pending item: ONE transaction server-side marks it approved
  /// and deploys the rule budget (investment + ledger row) via
  /// invest_in_campaign. Both acknowledgements are refused locally too.
  Future<Result<String>> approveQueueItem({
    required String itemId,
    required bool riskAck1,
    required bool riskAck2,
  }) => guard((db) async {
    if (!(riskAck1 && riskAck2)) {
      throw const ValidationFailure('risk_acknowledgements_required');
    }
    final id = await db.rpc<dynamic>(
      'approve_queue_item',
      params: {'p_item_id': itemId, 'p_ack1': riskAck1, 'p_ack2': riskAck2},
    );
    return id as String;
  });

  /// Declines a pending item. Moves no money; plain status update under the
  /// owner-decides RLS policy.
  Future<Result<void>> declineQueueItem(String itemId) => guard((db) async {
    await db
        .from('auto_invest_queue')
        .update({'status': 'declined'})
        .eq('id', itemId);
  });
}
