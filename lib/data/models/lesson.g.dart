// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Lesson _$LessonFromJson(Map<String, dynamic> json) => _Lesson(
  id: json['id'] as String,
  slug: json['slug'] as String,
  title: json['title'] as String,
  sort: (json['sort'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  body: json['body'] as String? ?? '',
);

Map<String, dynamic> _$LessonToJson(_Lesson instance) => <String, dynamic>{
  'id': instance.id,
  'slug': instance.slug,
  'title': instance.title,
  'sort': instance.sort,
  'created_at': instance.createdAt.toIso8601String(),
  'body': instance.body,
};
