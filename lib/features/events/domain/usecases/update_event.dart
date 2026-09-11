import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

/// Updates an existing user event / to-do.
class UpdateEvent implements UseCase<Event, Event> {
  const UpdateEvent(this._repo);
  final EventRepository _repo;

  @override
  Future<Result<Event>> call(Event params) => _repo.updateEvent(params);
}
