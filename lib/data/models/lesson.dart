import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
abstract class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    required String slug,
    required String title,
    required int sort,
    required DateTime createdAt,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}
