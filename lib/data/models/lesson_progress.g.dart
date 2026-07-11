// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessonProgress _$LessonProgressFromJson(Map<String, dynamic> json) =>
    _LessonProgress(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      moduleId: json['module_id'] as String,
      readCount: (json['read_count'] as num).toInt(),
      completed: json['completed'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$LessonProgressToJson(_LessonProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'module_id': instance.moduleId,
      'read_count': instance.readCount,
      'completed': instance.completed,
      'created_at': instance.createdAt.toIso8601String(),
    };
