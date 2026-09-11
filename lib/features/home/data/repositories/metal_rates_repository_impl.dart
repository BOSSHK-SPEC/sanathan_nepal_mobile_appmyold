import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/metal_rates.dart';
import '../../domain/repositories/metal_rates_repository.dart';
import '../datasources/metal_rates_data_source.dart';

class MetalRatesRepositoryImpl implements MetalRatesRepository {
  const MetalRatesRepositoryImpl(this._remote);
  final MetalRatesDataSource _remote;

  @override
  Future<Result<MetalRates>> getTodayRates() =>
      guard(() async => (await _remote.fetchToday()).toEntity());
}
