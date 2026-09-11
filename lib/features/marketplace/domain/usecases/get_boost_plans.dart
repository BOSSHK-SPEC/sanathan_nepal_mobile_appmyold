import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/boost_request.dart';
import '../repositories/boost_repository.dart';

/// Available boost durations / prices.
class GetBoostPlans implements NoParamsUseCase<List<BoostPlan>> {
  const GetBoostPlans(this._repo);
  final BoostRepository _repo;

  @override
  Future<Result<List<BoostPlan>>> call() => _repo.getPlans();
}
