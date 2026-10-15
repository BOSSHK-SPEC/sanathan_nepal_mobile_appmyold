import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/time_window.dart';
import 'day_period_row.dart';

/// The whole day drawn as one ring: sunrise at the top, running clockwise
/// through the daylight and on round through the night, with every period as
/// an arc in its own colour and a needle at the present moment.
///
/// A list of sixteen rows answers "what is Amrit's time"; this answers "how
/// much of the good part of the day is left", which is what people actually
/// open the screen to see.
class DayArc extends StatelessWidget {
  const DayArc({
    required this.day,
    required this.night,
    required this.now,
    required this.sunrise,
    required this.sunset,
    required this.nextSunrise,
    super.key,
  });

  final List<TimeWindow> day;
  final List<TimeWindow> night;
  final DateTime now;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime? nextSunrise;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: _DayArcPainter(
          windows: [...day, ...night],
          now: now,
          sunrise: sunrise,
          sunset: sunset,
          end: nextSunrise ?? sunset,
          colors: colors,
          nightFrom: day.isEmpty ? null : sunset,
        ),
      ),
    );
  }
}

class _DayArcPainter extends CustomPainter {
  _DayArcPainter({
    required this.windows,
    required this.now,
    required this.sunrise,
    required this.sunset,
    required this.end,
    required this.colors,
    required this.nightFrom,
  });

  final List<TimeWindow> windows;
  final DateTime now;
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime end;
  final AppColors colors;
  final DateTime? nightFrom;

  /// Sunrise sits at the top of the ring, and the day runs clockwise.
  static const double _start = -math.pi / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final span = end.difference(sunrise).inSeconds;
    if (span <= 0 || windows.isEmpty) return;
    final centre = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 18;
    final rect = Rect.fromCircle(center: centre, radius: radius);
    double angleOf(DateTime t) =>
        _start + (t.difference(sunrise).inSeconds / span) * 2 * math.pi;

    // The periods themselves.
    for (final w in windows) {
      final from = angleOf(w.start);
      final sweep = angleOf(w.end) - from;
      canvas.drawArc(
        rect,
        from,
        sweep,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 18
          ..color = DayPeriodRow.qualityColor(
            colors,
            w.quality,
          ).withValues(alpha: w.contains(now) ? 1 : 0.55),
      );
    }

    // Hairlines between periods, so eight equal arcs read as eight.
    for (final w in windows) {
      final a = angleOf(w.start);
      canvas.drawLine(
        centre + Offset(math.cos(a), math.sin(a)) * (radius - 9),
        centre + Offset(math.cos(a), math.sin(a)) * (radius + 9),
        Paint()
          ..color = colors.surface
          ..strokeWidth = 1.5,
      );
    }

    // Where the sun goes down: the one boundary that is not a period edge.
    if (nightFrom != null) {
      final a = angleOf(nightFrom!);
      canvas.drawLine(
        centre + Offset(math.cos(a), math.sin(a)) * (radius - 13),
        centre + Offset(math.cos(a), math.sin(a)) * (radius + 13),
        Paint()
          ..color = colors.textPrimary
          ..strokeWidth = 2,
      );
    }

    // The needle at this moment.
    if (!now.isBefore(sunrise) && now.isBefore(end)) {
      final a = angleOf(now);
      final tip = centre + Offset(math.cos(a), math.sin(a)) * (radius + 12);
      canvas
        ..drawLine(
          centre + Offset(math.cos(a), math.sin(a)) * (radius - 14),
          tip,
          Paint()
            ..color = colors.textPrimary
            ..strokeWidth = 2.5
            ..strokeCap = StrokeCap.round,
        )
        ..drawCircle(tip, 4, Paint()..color = colors.textPrimary)
        ..drawCircle(
          tip,
          4,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = colors.surface,
        );
    }
  }

  @override
  bool shouldRepaint(_DayArcPainter old) =>
      old.now != now || old.windows != windows || old.colors != colors;
}
