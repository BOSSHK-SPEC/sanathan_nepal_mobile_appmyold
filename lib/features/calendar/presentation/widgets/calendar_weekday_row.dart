import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../utils/calendar_format.dart';

/// "आ सो मं बु बि शु श" / "Sun Mon … Sat" / "रवि सोम … शनि" header row;
/// the region's weekend day is tinted in the holiday colour.
class CalendarWeekdayRow extends StatelessWidget {
  const CalendarWeekdayRow({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Weekday labels follow the UI language (Figma: आ सो मं… in Nepali,
    // Sun Mon Tue… in the English variants) regardless of the view mode.
    final languageCode = context.languageCode;
    final weekend = context.regionConfig.weekendWeekdays;
    return Row(
      children: List.generate(7, (i) {
        final label = CalendarFormat.weekdayShort(
          i,
          languageCode: languageCode,
        );
        return Expanded(
          child: Center(
            child: Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: compact ? 12 : 15,
                color: weekend.contains(i)
                    ? colors.holiday
                    : colors.textPrimary,
              ),
            ),
          ),
        );
      }),
    );
  }
}
