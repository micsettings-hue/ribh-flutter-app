import 'package:freezed_annotation/freezed_annotation.dart';

part 'distribution.freezed.dart';
part 'distribution.g.dart';

@freezed
abstract class Distribution with _$Distribution {
  const factory Distribution({
    required String id,
    required String campaignId,
    required int gross,
    required int ribhFee,
    required int investorShare,
    required DateTime createdAt,
  }) = _Distribution;

  factory Distribution.fromJson(Map<String, dynamic> json) =>
      _$DistributionFromJson(json);
}
