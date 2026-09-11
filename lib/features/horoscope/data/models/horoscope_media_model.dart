import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/horoscope_media.dart';

part 'horoscope_media_model.freezed.dart';
part 'horoscope_media_model.g.dart';

/// Wire shape of [HoroscopeMedia] (`duration` is carried in seconds).
@freezed
abstract class HoroscopeMediaModel with _$HoroscopeMediaModel {
  const HoroscopeMediaModel._();

  const factory HoroscopeMediaModel({
    @Default('') String titleNe,
    @Default('') String titleEn,
    @Default('') String titleHi,
    @JsonKey(name: 'duration') @Default(0) int durationSeconds,
    String? url,
  }) = _HoroscopeMediaModel;

  factory HoroscopeMediaModel.fromJson(Map<String, dynamic> json) =>
      _$HoroscopeMediaModelFromJson(json);

  factory HoroscopeMediaModel.fromEntity(HoroscopeMedia e) =>
      HoroscopeMediaModel(
        titleNe: e.titleNe,
        titleEn: e.titleEn,
        titleHi: e.titleHi,
        durationSeconds: e.duration.inSeconds,
        url: e.url,
      );

  HoroscopeMedia toEntity() => HoroscopeMedia(
    titleNe: titleNe,
    titleEn: titleEn,
    titleHi: titleHi,
    duration: Duration(seconds: durationSeconds),
    url: url,
  );
}
