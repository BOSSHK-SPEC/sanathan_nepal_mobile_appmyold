import 'calendar_events_data_source.dart';
import 'india_calendar_events_seed.dart';

/// Deterministic seed of Indian national holidays / major festivals
/// (see [indiaCalendarEventsSeed]).
class IndiaCalendarEventsDataSource extends SeedCalendarEventsDataSource {
  IndiaCalendarEventsDataSource() : super(indiaCalendarEventsSeed);
}
