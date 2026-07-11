import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

class GoalRepository extends SupabaseRepository {
  const GoalRepository(super.client);

  Future<Result<List<Goal>>> myGoals() => guard((db) async {
    final rows = await db
        .from('goals')
        .select()
        .order('created_at', ascending: false);
    return rows.map(Goal.fromJson).toList();
  });

  Future<Result<Goal>> createGoal({
    required String title,
    required String icon,
    required int target,
  }) => guard((db) async {
    if (target <= 0) throw const ValidationFailure('invalid_amount');
    final uid = requireUid(db);
    final json = await db
        .from('goals')
        .insert({
          'profile_id': uid,
          'title': title,
          'icon': icon,
          'target': target,
        })
        .select()
        .single();
    return Goal.fromJson(json);
  });

  Future<Result<Goal>> updateGoal(
    String id, {
    String? title,
    String? icon,
    int? target,
  }) => guard((db) async {
    if (target != null && target <= 0) {
      throw const ValidationFailure('invalid_amount');
    }
    final patch = <String, dynamic>{
      'title': ?title,
      'icon': ?icon,
      'target': ?target,
    };
    final json = await db
        .from('goals')
        .update(patch)
        .eq('id', id)
        .select()
        .single();
    return Goal.fromJson(json);
  });

  Future<Result<void>> deleteGoal(String id) => guard((db) async {
    await db.from('goals').delete().eq('id', id);
  });
}
