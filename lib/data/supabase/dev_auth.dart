import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_client.dart';

/// Development-only auto sign-in. In DEBUG builds only, if dev credentials
/// were provided via --dart-define(-from-file) and there is no session yet,
/// this signs in (creating the user on first run) so the app opens straight
/// into real data without the OTP/OAuth flow.
///
/// Hard-gated three ways so it can NEVER run in a shipped app:
///   1. `kReleaseMode` short-circuits it (also guards profile builds);
///   2. it does nothing unless DEV_EMAIL and DEV_PASSWORD are compiled in,
///      and those live only in the gitignored env/dev.json;
///   3. it only ever calls the public auth API with a normal password, so
///      it grants no privilege a normal user would not have.
abstract final class DevAuth {
  static const _email = String.fromEnvironment('DEV_EMAIL');
  static const _password = String.fromEnvironment('DEV_PASSWORD');

  static bool get _enabled =>
      !kReleaseMode &&
      RibhSupabase.isConfigured &&
      _email.isNotEmpty &&
      _password.isNotEmpty;

  /// Signs the dev user in WITHOUT blocking startup. Fire-and-forget from
  /// main() before runApp: the UI paints immediately (on the sign-in screen),
  /// and when this completes the router's onAuthStateChange listener
  /// redirects to the tabs. Every network call is bounded by a timeout so a
  /// slow or hanging backend can never stall the app; on timeout or error the
  /// app just stays on the normal signed-out screen.
  static void scheduleSignIn() {
    if (!_enabled) return;
    unawaited(_run());
  }

  static Future<void> _run() async {
    const budget = Duration(seconds: 8);
    final auth = Supabase.instance.client.auth;
    if (auth.currentSession != null) return;
    try {
      await auth
          .signInWithPassword(email: _email, password: _password)
          .timeout(budget);
    } on TimeoutException {
      debugPrint('DevAuth sign-in timed out; showing the sign-in screen.');
    } on AuthException {
      // First run: the dev user does not exist yet. Create it. With email
      // confirmation disabled on the dev project, sign-up returns a session
      // immediately; otherwise this is a no-op and the app shows the normal
      // signed-out state.
      try {
        await auth.signUp(email: _email, password: _password).timeout(budget);
      } on TimeoutException {
        debugPrint('DevAuth sign-up timed out.');
      } on AuthException catch (e) {
        debugPrint('DevAuth sign-up failed: ${e.message}');
      }
    }
  }
}
