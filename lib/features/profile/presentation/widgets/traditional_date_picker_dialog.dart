import 'package:flutter/material.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../l10n/profile_strings.dart';

/// Year / month / day dropdown picker for the active region's traditional
/// calendar (`context.traditionalCalendar`: Bikram Sambat in Nepal, Saka in
/// India). Returns the picked Gregorian [DateTime].
class TraditionalDatePickerDialog extends StatefulWidget {
  const TraditionalDatePickerDialog({
    required this.calendar,
    required this.initial,
    super.key,
    this.lastDate,
  });

  final TraditionalCalendar calendar;
  final TraditionalDate initial;

  /// Latest selectable Gregorian date (defaults to today).
  final DateTime? lastDate;

  /// Shows the dialog for [initial] (Gregorian) and returns the picked
  /// Gregorian date, or `null` when dismissed.
  static Future<DateTime?> show(BuildContext context, DateTime initial) {
    final calendar = context.traditionalCalendar;
    return showDialog<DateTime>(
      context: context,
      builder: (_) => TraditionalDatePickerDialog(
        calendar: calendar,
        initial: calendar.fromGregorian(initial),
      ),
    );
  }

  @override
  State<TraditionalDatePickerDialog> createState() =>
      _TraditionalDatePickerDialogState();
}

class _TraditionalDatePickerDialogState
    extends State<TraditionalDatePickerDialog> {
  late int _year = widget.initial.year;
  late int _month = widget.initial.month;
  late int _day = widget.initial.day;

  TraditionalCalendar get _cal => widget.calendar;
  int get _maxDay => _cal.daysInMonth(_year, _month);

  @override
  void initState() {
    super.initState();
    _year = _year.clamp(_cal.minYear, _maxYear);
    if (_day > _maxDay) _day = _maxDay;
  }

  int get _maxYear {
    final last = widget.lastDate ?? DateTime.now();
    return _cal.fromGregorian(last).year.clamp(_cal.minYear, _cal.maxYear);
  }

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final lang = context.languageCode;
    final years = [for (var y = _cal.minYear; y <= _maxYear; y++) y];
    String d(int n) => localizeDigits(context, '$n');
    return AlertDialog(
      title: Text(
        s.dobIn(_cal.eraLabel(languageCode: lang)),
        style: context.textTheme.headlineSmall,
      ),
      content: Row(
        children: [
          Expanded(
            child: DropdownButton<int>(
              value: _year,
              isExpanded: true,
              items: [
                for (final y in years)
                  DropdownMenuItem(value: y, child: Text(d(y))),
              ],
              onChanged: (v) => setState(() {
                _year = v ?? _year;
                if (_day > _maxDay) _day = _maxDay;
              }),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 2,
            child: DropdownButton<int>(
              value: _month,
              isExpanded: true,
              items: [
                for (var m = 1; m <= 12; m++)
                  DropdownMenuItem(
                    value: m,
                    child: Text(
                      _cal.monthName(m, languageCode: lang),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: (v) => setState(() {
                _month = v ?? _month;
                if (_day > _maxDay) _day = _maxDay;
              }),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: DropdownButton<int>(
              value: _day,
              isExpanded: true,
              items: [
                for (var i = 1; i <= _maxDay; i++)
                  DropdownMenuItem(value: i, child: Text(d(i))),
              ],
              onChanged: (v) => setState(() => _day = v ?? _day),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(s.cancel),
        ),
        PrimaryButton(
          label: s.save,
          expanded: false,
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          onPressed: () => Navigator.of(
            context,
          ).pop(_cal.toGregorian(TraditionalDate(_year, _month, _day))),
        ),
      ],
    );
  }
}
