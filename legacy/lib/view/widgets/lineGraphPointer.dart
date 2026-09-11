import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineGraphPainter extends CustomPainter {
  final List<double> dataPoints;
  final double maxValue;
  final double lineWidth;
  final Color lineColor;

  LineGraphPainter({
    required this.dataPoints,
    required this.maxValue,
    this.lineWidth = 2.0,
    this.lineColor = Colors.blue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    final double graphHeight = size.height;
    final double graphWidth = size.width;

    final double xInterval = graphWidth / (dataPoints.length - 1);
    final double yInterval = graphHeight / maxValue;

    final Path path = Path();
    path.moveTo(0, graphHeight - (dataPoints[0] * yInterval));

    for (int i = 1; i < dataPoints.length; i++) {
      final double x = i * xInterval;
      final double y = graphHeight - (dataPoints[i] * yInterval);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
