import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../domain/entities/horoscope_period.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../models/horoscope_prediction_model.dart';
import '../models/lucky_details_model.dart';
import 'horoscope_data_source.dart';

/// Horoscopes, served by the backend.
///
/// The server holds one row per sign, period and period-start, so every device
/// asking for "this week" gets the same reading — a client that computed its
/// own week boundary would show two users different predictions on the same
/// day, which for a horoscope is the whole product.
class ApiHoroscopeDataSource implements HoroscopeDataSource {
  const ApiHoroscopeDataSource(this._client);

  final ApiClient _client;

  @override
  Future<HoroscopePredictionModel> fetchPrediction(
    ZodiacSign sign,
    HoroscopePeriod period,
  ) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.almanacHoroscopeSign(sign.name),
      query: {'period': period.name},
    );
    return _toModel(asJsonMap(response), fallbackSign: sign, period: period);
  });

  @override
  Future<List<HoroscopePredictionModel>> fetchAll(HoroscopePeriod period) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.almanacHoroscope,
          query: {'period': period.name},
        );

        final all = asJsonList(response)
            .map(
              (json) => _toModel(
                json,
                fallbackSign: ZodiacSign.aries,
                period: period,
              ),
            )
            .toList(growable: false);

        if (all.isEmpty) {
          throw const NotFoundException('No horoscope published for today');
        }
        return all;
      });

  HoroscopePredictionModel _toModel(
    Map<String, dynamic> json, {
    required ZodiacSign fallbackSign,
    required HoroscopePeriod period,
  }) {
    final prediction = _localized(json['prediction']);
    final lucky = json['lucky'];

    return HoroscopePredictionModel(
      sign: ZodiacSign.values.firstWhere(
        (s) => s.name == json['sign'],
        orElse: () => fallbackSign,
      ),
      period: HoroscopePeriod.values.firstWhere(
        (p) => p.name == json['period'],
        orElse: () => period,
      ),
      textEn: prediction['en'] ?? '',
      // English is the guaranteed translation; falling back to it beats an
      // empty card in Nepali.
      textNe: prediction['ne'] ?? prediction['en'] ?? '',
      textHi: prediction['hi'] ?? prediction['en'] ?? '',
      lucky: _toLucky(lucky),
    );
  }

  /// Reads the server's "Lucky Details" object.
  ///
  /// Every field is optional and defaulted rather than required: this table is
  /// decoration under the prediction, and a server that has not filled in a
  /// ruling planet should cost the user a blank row, not the whole reading.
  LuckyDetailsModel _toLucky(Object? raw) {
    if (raw is! Map) return const LuckyDetailsModel();
    final json = Map<String, dynamic>.from(raw);

    final colour = _localized(json['colour'] ?? json['color']);
    final planet = _localized(json['rulingPlanet']);
    final symbol = _localized(json['symbol']);
    final element = _localized(json['element']);
    final stone = _localized(json['luckyStone']);
    final unlucky = _localized(json['unluckyStone']);
    final days = json['days'];

    return LuckyDetailsModel(
      numbers: _ints(json['numbers'] ?? json['number']),
      colorEn: colour['en'] ?? '',
      colorNe: colour['ne'] ?? colour['en'] ?? '',
      colorHi: colour['hi'] ?? '',
      colorValue: (json['colourValue'] as num?)?.toInt() ?? 0,
      daysEn: _strings(days, 'en'),
      daysNe: _strings(days, 'ne'),
      daysHi: _strings(days, 'hi'),
      rulingPlanetEn: planet['en'] ?? '',
      rulingPlanetNe: planet['ne'] ?? planet['en'] ?? '',
      rulingPlanetHi: planet['hi'] ?? '',
      symbolEn: symbol['en'] ?? '',
      symbolNe: symbol['ne'] ?? symbol['en'] ?? '',
      symbolHi: symbol['hi'] ?? '',
      elementEn: element['en'] ?? '',
      elementNe: element['ne'] ?? element['en'] ?? '',
      elementHi: element['hi'] ?? '',
      luckyStoneEn: stone['en'] ?? '',
      luckyStoneNe: stone['ne'] ?? stone['en'] ?? '',
      luckyStoneHi: stone['hi'] ?? '',
      unluckyStoneEn: unlucky['en'] ?? '',
      unluckyStoneNe: unlucky['ne'] ?? unlucky['en'] ?? '',
      unluckyStoneHi: unlucky['hi'] ?? '',
      luckyAlphabet: json['alphabet'] as String? ?? '',
      eventfulYears: _ints(json['eventfulYears']),
    );
  }

  /// Accepts a list of numbers or a single one — an older server sent
  /// `"number": 7` where this one sends `"numbers": [6, 9]`.
  static List<int> _ints(Object? raw) {
    if (raw is num) return [raw.toInt()];
    if (raw is! List) return const [];
    return [
      for (final v in raw)
        if (v is num) v.toInt(),
    ];
  }

  static List<String> _strings(Object? raw, String languageCode) {
    if (raw is! Map) return const [];
    final value = raw[languageCode] ?? raw['en'];
    if (value is! List) return const [];
    return [for (final v in value) v.toString()];
  }

  static Map<String, String> _localized(Object? raw) {
    if (raw is String) return {'en': raw};
    if (raw is! Map) return const {};
    return raw.map((k, v) => MapEntry(k.toString(), v.toString()));
  }
}
