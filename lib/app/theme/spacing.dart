/// The one spacing scale for the whole app. Every gap, pad, and section
/// break uses a step from here so vertical rhythm stays consistent across
/// screens (design system). Values are logical pixels.
abstract final class RibhSpace {
  /// Tight inline gap (icon to label, chip internals).
  static const double xs = 4;

  /// Between closely related lines.
  static const double sm = 8;

  /// Default gap between stacked elements in a card.
  static const double md = 12;

  /// Card padding and the common between-rows gap.
  static const double lg = 16;

  /// Page horizontal padding and between minor blocks.
  static const double xl = 20;

  /// Between a block and the next one.
  static const double xxl = 24;

  /// Between major sections (e.g. a card and the next section header).
  static const double section = 28;
}
