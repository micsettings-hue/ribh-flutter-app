import 'package:freezed_annotation/freezed_annotation.dart';

part 'nominee.freezed.dart';
part 'nominee.g.dart';

@freezed
abstract class Nominee with _$Nominee {
  const factory Nominee({
    required String id,
    required String profileId,
    required String name,
    required String relation,
    String? nidHash,
    required DateTime createdAt,
  }) = _Nominee;

  factory Nominee.fromJson(Map<String, dynamic> json) =>
      _$NomineeFromJson(json);
}
