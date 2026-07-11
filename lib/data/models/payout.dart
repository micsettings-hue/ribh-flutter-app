import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'payout.freezed.dart';
part 'payout.g.dart';

@freezed
abstract class Payout with _$Payout {
  const factory Payout({
    required String id,
    required String profileId,
    required String distributionId,
    required PayoutRoute route,
    required DateTime createdAt,
  }) = _Payout;

  factory Payout.fromJson(Map<String, dynamic> json) => _$PayoutFromJson(json);
}
