import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

class CampaignRepository extends SupabaseRepository {
  const CampaignRepository(super.client);

  Future<Result<List<Campaign>>> campaigns({CampaignStatus? status}) =>
      guard((db) async {
        var query = db.from('campaigns').select();
        if (status != null) {
          query = query.eq('status', status.dbValue);
        }
        final rows = await query.order('created_at', ascending: false);
        return rows.map(Campaign.fromJson).toList();
      });

  Future<Result<Campaign>> campaignById(String id) => guard((db) async {
    final json = await db.from('campaigns').select().eq('id', id).single();
    return Campaign.fromJson(json);
  });

  /// Campaign ids on the user's watchlist (the Saved set).
  Future<Result<Set<String>>> myWatchlist() => guard((db) async {
    final rows = await db.from('campaign_watchlist').select('campaign_id');
    return rows.map((row) => row['campaign_id'] as String).toSet();
  });

  Future<Result<void>> saveToWatchlist(String campaignId) => guard((db) async {
    final uid = requireUid(db);
    await db
        .from('campaign_watchlist')
        .upsert(
          {'profile_id': uid, 'campaign_id': campaignId},
          onConflict: 'profile_id,campaign_id',
          ignoreDuplicates: true,
        );
  });

  Future<Result<void>> removeFromWatchlist(String campaignId) =>
      guard((db) async {
        final uid = requireUid(db);
        await db
            .from('campaign_watchlist')
            .delete()
            .eq('profile_id', uid)
            .eq('campaign_id', campaignId);
      });
}
