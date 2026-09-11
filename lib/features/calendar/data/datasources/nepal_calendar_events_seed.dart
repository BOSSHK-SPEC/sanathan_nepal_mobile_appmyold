import '../models/calendar_event_model.dart';
import 'nepal_calendar_events_seed_a.dart';
import 'nepal_calendar_events_seed_b.dart';

/// Major Nepali festivals / public holidays for 2079–2083 BS.
/// The seed is authored in Bikram Sambat (see `seedEvent`), which converts
/// each entry to its Gregorian date with `nepali_utils`.
final List<CalendarEventModel> nepalCalendarEventsSeed = List.unmodifiable([
  ...seed2079To2080,
  ...seed2081To2083,
]);
