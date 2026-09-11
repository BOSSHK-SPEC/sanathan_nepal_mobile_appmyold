import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../calendar/presentation/widgets/month_calendar_view.dart';
import '../../../panchanga/presentation/cubit/panchanga_cubit.dart';
import '../l10n/events_strings.dart';
import '../utils/event_date_format.dart';
import 'today_date_column.dart';

/// Top card of the events page (Figma "Events Page" → Rectangle 2210 +
/// "Group 35827"): today's date column on the left (month/year, big day,
/// weekday, sunrise/sunset, secondary date) and the compact month grid with
/// the traditional/AD toggle on the right.
///
/// Sunrise / sunset come from the panchanga feature when it is registered
/// (`sl<PanchangaCubit>()`); otherwise the two lines are simply omitted.
class EventsHeaderCard extends StatelessWidget {
  const EventsHeaderCard({super.key, this.now});

  /// Injectable clock (tests); defaults to `DateTime.now()`.
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final today = now ?? DateTime.now();
    final hasPanchanga = sl.isRegistered<PanchangaCubit>();
    final child = Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TodayColumn(today: today, hasPanchanga: hasPanchanga),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: MonthCalendarView(
                compact: true,
                showHeader: false,
                // The B.S./A.D. toggle row needs ~230 px next to the today
                // column – dropped on very narrow phones (≈ < 350 px screens).
                showViewToggle: constraints.maxWidth >= 320,
                showViewToggleLabel: false,
              ),
            ),
          ],
        ),
      ),
    );
    if (!hasPanchanga) return child;
    return BlocProvider<PanchangaCubit>(
      create: (_) => sl<PanchangaCubit>()..selectDate(today),
      child: child,
    );
  }
}

class _TodayColumn extends StatelessWidget {
  const _TodayColumn({required this.today, required this.hasPanchanga});
  final DateTime today;
  final bool hasPanchanga;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final config = context.regionConfig;
    final lang = context.languageCode;
    final devanagari = context.usesDevanagariDigits;
    final traditional = config.calendar.fromGregorian(today);
    final day = config.isIndia ? today.day : traditional.day;
    final secondary = config.isIndia
        ? EventDateFormat.traditionalLine(
            today,
            config: config,
            languageCode: lang,
          )
        : EventDateFormat.ad(today);
    final panchanga = hasPanchanga
        ? context.watch<PanchangaCubit>().state.panchanga.dataOrNull
        : null;
    return TodayDateColumn(
      monthYear: EventDateFormat.primaryMonthYear(
        today,
        config: config,
        languageCode: lang,
      ),
      day: EventDateFormat.digits('$day', devanagari: devanagari),
      weekday: EventDateFormat.weekday(today, weekdays: s.weekdays),
      secondaryDate: secondary,
      sunrise: panchanga == null
          ? null
          : EventDateFormat.time(panchanga.sunrise, devanagari: devanagari),
      sunset: panchanga == null
          ? null
          : EventDateFormat.time(panchanga.sunset, devanagari: devanagari),
    );
  }
}
