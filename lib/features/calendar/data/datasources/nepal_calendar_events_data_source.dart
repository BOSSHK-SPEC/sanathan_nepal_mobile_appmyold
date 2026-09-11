import 'calendar_events_data_source.dart';
import 'nepal_calendar_events_seed.dart';

/// Deterministic seed of major Nepali festivals / public holidays
/// (see [nepalCalendarEventsSeed]).
class NepalCalendarEventsDataSource extends SeedCalendarEventsDataSource {
  NepalCalendarEventsDataSource() : super(nepalCalendarEventsSeed);
}
