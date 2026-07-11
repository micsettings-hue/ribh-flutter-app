/// Taka display formatting. Amounts are stored in integer poisha; this is
/// the one place they become text: the U+09F3 sign plus locale grouping,
/// Indian grouping for Bengali (1,28,400) and western elsewhere (128,400).
library;

const String takaSign = '৳';

/// Formats [poisha] as a signed taka amount for [localeCode] ('en' or 'bn').
/// Whole-taka amounts drop the decimals; anything else shows two.
String formatTaka(int poisha, {required String localeCode}) {
  final negative = poisha < 0;
  final abs = poisha.abs();
  final taka = abs ~/ 100;
  final fraction = abs % 100;

  final grouped = groupDigits('$taka', indian: localeCode == 'bn');
  final decimals = fraction == 0
      ? ''
      : '.${fraction.toString().padLeft(2, '0')}';
  return '${negative ? '-' : ''}$takaSign$grouped$decimals';
}

/// Parses user-typed taka ("1234", "1234.5", "1,234.56") into poisha.
/// Returns null when the text is not a positive amount with at most two
/// decimal places. Integer math throughout; no float rounding.
int? parseTakaToPoisha(String input) {
  final text = input.replaceAll(',', '').trim();
  final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(text);
  if (match == null) return null;
  final taka = int.parse(match.group(1)!);
  final fractionText = (match.group(2) ?? '').padRight(2, '0');
  final poisha =
      taka * 100 + int.parse(fractionText.isEmpty ? '0' : fractionText);
  return poisha > 0 ? poisha : null;
}

/// Groups a plain digit string: western 3-3-3 or Indian 3-then-2s.
String groupDigits(String digits, {required bool indian}) {
  if (digits.length <= 3) return digits;
  final head = digits.substring(0, digits.length - 3);
  final tail = digits.substring(digits.length - 3);
  final groups = <String>[];
  var rest = head;
  final size = indian ? 2 : 3;
  while (rest.length > size) {
    groups.insert(0, rest.substring(rest.length - size));
    rest = rest.substring(0, rest.length - size);
  }
  groups.insert(0, rest);
  return '${groups.join(',')},$tail';
}
