import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/horoscope_period.dart';
import '../entities/horoscope_prediction.dart';
import '../entities/zodiac_sign.dart';
import '../repositories/horoscope_repository.dart';

part 'get_prediction.freezed.dart';

/// Parameters for [GetPrediction].
@freezed
abstract class GetPredictionParams with _$GetPredictionParams {
  const factory GetPredictionParams({
    required ZodiacSign sign,
    required HoroscopePeriod period,
  }) = _GetPredictionParams;
}

/// Fetches the prediction of one sign for one period.
class GetPrediction
    implements UseCase<HoroscopePrediction, GetPredictionParams> {
  const GetPrediction(this._repo);
  final HoroscopeRepository _repo;

  @override
  Future<Result<HoroscopePrediction>> call(GetPredictionParams params) =>
      _repo.getPrediction(params.sign, params.period);
}
