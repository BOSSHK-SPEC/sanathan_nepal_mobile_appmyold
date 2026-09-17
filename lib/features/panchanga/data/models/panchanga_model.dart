import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/panchanga.dart';
import '../../domain/entities/time_window.dart';
import 'panchanga_detail_model.dart';
import 'panchanga_element_model.dart';
import 'planet_position_model.dart';
import 'time_window_model.dart';

part 'panchanga_model.freezed.dart';
part 'panchanga_model.g.dart';

/// Serialisable [Panchanga].
@freezed
abstract class PanchangaModel with _$PanchangaModel {
  const PanchangaModel._();

  const factory PanchangaModel({
    required DateTime date,
    required int shakaSamvat,
    required int nepalSamvat,
    @Default('') String nepalSamvatMonthNe,
    @Default('') String nepalSamvatMonthEn,
    @Default('') String tithiTitleNe,
    @Default('') String tithiTitleEn,
    required PanchangaElementModel tithi,
    required PanchangaElementModel nakshatra,
    required PanchangaElementModel karana,
    required PanchangaElementModel yoga,
    required DateTime sunrise,
    required DateTime sunset,
    required DateTime moonrise,
    required DateTime moonset,
    @Default([]) List<PanchangaDetailModel> dayDetails,
    @Default('') String chandraRashiNe,
    @Default('') String chandraRashiEn,
    @Default('') String anandadiYogaNe,
    @Default('') String anandadiYogaEn,
    @Default([]) List<PlanetPositionModel> planets,
    TimeWindowModel? rahuKaal,
    TimeWindowModel? yamaganda,
    TimeWindowModel? gulikaKaal,
    TimeWindowModel? abhijitMuhurat,
    @Default([]) List<TimeWindowModel> choghadiya,
    @JsonKey(unknownEnumValue: PanchangaSource.approximate)
    @Default(PanchangaSource.approximate)
    PanchangaSource source,
  }) = _PanchangaModel;

  factory PanchangaModel.fromJson(Map<String, dynamic> json) =>
      _$PanchangaModelFromJson(json);

  factory PanchangaModel.fromEntity(Panchanga e) => PanchangaModel(
    date: e.date,
    shakaSamvat: e.shakaSamvat,
    nepalSamvat: e.nepalSamvat,
    nepalSamvatMonthNe: e.nepalSamvatMonthNe,
    nepalSamvatMonthEn: e.nepalSamvatMonthEn,
    tithiTitleNe: e.tithiTitleNe,
    tithiTitleEn: e.tithiTitleEn,
    tithi: PanchangaElementModel.fromEntity(e.tithi),
    nakshatra: PanchangaElementModel.fromEntity(e.nakshatra),
    karana: PanchangaElementModel.fromEntity(e.karana),
    yoga: PanchangaElementModel.fromEntity(e.yoga),
    sunrise: e.sunrise,
    sunset: e.sunset,
    moonrise: e.moonrise,
    moonset: e.moonset,
    dayDetails: [
      for (final d in e.dayDetails) PanchangaDetailModel.fromEntity(d),
    ],
    chandraRashiNe: e.chandraRashiNe,
    chandraRashiEn: e.chandraRashiEn,
    anandadiYogaNe: e.anandadiYogaNe,
    anandadiYogaEn: e.anandadiYogaEn,
    planets: [for (final p in e.planets) PlanetPositionModel.fromEntity(p)],
    rahuKaal: _window(e.rahuKaal),
    yamaganda: _window(e.yamaganda),
    gulikaKaal: _window(e.gulikaKaal),
    abhijitMuhurat: _window(e.abhijitMuhurat),
    choghadiya: [for (final c in e.choghadiya) TimeWindowModel.fromEntity(c)],
    source: e.source,
  );

  Panchanga toEntity() => Panchanga(
    date: date,
    shakaSamvat: shakaSamvat,
    nepalSamvat: nepalSamvat,
    nepalSamvatMonthNe: nepalSamvatMonthNe,
    nepalSamvatMonthEn: nepalSamvatMonthEn,
    tithiTitleNe: tithiTitleNe,
    tithiTitleEn: tithiTitleEn,
    tithi: tithi.toEntity(),
    nakshatra: nakshatra.toEntity(),
    karana: karana.toEntity(),
    yoga: yoga.toEntity(),
    sunrise: sunrise,
    sunset: sunset,
    moonrise: moonrise,
    moonset: moonset,
    dayDetails: [for (final d in dayDetails) d.toEntity()],
    chandraRashiNe: chandraRashiNe,
    chandraRashiEn: chandraRashiEn,
    anandadiYogaNe: anandadiYogaNe,
    anandadiYogaEn: anandadiYogaEn,
    planets: [for (final p in planets) p.toEntity()],
    rahuKaal: rahuKaal?.toEntity(),
    yamaganda: yamaganda?.toEntity(),
    gulikaKaal: gulikaKaal?.toEntity(),
    abhijitMuhurat: abhijitMuhurat?.toEntity(),
    choghadiya: [for (final c in choghadiya) c.toEntity()],
    source: source,
  );

  static TimeWindowModel? _window(TimeWindow? w) =>
      w == null ? null : TimeWindowModel.fromEntity(w);
}
