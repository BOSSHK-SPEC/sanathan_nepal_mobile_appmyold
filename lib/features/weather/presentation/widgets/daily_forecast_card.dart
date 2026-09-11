import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/daily_forecast.dart';
import '../l10n/weather_strings.dart';
import 'weather_format.dart';
import 'weather_icon.dart';

/// "Next Forecast" card listing weekday / icon / max–min temperature rows.
class DailyForecastCard extends StatelessWidget {
  const DailyForecastCard({required this.days, super.key});
  final List<DailyForecast> days;

  @override
  Widget build(BuildContext context) {
    // Skip today – it's covered by the hourly card.
    final upcoming = days.length > 1 ? days.sublist(1) : days;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titled by the page's SectionHeader — an in-card heading under it
          // was the same words twice.
          for (final day in upcoming) _DayRow(day: day),
        ],
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({required this.day});
  final DailyForecast day;

  @override
  Widget build(BuildContext context) {
    final s = WeatherStrings.of(context);
    final dv = context.usesDevanagariDigits;
    final colors = context.colors;
    final degreeStyle = context.textTheme.labelSmall?.copyWith(
      color: colors.textPrimary,
    );
    Widget temp(double v, Color color) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          WeatherFormat.digits('${v.round()}', devanagari: dv),
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text('°C', style: degreeStyle?.copyWith(color: color)),
        ),
      ],
    );

    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              s.weekday(day.date.weekday),
              style: context.textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(child: WeatherIcon(day.condition, size: 40)),
          ),
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  temp(day.maxTemperature, colors.textPrimary),
                  const SizedBox(width: AppSpacing.sm),
                  temp(day.minTemperature, colors.textMuted),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
