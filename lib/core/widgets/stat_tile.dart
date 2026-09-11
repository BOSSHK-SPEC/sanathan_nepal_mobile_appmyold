import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';
import 'app_card.dart';

/// Dashboard metric: label, big value, optional delta and trend sparkline.
///
/// The delta encodes direction in an arrow as well as colour, so it stays
/// readable without colour perception.
class StatTile extends StatelessWidget {
  const StatTile({
    required this.label,
    super.key,
    this.value,
    this.valueWidget,
    this.delta,
    this.deltaPositive,
    this.trend,
    this.icon,
    this.onTap,
    this.accentColor,
  }) : assert(
         value != null || valueWidget != null,
         'Provide either value or valueWidget',
       );

  final String label;
  final String? value;

  /// Use for money, which should render through `MoneyText`.
  final Widget? valueWidget;

  /// e.g. "+12%" — rendered with an arrow.
  final String? delta;

  /// `null` colours the delta neutrally; otherwise green/red.
  final bool? deltaPositive;

  /// Normalised or raw series for the sparkline; ignored when shorter than 2.
  final List<double>? trend;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = accentColor ?? colors.accent;
    final deltaColor = deltaPositive == null
        ? colors.textMuted
        : (deltaPositive! ? colors.success : colors.error);

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(icon, size: 14, color: accent),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          valueWidget ??
              Text(
                value!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.displaySmall?.copyWith(
                  fontSize: 22,
                  height: 1.1,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
          if (delta != null || (trend != null && trend!.length > 1)) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                if (delta != null) ...[
                  Icon(
                    deltaPositive == null
                        ? Icons.remove_rounded
                        : deltaPositive!
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    size: 12,
                    color: deltaColor,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    delta!,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: deltaColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (trend != null && trend!.length > 1) ...[
                  const Spacer(),
                  SizedBox(
                    width: 56,
                    height: 20,
                    child: AppSparkline(values: trend!, color: accent),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Minimal trend line with a soft area fill and an emphasised endpoint.
class AppSparkline extends StatelessWidget {
  const AppSparkline({
    required this.values,
    super.key,
    this.color,
    this.strokeWidth = 1.6,
    this.showEndpoint = true,
  });

  final List<double> values;
  final Color? color;
  final double strokeWidth;
  final bool showEndpoint;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _SparklinePainter(
      values: values,
      color: color ?? context.colors.accent,
      strokeWidth: strokeWidth,
      showEndpoint: showEndpoint,
    ),
    size: Size.infinite,
  );
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({
    required this.values,
    required this.color,
    required this.strokeWidth,
    required this.showEndpoint,
  });

  final List<double> values;
  final Color color;
  final double strokeWidth;
  final bool showEndpoint;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2 || size.width <= 0 || size.height <= 0) return;

    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final range = (max - min).abs() < 0.0001 ? 1.0 : max - min;
    final dx = size.width / (values.length - 1);
    final inset = strokeWidth;

    final points = <Offset>[
      for (var i = 0; i < values.length; i++)
        Offset(
          i * dx,
          inset + (size.height - inset * 2) * (1 - (values[i] - min) / range),
        ),
    ];

    final line = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];
      final midX = (prev.dx + curr.dx) / 2;
      line.cubicTo(midX, prev.dy, midX, curr.dy, curr.dx, curr.dy);
    }

    final area = Path.from(line)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();

    canvas.drawPath(
      area,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );

    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke,
    );

    if (showEndpoint) {
      canvas.drawCircle(points.last, strokeWidth * 1.6, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.values != values ||
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.showEndpoint != showEndpoint;
}
