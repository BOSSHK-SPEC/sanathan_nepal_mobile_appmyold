import '../../../../core/calendar/calendar.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_filter.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/events_data_source.dart';
import '../models/event_model.dart';

/// [EventRepository] backed by an [EventsDataSource].
class EventRepositoryImpl implements EventRepository {
  EventRepositoryImpl(
    this._source, {
    DateTime Function()? clock,
    RegionResolver? resolver,
  }) : _clock = clock ?? DateTime.now,
       _resolver = resolver;

  final EventsDataSource _source;
  final DateTime Function() _clock;

  /// Supplies the region's calendar, so a Bikram Sambat or Saka anniversary
  /// recurs on its own calendar rather than on the Gregorian date.
  final RegionResolver? _resolver;

  TraditionalCalendar? get _calendar => _resolver?.config.calendar;

  @override
  Future<Result<List<Event>>> getEvents([
    EventFilter filter = EventFilter.all,
  ]) => guard(() async {
    final now = _clock();
    final calendar = _calendar;
    final list =
        (await _source.fetchAll())
            .map((m) => m.toEntity())
            .where((e) => filter.matches(e, now: now, calendar: calendar))
            .toList()
          // Ordered by when each event actually happens next: sorting on the
          // stored date buried every recurring event at the top of the list,
          // years in the past.
          ..sort((a, b) {
            final byDate = a
                .nextOccurrence(from: now, calendar: calendar)
                .compareTo(b.nextOccurrence(from: now, calendar: calendar));
            return byDate != 0 ? byDate : a.id.compareTo(b.id);
          });
    final limit = filter.limit;
    if (limit != null && list.length > limit) {
      return List<Event>.unmodifiable(list.take(limit));
    }
    return List<Event>.unmodifiable(list);
  });

  @override
  Future<Result<Event>> getEventById(String id) =>
      guard(() async => (await _source.fetchById(id)).toEntity());

  @override
  Future<Result<Event>> createEvent(Event event) => guard(
    () async => (await _source.insert(EventModel.fromEntity(event))).toEntity(),
  );

  @override
  Future<Result<Event>> updateEvent(Event event) => guard(
    () async => (await _source.update(EventModel.fromEntity(event))).toEntity(),
  );

  @override
  Future<Result<void>> deleteEvent(String id) =>
      guard(() => _source.delete(id));

  @override
  Future<Result<Event>> toggleChecklistItem(String eventId, String itemId) =>
      guard(() async {
        final event = await _source.fetchById(eventId);
        final items = event.checklist
            .map((c) => c.id == itemId ? c.copyWith(isDone: !c.isDone) : c)
            .toList();
        final updated = await _source.update(event.copyWith(checklist: items));
        return updated.toEntity();
      });
}
