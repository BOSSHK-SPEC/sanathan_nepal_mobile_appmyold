import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_month.dart';
import 'calendar_day_cell.dart';
import 'calendar_weekday_row.dart';

/// Pure 6×7 grid (weekday header + 42 cells) for a [CalendarMonth].
///
/// Stateless & cubit-free so it can be embedded anywhere (home page,
/// date converter result…).
class CalendarGrid extends StatelessWidget {
  const CalendarGrid({
    required this.month,
    super.key,
    this.onDayTap,
    this.selectedDay,
    this.highlightedDate,
    this.compact = false,
    this.showWeekdays = true,
    this.rowHeight,
  });

  final CalendarMonth month;
  final ValueChanged<CalendarDay>? onDayTap;
  final CalendarDay? selectedDay;

  /// Alternative to [selectedDay] – highlight the cell matching this AD date.
  final DateTime? highlightedDate;
  final bool compact;
  final bool showWeekdays;

  /// Overrides the default row height (40 full / 27 compact).
  final double? rowHeight;

  @override
  Widget build(BuildContext context) {
    final height = rowHeight ?? (compact ? 27.0 : 40.0);
    final rows = <Widget>[];
    for (var r = 0; r < 6; r++) {
      rows.add(
        SizedBox(
          height: height,
          child: Row(
            children: List.generate(7, (c) {
              final day = month.days[r * 7 + c];
              final target = selectedDay?.ad ?? highlightedDate;
              final isSelected =
                  target != null &&
                  target.year == day.ad.year &&
                  target.month == day.ad.month &&
                  target.day == day.ad.day;
              return Expanded(
                child: CalendarDayCell(
                  day: day,
                  mode: month.mode,
                  compact: compact,
                  selected: isSelected,
                  onTap: onDayTap == null ? null : () => onDayTap!(day),
                ),
              );
            }),
          ),
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showWeekdays) ...[
          CalendarWeekdayRow(compact: compact),
          if (compact) Divider(height: 1, color: context.colors.divider),
        ],
        ...rows,
      ],
    );
  }
}
