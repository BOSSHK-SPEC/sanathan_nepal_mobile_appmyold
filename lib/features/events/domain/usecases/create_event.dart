import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

/// Creates a user event / to-do.
class CreateEvent implements UseCase<Event, Event> {
  const CreateEvent(this._repo);
  final EventRepository _repo;

  @override
  Future<Result<Event>> call(Event params) => _repo.createEvent(params);
}
