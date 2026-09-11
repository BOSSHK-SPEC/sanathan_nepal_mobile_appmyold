import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/horoscope_period.dart';
import '../entities/horoscope_prediction.dart';
import '../repositories/horoscope_repository.dart';

/// Fetches predictions of all twelve signs for a period.
class GetAllPredictions
    implements UseCase<List<HoroscopePrediction>, HoroscopePeriod> {
  const GetAllPredictions(this._repo);
  final HoroscopeRepository _repo;

  @override
  Future<Result<List<HoroscopePrediction>>> call(HoroscopePeriod params) =>
      _repo.getAll(params);
}
