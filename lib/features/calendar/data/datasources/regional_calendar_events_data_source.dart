import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../models/calendar_event_model.dart';
import 'calendar_events_data_source.dart';
import 'india_calendar_events_data_source.dart';
import 'nepal_calendar_events_data_source.dart';

/// Picks the festival dataset of the *active* region on every call
/// (Nepal → [NepalCalendarEventsDataSource], India →
/// [IndiaCalendarEventsDataSource]).
class RegionalCalendarEventsDataSource implements CalendarEventsDataSource {
  RegionalCalendarEventsDataSource(
    this._resolver, {
    CalendarEventsDataSource? nepal,
    CalendarEventsDataSource? india,
  }) : _nepal = nepal ?? NepalCalendarEventsDataSource(),
       _india = india ?? IndiaCalendarEventsDataSource();

  final RegionResolver _resolver;
  final CalendarEventsDataSource _nepal;
  final CalendarEventsDataSource _india;

  CalendarEventsDataSource get _active => switch (_resolver.region) {
    Region.nepal => _nepal,
    Region.india => _india,
  };

  @override
  Future<List<CalendarEventModel>> fetchEvents({
    required DateTime from,
    required DateTime to,
  }) => _active.fetchEvents(from: from, to: to);
}
