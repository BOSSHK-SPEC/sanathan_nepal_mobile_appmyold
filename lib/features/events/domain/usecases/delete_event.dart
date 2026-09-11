import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../repositories/event_repository.dart';

/// Deletes an event by id.
class DeleteEvent implements UseCase<void, String> {
  const DeleteEvent(this._repo);
  final EventRepository _repo;

  @override
  Future<Result<void>> call(String params) => _repo.deleteEvent(params);
}
