import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Motion vocabulary (design system): page push 380ms standard ease with a
/// shared-element Hero; state changes 200 to 300ms; everything non-essential
/// gated on MediaQuery.disableAnimations.

const pagePushDuration = Duration(milliseconds: 380);
const stateSwapDuration = Duration(milliseconds: 250);

/// Pushed-route page: fade plus a slight upward slide under the Hero flight.
/// Under reduce-motion the push is instant and the Hero does not animate.
CustomTransitionPage<T> ribhPage<T>({required Widget child, LocalKey? key}) =>
    CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: pagePushDuration,
      reverseTransitionDuration: const Duration(milliseconds: 320),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (MediaQuery.of(context).disableAnimations) return child;
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.03),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );

/// State-change swap (sheet form to success, counter ticks): a 250ms fade
/// with a whisper of scale. Renders the child directly under reduce-motion.
class RibhSwap extends StatelessWidget {
  const RibhSwap({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return child;
    return AnimatedSwitcher(
      duration: stateSwapDuration,
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1).animate(animation),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
