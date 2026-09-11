import 'package:freezed_annotation/freezed_annotation.dart';

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

  bool matches(Event e, {DateTime? now}) {
    if (group != null && e.group != group) return false;
    if (category != null && e.category != category) return false;
    if (onlyHolidays && !e.isHoliday) return false;
    if (onlyVrat && !e.isVrat) return false;
    if (onlyImportant && !e.isImportant) return false;
    if (upcomingOnly) {
      final ref = from ?? now ?? DateTime.now();
      final today = DateTime(ref.year, ref.month, ref.day);
      if (e.date.isBefore(today)) return false;
    }
    final until = to;
    if (until != null &&
        e.date.isAfter(DateTime(until.year, until.month, until.day))) {
      return false;
    }
    return true;
  }
}
