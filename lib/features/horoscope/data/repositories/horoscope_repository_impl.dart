import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/horoscope_period.dart';
import '../../domain/entities/horoscope_prediction.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../../domain/repositories/horoscope_repository.dart';
import '../datasources/horoscope_data_source.dart';

/// Default [HoroscopeRepository] backed by a single [HoroscopeDataSource].
class HoroscopeRepositoryImpl implements HoroscopeRepository {
  const HoroscopeRepositoryImpl(this._source);
  final HoroscopeDataSource _source;

  @override
  Future<Result<HoroscopePrediction>> getPrediction(
    ZodiacSign sign,
    HoroscopePeriod period,
  ) => guard(
    () async => (await _source.fetchPrediction(sign, period)).toEntity(),
  );

  @override
  Future<Result<List<HoroscopePrediction>>> getAll(HoroscopePeriod period) =>
      guard(() async {
        final models = await _source.fetchAll(period);
        return [for (final m in models) m.toEntity()];
      });
}
