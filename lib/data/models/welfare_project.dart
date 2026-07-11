import 'package:freezed_annotation/freezed_annotation.dart';

part 'welfare_project.freezed.dart';
part 'welfare_project.g.dart';

@freezed
abstract class WelfareProject with _$WelfareProject {
  const WelfareProject._();

  const factory WelfareProject({
    required String id,
    required String sector,
    required String title,
    required String district,
    required int target,
    required int raised,
    required DateTime createdAt,
  }) = _WelfareProject;

  factory WelfareProject.fromJson(Map<String, dynamic> json) =>
      _$WelfareProjectFromJson(json);

  double get fundingPercent => target == 0 ? 0 : (raised / target) * 100;
}
