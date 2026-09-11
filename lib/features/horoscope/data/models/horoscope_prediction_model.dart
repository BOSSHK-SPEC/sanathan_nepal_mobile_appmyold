import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/horoscope_period.dart';
import '../../domain/entities/horoscope_prediction.dart';
import '../../domain/entities/zodiac_sign.dart';
import 'horoscope_media_model.dart';
import 'lucky_details_model.dart';
import 'sign_profile_model.dart';

part 'horoscope_prediction_model.freezed.dart';
part 'horoscope_prediction_model.g.dart';

/// Serialisable [HoroscopePrediction] (JSON shape is a best guess until a
/// backend contract exists). Enums travel by name (`aries`, `daily`).
@freezed
abstract class HoroscopePredictionModel with _$HoroscopePredictionModel {
  const HoroscopePredictionModel._();

  const factory HoroscopePredictionModel({
    @JsonKey(unknownEnumValue: ZodiacSign.aries)
    @Default(ZodiacSign.aries)
    ZodiacSign sign,
    @JsonKey(unknownEnumValue: HoroscopePeriod.daily)
    @Default(HoroscopePeriod.daily)
    HoroscopePeriod period,
    @Default('') String textNe,
    @Default('') String textEn,
    @Default('') String textHi,
    @Default(LuckyDetailsModel()) LuckyDetailsModel lucky,
    @Default(HoroscopeMediaModel()) HoroscopeMediaModel media,
    SignProfileModel? profile,
  }) = _HoroscopePredictionModel;

  factory HoroscopePredictionModel.fromJson(Map<String, dynamic> json) =>
      _$HoroscopePredictionModelFromJson(json);

  factory HoroscopePredictionModel.fromEntity(HoroscopePrediction e) =>
      HoroscopePredictionModel(
        sign: e.sign,
        period: e.period,
        textNe: e.textNe,
        textEn: e.textEn,
        textHi: e.textHi,
        lucky: LuckyDetailsModel.fromEntity(e.lucky),
        media: HoroscopeMediaModel.fromEntity(e.media),
        profile: e.profile == null
            ? null
            : SignProfileModel.fromEntity(e.profile!),
      );

  HoroscopePrediction toEntity() => HoroscopePrediction(
    sign: sign,
    period: period,
    textNe: textNe,
    textEn: textEn,
    textHi: textHi,
    lucky: lucky.toEntity(),
    media: media.toEntity(),
    profile: profile?.toEntity(),
  );
}
