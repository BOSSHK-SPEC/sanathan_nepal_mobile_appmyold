import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../cubit/calendar_cubit.dart';
import '../l10n/calendar_strings.dart';
import 'calendar_grid.dart';
import 'calendar_header.dart';
import 'calendar_view_toggle.dart';
import 'date_detail_sheet.dart';
import 'month_year_picker_sheet.dart';

/// Self-contained month calendar (header + weekday row + 6×7 grid).
///
/// Drop it anywhere – it creates and owns its own [CalendarCubit] via GetIt
/// unless a [CalendarCubit] is already provided above it in the tree
/// (`BlocProvider<CalendarCubit>`), in which case that one is reused.
///
/// The grid follows the active region: traditional calendar (B.S. / Saka),
/// weekend day, festivals and the default view mode (Nepal opens in B.S.,
/// India in Gregorian) all come from `RegionConfig`.
///
/// ```dart
/// // Home page – compact embed with the traditional/AD toggle row:
/// MonthCalendarView(compact: true, showViewToggle: true)
///
/// // Full Patro page look:
/// MonthCalendarView()
///
/// // Custom tap handling (default opens the date popup):
/// MonthCalendarView(onDayTap: (day) => ...)
/// ```
class MonthCalendarView extends StatelessWidget {
  const MonthCalendarView({
    super.key,
    this.compact = false,
    this.showHeader = true,
    this.showHeaderControls = true,
    this.showViewToggle = false,
    this.showViewToggleLabel = true,
    this.initialViewMode,
    this.onDayTap,
    this.padding = EdgeInsets.zero,
    this.rowHeight,
    this.highlightedDate,
  });

  /// Smaller typography / row height for embedding (home page).
  final bool compact;

  /// Month title + prev/today/next controls.
  final bool showHeader;
  final bool showHeaderControls;

  /// "पूर्वनिर्धारित क्यालेन्डर दृश्य ◉ वि.सं. ○ ई.सं." row under the grid.
  final bool showViewToggle;
  final bool showViewToggleLabel;

  /// Initial view mode; `null` = the region's default.
  final CalendarViewMode? initialViewMode;

  /// Called on cell tap; defaults to opening [DateDetailSheet].
  final ValueChanged<CalendarDay>? onDayTap;
  final EdgeInsets padding;
  final double? rowHeight;

  /// Cell to outline (e.g. the converted date) when no day is selected.
  final DateTime? highlightedDate;

  @override
  Widget build(BuildContext context) {
    final existing = _maybeCubit(context);
    if (existing != null) return _Body(view: this);
    return BlocProvider<CalendarCubit>(
      create: (_) => sl<CalendarCubit>(param1: initialViewMode)..load(),
      child: _Body(view: this),
    );
  }

  static CalendarCubit? _maybeCubit(BuildContext context) {
    try {
      return BlocProvider.of<CalendarCubit>(context);
    } on Object {
      return null;
    }
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.view});
  final MonthCalendarView view;

  Future<void> _pickMonth(BuildContext context, CalendarState state) async {
    final cubit = context.read<CalendarCubit>();
    final picked = await MonthYearPickerSheet.show(
      context,
      mode: state.viewMode,
      year: state.year,
      month: state.month,
    );
    if (picked != null) {
      await cubit.jumpTo(year: picked.year, month: picked.month);
    }
  }

  void _onDayTap(BuildContext context, CalendarDay day) {
    context.read<CalendarCubit>().selectDay(day);
    if (view.onDayTap != null) {
      view.onDayTap!(day);
    } else {
      DateDetailSheet.show(context, day);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = CalendarStrings.of(context);
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final cubit = context.read<CalendarCubit>();
        final month = state.calendarMonth.dataOrNull;
        final gridHeight =
            (view.rowHeight ?? (view.compact ? 27.0 : 40.0)) * 6 +
            (view.compact ? 22 : 36);
        return Padding(
          padding: view.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (view.showHeader) ...[
                CalendarHeader(
                  year: state.year,
                  month: state.month,
                  mode: state.viewMode,
                  calendarMonth: month,
                  compact: view.compact,
                  showControls: view.showHeaderControls,
                  onPrevious: cubit.previousMonth,
                  onNext: cubit.nextMonth,
                  onToday: cubit.goToToday,
                  onPickMonth: () => _pickMonth(context, state),
                ),
                SizedBox(height: view.compact ? AppSpacing.xs : AppSpacing.sm),
              ],
              if (month == null)
                SizedBox(
                  height: gridHeight,
                  child: switch (state.calendarMonth) {
                    Failed(:final failure) => ErrorView(
                      message: failure.message,
                      onRetry: cubit.load,
                    ),
                    _ => const LoadingView(),
                  },
                )
              else
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: state.calendarMonth.isLoading ? 0.5 : 1,
                  child: CalendarGrid(
                    month: month,
                    compact: view.compact,
                    rowHeight: view.rowHeight,
                    selectedDay: state.selectedDay,
                    highlightedDate: view.highlightedDate,
                    onDayTap: (d) => _onDayTap(context, d),
                  ),
                ),
              if (view.showViewToggle) ...[
                const SizedBox(height: AppSpacing.sm),
                CalendarViewToggle(
                  mode: state.viewMode,
                  year: state.year,
                  month: state.month,
                  showLabel: view.showViewToggleLabel,
                  onModeChanged: cubit.setViewMode,
                  onPrevious: cubit.previousMonth,
                  onNext: cubit.nextMonth,
                  onPickMonth: () => _pickMonth(context, state),
                ),
              ],
              if (state.calendarMonth.isFailed && month != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Text(
                    state.calendarMonth.errorMessage ?? strings.loadFailed,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colors.error,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
