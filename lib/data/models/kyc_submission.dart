import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'kyc_submission.freezed.dart';
part 'kyc_submission.g.dart';

/// A KYC submission. The raw NID never leaves the device; only its sha-256
/// digest is stored. Approval happens back-office (service_role); the app
/// never shows a verified state it did not earn.
@freezed
abstract class KycSubmission with _$KycSubmission {
  const factory KycSubmission({
    required String id,
    required String profileId,
    required String nidHash,
    required KycSource sourceOfFunds,
    required bool selfieCaptured,
    required KycStatus status,
    required DateTime createdAt,
  }) = _KycSubmission;

  factory KycSubmission.fromJson(Map<String, dynamic> json) =>
      _$KycSubmissionFromJson(json);
}
