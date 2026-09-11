import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/hourly_forecast.dart';
import 'weather_format.dart';
import 'weather_icon.dart';

/// A horizontal strip of hourly tiles (temperature / icon / time). The
/// selected tile is filled with the primary gradient (Figma "cardweather"
/// highlighted state).
///
/// Untitled and undated: the page's [SectionHeader] carries both, so the card
/// is only the strip.
class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({
    required this.hours,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<HourlyForecast> hours;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 118,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              itemCount: hours.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
              itemBuilder: (context, i) => _HourTile(
                hour: hours[i],
                selected: i == selectedIndex,
                onTap: () => onSelected(i),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HourTile extends StatelessWidget {
  const _HourTile({
    required this.hour,
    required this.selected,
    required this.onTap,
  });
  final HourlyForecast hour;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dv = context.usesDevanagariDigits;
    final textColor = selected ? colors.onPrimary : colors.textPrimary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          gradient: selected ? colors.primaryGradient : null,
          color: selected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: selected ? null : Border.all(color: colors.divider),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              WeatherFormat.celsius(hour.temperature, devanagari: dv),
              style: context.textTheme.titleMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            WeatherIcon(hour.condition, isDay: hour.isDay, size: 40),
            Text(
              WeatherFormat.clock24(hour.time, devanagari: dv),
              style: context.textTheme.titleSmall?.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
