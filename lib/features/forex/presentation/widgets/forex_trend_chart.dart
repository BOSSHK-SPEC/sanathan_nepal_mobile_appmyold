import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/forex_history_point.dart';
import '../../domain/entities/forex_range.dart';
import '../l10n/forex_strings.dart';
import 'forex_format.dart';

/// Buying (red) / selling (blue) line chart of NRB rates over [range]
/// (Figma "MAIN LINE CHART": "Rs" axis label, light horizontal grid,
/// month-day labels).
class ForexTrendChart extends StatelessWidget {
  const ForexTrendChart({
    required this.points,
    required this.range,
    super.key,
    this.height = 96,
  });

  final List<ForexHistoryPoint> points;
  final ForexRange range;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ForexStrings.of(context);
    final dv = context.usesDevanagariDigits;
    if (points.length < 2) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            s.noHistory,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
        ),
      );
    }

    final values = [
      for (final p in points) p.buy,
      for (final p in points) p.sell,
    ];
    final minV = values.reduce((a, b) => a < b ? a : b);
    final maxV = values.reduce((a, b) => a > b ? a : b);
    final pad = ((maxV - minV) * 0.25).clamp(0.05, double.infinity);
    final yInterval = _niceInterval((maxV - minV + pad * 2) / 2);
    final minY = ((minV - pad) / yInterval).floorToDouble() * yInterval;
    final maxY = ((maxV + pad) / yInterval).ceilToDouble() * yInterval;
    final lastX = (points.length - 1).toDouble();
    final labelStep = range == ForexRange.year
        ? 30.0
        : range == ForexRange.month
        ? 5.0
        : 1.0;

    FlLine grid(double _) => FlLine(color: colors.divider, strokeWidth: 0.8);
    final labelStyle = context.textTheme.labelSmall?.copyWith(fontSize: 8);

    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: Text(
              ForexFormat.axisSymbol(
                context.regionConfig,
                languageCode: context.languageCode,
              ),
              style: context.textTheme.labelSmall?.copyWith(fontSize: 9),
            ),
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: lastX,
                minY: minY,
                maxY: maxY,
                clipData: const FlClipData.none(),
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: yInterval,
                  getDrawingHorizontalLine: grid,
                ),
                borderData: FlBorderData(
                  border: Border(
                    left: BorderSide(color: colors.textMuted, width: 1),
                    bottom: BorderSide(color: colors.divider, width: 0.8),
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 26,
                      interval: yInterval,
                      getTitlesWidget: (v, meta) => Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.xs),
                        child: Text(
                          ForexFormat.digits(
                            v == v.roundToDouble()
                                ? v.toInt().toString()
                                : v.toStringAsFixed(1),
                            devanagari: dv,
                          ),
                          style: labelStyle,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 14,
                      interval: labelStep,
                      getTitlesWidget: (v, meta) {
                        final i = v.round();
                        if (i < 0 || i >= points.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            ForexFormat.axisDate(
                              points[i].date,
                              devanagari: dv,
                              monthOnly: range == ForexRange.year,
                            ),
                            style: labelStyle,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => colors.surfaceElevated,
                    getTooltipItems: (spots) => [
                      for (final sp in spots)
                        LineTooltipItem(
                          ForexFormat.rate(sp.y, devanagari: dv),
                          context.textTheme.labelSmall!.copyWith(
                            color: sp.bar.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                lineBarsData: [
                  _bar(points.map((p) => p.buy), colors.error, lastX),
                  _bar(points.map((p) => p.sell), colors.info, lastX),
                ],
              ),
              duration: Duration.zero,
            ),
          ),
        ],
      ),
    );
  }

  static LineChartBarData _bar(Iterable<double> ys, Color color, double lastX) {
    var i = 0;
    return LineChartBarData(
      spots: [for (final y in ys) FlSpot((i++).toDouble(), y)],
      color: color,
      barWidth: 1.6,
      isCurved: true,
      curveSmoothness: 0.2,
      preventCurveOverShooting: true,
      dotData: FlDotData(
        checkToShowDot: (spot, _) => spot.x == lastX,
        getDotPainter: (spot, _, bar, _) => FlDotCirclePainter(
          radius: 3,
          color: color,
          strokeWidth: 1.5,
          strokeColor: Colors.white,
        ),
      ),
    );
  }

  static double _niceInterval(double raw) {
    if (raw <= 0) return 1;
    final mag = _pow10(raw);
    final norm = raw / mag;
    final nice = norm < 1.5
        ? 1.0
        : norm < 3
        ? 2.0
        : norm < 7
        ? 5.0
        : 10.0;
    return nice * mag;
  }

  static double _pow10(double v) {
    var p = 1.0;
    while (p * 10 <= v) {
      p *= 10;
    }
    while (p > v) {
      p /= 10;
    }
    return p;
  }
}
