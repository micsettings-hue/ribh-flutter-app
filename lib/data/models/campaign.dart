import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'campaign.freezed.dart';
part 'campaign.g.dart';

@freezed
abstract class Campaign with _$Campaign {
  const Campaign._();

  const factory Campaign({
    required String id,
    String? businessId,
    required String contract,
    required String sector,
    required int pool,
    required int raised,
    required int profitPerLac,
    required double share,
    required int tenure,
    required String risk,
    required CampaignStatus status,
    required DateTime createdAt,
  }) = _Campaign;

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);

  double get fundingPercent => pool == 0 ? 0 : (raised / pool) * 100;
}
