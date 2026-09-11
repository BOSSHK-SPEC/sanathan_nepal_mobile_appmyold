import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/forex_rate.dart';
import '../repositories/forex_repository.dart';

class GetLatestRates implements NoParamsUseCase<List<ForexRate>> {
  const GetLatestRates(this._repo);
  final ForexRepository _repo;

  @override
  Future<Result<List<ForexRate>>> call() => _repo.getLatestRates();
}
