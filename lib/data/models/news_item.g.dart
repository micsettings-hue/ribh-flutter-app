// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewsItem _$NewsItemFromJson(Map<String, dynamic> json) => _NewsItem(
  id: json['id'] as String,
  category: json['category'] as String,
  title: json['title'] as String,
  summary: json['summary'] as String? ?? '',
  link: json['link'] as String?,
  thumbnailPath: json['thumbnail_path'] as String?,
  published: json['published'] as bool? ?? false,
  sort: (json['sort'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$NewsItemToJson(_NewsItem instance) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'title': instance.title,
  'summary': instance.summary,
  'link': instance.link,
  'thumbnail_path': instance.thumbnailPath,
  'published': instance.published,
  'sort': instance.sort,
  'created_at': instance.createdAt.toIso8601String(),
};
