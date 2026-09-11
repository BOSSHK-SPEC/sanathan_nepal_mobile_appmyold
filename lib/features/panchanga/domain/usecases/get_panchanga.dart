import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/panchanga.dart';
import '../repositories/panchanga_repository.dart';

/// Fetches the panchanga of one civil day.
class GetPanchanga implements UseCase<Panchanga, DateTime> {
  const GetPanchanga(this._repo);
  final PanchangaRepository _repo;

  @override
  Future<Result<Panchanga>> call(DateTime params) => _repo.getPanchanga(params);
}
