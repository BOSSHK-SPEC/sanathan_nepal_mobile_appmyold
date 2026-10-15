import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// The Sanatan Nepal mark: a Sri Yantra core (two interlocking triangles)
/// inside an eight-petal lotus, with a diya flame at the bindu.
///
/// The same drawing is the public site's splash (`landing/src/styles/splash.css`)
/// and the Android launch icon (`android/.../drawable/splash_mark.xml`), so the
/// launcher icon, the OS splash and this widget are one continuous image.
///
/// It is painted, not an asset: it has to scale from a 24 dp badge to a full
/// screen without a bitmap, and the intro traces its strokes rather than fading
/// a picture in.
class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    required this.color,
    this.progress = 1,
    this.pulse = 0,
    this.size = 180,
  });

  /// Ink for every stroke. Alpha is applied per element by the painter.
  final Color color;

  /// Draw-in, 0 (nothing) … 1 (complete). The elements are staggered inside it.
  final double progress;

  /// Idle phase, 0 … 1, wrapping. Drives the flame's breath and the orbit dot;
  /// pass a constant to hold the mark still (reduced motion).
  final double pulse;

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _BrandMarkPainter(
          color: color,
          progress: progress.clamp(0.0, 1.0),
          pulse: pulse,
        ),
        isComplex: true,
      ),
    );
  }
}

/// Eased sub-interval of [t]: 0 before [start], 1 after [end].
double _stage(double t, double start, double end, [Curve curve = Curves.easeOutCubic]) {
  if (end <= start) return t >= end ? 1 : 0;
  return curve.transform(((t - start) / (end - start)).clamp(0.0, 1.0));
}

/// The leading [t] of [path]. Used to trace the triangles stroke by stroke
/// instead of fading them in whole.
Path _trace(Path path, double t) {
  if (t >= 1) return path;
  final out = Path();
  if (t <= 0) return out;
  for (final metric in path.computeMetrics()) {
    out.addPath(metric.extractPath(0, metric.length * t), Offset.zero);
  }
  return out;
}

class _BrandMarkPainter extends CustomPainter {
  _BrandMarkPainter({
    required this.color,
    required this.progress,
    required this.pulse,
  });

  final Color color;
  final double progress;
  final double pulse;

  /// The drawing is authored on a 200 × 200 grid centred on (100, 100) — the
  /// same grid as the SVG on the web, so the two cannot drift.
  static const double _grid = 200;
  static const Offset _centre = Offset(100, 100);
  static const int _petals = 8;

  static final Path _petal = Path()
    ..moveTo(100, 25)
    ..cubicTo(111, 36, 112, 49, 100, 57)
    ..cubicTo(88, 49, 89, 36, 100, 25)
    ..close();

  static final Path _triangleUp = Path()
    ..moveTo(100, 64)
    ..lineTo(131.2, 118)
    ..lineTo(68.8, 118)
    ..close();

  static final Path _triangleDown = Path()
    ..moveTo(100, 136)
    ..lineTo(68.8, 82)
    ..lineTo(131.2, 82)
    ..close();

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.shortestSide / _grid;
    canvas.save();
    canvas.translate(
      (size.width - _grid * scale) / 2,
      (size.height - _grid * scale) / 2,
    );
    canvas.scale(scale);

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    // Two rings, sweeping in opposite directions so the mark reads as built
    // rather than revealed.
    final ring = _stage(progress, 0, 0.45);
    if (ring > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: _centre, radius: 88),
        -math.pi / 2,
        2 * math.pi * ring,
        false,
        stroke
          ..strokeWidth = 1.3
          ..color = color,
      );
    }
    final softRing = _stage(progress, 0.1, 0.55);
    if (softRing > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: _centre, radius: 80),
        -math.pi / 2,
        -2 * math.pi * softRing,
        false,
        stroke
          ..strokeWidth = 0.8
          ..color = color.withValues(alpha: 0.7),
      );
    }

    // Lotus: each petal blooms out of the centre, one after the next.
    for (var i = 0; i < _petals; i++) {
      final bloom = _stage(progress, 0.18 + i * 0.035, 0.48 + i * 0.035, Curves.easeOutBack);
      if (bloom <= 0) continue;
      canvas.save();
      canvas.translate(_centre.dx, _centre.dy);
      canvas.rotate(i * 2 * math.pi / _petals);
      canvas.scale(bloom.clamp(0.0, 1.1));
      canvas.translate(-_centre.dx, -_centre.dy);
      canvas
        ..drawPath(
          _petal,
          Paint()
            ..style = PaintingStyle.fill
            ..color = color.withValues(alpha: 0.16 * bloom.clamp(0.0, 1.0)),
        )
        ..drawPath(
          _petal,
          stroke
            ..strokeWidth = 0.9
            ..color = color.withValues(alpha: 0.9 * bloom.clamp(0.0, 1.0)),
        );
      canvas.restore();
    }

    // The yantra's two triangles, traced edge by edge.
    stroke
      ..strokeWidth = 1.3
      ..color = color;
    canvas
      ..drawPath(_trace(_triangleUp, _stage(progress, 0.38, 0.74)), stroke)
      ..drawPath(_trace(_triangleDown, _stage(progress, 0.46, 0.82)), stroke);

    // The diya at the bindu: lit last, then breathing.
    final lit = _stage(progress, 0.66, 1);
    if (lit > 0) {
      final breath = 1 + 0.06 * math.sin(pulse * 2 * math.pi);
      final radius = 22 * lit * breath;
      canvas
        ..drawCircle(
          _centre,
          radius,
          Paint()
            ..shader = ui.Gradient.radial(_centre, radius, [
              color.withValues(alpha: 0.55 * lit),
              color.withValues(alpha: 0.22 * lit),
              color.withValues(alpha: 0),
            ], const [0, 0.45, 1]),
        )
        ..drawCircle(
          _centre,
          2.6 * lit,
          Paint()..color = color.withValues(alpha: lit),
        );

      // A single graha on the outer ring — the orrery, in one dot.
      final angle = -math.pi / 2 + pulse * 2 * math.pi;
      canvas.drawCircle(
        _centre + Offset(math.cos(angle), math.sin(angle)) * 88,
        2.4 * lit,
        Paint()..color = color.withValues(alpha: lit),
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_BrandMarkPainter old) =>
      old.progress != progress || old.pulse != pulse || old.color != color;
}
