import 'package:flutter/material.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../l10n/onboarding_strings.dart';

/// Minimal traditional-calendar date picker (year / month / day dropdowns)
/// for the region's [TraditionalCalendar] – Bikram Sambat in Nepal, the
/// Indian national (Saka) calendar in India.
///
/// Returns the picked date converted to Gregorian, or `null` when dismissed.
class TraditionalDatePickerDialog extends StatefulWidget {
  TraditionalDatePickerDialog({
    required this.calendar,
    super.key,
    this.initial,
    int? firstYear,
    int? lastYear,
  }) : firstYear = firstYear ?? defaultFirstYear(calendar),
       lastYear = lastYear ?? defaultLastYear(calendar);

  final TraditionalCalendar calendar;
  final TraditionalDate? initial;
  final int firstYear;
  final int lastYear;

  /// Earliest selectable year (≈ Gregorian 1920, within calendar support).
  static int defaultFirstYear(TraditionalCalendar calendar) => calendar
      .fromGregorian(DateTime(1920))
      .year
      .clamp(calendar.minYear, calendar.maxYear);

  /// Latest selectable year (today, within calendar support).
  static int defaultLastYear(TraditionalCalendar calendar) => calendar
      .fromGregorian(DateTime.now())
      .year
      .clamp(calendar.minYear, calendar.maxYear);

  /// Shows the picker for the region active in [context].
  static Future<DateTime?> show(BuildContext context, {DateTime? initial}) {
    final calendar = context.traditionalCalendar;
    return showDialog<DateTime>(
      context: context,
      builder: (_) => TraditionalDatePickerDialog(
        calendar: calendar,
        initial: initial == null ? null : calendar.fromGregorian(initial),
      ),
    );
  }

  @override
  State<TraditionalDatePickerDialog> createState() =>
      _TraditionalDatePickerDialogState();
}

class _TraditionalDatePickerDialogState
    extends State<TraditionalDatePickerDialog> {
  late int _year;
  late int _month;
  late int _day;

  TraditionalCalendar get _calendar => widget.calendar;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final init =
        widget.initial ??
        _calendar.fromGregorian(DateTime(now.year - 25, now.month, now.day));
    _year = init.year.clamp(widget.firstYear, widget.lastYear);
    _month = init.month;
    _day = init.day;
  }

  int get _daysInMonth => _calendar.daysInMonth(_year, _month);

  String _digits(int n) =>
      context.usesDevanagariDigits ? '$n'.toDevanagariDigits() : '$n';

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    final months = _calendar.monthNames(languageCode: context.languageCode);
    final days = _daysInMonth;
    if (_day > days) _day = days;
    return AlertDialog(
      title: Text(s.dateOfBirthIn(s.traditionalEra(_calendar.id))),
      content: Row(
        children: [
          Expanded(
            child: _Dropdown<int>(
              value: _year,
              items: [
                for (var y = widget.firstYear; y <= widget.lastYear; y++) y,
              ],
              label: _digits,
              onChanged: (v) => setState(() => _year = v),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 2,
            child: _Dropdown<int>(
              value: _month,
              items: [for (var m = 1; m <= 12; m++) m],
              label: (m) => months[m - 1],
              onChanged: (v) => setState(() => _month = v),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _Dropdown<int>(
              value: _day,
              items: [for (var d = 1; d <= days; d++) d],
              label: _digits,
              onChanged: (v) => setState(() => _day = v),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.cancel),
        ),
        PrimaryButton(
          label: context.l10n.ok,
          expanded: false,
          height: 36,
          onPressed: () => Navigator.of(
            context,
          ).pop(_calendar.toGregorian(TraditionalDate(_year, _month, _day))),
        ),
      ],
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
  });

  final T value;
  final List<T> items;
  final String Function(T) label;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
    initialValue: value,
    isExpanded: true,
    decoration: const InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
    ),
    items: [
      for (final i in items)
        DropdownMenuItem<T>(
          value: i,
          child: Text(label(i), overflow: TextOverflow.ellipsis),
        ),
    ],
    onChanged: (v) {
      if (v != null) onChanged(v);
    },
  );
}
