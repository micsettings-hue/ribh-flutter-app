import 'package:http/http.dart' show ClientException;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/failures/failure.dart';
import '../../core/result/result.dart';

/// Base for all repositories. Every public method returns `Result<T>`;
/// nothing throws across the repository boundary.
///
/// [client] is null when Supabase credentials were not provided at build
/// time; every call then fails honestly with [NotConfiguredFailure].
abstract class SupabaseRepository {
  const SupabaseRepository(this.client);

  final SupabaseClient? client;

  Future<Result<T>> guard<T>(Future<T> Function(SupabaseClient db) run) async {
    final db = client;
    if (db == null) return Err<T>(const NotConfiguredFailure());
    try {
      return Ok(await run(db));
    } on Failure catch (failure) {
      return Err<T>(failure);
    } on AuthException catch (e) {
      return Err<T>(AuthFailure(e.message));
    } on PostgrestException catch (e) {
      return Err<T>(mapPostgrestException(e));
    } on ClientException catch (e) {
      return Err<T>(NetworkFailure(e.message));
    } catch (e) {
      return Err<T>(UnknownFailure(e.toString()));
    }
  }

  /// The current user's id, or an [AuthFailure] out of [guard] if signed out.
  String requireUid(SupabaseClient db) {
    final uid = db.auth.currentUser?.id;
    if (uid == null) throw const AuthFailure();
    return uid;
  }
}

/// Maps the raise messages of the database RPCs (see
/// supabase/migrations/20260711000200_ledger.sql) onto typed failures.
Failure mapPostgrestException(PostgrestException e) {
  final message = e.message;
  if (message.contains('insufficient_funds')) {
    return const InsufficientFundsFailure();
  }
  if (message.contains('not_verified')) {
    return const NotVerifiedFailure();
  }
  if (message.contains('not_authenticated') || e.code == '401') {
    return const AuthFailure();
  }
  const validation = [
    'risk_acknowledgements_required',
    'invalid_amount',
    'campaign_not_open',
    'campaign_not_found',
    'exceeds_pool',
    'project_not_found',
    'wallet_not_found',
  ];
  if (validation.any(message.contains)) {
    return ValidationFailure(message);
  }
  return UnknownFailure(message);
}
