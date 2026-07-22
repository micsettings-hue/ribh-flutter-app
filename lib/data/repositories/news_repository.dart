import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

/// News and Insight content. RLS returns only published rows to non-admins,
/// so this reads the user-facing feed directly.
class NewsRepository extends SupabaseRepository {
  const NewsRepository(super.client);

  Future<Result<List<NewsItem>>> publishedNews({int limit = 10}) =>
      guard((db) async {
        final rows = await db
            .from('news_items')
            .select()
            .eq('published', true)
            .order('sort')
            .order('created_at', ascending: false)
            .limit(limit);
        return rows.map(NewsItem.fromJson).toList();
      });
}
