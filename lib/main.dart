import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'data/supabase/supabase_client.dart';

/// No automatic provider retry: screens render a real error state with an
/// explicit retry action instead of Riverpod's silent background retry loop.
Duration? ribhRetry(int retryCount, Object error) => null;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RibhSupabase.init();
  runApp(ProviderScope(retry: ribhRetry, child: const RibhApp()));
}
