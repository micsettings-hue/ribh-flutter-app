import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

const _fontsRoot = 'node_modules/@expo-google-fonts';

/// The taka sign U+09F3 lives in Anek Bangla, not in Inter or Hanken, so we
/// append it as a same-family fallback for the Latin families. Without it,
/// every currency amount renders the sign as a box glyph.
const _takaFallback = 'anek-bangla/AnekBangla_400Regular.ttf';

/// google_fonts registers each weight as its own family, named
/// `<FamilyNoSpaces>_<variant>` (variant is `regular` for w400, else the
/// weight number). We register the real TTFs under those exact names so
/// golden captures render text instead of the default box glyphs. [fallback]
/// files are added under the same family for glyphs the primary font lacks.
Future<void> _load(
  String googleFamily,
  String path, {
  List<String> fallback = const [],
}) async {
  final file = File('$_fontsRoot/$path');
  if (!file.existsSync()) return;
  final loader = FontLoader(googleFamily);
  loader.addFont(
    file.readAsBytes().then((b) => ByteData.view(b.buffer)),
  );
  for (final extra in fallback) {
    final extraFile = File('$_fontsRoot/$extra');
    if (!extraFile.existsSync()) continue;
    loader.addFont(
      extraFile.readAsBytes().then((b) => ByteData.view(b.buffer)),
    );
  }
  await loader.load();
}

/// Loads a font by absolute path (for icon fonts living in pub-cache or the
/// Flutter SDK cache, outside the project tree).
Future<void> _loadAbsolute(String family, String absolutePath) async {
  final file = File(absolutePath);
  if (!file.existsSync()) return;
  final bytes = await file.readAsBytes();
  final loader = FontLoader(family)
    ..addFont(Future.value(ByteData.view(bytes.buffer)));
  await loader.load();
}

/// Auto-run by `flutter test` before any test.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  // The Prayer screen's Qibla dial subscribes to the magnetometer; the
  // sensors_plus plugin has no implementation in the test sandbox. Mock the
  // channels to no-op so the dial renders its no-reading state instead of
  // throwing a MissingPluginException.
  final messenger = binding.defaultBinaryMessenger;
  messenger.setMockMethodCallHandler(
    const MethodChannel('dev.fluttercommunity.plus/sensors/method'),
    (call) async => null,
  );
  for (final sensor in [
    'magnetometer',
    'accelerometer',
    'user_accel',
    'gyroscope',
  ]) {
    messenger.setMockMethodCallHandler(
      MethodChannel('dev.fluttercommunity.plus/sensors/$sensor'),
      (call) async => null,
    );
  }

  const home = String.fromEnvironment('HOME', defaultValue: '');
  final userHome = home.isNotEmpty ? home : Platform.environment['HOME'] ?? '';
  await _loadAbsolute(
    'packages/lucide_icons_flutter/Lucide',
    '$userHome/.pub-cache/hosted/pub.dev/lucide_icons_flutter-3.1.15/assets/lucide.ttf',
  );
  await _loadAbsolute(
    'MaterialIcons',
    '/opt/homebrew/share/flutter/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  );

  await _load('Inter_300', 'inter/Inter_300Light.ttf', fallback: [_takaFallback]);
  await _load('Inter_regular', 'inter/Inter_400Regular.ttf', fallback: [_takaFallback]);
  await _load('Inter_500', 'inter/Inter_500Medium.ttf', fallback: [_takaFallback]);
  await _load('Inter_600', 'inter/Inter_600SemiBold.ttf', fallback: [_takaFallback]);
  await _load('Inter_700', 'inter/Inter_700Bold.ttf', fallback: [_takaFallback]);
  await _load('Inter_800', 'inter/Inter_800ExtraBold.ttf', fallback: [_takaFallback]);
  await _load('Inter_900', 'inter/Inter_900Black.ttf', fallback: [_takaFallback]);

  await _load('HankenGrotesk_regular', 'hanken-grotesk/HankenGrotesk_400Regular.ttf', fallback: [_takaFallback]);
  await _load('HankenGrotesk_500', 'hanken-grotesk/HankenGrotesk_500Medium.ttf', fallback: [_takaFallback]);
  await _load('HankenGrotesk_600', 'hanken-grotesk/HankenGrotesk_600SemiBold.ttf', fallback: [_takaFallback]);
  await _load('HankenGrotesk_700', 'hanken-grotesk/HankenGrotesk_700Bold.ttf', fallback: [_takaFallback]);
  await _load('HankenGrotesk_800', 'hanken-grotesk/HankenGrotesk_800ExtraBold.ttf', fallback: [_takaFallback]);

  await _load('AnekBangla_regular', 'anek-bangla/AnekBangla_400Regular.ttf');
  await _load('AnekBangla_500', 'anek-bangla/AnekBangla_500Medium.ttf');
  await _load('AnekBangla_600', 'anek-bangla/AnekBangla_600SemiBold.ttf');
  await _load('AnekBangla_700', 'anek-bangla/AnekBangla_700Bold.ttf');

  await testMain();
}
