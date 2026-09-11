import '../../../../core/utils/result.dart';
import '../entities/event.dart';
import '../entities/event_filter.dart';

/// Contract for reading and mutating events (festivals, personal events,
/// to-dos). Implemented in the data layer.
abstract interface class EventRepository {
  /// Events matching [filter], sorted by date ascending.
  Future<Result<List<Event>>> getEvents([EventFilter filter = EventFilter.all]);

  Future<Result<Event>> getEventById(String id);

  /// Persists a new event; the returned event carries the generated id.
  Future<Result<Event>> createEvent(Event event);

  Future<Result<Event>> updateEvent(Event event);

  Future<Result<void>> deleteEvent(String id);

  /// Flips `isDone` of one checklist item and returns the updated event.
  Future<Result<Event>> toggleChecklistItem(String eventId, String itemId);
}
