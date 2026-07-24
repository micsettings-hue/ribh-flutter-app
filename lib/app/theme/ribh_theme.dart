import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ribh_tokens.dart';

/// One design language, two themes. Hanken Grotesk for display and headings,
/// Inter for body and UI, Anek Bangla when the locale is Bengali.
abstract final class RibhTheme {
  static ThemeData light({Locale? locale}) =>
      _build(RibhTokens.light, Brightness.light, locale);

  static ThemeData dark({Locale? locale}) =>
      _build(RibhTokens.dark, Brightness.dark, locale);

  static ThemeData _build(RibhTokens t, Brightness brightness, Locale? locale) {
    final isBengali = locale?.languageCode == 'bn';

    final scheme = ColorScheme(
      brightness: brightness,
      primary: t.teal,
      onPrimary: brightness == Brightness.light ? Colors.white : t.paper,
      secondary: t.green,
      onSecondary: brightness == Brightness.light ? Colors.white : t.paper,
      tertiary: t.goldText,
      onTertiary: brightness == Brightness.light ? Colors.white : t.paper,
      error: t.danger,
      onError: brightness == Brightness.light ? Colors.white : t.paper,
      surface: t.card,
      onSurface: t.ink,
      surfaceContainerHighest: t.mintSoft,
      onSurfaceVariant: t.inkSoft,
      outline: t.line,
      outlineVariant: t.line,
      primaryContainer: t.mint,
      onPrimaryContainer: t.tealDeep,
    );

    final baseText = brightness == Brightness.light
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    final bodyText = isBengali
        ? GoogleFonts.anekBanglaTextTheme(baseText)
        : GoogleFonts.interTextTheme(baseText);

    TextStyle display(TextStyle? base, double size, FontWeight weight) {
      final builder = isBengali
          ? GoogleFonts.anekBangla
          : GoogleFonts.hankenGrotesk;
      return builder(
        textStyle: base,
        fontSize: size,
        fontWeight: weight,
        color: t.ink,
      );
    }

    final textTheme = bodyText
        .apply(bodyColor: t.ink, displayColor: t.ink)
        .copyWith(
          displayLarge: display(bodyText.displayLarge, 40, FontWeight.w800),
          displayMedium: display(bodyText.displayMedium, 34, FontWeight.w800),
          displaySmall: display(bodyText.displaySmall, 28, FontWeight.w700),
          headlineLarge: display(bodyText.headlineLarge, 26, FontWeight.w700),
          headlineMedium: display(bodyText.headlineMedium, 22, FontWeight.w700),
          headlineSmall: display(bodyText.headlineSmall, 19, FontWeight.w600),
          titleLarge: display(bodyText.titleLarge, 17, FontWeight.w600),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: t.paper,
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: t.paper,
        foregroundColor: t.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineMedium,
        toolbarHeight: 64,
      ),
      cardTheme: CardThemeData(
        color: t.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: t.line, width: 1.5),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: DividerThemeData(color: t.line, thickness: 1),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: t.card,
        indicatorColor: t.mint,
        surfaceTintColor: Colors.transparent,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? t.tealDeep
                : t.inkSoft,
            size: 24,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium!.copyWith(
            color: states.contains(WidgetState.selected) ? t.ink : t.inkSoft,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
          ),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      extensions: [t],
    );
  }
}
