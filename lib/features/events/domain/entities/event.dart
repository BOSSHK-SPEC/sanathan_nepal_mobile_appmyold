import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/calendar/calendar.dart';
import 'event_category.dart';

part 'event.freezed.dart';

/// Nepali / English / Hindi variants of a text. [hi] is optional and falls
/// back to English (then Nepali) when empty.
@freezed
abstract class LocalizedText with _$LocalizedText {
  const LocalizedText._();

  const factory LocalizedText({
    required String ne,
    required String en,
    @Default('') String hi,
  }) = _LocalizedText;

  /// Same text in every language.
  factory LocalizedText.same(String value) =>
      LocalizedText(ne: value, en: value, hi: value);

  static const LocalizedText empty = LocalizedText(ne: '', en: '');

  bool get isEmpty => ne.isEmpty && en.isEmpty && hi.isEmpty;

  /// Returns the text for the active language, falling back to the other one.
  String resolve({required bool nepali}) {
    if (nepali) return ne.isNotEmpty ? ne : en;
    return en.isNotEmpty ? en : ne;
  }

  /// Text for [languageCode] (`ne` / `hi` / other = English) with fallbacks.
  String resolveFor(String languageCode) => switch (languageCode) {
    'ne' => resolve(nepali: true),
    'hi' => hi.isNotEmpty ? hi : (en.isNotEmpty ? en : ne),
    _ => resolve(nepali: false),
  };
}

/// A wall-clock time without a date (kept Flutter-free for the domain layer).
@freezed
abstract class EventTime with _$EventTime {
  const EventTime._();

  const factory EventTime({required int hour, required int minute}) =
      _EventTime;

  int get minutesOfDay => hour * 60 + minute;

  /// Formats as `6:30 AM`.
  String format12h() {
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m ${hour < 12 ? 'AM' : 'PM'}';
  }
}

/// Reminder configuration ("Remind me before N days at 12:00 AM").
@freezed
abstract class EventReminder with _$EventReminder {
  const factory EventReminder({
    required int daysBefore,
    required EventTime time,
  }) = _EventReminder;
}

/// A single to-do entry of an event's checklist.
@freezed
abstract class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required String id,
    required String label,
    @Default(false) bool isDone,
  }) = _ChecklistItem;
}

/// Domain entity for a festival, holiday, personal event or to-do.
@freezed
abstract class Event with _$Event {
  const Event._();

  const factory Event({
    required String id,
    required LocalizedText title,

    /// Gregorian (AD) date at midnight – the source of truth. Use
    /// [traditionalDate] for the region's calendar (BS in Nepal, Saka in
    /// India).
    required DateTime date,
    required EventCategory category,
    @Default(LocalizedText.empty) LocalizedText description,
    EventTime? time,
    @Default(false) bool isHoliday,
    @Default(false) bool isVrat,
    @Default(false) bool isImportant,
    String? imagePath,
    @Default(LocalizedText.empty) LocalizedText location,
    @Default(LocalizedText.empty) LocalizedText tithi,
    @Default(LocalizedText.empty) LocalizedText howToCelebrate,
    @Default(LocalizedText.empty) LocalizedText attractionPlaces,
    String? videoUrl,
    @Default([]) List<ChecklistItem> checklist,
    EventReminder? reminder,
    @Default(EventRepeat.none) EventRepeat repeat,

    /// Whether a yearly event recurs on its *traditional* date.
    ///
    /// A birthday recorded in Bikram Sambat comes round on its B.S. date,
    /// which lands on a different Gregorian day each year. Stored by the
    /// server and, until now, dropped on the way back — so a B.S. birthday
    /// silently recurred on the Gregorian date instead.
    @Default(false) bool useTraditionalDate,
  }) = _Event;

  EventGroup get group => category.group;

  /// `true` for user-created events and to-dos (editable / deletable).
  bool get isMine => group != EventGroup.festival;

  /// [date] expressed in the given traditional [calendar]
  /// (`RegionConfig.calendar`).
  TraditionalDate traditionalDate(TraditionalCalendar calendar) =>
      calendar.fromGregorian(date);

  /// When this event next happens, on or after [from].
  ///
  /// For a one-off this is simply [date]. For a yearly event it is this
  /// year's occurrence, or next year's once today has passed — which is the
  /// whole point: a birthday stored as `2000-02-03` is not an event in the
  /// past, it is an event every February. Without this the upcoming filter
  /// dropped every recurring event ever created, and `daysLeft` reported
  /// thousands of days ago.
  ///
  /// [calendar] is required only for [useTraditionalDate] events; without it
  /// they fall back to recurring on the Gregorian date, which is wrong by a
  /// few days rather than wrong by decades.
  DateTime nextOccurrence({DateTime? from, TraditionalCalendar? calendar}) {
    final now = from ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = DateTime(date.year, date.month, date.day);
    if (repeat != EventRepeat.yearly || !start.isBefore(today)) return start;

    if (useTraditionalDate && calendar != null) {
      return _nextTraditional(calendar, today);
    }
    return _nextGregorian(today);
  }

  /// The anniversary in this calendar's own year, clamped to a month that may
  /// be shorter — Bikram Sambat months vary in length between years, so the
  /// 32nd of a month can simply not exist next year.
  DateTime _nextTraditional(TraditionalCalendar calendar, DateTime today) {
    final anniversary = calendar.fromGregorian(date);
    var year = calendar.fromGregorian(today).year;

    DateTime at(int y) {
      final maxDay = calendar.daysInMonth(y, anniversary.month);
      final day = anniversary.day > maxDay ? maxDay : anniversary.day;
      return calendar.toGregorian(TraditionalDate(y, anniversary.month, day));
    }

    final thisYear = at(year);
    return thisYear.isBefore(today) ? at(++year) : thisYear;
  }

  /// The same, in Gregorian years. The clamp matters here too: a 29 February
  /// birthday has no date at all in three years out of four.
  DateTime _nextGregorian(DateTime today) {
    DateTime at(int year) {
      final lastDay = DateTime(year, date.month + 1, 0).day;
      return DateTime(year, date.month, date.day > lastDay ? lastDay : date.day);
    }

    final thisYear = at(today.year);
    return thisYear.isBefore(today) ? at(today.year + 1) : thisYear;
  }

  /// Whole days between [from] (defaults to today) and the next occurrence.
  int daysLeft([DateTime? from, TraditionalCalendar? calendar]) {
    final now = from ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return nextOccurrence(
      from: today,
      calendar: calendar,
    ).difference(today).inDays;
  }
}
