import 'package:flutter/material.dart';

import '../app/theme/ribh_tokens.dart';

/// The loading placeholder from the design system: a mint-soft rounded box
/// with a soft shimmer sweep. Static under reduce-motion. Marked as a
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
    duration: const Duration(milliseconds: 1400),
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
        _controller.repeat();
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
    final base = tokens.mintSoft;
    final highlight = Color.alphaBlend(
      Colors.white.withValues(alpha: 0.45),
      tokens.mint,
    );
    final shape = BorderRadius.circular(widget.radius);

    if (MediaQuery.of(context).disableAnimations) {
      return ExcludeSemantics(
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(color: base, borderRadius: shape),
        ),
      );
    }

    return ExcludeSemantics(
      child: ClipRRect(
        borderRadius: shape,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            // Sweep a highlight band left to right across the box.
            final t = _controller.value;
            return Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-2 + 3 * t, 0),
                  end: Alignment(-1 + 3 * t, 0),
                  colors: [base, highlight, base],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
