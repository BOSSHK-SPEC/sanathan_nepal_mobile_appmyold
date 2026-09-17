import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/day_panchanga.dart';
import '../../domain/entities/lunar_day.dart';

part 'day_panchanga_model.freezed.dart';

/// Wire shape of one `GET /almanac/panchanga/range` entry.
@freezed
abstract class DayPanchangaModel with _$DayPanchangaModel {
  const DayPanchangaModel._();

  const factory DayPanchangaModel({
    required DateTime date,
    required int tithiIndex,
    required String tithiEn,
    required String tithiNe,
    @Default('') String tithiHi,
    required bool krishna,
    DateTime? tithiEndsAt,
    required String nakshatraEn,
    required String nakshatraNe,
    @Default('') String nakshatraHi,
    required String yogaEn,
    required String yogaNe,
    @Default('') String yogaHi,
    required String karanaEn,
    required String karanaNe,
    @Default('') String karanaHi,
    required String moonRashiEn,
    required String moonRashiNe,
    @Default('') String moonRashiHi,
    required String lunarMonthEn,
    required String lunarMonthNe,
    @Default('') String lunarMonthHi,
    @Default(false) bool isAdhikaMonth,
    @Default(<String>[]) List<String> vrat,
    required DateTime sunrise,
    required DateTime sunset,
    @Default(false) bool isApproximate,
  }) = _DayPanchangaModel;

  /// `null` when the entry is missing something the grid cannot do without,
  /// so one malformed day drops out instead of failing the whole month.
  static DayPanchangaModel? fromWire(Map<String, dynamic> json) {
    final date = _day(json['date']);
    final tithi = _map(json['tithi']);
    final tithiNames = _names(tithi);
    final tithiIndex = (tithi?['index'] as num?)?.toInt();
    final nakshatra = _names(_map(json['nakshatra']));
    final yoga = _names(_map(json['yoga']));
    final karana = _names(_map(json['karana']));
    final rashi = _names(_map(json['moonRashi']));
    final lunarMonth = _map(json['lunarMonth']);
    final month = _names(_map(lunarMonth?['purnimanta']));
    final sunrise = _local(json['sunriseLocal']);
    final sunset = _local(json['sunsetLocal']);
    if (date == null ||
        tithiNames == null ||
        tithiIndex == null ||
        tithiIndex < 0 ||
        tithiIndex > 29 ||
        nakshatra == null ||
        yoga == null ||
        karana == null ||
        rashi == null ||
        month == null ||
        sunrise == null ||
        sunset == null) {
      return null;
    }
    return DayPanchangaModel(
      date: date,
      tithiIndex: tithiIndex,
      tithiEn: tithiNames.en,
      tithiNe: tithiNames.ne,
      tithiHi: tithiNames.hi,
      krishna: tithi?['paksha'] == 'krishna',
      tithiEndsAt: _local(tithi?['endsAtLocal']),
      nakshatraEn: nakshatra.en,
      nakshatraNe: nakshatra.ne,
      nakshatraHi: nakshatra.hi,
      yogaEn: yoga.en,
      yogaNe: yoga.ne,
      yogaHi: yoga.hi,
      karanaEn: karana.en,
      karanaNe: karana.ne,
      karanaHi: karana.hi,
      moonRashiEn: rashi.en,
      moonRashiNe: rashi.ne,
      moonRashiHi: rashi.hi,
      lunarMonthEn: month.en,
      lunarMonthNe: month.ne,
      lunarMonthHi: month.hi,
      isAdhikaMonth: lunarMonth?['isAdhika'] == true,
      vrat: [
        for (final v in (json['vrat'] as List?) ?? const [])
          if (v is String) v,
      ],
      sunrise: sunrise,
      sunset: sunset,
    );
  }

  factory DayPanchangaModel.fromEntity(DayPanchanga e) => DayPanchangaModel(
    date: e.date,
    tithiIndex: e.tithiIndex,
    tithiEn: e.tithi.en,
    tithiNe: e.tithi.ne,
    tithiHi: e.tithi.hi,
    krishna: e.paksha == Paksha.krishna,
    tithiEndsAt: e.tithiEndsAt,
    nakshatraEn: e.nakshatra.en,
    nakshatraNe: e.nakshatra.ne,
    nakshatraHi: e.nakshatra.hi,
    yogaEn: e.yoga.en,
    yogaNe: e.yoga.ne,
    yogaHi: e.yoga.hi,
    karanaEn: e.karana.en,
    karanaNe: e.karana.ne,
    karanaHi: e.karana.hi,
    moonRashiEn: e.moonRashi.en,
    moonRashiNe: e.moonRashi.ne,
    moonRashiHi: e.moonRashi.hi,
    lunarMonthEn: e.lunarMonth.en,
    lunarMonthNe: e.lunarMonth.ne,
    lunarMonthHi: e.lunarMonth.hi,
    isAdhikaMonth: e.isAdhikaMonth,
    vrat: [for (final v in e.vrat) v.name],
    sunrise: e.sunrise,
    sunset: e.sunset,
    isApproximate: e.isApproximate,
  );

  DayPanchanga toEntity() => DayPanchanga(
    date: date,
    tithiIndex: tithiIndex,
    tithi: PanchangaText(en: tithiEn, ne: tithiNe, hi: tithiHi),
    paksha: krishna ? Paksha.krishna : Paksha.shukla,
    tithiEndsAt: tithiEndsAt,
    nakshatra: PanchangaText(en: nakshatraEn, ne: nakshatraNe, hi: nakshatraHi),
    yoga: PanchangaText(en: yogaEn, ne: yogaNe, hi: yogaHi),
    karana: PanchangaText(en: karanaEn, ne: karanaNe, hi: karanaHi),
    moonRashi: PanchangaText(en: moonRashiEn, ne: moonRashiNe, hi: moonRashiHi),
    lunarMonth: PanchangaText(
      en: lunarMonthEn,
      ne: lunarMonthNe,
      hi: lunarMonthHi,
    ),
    isAdhikaMonth: isAdhikaMonth,
    vrat: [for (final v in vrat) ?VratKind.fromName(v)],
    sunrise: sunrise,
    sunset: sunset,
    isApproximate: isApproximate,
  );

  static Map<String, dynamic>? _map(Object? raw) =>
      raw is Map ? Map<String, dynamic>.from(raw) : null;

  static ({String en, String ne, String hi})? _names(Map<String, dynamic>? m) {
    final names = _map(m?['names']);
    final en = names?['en'];
    final ne = names?['ne'];
    if (en is! String || ne is! String) return null;
    final hi = names?['hi'];
    return (en: en, ne: ne, hi: hi is String ? hi : '');
  }

  static DateTime? _day(Object? raw) {
    if (raw is! String) return null;
    final parsed = DateTime.tryParse(raw);
    return parsed == null
        ? null
        : DateTime(parsed.year, parsed.month, parsed.day);
  }

  /// Wall-clock `YYYY-MM-DDTHH:mm:ss` at the region's reference city.
  static DateTime? _local(Object? raw) {
    if (raw is! String || raw.length < 16) return null;
    return DateTime.tryParse(raw);
  }
}
