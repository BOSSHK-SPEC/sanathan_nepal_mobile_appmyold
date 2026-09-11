import 'package:flutter/material.dart';

/// Draws a smooth curve through evenly spaced temperature samples with a
/// small dot on each sample (Figma home weather card "Group 35735").
class TemperatureCurve extends StatelessWidget {
  const TemperatureCurve({
    required this.values,
    required this.color,
    super.key,
    this.height = 14,
    this.strokeWidth = 1.5,
  });

  final List<double> values;
  final Color color;
  final double height;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: double.infinity,
    child: CustomPaint(painter: _CurvePainter(values, color, strokeWidth)),
  );
}

class _CurvePainter extends CustomPainter {
  const _CurvePainter(this.values, this.color, this.strokeWidth);
  final List<double> values;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final span = (max - min) == 0 ? 1.0 : (max - min);
    final slot = size.width / values.length;
    final pad = strokeWidth * 2;
    final points = <Offset>[
      for (var i = 0; i < values.length; i++)
        Offset(
          slot * i + slot / 2,
          pad + (size.height - pad * 2) * (1 - (values[i] - min) / span),
        ),
    ];
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final cx = (p0.dx + p1.dx) / 2;
      path.cubicTo(cx, p0.dy, cx, p1.dy, p1.dx, p1.dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
    final dot = Paint()..color = color;
    for (final p in points) {
      canvas.drawCircle(p, strokeWidth * 1.4, dot);
    }
  }

  @override
  bool shouldRepaint(_CurvePainter old) =>
      old.values != values || old.color != color;
}
