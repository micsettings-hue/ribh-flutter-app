import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    required UserRole role,
    required int kycTier,
    String? nidHash,
    String? riskTier,
    required String lang,
    required String theme,
    required bool twofaEnabled,
    String? nomineeId,
    required DateTime createdAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
