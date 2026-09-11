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
  }) = _Event;

  EventGroup get group => category.group;

  /// `true` for user-created events and to-dos (editable / deletable).
  bool get isMine => group != EventGroup.festival;

  /// [date] expressed in the given traditional [calendar]
  /// (`RegionConfig.calendar`).
  TraditionalDate traditionalDate(TraditionalCalendar calendar) =>
      calendar.fromGregorian(date);

  /// Whole days between [from] (defaults to today) and the event date.
  int daysLeft([DateTime? from]) {
    final now = from ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return DateTime(date.year, date.month, date.day).difference(today).inDays;
  }
}
