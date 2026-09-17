import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';
import 'motion_config.dart';

/// The ambient backdrop: slow-drifting colour fields painted behind content.
///
/// Built from the theme's own roles (`primary`, `accent`, `today`) rather than
/// fixed hex, so the light orange theme and the dark indigo theme each get a
/// backdrop that belongs to them instead of one washing the other out.
///
/// Painted with a `CustomPainter` over three sine-driven blobs rather than a
/// stack of animated `Container`s: one repaint per frame on one layer, no
/// rebuild of the widget tree, and no `BackdropFilter` — which on Flutter web
/// forces an expensive offscreen pass on every frame and turns a 60fps page
/// into a 20fps one.
class AuroraBackground extends StatefulWidget {
  const AuroraBackground({required this.child, super.key, this.intensity = 1});

  final Widget child;

  /// Scales opacity. Below 1 for pages carrying dense text over the top.
  final double intensity;

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Motion.ambient,
  );

  @override
  void initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final animate = Motion.enabled(context);

    // Still, but not absent: reduced motion keeps the composition and freezes
    // it at a pleasant point in the loop rather than dropping to flat grey.
    final animation = animate
        ? _controller
        : const AlwaysStoppedAnimation<double>(0.22);

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.background),
      child: Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, _) => CustomPaint(
                painter: _AuroraPainter(
                  t: animation.value,
                  intensity: widget.intensity,
                  isDark: context.isDark,
                  blobs: [colors.primary, colors.accent, colors.today],
                ),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class _AuroraPainter extends CustomPainter {
  const _AuroraPainter({
    required this.t,
    required this.intensity,
    required this.isDark,
    required this.blobs,
  });

  final double t;
  final double intensity;
  final bool isDark;
  final List<Color> blobs;

  @override
  void paint(Canvas canvas, Size size) {
    // Each blob travels its own Lissajous path at its own rate, so the three
    // never fall into a visible repeating pattern.
    const paths = [
      (ax: 0.22, ay: 0.30, fx: 1.0, fy: 0.7, phase: 0.0, radius: 0.62),
      (ax: 0.30, ay: 0.22, fx: 0.7, fy: 1.3, phase: 2.1, radius: 0.54),
      (ax: 0.26, ay: 0.26, fx: 1.4, fy: 0.9, phase: 4.2, radius: 0.48),
    ];

    const tau = math.pi * 2;

    for (final (index, path) in paths.indexed) {
      final angle = tau * t + path.phase;
      final center = Offset(
        size.width * (0.5 + path.ax * math.sin(angle * path.fx)),
        size.height * (0.42 + path.ay * math.cos(angle * path.fy)),
      );
      final radius = size.shortestSide * path.radius;
      final color = blobs[index % blobs.length];

      // Dark themes need more light to register; light themes need very little
      // before the text on top loses contrast.
      final alpha = (isDark ? 0.30 : 0.16) * intensity;

      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [
              color.withValues(alpha: alpha),
              color.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: center, radius: radius)),
      );
    }
  }

  @override
  bool shouldRepaint(_AuroraPainter old) =>
      old.t != t ||
      old.intensity != intensity ||
      old.isDark != isDark ||
      !identical(old.blobs, blobs);
}
