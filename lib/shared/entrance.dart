import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Staggered fade-and-rise entrance for a list of children (Invest list,
/// News cards, Portfolio row) on first load. Returns the children unchanged
/// under reduce-motion so nothing moves when the OS asks for stillness.
List<Widget> ribhStagger(
  BuildContext context,
  List<Widget> children, {
  Duration interval = const Duration(milliseconds: 55),
  Duration duration = const Duration(milliseconds: 320),
}) {
  if (MediaQuery.of(context).disableAnimations) return children;
  return [
    for (var i = 0; i < children.length; i++)
      children[i]
          .animate()
          .fadeIn(duration: duration, delay: interval * i)
          .slideY(
            begin: 0.08,
            end: 0,
            duration: duration,
            delay: interval * i,
            curve: Curves.easeOutCubic,
          ),
  ];
}

/// A single element's entrance (fade + rise), for one-off cards. No-op under
/// reduce-motion.
Widget ribhEnter(
  BuildContext context,
  Widget child, {
  Duration delay = Duration.zero,
  Duration duration = const Duration(milliseconds: 320),
}) {
  if (MediaQuery.of(context).disableAnimations) return child;
  return child
      .animate()
      .fadeIn(duration: duration, delay: delay)
      .slideY(begin: 0.08, end: 0, duration: duration, delay: delay, curve: Curves.easeOutCubic);
}
