import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_progress.freezed.dart';
part 'lesson_progress.g.dart';

@freezed
abstract class LessonProgress with _$LessonProgress {
  const factory LessonProgress({
    required String id,
    required String profileId,
    required String moduleId,
    required int readCount,
    required bool completed,
    required DateTime createdAt,
  }) = _LessonProgress;

  factory LessonProgress.fromJson(Map<String, dynamic> json) =>
      _$LessonProgressFromJson(json);
}
