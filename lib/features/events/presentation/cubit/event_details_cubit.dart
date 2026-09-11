import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/event.dart';
import '../../domain/usecases/delete_event.dart';
import '../../domain/usecases/get_event_by_id.dart';
import '../../domain/usecases/toggle_checklist_item.dart';
import '../../../../core/state/app_cubit.dart';

part 'event_details_cubit.freezed.dart';
part 'event_details_state.dart';

/// Loads one event, toggles its checklist and deletes it.
class EventDetailsCubit extends AppCubit<EventDetailsState> {
  EventDetailsCubit({
    required GetEventById getEventById,
    required ToggleChecklistItem toggleChecklistItem,
    required DeleteEvent deleteEvent,
  }) : _getEventById = getEventById,
       _toggle = toggleChecklistItem,
       _delete = deleteEvent,
       super(const EventDetailsState());

  final GetEventById _getEventById;
  final ToggleChecklistItem _toggle;
  final DeleteEvent _delete;

  Future<void> load(String id) async {
    emit(state.copyWith(event: state.event.toLoading()));
    final result = await _getEventById(id);
    emit(
      state.copyWith(
        event: result.fold(state.event.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> toggleChecklist(String itemId) async {
    final event = state.event.dataOrNull;
    if (event == null) return;
    final result = await _toggle(
      ToggleChecklistParams(eventId: event.id, itemId: itemId),
    );
    emit(
      result.fold(
        (f) => state.copyWith(actionFailure: f),
        (updated) => state.copyWith(
          event: LoadState.loaded(updated),
          actionFailure: null,
        ),
      ),
    );
  }

  Future<void> delete() async {
    final event = state.event.dataOrNull;
    if (event == null || state.deletion.isLoading) return;
    emit(state.copyWith(deletion: state.deletion.toLoading()));
    final result = await _delete(event.id);
    emit(
      state.copyWith(
        deletion: result.fold(state.deletion.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Replaces the loaded event (e.g. after returning from the edit form).
  void refreshWith(Event event) =>
      emit(state.copyWith(event: LoadState.loaded(event)));
}
