import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../calendar/calendar.dart';
import '../extensions/context_extensions.dart';
import '../extensions/string_extensions.dart';
import '../theme/app_spacing.dart';
import 'primary_button.dart';

/// Year → month → day picker for the region's traditional calendar (Bikram
/// Sambat in Nepal, Saka in India). Returns the picked date as Gregorian.
///
/// One picker for the whole app. There used to be two copies — onboarding and
/// profile — each laying three dropdowns side by side in a ~230 px dialog.
/// That left the year and day boxes roughly 18 px for text once the arrow and
/// padding were taken, so whatever was picked simply did not show. Stacked,
/// full-width rows show every value in full, in any language.
///
/// Year comes first because it decides whether Chaitra has 30 or 31 days, and
/// month second because it decides how many days there are.
class TraditionalDatePicker extends StatefulWidget {
  const TraditionalDatePicker({
    required this.calendar,
    required this.title,
    super.key,
    this.initial,
    this.firstDate,
    this.lastDate,
    this.confirmLabel,
  });

  final TraditionalCalendar calendar;
  final String title;

  /// Gregorian date to open on; defaults to 25 years ago.
  final DateTime? initial;

  /// Earliest selectable Gregorian date; defaults to 1 Jan 1900.
  final DateTime? firstDate;

  /// Latest selectable Gregorian date; defaults to today — nobody is born
  /// tomorrow.
  final DateTime? lastDate;

  /// Label of the confirm button; defaults to "OK".
  final String? confirmLabel;

  /// Shows the picker for the region active in [context] and returns the
  /// picked Gregorian date, or `null` when dismissed.
  static Future<DateTime?> show(
    BuildContext context, {
    required String title,
    DateTime? initial,
    DateTime? firstDate,
    DateTime? lastDate,
    String? confirmLabel,
  }) {
    final calendar = context.traditionalCalendar;
    return showDialog<DateTime>(
      context: context,
      builder: (_) => TraditionalDatePicker(
        calendar: calendar,
        title: title,
        initial: initial,
        firstDate: firstDate,
        lastDate: lastDate,
        confirmLabel: confirmLabel,
      ),
    );
  }

  @override
  State<TraditionalDatePicker> createState() => _TraditionalDatePickerState();
}

class _TraditionalDatePickerState extends State<TraditionalDatePicker> {
  late final TraditionalDate _min;
  late final TraditionalDate _max;
  late int _year;
  late int _month;
  late int _day;

  TraditionalCalendar get _cal => widget.calendar;

  @override
  void initState() {
    super.initState();
    // Every bound is kept inside what the calendar can convert: Bikram
    // Sambat is table-driven and has no answer outside its table.
    final earliest = _cal.toGregorian(TraditionalDate(_cal.minYear, 1, 1));
    final latest = _cal.toGregorian(
      TraditionalDate(_cal.maxYear, 12, _cal.daysInMonth(_cal.maxYear, 12)),
    );
    DateTime within(DateTime d) {
      final day = DateTime(d.year, d.month, d.day);
      if (day.isBefore(earliest)) return earliest;
      if (day.isAfter(latest)) return latest;
      return day;
    }

    final now = DateTime.now();
    final last = within(widget.lastDate ?? now);
    var first = within(widget.firstDate ?? DateTime(1900));
    if (first.isAfter(last)) first = last;
    _min = _cal.fromGregorian(first);
    _max = _cal.fromGregorian(last);

    final start = _cal.fromGregorian(
      within(widget.initial ?? DateTime(now.year - 25, now.month, now.day)),
    );
    _year = start.year;
    _month = start.month;
    _day = start.day;
    _clamp();
  }

  int get _firstMonth => _year == _min.year ? _min.month : 1;
  int get _lastMonth => _year == _max.year ? _max.month : 12;
  int get _firstDay =>
      _year == _min.year && _month == _min.month ? _min.day : 1;
  int get _lastDay {
    final days = _cal.daysInMonth(_year, _month);
    return _year == _max.year && _month == _max.month
        ? math.min(days, _max.day)
        : days;
  }

  /// Pulls the month and day back inside what the year and month allow.
  ///
  /// Day 31 of Jyaishtha, then Kartika picked: Kartika has 30 days, so the
  /// day becomes 30 rather than naming a date that does not exist — which is
  /// what used to leave the day box showing 31 and throwing.
  void _clamp() {
    _year = _year.clamp(_min.year, _max.year);
    _month = _month.clamp(_firstMonth, _lastMonth);
    _day = _day.clamp(_firstDay, _lastDay);
  }

  void _set(void Function() change) => setState(() {
    change();
    _clamp();
  });

  String _digits(int n) =>
      context.usesDevanagariDigits ? '$n'.toDevanagariDigits() : '$n';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lang = context.languageCode;
    final picked = _cal.toGregorian(TraditionalDate(_year, _month, _day));
    // Full date, year included — a medium date ("Mon, Nov 6") drops the year,
    // which is the one part a birthday cannot do without.
    final gregorian = MaterialLocalizations.of(context).formatFullDate(picked);

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xxl,
      ),
      title: Text(widget.title),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Field(
                label: l10n.year,
                value: _year,
                items: [for (var y = _min.year; y <= _max.year; y++) y],
                text: _digits,
                onChanged: (v) => _set(() => _year = v),
              ),
              const SizedBox(height: AppSpacing.md),
              _Field(
                label: l10n.month,
                value: _month,
                items: [for (var m = _firstMonth; m <= _lastMonth; m++) m],
                text: (m) => _cal.monthName(m, languageCode: lang),
                onChanged: (v) => _set(() => _month = v),
              ),
              const SizedBox(height: AppSpacing.md),
              _Field(
                label: l10n.day,
                value: _day,
                items: [for (var d = _firstDay; d <= _lastDay; d++) d],
                text: _digits,
                onChanged: (v) => _set(() => _day = v),
              ),
              const SizedBox(height: AppSpacing.lg),
              // The choice read back as a date, with its A.D. equivalent —
              // many people know their birthday in one calendar only.
              Text(
                '${_cal.monthName(_month, languageCode: lang)} '
                '${_digits(_day)}, ${_digits(_year)}',
                style: context.textTheme.titleSmall,
              ),
              Text(
                context.usesDevanagariDigits
                    ? gregorian.toDevanagariDigits()
                    : gregorian,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        PrimaryButton(
          label: widget.confirmLabel ?? l10n.ok,
          expanded: false,
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          onPressed: () => Navigator.of(context).pop(picked),
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.value,
    required this.items,
    required this.text,
    required this.onChanged,
  });

  final String label;
  final int value;
  final List<int> items;
  final String Function(int) text;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          color: context.colors.textSecondary,
        ),
      ),
      const SizedBox(height: AppSpacing.xs),
      DropdownButtonFormField<int>(
        // Keyed by value and range because a form field reads its value only
        // once. Without this, a day list that shrank under it kept showing —
        // and asserting on — a day that was no longer offered.
        key: ValueKey('$label|$value|${items.first}-${items.last}'),
        initialValue: value,
        isExpanded: true,
        menuMaxHeight: 320,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        items: [
          for (final item in items)
            DropdownMenuItem<int>(value: item, child: Text(text(item))),
        ],
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    ],
  );
}
