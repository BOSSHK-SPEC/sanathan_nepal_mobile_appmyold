import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/entities/vedic_basics.dart';
import '../cubit/chart_cubit.dart';
import '../l10n/kundli_strings.dart';

/// Renders a birth chart in either regional style.
///
/// The two styles are genuinely different diagrams, not a skin: the North
/// Indian chart is a diamond whose twelve compartments are *houses* with the
/// ascendant always at the top, while the South Indian chart is a fixed
/// 4×4 grid of *signs* with Mesha always in the same cell. Readers are
/// fluent in one or the other, so both are laid out properly rather than
/// approximated.
class KundliDiagram extends StatelessWidget {
  const KundliDiagram({
    required this.chart,
    required this.style,
    super.key,
    this.onHouseTap,
  });

  final KundliChart chart;
  final ChartStyle style;
  final ValueChanged<int>? onHouseTap;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: style == ChartStyle.north
        ? _NorthChart(chart: chart, onHouseTap: onHouseTap)
        : _SouthChart(chart: chart, onHouseTap: onHouseTap),
  );
}

/// Shared cell content: sign number, then the grahas sitting there.
class _CellContent extends StatelessWidget {
  const _CellContent({
    required this.signNumber,
    required this.planets,
    this.dense = false,
    this.highlight = false,
  });

  final int signNumber;
  final List<PlanetPosition> planets;
  final bool dense;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = KundliStrings.of(context);
    final digits = context.usesDevanagariDigits;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          digits ? '$signNumber'.toDevanagariDigits() : '$signNumber',
          style: context.textTheme.labelSmall?.copyWith(
            color: highlight ? colors.accent : colors.textMuted,
            fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
            fontSize: dense ? 8 : 10,
          ),
        ),
        if (planets.isNotEmpty)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 3,
            children: [
              for (final p in planets)
                Text(
                  p.retrograde
                      ? '${s.grahaShort(p.graha)}℞'
                      : s.grahaShort(p.graha),
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: dense ? 9 : 11,
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

/// Diamond layout. House 1 is the top-centre rhombus and the rest run
/// anticlockwise, which is the convention everywhere the style is used.
class _NorthChart extends StatelessWidget {
  const _NorthChart({required this.chart, this.onHouseTap});

  final KundliChart chart;
  final ValueChanged<int>? onHouseTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              CustomPaint(
                size: Size.square(size),
                painter: _NorthPainter(
                  line: colors.border,
                  fill: colors.surface,
                ),
              ),
              for (var house = 1; house <= 12; house++)
                _positioned(context, house, size),
            ],
          ),
        );
      },
    );
  }

  /// Centres of the twelve compartments as fractions of the square.
  static const List<Offset> _centres = [
    Offset(0.50, 0.25), // 1
    Offset(0.26, 0.12), // 2
    Offset(0.12, 0.26), // 3
    Offset(0.25, 0.50), // 4
    Offset(0.12, 0.74), // 5
    Offset(0.26, 0.88), // 6
    Offset(0.50, 0.75), // 7
    Offset(0.74, 0.88), // 8
    Offset(0.88, 0.74), // 9
    Offset(0.75, 0.50), // 10
    Offset(0.88, 0.26), // 11
    Offset(0.74, 0.12), // 12
  ];

  Widget _positioned(BuildContext context, int house, double size) {
    final centre = _centres[house - 1];
    const cell = 0.24;
    return Positioned(
      left: (centre.dx - cell / 2) * size,
      top: (centre.dy - cell / 2) * size,
      width: cell * size,
      height: cell * size,
      child: GestureDetector(
        onTap: onHouseTap == null ? null : () => onHouseTap!(house),
        behavior: HitTestBehavior.opaque,
        child: _CellContent(
          signNumber: chart.signOfHouse(house).index + 1,
          planets: chart.inHouse(house),
          highlight: house == 1,
        ),
      ),
    );
  }
}

class _NorthPainter extends CustomPainter {
  const _NorthPainter({required this.line, required this.fill});

  final Color line;
  final Color fill;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = fill);

    final stroke = Paint()
      ..color = line
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    // Outer square, both diagonals, and the inner diamond joining the
    // midpoints — those five strokes are the whole North Indian chart.
    canvas
      ..drawRect(Rect.fromLTWH(0, 0, w, h), stroke)
      ..drawLine(Offset.zero, Offset(w, h), stroke)
      ..drawLine(Offset(w, 0), Offset(0, h), stroke)
      ..drawPath(
        Path()
          ..moveTo(w / 2, 0)
          ..lineTo(w, h / 2)
          ..lineTo(w / 2, h)
          ..lineTo(0, h / 2)
          ..close(),
        stroke,
      );
  }

  @override
  bool shouldRepaint(_NorthPainter old) => old.line != line || old.fill != fill;
}

/// Fixed 4×4 grid of signs with a hollow centre. Mesha is always the same
/// cell, so a reader locates a sign by position rather than by label.
class _SouthChart extends StatelessWidget {
  const _SouthChart({required this.chart, this.onHouseTap});

  final KundliChart chart;
  final ValueChanged<int>? onHouseTap;

  /// (row, column) for each rashi, clockwise from Meena at the top-left.
  static const List<(int, int)> _cells = [
    (1, 1), // Mesha
    (0, 2), // Vrishabha — laid out clockwise around the ring
    (0, 3),
    (1, 3),
    (2, 3),
    (3, 3),
    (3, 2),
    (3, 1),
    (3, 0),
    (2, 0),
    (1, 0),
    (0, 0),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final ascendantSign = chart.ascendant;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;
        final cell = size / 4;

        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              for (var i = 0; i < Rashi.values.length; i++)
                () {
                  final rashi = Rashi.values[i];
                  final (row, col) = _cells[i];
                  final house =
                      ((rashi.index - ascendantSign.index + 12) % 12) + 1;
                  return Positioned(
                    left: col * cell,
                    top: row * cell,
                    width: cell,
                    height: cell,
                    child: GestureDetector(
                      onTap: onHouseTap == null
                          ? null
                          : () => onHouseTap!(house),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: BoxDecoration(
                          color: rashi == ascendantSign
                              ? colors.accent.withValues(alpha: 0.1)
                              : colors.surface,
                          border: Border.all(color: colors.border),
                        ),
                        child: _CellContent(
                          signNumber: rashi.index + 1,
                          planets: chart.inSign(rashi),
                          dense: true,
                          highlight: rashi == ascendantSign,
                        ),
                      ),
                    ),
                  );
                }(),
              // Hollow centre: the four inner cells are one empty block.
              Positioned(
                left: cell,
                top: cell,
                width: cell * 2,
                height: cell * 2,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    border: Border.all(color: colors.border),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Text(
                        chart.profile.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
