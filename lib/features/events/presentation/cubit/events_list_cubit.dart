import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../../domain/entities/event_filter.dart';
import '../../domain/usecases/delete_event.dart';
import '../../domain/usecases/get_events.dart';
import '../../domain/usecases/toggle_checklist_item.dart';
import '../../../../core/state/app_cubit.dart';

part 'events_list_cubit.freezed.dart';
part 'events_list_state.dart';

/// Drives the events page (tabs + chips + list) and the compact Home section.
class EventsListCubit extends AppCubit<EventsListState> {
  EventsListCubit({
    required GetEvents getEvents,
    required DeleteEvent deleteEvent,
    required ToggleChecklistItem toggleChecklistItem,
  }) : _getEvents = getEvents,
       _deleteEvent = deleteEvent,
       _toggle = toggleChecklistItem,
       super(const EventsListState());

  final GetEvents _getEvents;
  final DeleteEvent _deleteEvent;
  final ToggleChecklistItem _toggle;

  /// Loads the list for the current filter (optionally switching [group]).
  Future<void> load({EventGroup? group}) async {
    final switching = group != null && group != state.group;
    emit(
      state.copyWith(
        events: state.events.toLoading(),
        group: group ?? state.group,
        category: switching ? null : state.category,
        onlyImportant: switching ? false : state.onlyImportant,
        focusedEventId: switching ? null : state.focusedEventId,
      ),
    );
    await _refresh();
  }

  /// To-Do chips: show only [eventId] (`null` = all to-dos). Client-side –
  /// the loaded list is kept so the chips stay in place.
  void focusEvent(String? eventId) =>
      emit(state.copyWith(focusedEventId: eventId));

  Future<void> selectGroup(EventGroup group) => load(group: group);

  /// Chip selection – `null` means "All".
  Future<void> selectCategory(EventCategory? category) async {
    emit(
      state.copyWith(
        events: state.events.toLoading(),
        category: category,
        onlyImportant: false,
      ),
    );
    await _refresh();
  }

  /// "Important" chip of the festivals tab.
  Future<void> selectImportant() async {
    emit(
      state.copyWith(
        events: state.events.toLoading(),
        category: null,
        onlyImportant: true,
      ),
    );
    await _refresh();
  }

  Future<void> toggleHolidays() async {
    emit(state.copyWith(onlyHolidays: !state.onlyHolidays));
    await _refresh();
  }

  Future<void> toggleVrat() async {
    emit(state.copyWith(onlyVrat: !state.onlyVrat));
    await _refresh();
  }

  Future<void> delete(String id) async {
    final result = await _deleteEvent(id);
    emit(
      result.fold(
        (f) => state.copyWith(actionFailure: f),
        (_) => state.copyWith(
          events: state.events.map(
            (list) => list.where((e) => e.id != id).toList(),
          ),
          actionFailure: null,
        ),
      ),
    );
  }

  /// Toggles a checklist entry of a listed event (checklist popup).
  Future<void> toggleChecklist(String eventId, String itemId) async {
    final result = await _toggle(
      ToggleChecklistParams(eventId: eventId, itemId: itemId),
    );
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

  Future<void> _refresh() async {
    final result = await _getEvents(state.filter);
    emit(
      state.copyWith(
        events: result.fold(state.events.toFailed, LoadState.loaded),
      ),
    );
  }
}
