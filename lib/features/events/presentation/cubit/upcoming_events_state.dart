part of 'upcoming_events_cubit.dart';

/// Pills of the Home events block.
enum UpcomingScope { all, governmentHolidays, mine }

/// State of the compact Home events section.
@freezed
abstract class UpcomingEventsState with _$UpcomingEventsState {
  const UpcomingEventsState._();

  const factory UpcomingEventsState({
    /// Next few events for [scope] + chips.
    @Default(LoadState.idle()) LoadState<List<Event>> events,
    @Default(UpcomingScope.all) UpcomingScope scope,
    @Default(false) bool onlyHolidays,
    @Default(false) bool onlyVrat,
  }) = _UpcomingEventsState;

  /// Loaded events (or the stale ones kept while refreshing).
  List<Event> get eventList => events.dataOrNull ?? const [];

  /// The event highlighted in the featured card (first upcoming).
  Event? get featured => eventList.firstOrNull;
}
