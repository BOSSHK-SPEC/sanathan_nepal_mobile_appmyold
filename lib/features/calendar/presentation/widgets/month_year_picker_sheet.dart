import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../../domain/services/calendar_year_range.dart';
import '../l10n/calendar_strings.dart';
import '../utils/calendar_format.dart';
import 'wheel_picker.dart';

/// Result of [MonthYearPickerSheet.show].
typedef MonthYear = ({int year, int month});

/// "मिति छान्नुहोस्" dialog with year / month wheels and a split
/// छाड्नुहोस् | छान्नुहोस् footer (Figma 580:2695 / 626:1392). Months and
/// the year range follow the region's traditional calendar in traditional
/// mode and the Gregorian calendar otherwise.
class MonthYearPickerSheet extends StatefulWidget {
  const MonthYearPickerSheet({
    required this.mode,
    required this.year,
    required this.month,
    super.key,
    this.minYear,
    this.maxYear,
  });

  final CalendarViewMode mode;
  final int year;
  final int month;
  final int? minYear;
  final int? maxYear;

  static Future<MonthYear?> show(
    BuildContext context, {
    required CalendarViewMode mode,
    required int year,
    required int month,
  }) => showDialog<MonthYear>(
    context: context,
    builder: (_) => MonthYearPickerSheet(mode: mode, year: year, month: month),
  );

  @override
  State<MonthYearPickerSheet> createState() => _MonthYearPickerSheetState();
}

class _MonthYearPickerSheetState extends State<MonthYearPickerSheet> {
  late int _year = widget.year;
  late int _month = widget.month;

  late int _minYear;
  late int _maxYear;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final range = supportedYears(context.traditionalCalendar, widget.mode);
    _minYear = widget.minYear ?? range.min;
    _maxYear = widget.maxYear ?? range.max;
    _year = _year.clamp(_minYear, _maxYear);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final languageCode = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final calendar = context.traditionalCalendar;
    final strings = CalendarStrings.of(context);
    final isTraditional = widget.mode == CalendarViewMode.traditional;
    final years = [
      for (var y = _minYear; y <= _maxYear; y++)
        CalendarFormat.digits(y, devanagari: devanagari),
    ];
    final months = [
      for (var m = 1; m <= 12; m++)
        isTraditional
            ? calendar.monthName(m, languageCode: languageCode)
            : CalendarFormat.adMonth(m, languageCode: languageCode),
    ];

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text(strings.selectMonth, style: context.textTheme.titleMedium),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WheelPicker(
                  items: years,
                  selectedIndex: _year - _minYear,
                  onChanged: (i) => setState(() => _year = _minYear + i),
                ),
                WheelPicker(
                  items: months,
                  selectedIndex: _month - 1,
                  width: 110,
                  onChanged: (i) => setState(() => _month = i + 1),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Divider(height: 1, color: colors.border),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        strings.cancel,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  VerticalDivider(width: 1, color: colors.border),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(
                        context,
                      ).pop((year: _year, month: _month)),
                      child: Text(
                        strings.confirm,
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
      ),
    );
  }
}
