import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

/// Loads a single event.
class GetEventById implements UseCase<Event, String> {
  const GetEventById(this._repo);
  final EventRepository _repo;

  @override
  Future<Result<Event>> call(String params) => _repo.getEventById(params);
}
