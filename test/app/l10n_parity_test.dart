import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Localization completeness (launch gate: full Bengali and English parity).
/// Fails the suite the moment a key exists in one locale and not the other,
/// or a placeholder set drifts between them.
void main() {
  Map<String, dynamic> load(String locale) =>
      jsonDecode(File('lib/app/l10n/app_$locale.arb').readAsStringSync())
          as Map<String, dynamic>;

  Set<String> keysOf(Map<String, dynamic> arb) =>
      arb.keys.where((k) => !k.startsWith('@')).toSet();

  Set<String> placeholdersOf(Map<String, dynamic> arb, String key) {
    final meta = arb['@$key'];
    if (meta is! Map<String, dynamic>) return const {};
    final placeholders = meta['placeholders'];
    if (placeholders is! Map<String, dynamic>) return const {};
    return placeholders.keys.toSet();
  }

  test('every English key exists in Bengali and vice versa', () {
    final en = keysOf(load('en'));
    final bn = keysOf(load('bn'));
    expect(en.difference(bn), isEmpty, reason: 'keys missing from app_bn.arb');
    expect(bn.difference(en), isEmpty, reason: 'keys missing from app_en.arb');
  });

  test('placeholder sets match between locales', () {
    final en = load('en');
    final bn = load('bn');
    for (final key in keysOf(en)) {
      expect(
        placeholdersOf(bn, key),
        placeholdersOf(en, key),
        reason: 'placeholder drift on "$key"',
      );
    }
  });

  test('no empty translations', () {
    for (final locale in ['en', 'bn']) {
      final arb = load(locale);
      for (final key in keysOf(arb)) {
        expect(
          (arb[key] as String).trim(),
          isNotEmpty,
          reason: 'empty value for "$key" in $locale',
        );
      }
    }
  });
}
