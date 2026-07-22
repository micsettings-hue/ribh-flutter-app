import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_item.freezed.dart';
part 'news_item.g.dart';

/// A News and Insight content item, authored through the admin tool (M10)
/// and shown on Home. Only published rows reach clients (RLS).
@freezed
abstract class NewsItem with _$NewsItem {
  const factory NewsItem({
    required String id,
    required String category,
    required String title,
    @Default('') String summary,
    String? link,
    String? thumbnailPath,
    @Default(false) bool published,
    @Default(0) int sort,
    required DateTime createdAt,
  }) = _NewsItem;

  factory NewsItem.fromJson(Map<String, dynamic> json) =>
      _$NewsItemFromJson(json);
}
