import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'tree.freezed.dart';
part 'tree.g.dart';

@freezed
abstract class Tree with _$Tree {
  const factory Tree({
    required String id,
    required String profileId,
    required TreeSource source,
    String? drive,
    String? district,
    DateTime? plantedAt,
    required DateTime createdAt,
  }) = _Tree;

  factory Tree.fromJson(Map<String, dynamic> json) => _$TreeFromJson(json);
}
