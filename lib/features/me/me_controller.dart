import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/constants/risk_tiers.dart';
import '../../core/result/result.dart';
import '../../data/models/models.dart';
import '../../data/repositories/providers.dart';

part 'me_controller.g.dart';

class MeData {
  const MeData({required this.profile, required this.kyc, required this.email});

  final Profile profile;
  final KycSubmission? kyc;
  final String? email;
}

@riverpod
class MeController extends _$MeController {
  @override
  Future<MeData> build() async {
    final authRepo = ref.watch(authRepositoryProvider);
    final kycRepo = ref.watch(kycRepositoryProvider);

    final profile = (await authRepo.myProfile()).fold(
      (value) => value,
      (failure) => throw failure,
    );
    final kyc = (await kycRepo.latestSubmission()).fold(
      (value) => value,
      (failure) => throw failure,
    );
    return MeData(profile: profile, kyc: kyc, email: authRepo.currentEmail);
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }

  /// Submits KYC and refreshes. Returns the repository result so the sheet
  /// can render a real inline error.
  Future<Result<String>> submitKyc({
    required String nidNumber,
    required KycSource sourceOfFunds,
  }) async {
    final result = await ref
        .read(kycRepositoryProvider)
        .submitKyc(nidNumber: nidNumber, sourceOfFunds: sourceOfFunds);
    if (result.isOk) ref.invalidateSelf();
    return result;
  }

  Future<Result<Profile>> saveRiskTier(RiskTier tier) async {
    final result = await ref
        .read(authRepositoryProvider)
        .updateMyProfile(riskTier: tier.dbValue);
    if (result.isOk) ref.invalidateSelf();
    return result;
  }
}
