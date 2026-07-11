import '../../core/result/result.dart';
import '../models/models.dart';
import 'supabase_repository.dart';

/// Profile access for the signed-in user. Sign-in, sign-up, and the KYC flow
/// arrive in M2; the data spine only needs the profile row.
class AuthRepository extends SupabaseRepository {
  const AuthRepository(super.client);

  Future<Result<Profile>> myProfile() => guard((db) async {
    final uid = requireUid(db);
    final json = await db.from('profiles').select().eq('id', uid).single();
    return Profile.fromJson(json);
  });

  Future<Result<Profile>> updateMyProfile({
    String? lang,
    String? theme,
    bool? twofaEnabled,
  }) => guard((db) async {
    final uid = requireUid(db);
    final patch = <String, dynamic>{
      'lang': ?lang,
      'theme': ?theme,
      'twofa_enabled': ?twofaEnabled,
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
