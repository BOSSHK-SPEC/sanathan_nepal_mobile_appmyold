import 'package:flutter/material.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/book_appointment_cubit.dart';
import 'appointment_format.dart';

/// Compact month calendar used inside the booking card (Figma `759:2525`).
///
/// Renders either a traditional-calendar month (Bikram Sambat in Nepal,
/// Saka in India – from `context.traditionalCalendar`) or a Gregorian month
/// depending on [mode]; the value exchanged with the caller is always a
/// Gregorian [DateTime]. Days before [minDate] are disabled and the
/// region's weekend day is highlighted.
class BookingCalendar extends StatefulWidget {
  const BookingCalendar({
    required this.selected,
    required this.mode,
    required this.onSelected,
    super.key,
    this.minDate,
    this.availableDays,
  });

  final DateTime selected;
  final DateMode mode;
  final ValueChanged<DateTime> onSelected;
  final DateTime? minDate;

  /// Days the astrologer actually works. Null means "not known yet", which
  /// leaves every day tappable rather than greying out the whole month while
  /// the calendar is still loading.
  final Set<DateTime>? availableDays;

  @override
  State<BookingCalendar> createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  /// First day of the visible month (Gregorian).
  late DateTime _visibleAd;

  /// Visible traditional month (year, month, 1) – only used in that mode.
  TraditionalDate? _visibleTraditional;

  @override
  void initState() {
    super.initState();
    _visibleAd = DateTime(widget.selected.year, widget.selected.month);
  }

  @override
  void didUpdateWidget(covariant BookingCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode != widget.mode ||
        oldWidget.selected != widget.selected) {
      _visibleAd = DateTime(widget.selected.year, widget.selected.month);
      _visibleTraditional = null;
    }
  }

  TraditionalDate _traditionalMonth(TraditionalCalendar calendar) {
    final cached = _visibleTraditional;
    if (cached != null) return cached;
    final t = calendar.fromGregorian(widget.selected);
    return _visibleTraditional = TraditionalDate(t.year, t.month, 1);
  }

  void _shift(int delta, TraditionalCalendar calendar) {
    setState(() {
      if (widget.mode == DateMode.traditional) {
        final cur = _traditionalMonth(calendar);
        var y = cur.year;
        var m = cur.month + delta;
        if (m < 1) {
          m = 12;
          y--;
        } else if (m > 12) {
          m = 1;
          y++;
        }
        y = y.clamp(calendar.minYear, calendar.maxYear);
        _visibleTraditional = TraditionalDate(y, m, 1);
      } else {
        _visibleAd = DateTime(_visibleAd.year, _visibleAd.month + delta);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final fmt = AppointmentFormat.of(context);
    final calendar = context.traditionalCalendar;
    final weekend = calendar.weekendWeekdays;
    final traditionalMode = widget.mode == DateMode.traditional;
    final weekdays = fmt.weekdayInitials;

    // Build the list of day cells for the visible month.
    final String monthLabel;
    final int leadingBlanks;
    final List<DateTime> days;
    if (traditionalMode) {
      final month = _traditionalMonth(calendar);
      monthLabel = fmt.traditionalMonthYear(month);
      final first = calendar.toGregorian(month);
      leadingBlanks = first.weekday % 7;
      days = List.generate(
        calendar.daysInMonth(month.year, month.month),
        (i) => DateTime(first.year, first.month, first.day + i),
      );
    } else {
      monthLabel = fmt.gregorianMonthYear(_visibleAd.year, _visibleAd.month);
      leadingBlanks = _visibleAd.weekday % 7;
      final count = DateTime(_visibleAd.year, _visibleAd.month + 1, 0).day;
      days = List.generate(
        count,
        (i) => DateTime(_visibleAd.year, _visibleAd.month, i + 1),
      );
    }
    final today = DateTime.now();
    final min = widget.minDate == null
        ? null
        : DateTime(
            widget.minDate!.year,
            widget.minDate!.month,
            widget.minDate!.day,
          );

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => _shift(-1, calendar),
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.chevron_left, size: 20),
            ),
            Expanded(
              child: Text(
                monthLabel,
                textAlign: TextAlign.center,
                style: textTheme.titleSmall,
              ),
            ),
            IconButton(
              onPressed: () => _shift(1, calendar),
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.chevron_right, size: 20),
            ),
          ],
        ),
        Row(
          children: [
            for (var i = 0; i < weekdays.length; i++)
              Expanded(
                child: Text(
                  weekdays[i],
                  textAlign: TextAlign.center,
                  style: textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: weekend.contains(i)
                        ? colors.holiday
                        : colors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
        Divider(color: colors.divider, height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: 32,
          ),
          itemCount: leadingBlanks + days.length,
          itemBuilder: (context, i) {
            if (i < leadingBlanks) return const SizedBox.shrink();
            final day = days[i - leadingBlanks];
            // Past, or a day this astrologer keeps no hours on. Tapping the
            // latter used to open an empty time grid with nothing to explain
            // it; dimming it says "not this day" before the tap.
            final available =
                widget.availableDays == null ||
                widget.availableDays!.contains(
                  DateTime(day.year, day.month, day.day),
                );
            final disabled = (min != null && day.isBefore(min)) || !available;
            final selected = _sameDay(day, widget.selected);
            final isToday = _sameDay(day, today);
            final isWeekend = weekend.contains(day.weekday % 7);
            final traditionalDay = calendar.fromGregorian(day).day;
            final primaryNumber = traditionalMode ? traditionalDay : day.day;
            final secondaryNumber = traditionalMode ? day.day : traditionalDay;
            return InkWell(
              onTap: disabled ? null : () => widget.onSelected(day),
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  gradient: selected ? colors.primaryGradient : null,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: isToday && !selected
                      ? Border.all(color: colors.today)
                      : null,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        fmt.number(primaryNumber),
                        style: textTheme.labelLarge?.copyWith(
                          fontSize: 13,
                          color: selected
                              ? colors.onPrimary
                              : disabled
                              ? colors.textMuted.withValues(alpha: 0.5)
                              : isWeekend
                              ? colors.holiday
                              : colors.textPrimary,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      top: 1,
                      child: Text(
                        '$secondaryNumber',
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: 7,
                          color: selected ? colors.onPrimary : colors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
