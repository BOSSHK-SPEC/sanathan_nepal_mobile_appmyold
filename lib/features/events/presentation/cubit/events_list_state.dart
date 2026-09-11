part of 'events_list_cubit.dart';

/// State of the events page list: current tab, chip filter and results.
@freezed
abstract class EventsListState with _$EventsListState {
  const EventsListState._();

  const factory EventsListState({
    /// Events matching [filter].
    @Default(LoadState.idle()) LoadState<List<Event>> events,
    @Default(EventGroup.festival) EventGroup group,

    /// Selected chip; `null` = "All".
    EventCategory? category,
    @Default(false) bool onlyImportant,
    @Default(false) bool onlyHolidays,
    @Default(false) bool onlyVrat,

    /// To-Do tab: chip that narrows the list to one to-do (`null` = "All").
    String? focusedEventId,

    /// Failure of the last delete / checklist toggle (shown as a snackbar);
    /// reset by the next successful action.
    Failure? actionFailure,
  }) = _EventsListState;

  /// Loaded events (or the stale ones kept while refreshing).
  List<Event> get eventList => events.dataOrNull ?? const [];

  /// [eventList] narrowed to [focusedEventId] when one is set.
  List<Event> get visibleEvents => focusedEventId == null
      ? eventList
      : eventList.where((e) => e.id == focusedEventId).toList(growable: false);

  EventFilter get filter => EventFilter(
    group: group,
    category: category,
    onlyImportant: onlyImportant,
    onlyHolidays: onlyHolidays,
    onlyVrat: onlyVrat,
  );
}
