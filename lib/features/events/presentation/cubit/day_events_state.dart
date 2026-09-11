part of 'day_events_cubit.dart';

/// Events of a single day, split by tab group for rendering.
@freezed
abstract class DayEventsState with _$DayEventsState {
  const DayEventsState._();

  const factory DayEventsState({
    /// Civil day (local midnight) the list belongs to.
    required DateTime date,
    @Default(LoadState.idle()) LoadState<List<Event>> events,

    /// Failure of the last checklist toggle (shown as a snackbar).
    Failure? actionFailure,
  }) = _DayEventsState;

  List<Event> get eventList => events.dataOrNull ?? const [];

  List<Event> get festivals =>
      eventList.where((e) => e.group == EventGroup.festival).toList();
  List<Event> get personal =>
      eventList.where((e) => e.group == EventGroup.personal).toList();
  List<Event> get todos =>
      eventList.where((e) => e.group == EventGroup.todo).toList();
}
