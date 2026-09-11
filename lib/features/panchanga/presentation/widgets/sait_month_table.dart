import 'package:flutter/material.dart';

import '../../../../core/calendar/traditional_calendar.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/suva_sait.dart';
import '../l10n/sait_strings.dart';
import 'panchanga_format.dart';

/// Icon shown before a sait category (keyed by `SuvaSait.id`; Figma dark
/// spec: rice / pooja / wedding / agni / store / house / relocation / like).
IconData saitIcon(String id) => switch (id) {
  'pasni' => Icons.rice_bowl_outlined,
  'rudri' => Icons.temple_hindu_outlined,
  'bibaha' => Icons.favorite_outline,
  'hom' => Icons.local_fire_department_outlined,
  'shop' => Icons.storefront_outlined,
  'foundation' => Icons.foundation,
  'shifting' => Icons.home_work_outlined,
  'bratabandha' => Icons.volunteer_activism_outlined,
  _ => Icons.event_available_outlined,
};

/// Figma "MONTHY SAIT": one row per category – icon + label on the left,
/// the days of the traditional month [year]/[month] as small circular chips
/// on the right ("१ ४ ७ ९ १० २० २९ ३०"). Optional [monthStrip] (yearly view)
/// sits above the rows.
class SaitMonthTable extends StatelessWidget {
  const SaitMonthTable({
    required this.saits,
    required this.year,
    required this.month,
    super.key,
    this.monthStrip,
    this.highlightDay,
  });

  final List<SuvaSait> saits;
  final int year;
  final int month;
  final Widget? monthStrip;

  /// Day of [month] to tint as "selected" (the panchanga date when it falls
  /// inside the browsed month).
  final int? highlightDay;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final calendar = context.traditionalCalendar;
    final config = context.regionConfig;
    final devanagari = context.usesDevanagariDigits;
    final s = SaitStrings.of(context);
    final rows = [
      for (final sait in saits) (sait, sait.daysIn(calendar, year, month)),
    ];
    final empty = rows.every((r) => r.$2.isEmpty);
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceVariant.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ?monthStrip,
          if (empty)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                s.noSaitInMonth(config),
                textAlign: TextAlign.center,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ),
          for (final (sait, days) in rows)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 112,
                    child: Row(
                      children: [
                        Icon(saitIcon(sait.id), size: 14, color: colors.accent),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            sait.title(nepali: devanagari),
                            style: context.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: [
                        for (final d in days)
                          _DayChip(
                            label: PanchangaFormat.digits(
                              '$d',
                              devanagari: devanagari,
                            ),
                            selected: d == highlightDay,
                          ),
                        if (days.isEmpty)
                          Text(
                            '—',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                      ],
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

class _DayChip extends StatelessWidget {
  const _DayChip({required this.label, required this.selected});
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? colors.accent : colors.surface,
        border: Border.all(color: selected ? colors.accent : colors.border),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          fontSize: 10,
          color: selected ? colors.onPrimary : colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Horizontal strip of the twelve traditional month names with ‹ › arrows
/// (Figma yearly table header "‹ Baisakh Jestha Ashar … ›").
class SaitMonthStrip extends StatelessWidget {
  const SaitMonthStrip({
    required this.calendar,
    required this.selectedMonth,
    required this.onSelect,
    super.key,
  });

  final TraditionalCalendar calendar;
  final int selectedMonth;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = SaitStrings.of(context);
    final config = context.regionConfig;
    final names = calendar.monthNames(languageCode: context.languageCode);
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: colors.chipBackground,
        border: Border(bottom: BorderSide(color: colors.border)),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: s.previousMonth(config),
            onPressed: selectedMonth > 1
                ? () => onSelect(selectedMonth - 1)
                : null,
            icon: const Icon(Icons.chevron_left, size: 16),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              itemCount: names.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, i) {
                final selected = i + 1 == selectedMonth;
                return InkWell(
                  onTap: () => onSelect(i + 1),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selected ? colors.accent : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      names[i],
                      style: context.textTheme.labelSmall?.copyWith(
                        color: selected ? colors.accent : colors.textPrimary,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            tooltip: s.nextMonth(config),
            onPressed: selectedMonth < 12
                ? () => onSelect(selectedMonth + 1)
                : null,
            icon: const Icon(Icons.chevron_right, size: 16),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
        ],
      ),
    );
  }
}
