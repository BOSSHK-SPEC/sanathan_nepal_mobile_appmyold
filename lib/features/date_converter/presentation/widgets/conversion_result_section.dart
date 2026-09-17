import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../calendar/domain/entities/calendar_view_mode.dart';
import '../../../calendar/presentation/cubit/calendar_cubit.dart';
import '../../../calendar/presentation/utils/calendar_format.dart';
import '../../../calendar/presentation/widgets/month_calendar_view.dart';
import '../../domain/entities/conversion_direction.dart';
import '../../domain/entities/converted_date.dart';
import '../l10n/date_converter_strings.dart';

/// "[source card] = [target card]  |  mini month grid" block under the
/// converter (Figma 555:1891, groups 36162 / 36165 / CALENDER).
///
/// The traditional card shows the region's calendar (B.S. in Nepal, Saka –
/// plus the Vikram Samvat year – in India); the mini grid opens in the
/// region's default view mode on the converted month.
class ConversionResultSection extends StatelessWidget {
  const ConversionResultSection({required this.result, super.key});

  final ConvertedDate result;

  @override
  Widget build(BuildContext context) {
    final languageCode = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final config = context.regionConfig;
    final calendar = config.calendar;
    final strings = DateConverterStrings.of(context);
    final traditionalTitle = CalendarFormat.traditionalMonthTitle(
      calendar,
      result.traditional.year,
      result.traditional.month,
      languageCode: languageCode,
      era: config.labelsTraditionalEra,
    ).replaceFirst(RegExp(r',\s*'), ', ');
    final adTitle = CalendarFormat.adMonthTitle(
      result.ad.year,
      result.ad.month,
      languageCode: 'en',
    );
    final weekday = CalendarFormat.weekdayFull(
      result.ad,
      languageCode: languageCode,
    );
    final showVikram = config.samvatLabels.contains(SamvatKind.vikram);
    final traditionalCard = _DateCard(
      title: traditionalTitle,
      day: CalendarFormat.digits(
        result.traditional.day,
        devanagari: devanagari,
      ),
      weekday: weekday,
      // "≈" marks the on-device estimate, shown only when the server's
      // calculation for the day could not be loaded.
      sunrise:
          '${result.panchanga.isApproximate ? '≈' : ''}'
          '${CalendarFormat.time(result.panchanga.sunrise, devanagari: devanagari)}',
      sunset:
          '${result.panchanga.isApproximate ? '≈' : ''}'
          '${CalendarFormat.time(result.panchanga.sunset, devanagari: devanagari)}',
      holiday: result.isHoliday,
      footnote: showVikram
          ? '${strings.vikramSamvat} '
                '${CalendarFormat.digits(result.vikramSamvat, devanagari: devanagari)}'
          : null,
    );
    final adCard = _DateCard(
      title: adTitle,
      day: '${result.ad.day}',
      weekday: CalendarFormat.weekdayFull(result.ad, languageCode: 'en'),
      holiday: result.isHoliday,
      trailing: _ReminderButton(
        label: strings.addEventReminder,
        // New-event form pre-selected on the converted day.
        onTap: () => context.push(AppRoutes.eventCreate, extra: result.ad),
      ),
    );
    final traditionalFirst =
        result.direction == ConversionDirection.traditionalToGregorian;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 104,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              traditionalFirst ? traditionalCard : adCard,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Center(
                  child: Text('=', style: context.textTheme.headlineLarge),
                ),
              ),
              traditionalFirst ? adCard : traditionalCard,
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: BlocProvider<CalendarCubit>(
            key: ValueKey(result.ad),
            create: (_) =>
                sl<CalendarCubit>(param1: null)..jumpToDate(result.ad),
            child: MonthCalendarView(
              compact: true,
              showHeader: false,
              highlightedDate: result.ad,
              rowHeight: 26,
            ),
          ),
        ),
      ],
    );
  }
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.title,
    required this.day,
    required this.weekday,
    required this.holiday,
    this.sunrise,
    this.sunset,
    this.trailing,
    this.footnote,
  });

  final String title;
  final String day;
  final String weekday;
  final bool holiday;
  final String? sunrise;
  final String? sunset;
  final Widget? trailing;

  /// Small line under the box (e.g. "Vikram Samvat 2083").
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(fontSize: 15),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        day,
                        maxLines: 1,
                        style: context.textTheme.displayMedium?.copyWith(
                          fontSize: 26,
                          height: 1.1,
                          color: holiday ? colors.holiday : colors.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      weekday,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (sunrise != null && sunset != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _SunMini(icon: Icons.wb_twilight, time: sunrise!),
                    _SunMini(icon: Icons.nightlight_outlined, time: sunset!),
                  ],
                )
              else
                ?trailing,
            ],
          ),
        ),
        if (footnote != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              footnote!,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 9,
                color: colors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}

class _SunMini extends StatelessWidget {
  const _SunMini({required this.icon, required this.time});
  final IconData icon;
  final String time;
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 10, color: context.colors.iconMuted),
      Text(time, style: context.textTheme.labelSmall?.copyWith(fontSize: 8)),
    ],
  );
}

class _ReminderButton extends StatelessWidget {
  const _ReminderButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(3),
      child: Container(
        width: 30,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
        decoration: BoxDecoration(
          color: colors.chipBackground,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 6,
                height: 1.1,
              ),
            ),
            Icon(Icons.event_available, size: 14, color: colors.icon),
          ],
        ),
      ),
    );
  }
}
