import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../calendar/presentation/utils/calendar_format.dart';
import '../../../calendar/presentation/widgets/wheel_picker.dart';
import '../../domain/entities/date_parts.dart';
import '../l10n/date_converter_strings.dart';

/// Rounded card with month / day / year wheels (with ▲▼ steppers) and the
/// split "रद्द गर्नुहोस् | परिवर्तन गर्नुहोस्" footer (Figma 580:2130 / 633:911).
/// Month names come from the region's traditional calendar when
/// [isTraditional] is set, otherwise from the Gregorian calendar.
class ConversionInputCard extends StatelessWidget {
  const ConversionInputCard({
    required this.isTraditional,
    required this.input,
    required this.daysInMonth,
    required this.minYear,
    required this.maxYear,
    required this.onYear,
    required this.onMonth,
    required this.onDay,
    required this.onCancel,
    required this.onConvert,
    super.key,
    this.busy = false,
  });

  final bool isTraditional;
  final DateParts input;
  final int daysInMonth;
  final int minYear;
  final int maxYear;
  final ValueChanged<int> onYear;
  final ValueChanged<int> onMonth;
  final ValueChanged<int> onDay;
  final VoidCallback onCancel;
  final VoidCallback onConvert;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final languageCode = context.languageCode;
    final calendar = context.traditionalCalendar;
    final strings = DateConverterStrings.of(context);
    // Traditional dates follow the UI script; Gregorian digits stay Latin.
    final devanagari = isTraditional && context.usesDevanagariDigits;

    final months = [
      for (var m = 1; m <= 12; m++)
        isTraditional
            ? calendar.monthName(m, languageCode: languageCode)
            : CalendarFormat.adMonth(m, languageCode: languageCode),
    ];
    final days = [
      for (var d = 1; d <= daysInMonth; d++)
        CalendarFormat.digits(d, devanagari: devanagari),
    ];
    final years = [
      for (var y = minYear; y <= maxYear; y++)
        CalendarFormat.digits(y, devanagari: devanagari),
    ];
    final wheelStyle = context.textTheme.bodyLarge?.copyWith(fontSize: 15);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDark ? 0.25 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WheelPicker(
                  key: ValueKey('month-$isTraditional'),
                  items: months,
                  selectedIndex: input.month - 1,
                  onChanged: (i) => onMonth(i + 1),
                  showArrows: true,
                  width: 108,
                  textStyle: wheelStyle,
                ),
                WheelPicker(
                  key: ValueKey('day-$isTraditional-$daysInMonth'),
                  items: days,
                  selectedIndex: (input.day - 1).clamp(0, days.length - 1),
                  onChanged: (i) => onDay(i + 1),
                  showArrows: true,
                  width: 70,
                  textStyle: wheelStyle,
                ),
                WheelPicker(
                  key: ValueKey('year-$isTraditional'),
                  items: years,
                  selectedIndex: (input.year - minYear).clamp(
                    0,
                    years.length - 1,
                  ),
                  onChanged: (i) => onYear(minYear + i),
                  showArrows: true,
                  width: 80,
                  textStyle: wheelStyle,
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.border),
          SizedBox(
            height: 46,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: busy ? null : onCancel,
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      strings.cancel,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(width: 1, color: colors.border),
                Expanded(
                  child: TextButton(
                    onPressed: busy ? null : onConvert,
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: busy
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.accent,
                            ),
                          )
                        : Text(
                            strings.convert,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: colors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
