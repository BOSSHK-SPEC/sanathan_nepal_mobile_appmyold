import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Left column of the events header (Figma "Group 35645"): month/year
/// title, boxed big day number with weekday, sunrise / sunset mini rows and
/// the secondary (other calendar) date under the box.
class TodayDateColumn extends StatelessWidget {
  const TodayDateColumn({
    required this.monthYear,
    required this.day,
    required this.weekday,
    required this.secondaryDate,
    super.key,
    this.sunrise,
    this.sunset,
    this.width = 84,
  });

  final String monthYear;
  final String day;
  final String weekday;
  final String secondaryDate;
  final String? sunrise;
  final String? sunset;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              monthYear,
              maxLines: 1,
              style: context.textTheme.headlineSmall?.copyWith(height: 1.1),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: colors.border.withValues(alpha: 0.5)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          day,
                          maxLines: 1,
                          style: context.textTheme.displayMedium?.copyWith(
                            color: colors.accent,
                            fontSize: 26,
                            height: 1.05,
                          ),
                        ),
                      ),
                      Text(
                        weekday,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                if (sunrise != null && sunset != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SunTime(
                        icon: Icons.wb_twilight,
                        color: colors.warning,
                        time: sunrise!,
                      ),
                      _SunTime(
                        icon: Icons.nightlight_outlined,
                        color: colors.textMuted,
                        time: sunset!,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            secondaryDate,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _SunTime extends StatelessWidget {
  const _SunTime({required this.icon, required this.color, required this.time});
  final IconData icon;
  final Color color;
  final String time;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 10, color: color),
      Text(time, style: context.textTheme.labelSmall?.copyWith(fontSize: 8)),
    ],
  );
}
