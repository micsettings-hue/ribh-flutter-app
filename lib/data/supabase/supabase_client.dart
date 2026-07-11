import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase bootstrap. Credentials are injected at build time:
///
///   flutter run --dart-define=SUPABASE_URL=... \
///     --dart-define=SUPABASE_PUBLISHABLE_KEY=...
///
/// Nothing is committed. When credentials are absent (CI, local UI work) the
/// app runs unconfigured: repositories must surface a real "backend not
/// configured" failure, never a fake success.
abstract final class RibhSupabase {
  static const url = String.fromEnvironment('SUPABASE_URL');
  static const publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  static bool get isConfigured => url.isNotEmpty && publishableKey.isNotEmpty;

  static Future<void> init() async {
    if (!isConfigured) return;
    await Supabase.initialize(url: url, publishableKey: publishableKey);
  }
}

/// Null when Supabase is not configured. Repositories built on a null client
/// return a real `NotConfiguredFailure` from every call instead of faking a
/// backend. Tests override this with a client backed by a mock HTTP layer.
final supabaseClientOrNullProvider = Provider<SupabaseClient?>(
  (ref) => RibhSupabase.isConfigured ? Supabase.instance.client : null,
);

/// Repositories depend on this provider, never on `Supabase.instance`
/// directly, so tests can override it with a mock client.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  if (!RibhSupabase.isConfigured) {
    throw StateError(
      'Supabase is not configured. Pass SUPABASE_URL and '
      'SUPABASE_PUBLISHABLE_KEY via --dart-define.',
    );
  }
  return Supabase.instance.client;
});
