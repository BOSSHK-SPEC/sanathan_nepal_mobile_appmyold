import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/metal_rates.dart';
import '../repositories/metal_rates_repository.dart';

class GetMetalRates implements NoParamsUseCase<MetalRates> {
  const GetMetalRates(this._repo);
  final MetalRatesRepository _repo;
  @override
  Future<Result<MetalRates>> call() => _repo.getTodayRates();
}
