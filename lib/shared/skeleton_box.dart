import 'package:flutter/material.dart';

import '../app/theme/ribh_tokens.dart';

/// The loading placeholder from the design system: a mint-soft rounded box
/// with a slow breathing pulse. Static under reduce-motion. Marked as a
/// placeholder for screen readers so loading layouts stay quiet.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({
    super.key,
    this.height = 56,
    this.width,
    this.radius = 16,
  });

  final double height;
  final double? width;
  final double radius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  );

  @override
  void initState() {
    super.initState();
    // After the first frame so TickerMode and MediaQuery are settled; the
    // dependency phase runs during tab switches and must stay side-effect
    // free.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!MediaQuery.of(context).disableAnimations &&
          !_controller.isAnimating) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return ExcludeSemantics(
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.55, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: tokens.mintSoft,
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        ),
      ),
    );
  }
}
