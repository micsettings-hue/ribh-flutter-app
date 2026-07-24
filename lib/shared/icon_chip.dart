import 'package:flutter/material.dart';

import '../app/theme/ribh_tokens.dart';

/// The one icon container for the whole app: a rounded-square, mint-tinted
/// chip holding a single stroke icon at a consistent size and tint. Used by
/// the services grid, ledger rows, prayer alarms, and anywhere an icon sits
/// in a tile, so icon weight and framing never drift between screens
/// (design system: stroke-only, one set, consistent containers).
class RibhIconChip extends StatelessWidget {
  const RibhIconChip({
    super.key,
    required this.icon,
    this.size = md,
    this.background,
    this.foreground,
  });

  /// Standard chip sizes. Ledger rows and alarms use [sm]; the services
  /// grid uses [md].
  static const double sm = 38;
  static const double md = 40;
  static const double lg = 44;

  final IconData icon;
  final double size;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background ?? tokens.mintSoft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: size * 0.46,
        color: foreground ?? tokens.teal,
      ),
    );
  }
}
