import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../core/failures/failure.dart';
import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

/// KYC submissions. The raw NID number is hashed on-device (sha-256) and
/// never transmitted or stored in the clear. Verification against the
/// national register and the tier upgrade are back-office; the app only
/// ever shows the real submission status.
class KycRepository extends SupabaseRepository {
  const KycRepository(super.client);

  /// The user's latest submission, or null if they never submitted.
  Future<Result<KycSubmission?>> latestSubmission() => guard((db) async {
    final rows = await db
        .from('kyc_submissions')
        .select()
        .order('created_at', ascending: false)
        .limit(1);
    return rows.isEmpty ? null : KycSubmission.fromJson(rows.first);
  });

  /// Submits KYC via the `submit_kyc` RPC. Returns the submission id.
  /// [selfieCaptured] stays false until the liveness provider integration
  /// exists; the flow says so honestly instead of faking a match.
  Future<Result<String>> submitKyc({
    required String nidNumber,
    required KycSource sourceOfFunds,
    bool selfieCaptured = false,
  }) => guard((db) async {
    final digits = nidNumber.replaceAll(RegExp(r'\D'), '');
    if (!isValidNidNumber(nidNumber)) {
      throw const ValidationFailure('invalid_nid');
    }
    final id = await db.rpc<dynamic>(
      'submit_kyc',
      params: {
        'p_nid_hash': hashNid(digits),
        'p_source_of_funds': sourceOfFunds.dbValue,
        'p_selfie_captured': selfieCaptured,
      },
    );
    return id as String;
  });
}

/// Bangladeshi NID numbers are 10, 13, or 17 digits.
bool isValidNidNumber(String input) {
  final digits = input.replaceAll(RegExp(r'\D'), '');
  if (digits.length != input.trim().length) return false;
  return const [10, 13, 17].contains(digits.length);
}

/// sha-256 hex digest of the NID digits; matches what `submit_kyc` expects.
String hashNid(String nidDigits) =>
    sha256.convert(utf8.encode(nidDigits)).toString();
