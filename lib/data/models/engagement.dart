import 'package:freezed_annotation/freezed_annotation.dart';

part 'engagement.freezed.dart';
part 'engagement.g.dart';

/// Consistency engagement state. The score reflects app engagement habits
/// and NEVER measures worship itself.
@freezed
abstract class Engagement with _$Engagement {
  const factory Engagement({
    required String profileId,
    required Map<String, dynamic> adhkarCounts,
    required Map<String, dynamic> habitDays,
    required int prayerStreak,
    required int score,
    required DateTime updatedAt,
  }) = _Engagement;

  factory Engagement.fromJson(Map<String, dynamic> json) =>
      _$EngagementFromJson(json);
}
