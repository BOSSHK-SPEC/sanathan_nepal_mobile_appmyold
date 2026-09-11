import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../calendar/domain/entities/calendar_view_mode.dart';
import '../../../calendar/presentation/cubit/calendar_cubit.dart';
import '../../../calendar/presentation/widgets/month_calendar_view.dart';
import '../cubit/event_form_cubit.dart';
import '../l10n/events_strings.dart';
import '../utils/event_date_format.dart';
import 'form_widgets.dart';

/// "कार्यक्रम मिति" – B.S / A.D / Tithi radios + read-only date box, the
/// inline month calendar (Figma "Group 35926": tap a day to pick the date,
/// ‹ › month navigation, selected day highlighted) and the optional time row.
///
/// The calendar opens in the radio's calendar system (traditional for B.S. /
/// Tithi, Gregorian for A.D.) on the month of the current date.
class EventDateSection extends StatelessWidget {
  const EventDateSection({
    required this.state,
    required this.onModeChanged,
    required this.onDateChanged,
    required this.onPickTime,
    required this.onClearTime,
    super.key,
  });

  final EventFormState state;
  final ValueChanged<DateDisplayMode> onModeChanged;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onPickTime;
  final VoidCallback onClearTime;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final devanagari = context.usesDevanagariDigits;
    final lang = context.languageCode;
    final calendar = context.traditionalCalendar;
    // "B.S." in Nepal, "Saka" in India – the region's traditional calendar.
    final labels = {
      DateDisplayMode.bs: calendar.eraLabel(languageCode: lang),
      DateDisplayMode.ad: s.ad,
      DateDisplayMode.tithi: s.tithi,
    };
    final dateText = switch (state.dateMode) {
      DateDisplayMode.ad => EventDateFormat.adIso(state.date),
      DateDisplayMode.bs => EventDateFormat.traditionalIso(
        state.date,
        calendar: calendar,
        devanagari: devanagari,
      ),
      DateDisplayMode.tithi => EventDateFormat.traditional(
        state.date,
        calendar: calendar,
        languageCode: lang,
      ),
    };
    final viewMode = state.dateMode == DateDisplayMode.ad
        ? CalendarViewMode.gregorian
        : CalendarViewMode.traditional;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(s.eventDate),
        Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: AppSpacing.xs,
                children: [
                  for (final m in DateDisplayMode.values)
                    AppRadioOption<DateDisplayMode>(
                      value: m,
                      groupValue: state.dateMode,
                      label: labels[m]!,
                      textStyle: context.textTheme.labelSmall,
                      onChanged: onModeChanged,
                    ),
                ],
              ),
            ),
            SelectedDateBox(value: dateText),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: BlocProvider<CalendarCubit>(
            // Re-created only when the calendar system changes; day taps and
            // month navigation keep the same cubit.
            key: ValueKey(viewMode),
            create: (_) =>
                sl<CalendarCubit>(param1: viewMode)..jumpToDate(state.date),
            child: MonthCalendarView(
              compact: true,
              highlightedDate: state.date,
              onDayTap: (day) => onDateChanged(day.ad),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(child: FormLabel(s.eventTime)),
            PickerBox(
              value: state.time?.format12h() ?? s.pickTime,
              width: 140,
              icon: Icons.access_time,
              onTap: onPickTime,
            ),
            if (state.time != null)
              IconButton(
                visualDensity: VisualDensity.compact,
                tooltip: s.cancel,
                icon: const Icon(Icons.close, size: 16),
                onPressed: onClearTime,
              ),
          ],
        ),
      ],
    );
  }
}

/// Read-only "२०७९-१२-०२ ⌄" box next to the date radios (Figma "Group 35930")
/// mirroring the day picked on the inline calendar.
class SelectedDateBox extends StatelessWidget {
  const SelectedDateBox({required this.value, super.key, this.width = 140});
  final String value;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: width,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium,
            ),
          ),
          Icon(Icons.expand_more, size: 14, color: colors.textMuted),
        ],
      ),
    );
  }
}
