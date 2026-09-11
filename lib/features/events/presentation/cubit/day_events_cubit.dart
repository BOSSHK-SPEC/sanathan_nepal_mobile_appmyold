import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../../domain/entities/event_filter.dart';
import '../../domain/usecases/get_events.dart';
import '../../domain/usecases/toggle_checklist_item.dart';
import '../../../../core/state/app_cubit.dart';

part 'day_events_cubit.freezed.dart';
part 'day_events_state.dart';

/// Loads every event (festivals, personal events, to-dos) of one civil day –
/// backs [EventsForDateSection] (date converter result, calendar popups…).
class DayEventsCubit extends AppCubit<DayEventsState> {
  DayEventsCubit({
    required GetEvents getEvents,
    required ToggleChecklistItem toggleChecklistItem,
    DateTime? initialDate,
  }) : _getEvents = getEvents,
       _toggle = toggleChecklistItem,
       super(DayEventsState(date: _midnight(initialDate ?? DateTime.now())));

  final GetEvents _getEvents;
  final ToggleChecklistItem _toggle;

  static DateTime _midnight(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Loads the events of [date] (defaults to the current state date).
  Future<void> load([DateTime? date]) async {
    final day = _midnight(date ?? state.date);
    emit(state.copyWith(date: day, events: state.events.toLoading()));
    final result = await _getEvents(EventFilter.onDay(day));
    if (isClosed) return;
    emit(
      state.copyWith(
        events: result.fold(state.events.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Toggles one checklist entry of a listed to-do / event.
  Future<void> toggleChecklist(String eventId, String itemId) async {
    final result = await _toggle(
      ToggleChecklistParams(eventId: eventId, itemId: itemId),
    );
    if (isClosed) return;
    emit(
      result.fold(
        (f) => state.copyWith(actionFailure: f),
        (updated) => state.copyWith(
          events: state.events.map(
            (list) =>
                list.map((e) => e.id == updated.id ? updated : e).toList(),
          ),
          actionFailure: null,
        ),
      ),
    );
  }
}
