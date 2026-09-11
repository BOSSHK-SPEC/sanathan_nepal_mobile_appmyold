import '../../../../core/utils/result.dart';
import '../entities/horoscope_period.dart';
import '../entities/horoscope_prediction.dart';
import '../entities/zodiac_sign.dart';

/// Read-side contract for horoscope predictions.
abstract interface class HoroscopeRepository {
  /// Prediction of a single [sign] for [period].
  Future<Result<HoroscopePrediction>> getPrediction(
    ZodiacSign sign,
    HoroscopePeriod period,
  );

  /// Predictions of all twelve signs for [period], in zodiac order.
  Future<Result<List<HoroscopePrediction>>> getAll(HoroscopePeriod period);
}
