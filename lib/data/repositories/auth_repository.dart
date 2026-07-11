import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

/// Auth and profile access. Sign-in is passwordless email OTP through
/// Supabase Auth; a new auth user gets a profile, wallet, and engagement row
/// via the database triggers.
class AuthRepository extends SupabaseRepository {
  const AuthRepository(super.client);

  bool get isSignedIn => client?.auth.currentSession != null;

  String? get currentEmail => client?.auth.currentUser?.email;

  /// Sends a one-time code to [email]. Creates the account on first use.
  Future<Result<void>> sendEmailOtp(String email) => guard((db) async {
    await db.auth.signInWithOtp(email: email);
  });

  /// Exchanges the emailed code for a session.
  Future<Result<void>> verifyEmailOtp({
    required String email,
    required String code,
  }) => guard((db) async {
    await db.auth.verifyOTP(type: OtpType.email, email: email, token: code);
  });

  Future<Result<void>> signOut() => guard((db) async {
    await db.auth.signOut();
  });

  Future<Result<Profile>> myProfile() => guard((db) async {
    final uid = requireUid(db);
    final json = await db.from('profiles').select().eq('id', uid).single();
    return Profile.fromJson(json);
  });

  Future<Result<Profile>> updateMyProfile({
    String? lang,
    String? theme,
    bool? twofaEnabled,
    String? riskTier,
  }) => guard((db) async {
    final uid = requireUid(db);
    final patch = <String, dynamic>{
      'lang': ?lang,
      'theme': ?theme,
      'twofa_enabled': ?twofaEnabled,
      'risk_tier': ?riskTier,
    };
    final json = await db
        .from('profiles')
        .update(patch)
        .eq('id', uid)
        .select()
        .single();
    return Profile.fromJson(json);
  });
}
