import '../models/event_model.dart';

/// I/O contract for events. Throws `core/error/exceptions.dart` types.
abstract interface class EventsDataSource {
  Future<List<EventModel>> fetchAll();
  Future<EventModel> fetchById(String id);
  Future<EventModel> insert(EventModel event);
  Future<EventModel> update(EventModel event);
  Future<void> delete(String id);
}
