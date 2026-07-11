// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engagement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Engagement _$EngagementFromJson(Map<String, dynamic> json) => _Engagement(
  profileId: json['profile_id'] as String,
  adhkarCounts: json['adhkar_counts'] as Map<String, dynamic>,
  habitDays: json['habit_days'] as Map<String, dynamic>,
  prayerStreak: (json['prayer_streak'] as num).toInt(),
  score: (json['score'] as num).toInt(),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$EngagementToJson(_Engagement instance) =>
    <String, dynamic>{
      'profile_id': instance.profileId,
      'adhkar_counts': instance.adhkarCounts,
      'habit_days': instance.habitDays,
      'prayer_streak': instance.prayerStreak,
      'score': instance.score,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
