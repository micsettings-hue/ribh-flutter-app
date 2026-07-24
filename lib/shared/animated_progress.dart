import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../app/theme/ribh_tokens.dart';

/// A pill progress bar that draws in from zero on first appearance. Used for
/// campaign funding, Grow diversification, and goal progress. Under
/// reduce-motion it paints its final value immediately.
class RibhProgressBar extends StatelessWidget {
  const RibhProgressBar({
    super.key,
    required this.value,
    this.minHeight = 6,
    this.color,
    this.background,
    this.duration = const Duration(milliseconds: 900),
  });

  /// 0..1. Values outside are clamped.
  final double value;
  final double minHeight;
  final Color? color;
  final Color? background;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final target = value.clamp(0.0, 1.0);
    final reduce = MediaQuery.of(context).disableAnimations;

    Widget bar(double v) => ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: LinearProgressIndicator(
        value: v,
        minHeight: minHeight,
        backgroundColor: background ?? tokens.mintSoft,
        color: color ?? tokens.teal,
      ),
    );

    if (reduce) return bar(target);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: target),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => bar(v),
    );
  }
}

/// A circular score ring that draws in and counts up from zero on first
/// appearance (Barakah score). Under reduce-motion it renders the final
/// value with no animation.
class RibhScoreRing extends StatelessWidget {
  const RibhScoreRing({
    super.key,
    required this.score,
    this.max = 100,
    this.size = 120,
    this.stroke = 10,
    this.duration = const Duration(milliseconds: 1200),
    this.caption,
    this.trackColor,
    this.progressColor,
    this.textColor,
    this.captionColor,
  });

  final int score;
  final int max;
  final double size;
  final double stroke;
  final Duration duration;

  /// Optional line under the number (e.g. "app habits only").
  final String? caption;

  /// Overrides for placing the ring on a coloured surface (e.g. the teal
  /// gradient); default to the mint/teal tokens on a light card.
  final Color? trackColor;
  final Color? progressColor;
  final Color? textColor;
  final Color? captionColor;

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.of(context).disableAnimations;
    final target = max == 0 ? 0.0 : score / max;

    _RingContent content(double fraction, int value) => _RingContent(
      fraction: fraction,
      value: value,
      size: size,
      stroke: stroke,
      caption: caption,
      trackColor: trackColor,
      progressColor: progressColor,
      textColor: textColor,
      captionColor: captionColor,
    );

    if (reduce) return content(target, score);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: target.clamp(0.0, 1.0)),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, t, _) => content(t, (t * max).round()),
    );
  }
}

class _RingContent extends StatelessWidget {
  const _RingContent({
    required this.fraction,
    required this.value,
    required this.size,
    required this.stroke,
    this.caption,
    this.trackColor,
    this.progressColor,
    this.textColor,
    this.captionColor,
  });

  final double fraction;
  final int value;
  final double size;
  final double stroke;
  final String? caption;
  final Color? trackColor;
  final Color? progressColor;
  final Color? textColor;
  final Color? captionColor;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = Theme.of(context);
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(
          fraction: fraction,
          track: trackColor ?? tokens.mintSoft,
          progress: progressColor ?? tokens.teal,
          stroke: stroke,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$value',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: textColor ?? tokens.tealDeep,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (caption != null)
                Text(
                  caption!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: captionColor ?? tokens.inkSoft,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.fraction,
    required this.track,
    required this.progress,
    required this.stroke,
  });

  final double fraction;
  final Color track;
  final Color progress;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - stroke) / 2;
    final trackPaint = Paint()
      ..color = track
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    final progressPaint = Paint()
      ..color = progress
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * fraction.clamp(0.0, 1.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.fraction != fraction ||
      old.progress != progress ||
      old.track != track ||
      old.stroke != stroke;
}
