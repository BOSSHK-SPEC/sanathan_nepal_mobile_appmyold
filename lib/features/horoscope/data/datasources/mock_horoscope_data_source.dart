import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/horoscope_media.dart';
import '../../domain/entities/horoscope_period.dart';
import '../../domain/entities/horoscope_prediction.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../models/horoscope_prediction_model.dart';
import 'horoscope_data_source.dart';
import 'horoscope_lucky_seed.dart';
import 'horoscope_profile_seed.dart';
import 'horoscope_seed_en.dart';
import 'horoscope_seed_hi.dart';
import 'horoscope_seed_ne.dart';

/// Deterministic in-memory horoscope data (12 signs × 4 periods, trilingual).
///
/// The media title carries the current month/year of the active region's
/// traditional calendar (Bikram Sambat in Nepal, Saka in India) – resolved
/// through [RegionResolver] on every call so a runtime region switch is
/// reflected immediately.
class MockHoroscopeDataSource implements HoroscopeDataSource {
  MockHoroscopeDataSource({
    required RegionResolver resolver,
    DateTime Function()? now,
  }) : _resolver = resolver,
       _now = now ?? DateTime.now;

  final RegionResolver _resolver;
  final DateTime Function() _now;

  @override
  Future<HoroscopePredictionModel> fetchPrediction(
    ZodiacSign sign,
    HoroscopePeriod period,
  ) async => _build(sign, period);

  @override
  Future<List<HoroscopePredictionModel>> fetchAll(
    HoroscopePeriod period,
  ) async =>
      ZodiacSign.values.map((s) => _build(s, period)).toList(growable: false);

  HoroscopePredictionModel _build(ZodiacSign sign, HoroscopePeriod period) {
    final calendar = _resolver.config.calendar;
    final today = calendar.fromGregorian(_now());
    final monthNe = calendar.monthName(today.month, languageCode: 'ne');
    final monthEn = calendar.monthName(today.month, languageCode: 'en');
    final monthHi = calendar.monthName(today.month, languageCode: 'hi');
    final yearDev = '${today.year}'.toDevanagariDigits();
    // Clip length varies per sign so the mocked player looks realistic.
    final seconds = 900 + sign.index * 37 + period.index * 60;
    final prediction = HoroscopePrediction(
      sign: sign,
      period: period,
      textNe: horoscopeSeedNe[sign]![period.index],
      textEn: horoscopeSeedEn[sign]![period.index],
      textHi: horoscopeSeedHi[sign]![period.index],
      lucky: horoscopeLuckySeed[sign]!,
      media: HoroscopeMedia(
        titleNe: '${sign.nameNe} राशिफल - $monthNe, $yearDev',
        titleEn: '${sign.nameEn} Rashifal - $monthEn, ${today.year}',
        titleHi: '${sign.nameHi} राशिफल – $monthHi, $yearDev',
        duration: Duration(seconds: seconds),
      ),
      profile: horoscopeProfileFor(sign),
    );
    return HoroscopePredictionModel.fromEntity(prediction);
  }
}
