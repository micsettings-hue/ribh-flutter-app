import 'package:flutter/services.dart';

/// Haptics for the moments that matter, and only those. Haptics are not
/// motion, so they are not gated on reduce-motion.
abstract final class RibhHaptics {
  /// Counter taps (tasbih).
  static void tap() => HapticFeedback.lightImpact();

  /// Selections: filters, toggles, bookmarks.
  static void select() => HapticFeedback.selectionClick();

  /// A money movement was committed (invest, give, request recorded).
  static void commit() => HapticFeedback.mediumImpact();

  /// A goal or target was reached (tasbih target, milestone). Stronger than
  /// a tap so completion feels distinct.
  static void success() => HapticFeedback.heavyImpact();
}
