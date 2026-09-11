import '../../../../core/utils/result.dart';
import '../entities/metal_rates.dart';

abstract interface class MetalRatesRepository {
  Future<Result<MetalRates>> getTodayRates();
}
