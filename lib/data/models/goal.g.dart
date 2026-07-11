// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Goal _$GoalFromJson(Map<String, dynamic> json) => _Goal(
  id: json['id'] as String,
  profileId: json['profile_id'] as String,
  title: json['title'] as String,
  icon: json['icon'] as String,
  target: (json['target'] as num).toInt(),
  saved: (json['saved'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$GoalToJson(_Goal instance) => <String, dynamic>{
  'id': instance.id,
  'profile_id': instance.profileId,
  'title': instance.title,
  'icon': instance.icon,
  'target': instance.target,
  'saved': instance.saved,
  'created_at': instance.createdAt.toIso8601String(),
};
