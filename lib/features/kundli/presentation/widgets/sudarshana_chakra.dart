import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/entities/vedic_basics.dart';
import '../l10n/kundli_strings.dart';

/// The three reference points a Sudarshana chakra is read from, outermost
/// ring first.
enum SudarshanaRing {
  /// Houses counted from the ascendant — the body and the life as lived.
  lagna,

  /// Counted from the Moon's sign — the mind.
  chandra,

  /// Counted from the Sun's sign — the self and the father.
  surya;

  /// The sign this ring calls its first house. Everything else on the ring
  /// follows from it, so this is the one piece worth testing.
  Rashi firstSignOf(KundliChart chart) => switch (this) {
    SudarshanaRing.lagna => chart.ascendant,
    SudarshanaRing.chandra => chart.moonSign,
    SudarshanaRing.surya => chart.sunSign,
  };
}

/// The Sudarshana chakra: one birth chart drawn three times over, as houses
/// counted from the ascendant, from the Moon and from the Sun.
///
/// The grahas do not move between the rings — the same sign holds the same
/// grahas in all three. What changes is which sign is being called the first
/// house, and therefore what every graha is taken to govern. Reading the three
/// together is the point of the diagram, which is why they are concentric
/// rather than three charts side by side.
class SudarshanaChakra extends StatelessWidget {
  const SudarshanaChakra({required this.chart, super.key});

  final KundliChart chart;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final labels = {for (final g in Graha.values) g: _short(g)};
    // A painted chart is invisible to a screen reader unless it is described.
    final s = KundliStrings.of(context);
    return Semantics(
      label:
          '${s.sudarshana}: '
          '${s.rashiName(chart.ascendant)}, '
          '${s.rashiName(chart.moonSign)}, '
          '${s.rashiName(chart.sunSign)}',
      image: true,
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          painter: _ChakraPainter(
            chart: chart,
            colors: colors,
            labels: labels,
            textDirection: Directionality.of(context),
          ),
        ),
      ),
    );
  }

  /// Two-letter forms, which is what fits in a sector and what charts use.
  static String _short(Graha g) => switch (g) {
    Graha.sun => 'Su',
    Graha.moon => 'Mo',
    Graha.mars => 'Ma',
    Graha.mercury => 'Me',
    Graha.jupiter => 'Ju',
    Graha.venus => 'Ve',
    Graha.saturn => 'Sa',
    Graha.rahu => 'Ra',
    Graha.ketu => 'Ke',
  };
}

class _ChakraPainter extends CustomPainter {
  _ChakraPainter({
    required this.chart,
    required this.colors,
    required this.labels,
    required this.textDirection,
  });

  final KundliChart chart;
  final AppColors colors;
  final Map<Graha, String> labels;
  final TextDirection textDirection;

  /// House 1 of each ring sits at the top and houses run clockwise, as they do
  /// on a South Indian chart read round.
  static const double _top = -math.pi / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final centre = size.center(Offset.zero);
    final outer = size.shortestSide / 2 - 2;
    // Three bands of equal width, with a hub left clear for the labels.
    final hub = outer * 0.24;
    final band = (outer - hub) / 3;

    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = colors.border;

    for (final ring in SudarshanaRing.values) {
      final i = ring.index;
      final rOuter = outer - band * i;
      final rInner = rOuter - band;
      final first = ring.firstSignOf(chart);

      // Alternating sector tint, so twelve sectors can be counted by eye.
      for (var house = 1; house <= 12; house++) {
        final from = _top + (house - 1) * math.pi / 6;
        if (house.isOdd) {
          canvas.drawPath(
            _sector(centre, rInner, rOuter, from, math.pi / 6),
            Paint()..color = colors.surfaceVariant.withValues(alpha: 0.6),
          );
        }
        // The first house of each ring is the one the reading starts from.
        if (house == 1) {
          canvas.drawPath(
            _sector(centre, rInner, rOuter, from, math.pi / 6),
            Paint()..color = colors.accent.withValues(alpha: 0.14),
          );
        }
      }

      canvas
        ..drawCircle(centre, rOuter, line)
        ..drawCircle(centre, rInner, line);
      for (var house = 0; house < 12; house++) {
        final a = _top + house * math.pi / 6;
        canvas.drawLine(
          centre + Offset(math.cos(a), math.sin(a)) * rInner,
          centre + Offset(math.cos(a), math.sin(a)) * rOuter,
          line,
        );
      }

      // Contents: the sign number, then whatever sits in that sign.
      for (var house = 1; house <= 12; house++) {
        final sign = Rashi.values[(first.index + house - 1) % 12];
        final mid = _top + (house - 0.5) * math.pi / 6;
        final at =
            centre +
            Offset(math.cos(mid), math.sin(mid)) * ((rInner + rOuter) / 2);
        final grahas = chart
            .inSign(sign)
            .map((p) => labels[p.graha]!)
            .toList(growable: false);
        _text(
          canvas,
          at,
          '${sign.index + 1}',
          size: band * 0.17,
          color: colors.textMuted,
          offset: Offset(0, -band * 0.26),
        );
        if (grahas.isNotEmpty) {
          _text(
            canvas,
            at,
            grahas.join(' '),
            size: band * 0.2,
            color: colors.textPrimary,
            bold: true,
            offset: Offset(0, band * 0.06),
            maxWidth: band * 1.6,
          );
        }
      }
    }

    canvas.drawCircle(centre, hub, Paint()..color = colors.surface);
    canvas.drawCircle(centre, hub, line);
    _text(
      canvas,
      centre,
      'L\nC\nS',
      size: hub * 0.32,
      color: colors.textMuted,
      bold: true,
    );
  }

  Path _sector(
    Offset centre,
    double rInner,
    double rOuter,
    double from,
    double sweep,
  ) => Path()
    ..addArc(Rect.fromCircle(center: centre, radius: rOuter), from, sweep)
    ..arcTo(
      Rect.fromCircle(center: centre, radius: rInner),
      from + sweep,
      -sweep,
      false,
    )
    ..close();

  void _text(
    Canvas canvas,
    Offset at,
    String text, {
    required double size,
    required Color color,
    bool bold = false,
    Offset offset = Offset.zero,
    double? maxWidth,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: 'Mukta',
          fontSize: size,
          height: 1.1,
          color: color,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: textDirection,
    )..layout(maxWidth: maxWidth ?? size * 10);
    painter.paint(
      canvas,
      at + offset - Offset(painter.width / 2, painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(_ChakraPainter old) =>
      old.chart != chart || old.colors != colors;
}
