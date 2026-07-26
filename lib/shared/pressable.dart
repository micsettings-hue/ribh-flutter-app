import 'package:flutter/material.dart';

/// Wraps a tappable card so it dips slightly while pressed, giving touch a
/// physical feel on top of the ink ripple. The child keeps its own onTap;
/// this only adds the scale. No-op under reduce-motion.
class RibhPressable extends StatefulWidget {
  const RibhPressable({super.key, required this.child, this.pressedScale = 0.97});

  final Widget child;
  final double pressedScale;

  @override
  State<RibhPressable> createState() => _RibhPressableState();
}

class _RibhPressableState extends State<RibhPressable> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) return widget.child;
    return Listener(
      onPointerDown: (_) => setState(() => _down = true),
      onPointerUp: (_) => setState(() => _down = false),
      onPointerCancel: (_) => setState(() => _down = false),
      child: AnimatedScale(
        scale: _down ? widget.pressedScale : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
