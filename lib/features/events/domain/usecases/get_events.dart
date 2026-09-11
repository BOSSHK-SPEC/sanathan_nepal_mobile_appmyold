import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/event.dart';
import '../entities/event_filter.dart';
import '../repositories/event_repository.dart';

/// Lists events matching an [EventFilter].
class GetEvents implements UseCase<List<Event>, EventFilter> {
  const GetEvents(this._repo);
  final EventRepository _repo;

  @override
  Future<Result<List<Event>>> call(EventFilter params) =>
      _repo.getEvents(params);
}
