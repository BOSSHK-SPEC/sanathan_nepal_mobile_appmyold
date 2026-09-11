import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../utils/calendar_format.dart';

/// One grid cell: primary day number (traditional or Gregorian), small
/// secondary number, event dot, today highlight (green box) and holiday
/// colouring.
class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({
    required this.day,
    required this.mode,
    required this.onTap,
    super.key,
    this.compact = false,
    this.selected = false,
  });

  final CalendarDay day;
  final CalendarViewMode mode;
  final VoidCallback? onTap;
  final bool compact;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final config = context.regionConfig;
    final isTraditional = mode == CalendarViewMode.traditional;

    // Traditional numerals follow the app language; in Gregorian view the
    // small traditional numbers use the region's default script (Nepal:
    // Devanagari as in Figma "DARK - AD CALENDER", India: Latin).
    final primary = isTraditional
        ? CalendarFormat.digits(
            day.traditional.day,
            devanagari: context.usesDevanagariDigits,
          )
        : '${day.ad.day}';
    final secondary = isTraditional
        ? '${day.ad.day}'
        : CalendarFormat.digits(
            day.traditional.day,
            devanagari: CalendarFormat.devanagari(config.defaultLanguageCode),
          );

    Color primaryColor;
    Color secondaryColor;
    if (day.isToday) {
      primaryColor = colors.onPrimary;
      secondaryColor = colors.onPrimary;
    } else if (!day.isCurrentMonth) {
      primaryColor = colors.textMuted.withValues(alpha: 0.6);
      secondaryColor = colors.textMuted.withValues(alpha: 0.6);
    } else if (day.isHoliday) {
      primaryColor = colors.holiday;
      secondaryColor = colors.holiday;
    } else {
      primaryColor = colors.textPrimary;
      secondaryColor = colors.textSecondary.withValues(alpha: 0.7);
    }

    final primarySize = compact ? 12.0 : 15.0;
    final secondarySize = compact ? 8.0 : 10.0;

    return Semantics(
      button: true,
      label: '$primary / $secondary',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Container(
          margin: EdgeInsets.all(compact ? 1 : 2),
          decoration: BoxDecoration(
            color: day.isToday ? colors.today : null,
            borderRadius: BorderRadius.circular(compact ? 4 : 6),
            border: selected && !day.isToday
                ? Border.all(color: colors.accent, width: 1.2)
                : null,
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: compact ? 6 : 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Text(
                    primary,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: primarySize,
                      height: 1.1,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: compact ? 1 : 3,
                bottom: compact ? 1 : 3,
                child: Text(
                  secondary,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: secondarySize,
                    height: 1,
                    color: secondaryColor,
                  ),
                ),
              ),
              if (day.hasEvents)
                Positioned(
                  left: compact ? 3 : 6,
                  bottom: compact ? 3 : 5,
                  child: Container(
                    width: compact ? 3 : 4,
                    height: compact ? 3 : 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: day.isToday
                          ? colors.onPrimary
                          : (day.hasHolidayEvent
                                ? colors.holiday
                                : colors.textPrimary),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
