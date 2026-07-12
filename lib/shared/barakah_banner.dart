import 'dart:async';

import 'package:flutter/material.dart';

import '../app/theme/ribh_tokens.dart';

class BarakahSlide {
  const BarakahSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}

/// The Barakah banner: a real PageView auto-advancing every 4.2s, pausing
/// while touched, and not advancing at all when the platform asks for
/// reduced motion (MediaQuery.disableAnimations).
class BarakahBanner extends StatefulWidget {
  const BarakahBanner({super.key, required this.slides, this.onTap});

  final List<BarakahSlide> slides;
  final VoidCallback? onTap;

  static const advanceEvery = Duration(milliseconds: 4200);

  @override
  State<BarakahBanner> createState() => _BarakahBannerState();
}

class _BarakahBannerState extends State<BarakahBanner> {
  final _controller = PageController();
  Timer? _timer;
  int _index = 0;
  bool _touching = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    _timer?.cancel();
    if (!reduceMotion && widget.slides.length > 1) {
      _timer = Timer.periodic(BarakahBanner.advanceEvery, (_) => _advance());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _advance() {
    if (_touching || !_controller.hasClients) return;
    final next = (_index + 1) % widget.slides.length;
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = Theme.of(context);

    return Listener(
      onPointerDown: (_) => _touching = true,
      onPointerUp: (_) => _touching = false,
      onPointerCancel: (_) => _touching = false,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: tokens.mintSoft,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: tokens.line, width: 1.5),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 76,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.slides.length,
                  onPageChanged: (index) => setState(() => _index = index),
                  itemBuilder: (context, index) {
                    final slide = widget.slides[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  tokens.amanahGradientStart,
                                  tokens.amanahGradientEnd,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              slide.icon,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  slide.title,
                                  style: theme.textTheme.titleSmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  slide.subtitle,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: tokens.inkSoft,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < widget.slides.length; i++)
                      Container(
                        width: i == _index ? 16 : 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: i == _index ? tokens.teal : tokens.line,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
