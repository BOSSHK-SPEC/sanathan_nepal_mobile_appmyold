import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/suva_sait.dart';
import '../repositories/panchanga_repository.dart';

/// Fetches the list of auspicious-timing categories with upcoming dates.
class GetSuvaSaits implements NoParamsUseCase<List<SuvaSait>> {
  const GetSuvaSaits(this._repo);
  final PanchangaRepository _repo;

  @override
  Future<Result<List<SuvaSait>>> call() => _repo.getSuvaSaits();
}
