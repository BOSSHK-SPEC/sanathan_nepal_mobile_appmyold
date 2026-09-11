import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../calendar/presentation/cubit/calendar_cubit.dart';
import '../../../calendar/presentation/widgets/calendar_view_toggle.dart';
import '../../../calendar/presentation/widgets/month_calendar_view.dart';
import '../../../calendar/presentation/widgets/month_year_picker_sheet.dart';
import '../../domain/entities/metal_rates.dart';
import 'today_summary_column.dart';

/// Top block of the Home page (Figma "CALENDER" + "Group 35645"):
/// left = today's summary column, right = compact month grid, and the
/// "default calendar view" traditional/AD toggle row underneath.
///
/// Owns one [CalendarCubit] (opened in the region's default view mode –
/// B.S. in Nepal, Gregorian in India) shared by the grid and the toggle row.
class HomeCalendarHeader extends StatelessWidget {
  const HomeCalendarHeader({required this.now, super.key, this.metalRates});

  final DateTime now;
  final MetalRates? metalRates;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarCubit>(
      create: (_) => sl<CalendarCubit>(param1: null)..load(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TodaySummaryColumn(now: now, metalRates: metalRates),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(
                  child: MonthCalendarView(compact: true, showHeader: false),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            BlocBuilder<CalendarCubit, CalendarState>(
              builder: (context, state) {
                final cubit = context.read<CalendarCubit>();
                return CalendarViewToggle(
                  mode: state.viewMode,
                  year: state.year,
                  month: state.month,
                  onModeChanged: cubit.setViewMode,
                  onPrevious: cubit.previousMonth,
                  onNext: cubit.nextMonth,
                  onPickMonth: () async {
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
