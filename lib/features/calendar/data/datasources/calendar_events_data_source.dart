import '../models/calendar_event_model.dart';

/// Source of festival / holiday events (seed today, remote API later).
abstract interface class CalendarEventsDataSource {
  /// Events on Gregorian dates in the inclusive range [from]–[to], sorted by
  /// date.
  Future<List<CalendarEventModel>> fetchEvents({
    required DateTime from,
    required DateTime to,
  });
}

/// In-memory seed-backed [CalendarEventsDataSource].
class SeedCalendarEventsDataSource implements CalendarEventsDataSource {
  const SeedCalendarEventsDataSource(this.seed);

  /// Exposed for tests / other features.
  final List<CalendarEventModel> seed;

  @override
  Future<List<CalendarEventModel>> fetchEvents({
    required DateTime from,
    required DateTime to,
  }) async {
    final start = DateTime(from.year, from.month, from.day);
    final end = DateTime(to.year, to.month, to.day, 23, 59, 59);
    return seed
        .where((e) => !e.date.isBefore(start) && !e.date.isAfter(end))
        .toList(growable: false)
      ..sort((a, b) => a.date.compareTo(b.date));
  }
}
