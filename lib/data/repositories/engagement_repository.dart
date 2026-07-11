import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

/// Engagement state behind the Barakah surfaces. The score reflects app
/// habits only; it never measures worship itself, is never punitive, and is
/// never public.
class EngagementRepository extends SupabaseRepository {
  const EngagementRepository(super.client);

  Future<Result<Engagement>> myEngagement() => guard((db) async {
    final uid = requireUid(db);
    final json = await db
        .from('engagement')
        .select()
        .eq('profile_id', uid)
        .single();
    return Engagement.fromJson(json);
  });

  Future<Result<Engagement>> saveEngagement({
    Map<String, dynamic>? adhkarCounts,
    Map<String, dynamic>? habitDays,
    int? prayerStreak,
    int? score,
  }) => guard((db) async {
    final uid = requireUid(db);
    final patch = <String, dynamic>{
      'adhkar_counts': ?adhkarCounts,
      'habit_days': ?habitDays,
      'prayer_streak': ?prayerStreak,
      'score': ?score,
    };
    final json = await db
        .from('engagement')
        .update(patch)
        .eq('profile_id', uid)
        .select()
        .single();
    return Engagement.fromJson(json);
  });
}
