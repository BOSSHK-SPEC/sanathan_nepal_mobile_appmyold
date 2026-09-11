import 'package:freezed_annotation/freezed_annotation.dart';

import 'panchanga_detail.dart';
import 'panchanga_element.dart';
import 'planet_position.dart';
import 'time_window.dart';

part 'panchanga.freezed.dart';

/// Full panchanga (पञ्चाङ्ग) of one civil day.
@freezed
abstract class Panchanga with _$Panchanga {
  const Panchanga._();

  const factory Panchanga({
    /// Gregorian civil date (midnight, local).
    required DateTime date,
    required int shakaSamvat,
    required int nepalSamvat,
    required String nepalSamvatMonthNe,
    required String nepalSamvatMonthEn,

    /// e.g. "फागुन शुक्ल पूर्णिमा" / "Falgun Shukla Purnima".
    required String tithiTitleNe,
    required String tithiTitleEn,
    required PanchangaElement tithi,
    required PanchangaElement nakshatra,
    required PanchangaElement karana,
    required PanchangaElement yoga,
    required DateTime sunrise,
    required DateTime sunset,
    required DateTime moonrise,
    required DateTime moonset,

    /// Rows of the day-level "थप जानकारी" table.
    required List<PanchangaDetail> dayDetails,
    required String chandraRashiNe,
    required String chandraRashiEn,
    required String anandadiYogaNe,
    required String anandadiYogaEn,

    /// सूर्योदयकालीन स्पष्ट ग्रहहरू (मंगल, बुध, बृहस्पति, शुक्र, शनि, राहु).
    required List<PlanetPosition> planets,

    /// Inauspicious weekday-based 1/8th-day windows between sunrise and sunset
    /// (shown in India; computed for every region).
    TimeWindow? rahuKaal,
    TimeWindow? yamaganda,
    TimeWindow? gulikaKaal,

    /// Auspicious midday window (solar noon ± 24 min).
    TimeWindow? abhijitMuhurat,

    /// Eight daytime Choghadiya segments (sunrise → sunset), ascending.
    @Default([]) List<TimeWindow> choghadiya,
  }) = _Panchanga;

  String nepalSamvatMonth({required bool nepali}) =>
      nepali ? nepalSamvatMonthNe : nepalSamvatMonthEn;
  String tithiTitle({required bool nepali}) =>
      nepali ? tithiTitleNe : tithiTitleEn;
  String chandraRashi({required bool nepali}) =>
      nepali ? chandraRashiNe : chandraRashiEn;
  String anandadiYoga({required bool nepali}) =>
      nepali ? anandadiYogaNe : anandadiYogaEn;
}
