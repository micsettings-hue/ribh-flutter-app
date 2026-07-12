import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

class LearnRepository extends SupabaseRepository {
  const LearnRepository(super.client);

  Future<Result<List<Lesson>>> lessons() => guard((db) async {
    final rows = await db.from('lessons').select().order('sort');
    return rows.map(Lesson.fromJson).toList();
  });

  /// Per-user progress keyed by module (lesson) id.
  Future<Result<Map<String, LessonProgress>>> myProgress() => guard((db) async {
    final rows = await db.from('lessons_progress').select();
    return {
      for (final row in rows.map(LessonProgress.fromJson)) row.moduleId: row,
    };
  });

  /// Records a read: increments read_count and marks the module completed.
  Future<Result<LessonProgress>> markRead(String moduleId) => guard((db) async {
    final uid = requireUid(db);
    final existing = await db
        .from('lessons_progress')
        .select()
        .eq('module_id', moduleId)
        .maybeSingle();
    final readCount = existing == null
        ? 1
        : (LessonProgress.fromJson(existing).readCount + 1);
    final json = await db
        .from('lessons_progress')
        .upsert({
          'profile_id': uid,
          'module_id': moduleId,
          'read_count': readCount,
          'completed': true,
        }, onConflict: 'profile_id,module_id')
        .select()
        .single();
    return LessonProgress.fromJson(json);
  });
}
