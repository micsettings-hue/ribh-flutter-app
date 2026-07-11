import 'package:flutter/material.dart';

/// Mint Modern design tokens as a [ThemeExtension], one set per brightness.
/// Every text-on-background pair passes WCAG AA in both themes; use
/// [goldText] for any gold rendered as text.
@immutable
class RibhTokens extends ThemeExtension<RibhTokens> {
  const RibhTokens({
    required this.teal,
    required this.tealDeep,
    required this.green,
    required this.mint,
    required this.mintSoft,
    required this.gold,
    required this.goldText,
    required this.ink,
    required this.inkSoft,
    required this.line,
    required this.paper,
    required this.card,
    required this.danger,
    required this.amber,
    required this.amberSoft,
    required this.amanahGradientStart,
    required this.amanahGradientEnd,
  });

  final Color teal;
  final Color tealDeep;
  final Color green;
  final Color mint;
  final Color mintSoft;
  final Color gold;
  final Color goldText;
  final Color ink;
  final Color inkSoft;
  final Color line;
  final Color paper;
  final Color card;
  final Color danger;
  final Color amber;
  final Color amberSoft;
  final Color amanahGradientStart;
  final Color amanahGradientEnd;

  static const light = RibhTokens(
    teal: Color(0xFF0FA67A),
    tealDeep: Color(0xFF06342A),
    green: Color(0xFF14C48A),
    mint: Color(0xFFC8F5E2),
    mintSoft: Color(0xFFEAFBF3),
    gold: Color(0xFFC99A2E),
    goldText: Color(0xFF8A6210),
    ink: Color(0xFF0B1A15),
    inkSoft: Color(0xFF4C6960),
    line: Color(0xFFD6ECE2),
    paper: Color(0xFFF7FBF9),
    card: Color(0xFFFFFFFF),
    danger: Color(0xFFC2412E),
    amber: Color(0xFF8C5E0E),
    amberSoft: Color(0xFFFBF1DC),
    amanahGradientStart: Color(0xFF0F6E56),
    amanahGradientEnd: Color(0xFF0A4C3B),
  );

  static const dark = RibhTokens(
    teal: Color(0xFF18C48A),
    tealDeep: Color(0xFF0FA67A),
    green: Color(0xFF3FE0A8),
    mint: Color(0xFF123A2C),
    mintSoft: Color(0xFF0C2A20),
    gold: Color(0xFFE0B84B),
    goldText: Color(0xFFE0B84B),
    ink: Color(0xFFE8F7EF),
    inkSoft: Color(0xFF8FB6A6),
    line: Color(0xFF1C4133),
    paper: Color(0xFF061710),
    card: Color(0xFF0E241B),
    danger: Color(0xFFE88C7A),
    amber: Color(0xFFE0B84B),
    amberSoft: Color(0xFF332912),
    amanahGradientStart: Color(0xFF0F6E56),
    amanahGradientEnd: Color(0xFF0A4C3B),
  );

  @override
  RibhTokens copyWith({
    Color? teal,
    Color? tealDeep,
    Color? green,
    Color? mint,
    Color? mintSoft,
    Color? gold,
    Color? goldText,
    Color? ink,
    Color? inkSoft,
    Color? line,
    Color? paper,
    Color? card,
    Color? danger,
    Color? amber,
    Color? amberSoft,
    Color? amanahGradientStart,
    Color? amanahGradientEnd,
  }) {
    return RibhTokens(
      teal: teal ?? this.teal,
      tealDeep: tealDeep ?? this.tealDeep,
      green: green ?? this.green,
      mint: mint ?? this.mint,
      mintSoft: mintSoft ?? this.mintSoft,
      gold: gold ?? this.gold,
      goldText: goldText ?? this.goldText,
      ink: ink ?? this.ink,
      inkSoft: inkSoft ?? this.inkSoft,
      line: line ?? this.line,
      paper: paper ?? this.paper,
      card: card ?? this.card,
      danger: danger ?? this.danger,
      amber: amber ?? this.amber,
      amberSoft: amberSoft ?? this.amberSoft,
      amanahGradientStart: amanahGradientStart ?? this.amanahGradientStart,
      amanahGradientEnd: amanahGradientEnd ?? this.amanahGradientEnd,
    );
  }

  @override
  RibhTokens lerp(ThemeExtension<RibhTokens>? other, double t) {
    if (other is! RibhTokens) return this;
    return RibhTokens(
      teal: Color.lerp(teal, other.teal, t)!,
      tealDeep: Color.lerp(tealDeep, other.tealDeep, t)!,
      green: Color.lerp(green, other.green, t)!,
      mint: Color.lerp(mint, other.mint, t)!,
      mintSoft: Color.lerp(mintSoft, other.mintSoft, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      goldText: Color.lerp(goldText, other.goldText, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkSoft: Color.lerp(inkSoft, other.inkSoft, t)!,
      line: Color.lerp(line, other.line, t)!,
      paper: Color.lerp(paper, other.paper, t)!,
      card: Color.lerp(card, other.card, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      amberSoft: Color.lerp(amberSoft, other.amberSoft, t)!,
      amanahGradientStart: Color.lerp(
        amanahGradientStart,
        other.amanahGradientStart,
        t,
      )!,
      amanahGradientEnd: Color.lerp(
        amanahGradientEnd,
        other.amanahGradientEnd,
        t,
      )!,
    );
  }
}

extension RibhTokensX on BuildContext {
  RibhTokens get tokens => Theme.of(this).extension<RibhTokens>()!;
}
