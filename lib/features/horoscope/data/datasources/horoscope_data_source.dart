import '../../domain/entities/horoscope_period.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../models/horoscope_prediction_model.dart';

/// I/O boundary for horoscope predictions (remote API or mock).
abstract interface class HoroscopeDataSource {
  Future<HoroscopePredictionModel> fetchPrediction(
    ZodiacSign sign,
    HoroscopePeriod period,
  );

  Future<List<HoroscopePredictionModel>> fetchAll(HoroscopePeriod period);
}
