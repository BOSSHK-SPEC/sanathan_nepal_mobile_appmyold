import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/calendar/calendar.dart';
import 'event.dart';
import 'event_category.dart';

part 'event_filter.freezed.dart';

/// Filter used when listing events.
///
/// * [group] – which tab (festivals / my events / to-do); `null` = all.
/// * [category] – optional chip filter inside the tab.
/// * [onlyHolidays] / [onlyVrat] / [onlyImportant] – festival sub-filters.
/// * [from] – hide events dated before this day (defaults to "today" when
///   [upcomingOnly] is `true`).
/// * [to] – hide events dated after this day (inclusive). `from == to` lists
///   the events of a single day.
@freezed
abstract class EventFilter with _$EventFilter {
  const EventFilter._();

  const factory EventFilter({
    EventGroup? group,
    EventCategory? category,
    @Default(false) bool onlyHolidays,
    @Default(false) bool onlyVrat,
    @Default(false) bool onlyImportant,
    @Default(true) bool upcomingOnly,
    DateTime? from,
    DateTime? to,
    int? limit,
  }) = _EventFilter;

  static const EventFilter all = EventFilter(upcomingOnly: false);

  /// Everything (festivals, personal events, to-dos) that falls on [day].
  factory EventFilter.onDay(DateTime day, {EventGroup? group}) {
    final d = DateTime(day.year, day.month, day.day);
    return EventFilter(group: group, from: d, to: d);
  }

  /// Whether [e] belongs in this list.
  ///
  /// Dates are compared against the event's *next occurrence*, not the date it
  /// was created on. A birthday entered as `2000-02-03` is not a past event —
  /// comparing the stored date meant every recurring event a user ever created
  /// was filtered out of every upcoming list, while still being returned
  /// happily by the API.
  ///
  /// [calendar] lets a Bikram Sambat / Saka anniversary recur on its own
  /// calendar; without one those fall back to the Gregorian date.
  bool matches(Event e, {DateTime? now, TraditionalCalendar? calendar}) {
    if (group != null && e.group != group) return false;
    if (category != null && e.category != category) return false;
    if (onlyHolidays && !e.isHoliday) return false;
    if (onlyVrat && !e.isVrat) return false;
    if (onlyImportant && !e.isImportant) return false;

    final ref = from ?? now ?? DateTime.now();
    final today = DateTime(ref.year, ref.month, ref.day);
    final occurrence = e.nextOccurrence(from: today, calendar: calendar);

    if (upcomingOnly && occurrence.isBefore(today)) return false;

    // A single-day query (`from == to`) asks "what falls on this day?", so a
    // yearly event answers with the occurrence in that day's year.
    if (from != null && occurrence.isBefore(today)) return false;

    final until = to;
    if (until != null &&
        occurrence.isAfter(DateTime(until.year, until.month, until.day))) {
      return false;
    }
    return true;
  }
}
