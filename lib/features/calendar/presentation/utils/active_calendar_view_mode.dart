import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../cubit/calendar_cubit.dart';

/// Which calendar leads the dates printed *around* a month grid.
///
/// A screen that shows a calendar also prints dates beside and below it — a
/// today column, list rows, event cards. Those have to follow the grid's
/// B.S./Saka ↔ A.D. toggle, not the region: the region only decides what the
/// calendar *opens* in. Reading `config.isIndia` or
/// `config.defaultCalendarViewMode` instead is why a switch converted the grid
/// and left every date next to it in the other calendar.
extension ActiveCalendarViewMode on BuildContext {
  /// The view mode of the nearest [CalendarCubit], rebuilding the caller when
  /// it changes; the region's default when no calendar is above — a date
  /// converter result or a details page has no toggle to follow.
  ///
  /// Call from `build` only.
  CalendarViewMode get activeCalendarViewMode {
    if (!hasCalendarCubitAbove) return regionConfig.defaultCalendarViewMode;
    return select<CalendarCubit, CalendarViewMode>((c) => c.state.viewMode);
  }

  /// Whether the active mode leads with the Gregorian date.
  bool get gregorianLeads =>
      activeCalendarViewMode == CalendarViewMode.gregorian;

  /// Whether a [CalendarCubit] is provided above — lets a widget reuse the
  /// page's calendar instead of creating a second one that nothing else sees.
  bool get hasCalendarCubitAbove {
    try {
      BlocProvider.of<CalendarCubit>(this);
      return true;
    } on Object {
      return false;
    }
  }
}
