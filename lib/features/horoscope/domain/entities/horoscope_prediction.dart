import 'package:freezed_annotation/freezed_annotation.dart';

import 'horoscope_media.dart';
import 'horoscope_period.dart';
import 'lucky_details.dart';
import 'sign_profile.dart';
import 'zodiac_sign.dart';

part 'horoscope_prediction.freezed.dart';

/// A horoscope prediction for one [sign] over one [period].
@freezed
abstract class HoroscopePrediction with _$HoroscopePrediction {
  const HoroscopePrediction._();

  const factory HoroscopePrediction({
    required ZodiacSign sign,
    required HoroscopePeriod period,
    required String textNe,
    required String textEn,
    required LuckyDetails lucky,
    required HoroscopeMedia media,

    /// Hindi text – empty when not provided (falls back to [textEn]).
    @Default('') String textHi,

    /// About-the-sign content of the expanded "More Details" area (null when
    /// the backend does not provide it – the UI then hides that block).
    SignProfile? profile,
  }) = _HoroscopePrediction;

  String text({required bool nepali}) => nepali ? textNe : textEn;

  /// Prediction text for a language code (`ne`, `hi`, otherwise English).
  String textFor(String languageCode) => switch (languageCode) {
    'ne' => textNe,
    'hi' => textHi.isNotEmpty ? textHi : textEn,
    _ => textEn,
  };
}
