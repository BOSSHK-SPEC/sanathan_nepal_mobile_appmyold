import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../calendar/domain/entities/calendar_view_mode.dart';
import '../../../calendar/presentation/cubit/calendar_cubit.dart';
import '../../../calendar/presentation/utils/active_calendar_view_mode.dart';
import '../../../calendar/presentation/utils/calendar_format.dart';
import '../../../calendar/presentation/widgets/month_calendar_view.dart';
import '../../../calendar/presentation/widgets/month_year_picker_sheet.dart';
import '../../domain/entities/panchanga.dart';
import '../cubit/panchanga_cubit.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_format.dart';

/// Top block of the Panchanga page (Figma "Group 35827"): left = selected
/// day summary (month/year, day badge with weekday and sunrise/sunset,
/// Gregorian date), right = compact month grid; underneath the
/// "‹ फागुन, २०७९ ⌄ ›" month row. Tapping a day in the grid selects it in the
/// [PanchangaCubit] found above; the grid follows the cubit's date.
class PanchangaDayHeader extends StatelessWidget {
  const PanchangaDayHeader({
    required this.date,
    super.key,
    this.panchanga,
    this.showCalendar = true,
  });

  final DateTime date;

  /// Loaded panchanga of [date] (sunrise / sunset in the badge).
  final Panchanga? panchanga;

  /// Hide the month grid (compact embeds / tests without a calendar cubit).
  final bool showCalendar;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final summary = _DaySummary(date: date, panchanga: panchanga);
    final card = Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        gradient: colors.cardGradient,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: showCalendar ? _WithCalendar(summary: summary) : summary,
    );
    if (!showCalendar) return card;
    return BlocProvider<CalendarCubit>(
      create: (_) => sl<CalendarCubit>(param1: null)..jumpToDate(date),
      child: BlocListener<PanchangaCubit, PanchangaState>(
        listenWhen: (a, b) => a.date != b.date,
        listener: (context, state) =>
            context.read<CalendarCubit>().jumpToDate(state.date),
        child: card,
      ),
    );
  }
}

class _WithCalendar extends StatelessWidget {
  const _WithCalendar({required this.summary});
  final Widget summary;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final lang = context.languageCode;
    final calendar = context.traditionalCalendar;
    final s = PanchangaStrings.of(context);
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final cubit = context.read<CalendarCubit>();
        final title = state.viewMode == CalendarViewMode.traditional
            ? CalendarFormat.traditionalMonthTitle(
                calendar,
                state.year,
                state.month,
                languageCode: lang,
              ).replaceFirst(RegExp(r',\s*'), ', ')
            : CalendarFormat.adMonthTitle(
                state.year,
                state.month,
                languageCode: lang,
              );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                summary,
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: MonthCalendarView(
                    compact: true,
                    showHeader: false,
                    highlightedDate: context.read<PanchangaCubit>().state.date,
                    onDayTap: (day) =>
                        context.read<PanchangaCubit>().selectDate(day.ad),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () async {
                    final picked = await MonthYearPickerSheet.show(
                      context,
                      mode: state.viewMode,
                      year: state.year,
                      month: state.month,
                    );
                    if (picked != null) {
                      await cubit.jumpTo(
                        year: picked.year,
                        month: picked.month,
                      );
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 14,
                        color: colors.textSecondary,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  tooltip: s.previousMonth,
                  onPressed: cubit.previousMonth,
                  icon: Icon(Icons.chevron_left, color: colors.accent),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 28,
                    minHeight: 28,
                  ),
                ),
                IconButton(
                  tooltip: s.todayLabel,
                  onPressed: () {
                    context.read<PanchangaCubit>().today();
                    cubit.goToToday();
                  },
                  icon: Icon(
                    Icons.circle_outlined,
                    size: 12,
                    color: colors.accent,
                  ),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 24,
                    minHeight: 28,
                  ),
                ),
                IconButton(
                  tooltip: s.nextMonth,
                  onPressed: cubit.nextMonth,
                  icon: Icon(Icons.chevron_right, color: colors.accent),
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 28,
                    minHeight: 28,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// Left column: "फागुन,२०७९", day badge (day number + weekday, sunrise /
/// sunset) and the secondary (Gregorian or Saka) date.
class _DaySummary extends StatelessWidget {
  const _DaySummary({required this.date, required this.panchanga});
  final DateTime date;
  final Panchanga? panchanga;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final config = context.regionConfig;
    final lang = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final calendar = config.calendar;
    final s = PanchangaStrings.of(context);
    final t = calendar.fromGregorian(date);
    // Follows the month grid beside it, not the region: the region only
    // decides what the calendar opens in. Without a grid (`showCalendar:
    // false`) there is no cubit and this is the region's default.
    final traditionalPrimary =
        context.activeCalendarViewMode == CalendarViewMode.traditional;
    final String monthYear;
    final String day;
    final String secondary;
    if (traditionalPrimary) {
      monthYear = CalendarFormat.traditionalMonthTitle(
        calendar,
        t.year,
        t.month,
        languageCode: lang,
      );
      day = PanchangaFormat.digits('${t.day}', devanagari: devanagari);
      secondary = PanchangaFormat.adDate(date, devanagari: false);
    } else {
      monthYear = CalendarFormat.adMonthTitle(
        date.year,
        date.month,
        languageCode: lang,
      );
      day = PanchangaFormat.digits('${date.day}', devanagari: devanagari);
      secondary = PanchangaFormat.traditionalDate(
        date,
        calendar: calendar,
        languageCode: lang,
      );
    }
    final p = panchanga;
    return SizedBox(
      width: 84,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            monthYear,
            style: context.textTheme.titleSmall?.copyWith(
              color: colors.accent,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: colors.accent,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      Text(
                        s.weekdays[date.weekday % 7],
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (p != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        size: 10,
                        color: colors.accent,
                      ),
                      Text(
                        PanchangaFormat.hm(p.sunrise, devanagari: devanagari),
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 8,
                        ),
                      ),
                      Icon(
                        Icons.wb_twilight_outlined,
                        size: 10,
                        color: colors.accent,
                      ),
                      Text(
                        PanchangaFormat.hm(p.sunset, devanagari: devanagari),
                        style: context.textTheme.labelSmall?.copyWith(
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            secondary,
            style: context.textTheme.labelSmall?.copyWith(fontSize: 10),
            maxLines: 2,
          ),
          if (p != null)
            Text(
              p.tithiTitle(nepali: devanagari),
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10,
                color: colors.textSecondary,
              ),
              maxLines: 2,
            ),
        ],
      ),
    );
  }
}
