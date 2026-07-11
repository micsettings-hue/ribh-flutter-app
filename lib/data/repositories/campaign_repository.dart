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
}
