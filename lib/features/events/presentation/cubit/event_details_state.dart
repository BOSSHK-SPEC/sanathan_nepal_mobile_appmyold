part of 'event_details_cubit.dart';

/// State for the event details page.
@freezed
abstract class EventDetailsState with _$EventDetailsState {
  const EventDetailsState._();

  const factory EventDetailsState({
    /// The event being shown.
    @Default(LoadState.idle()) LoadState<Event> event,

    /// Deletion of the shown event – `Loaded` once it is gone (page pops).
    @Default(LoadState.idle()) LoadState<void> deletion,

    /// Failure of the last checklist toggle (snackbar); reset by the next
    /// successful toggle.
    Failure? actionFailure,
  }) = _EventDetailsState;

  bool get isDeleted => deletion.isLoaded;
}
