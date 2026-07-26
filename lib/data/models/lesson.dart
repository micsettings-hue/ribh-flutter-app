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
    // Long-form article body. Board-gated placeholder until sign-off; empty
    // when a lesson has no body yet. Simple markup: lines starting with
    // "## " are section headings, blank lines separate paragraphs.
    @Default('') String body,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}
