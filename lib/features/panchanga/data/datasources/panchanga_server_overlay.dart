import '../../domain/entities/panchanga.dart';
import '../../domain/entities/panchanga_detail.dart';
import '../../domain/entities/panchanga_element.dart';
import '../../domain/entities/planet_position.dart';
import '../../domain/entities/time_window.dart';
import 'muhurta_windows.dart';
import 'panchanga_names.dart';
import 'sun_calculator.dart';

/// Lays the server's panchanga for a day over the on-device calculation.
///
/// The server computes from an ephemeris and has been checked against Drik
/// Panchang; the device's calculation is a mean-motion estimate that can put
/// the tithi a day out. So every value the server computes replaces the
/// estimate, and the estimate is kept only for what the server does not send
/// (the static daily-motion rows, the ahargana counters).
///
/// Two payload shapes are understood:
///
/// * `panchanga/v1` — the ephemeris engine's full day.
/// * the older editorial shape (`{tithi: {name, endsAt: "HH:MM"}, sunrise}`),
///   kept so a hand-published row still overlays as it always did.
abstract final class PanchangaServerOverlay {
  static const String schemaV1 = 'panchanga/v1';

  static Panchanga apply(Panchanga base, Map<String, dynamic> payload) =>
      payload['schema'] == schemaV1
      ? _v1(base, payload)
      : _legacy(base, payload);

  // ------------------------------------------------------------------ v1

  static Panchanga _v1(Panchanga base, Map<String, dynamic> p) {
    final sunrise = _local(p['sunriseLocal']) ?? base.sunrise;
    final sunset = _local(p['sunsetLocal']) ?? base.sunset;
    final weekday = (p['weekday'] as num?)?.toInt() ?? base.date.weekday % 7;

    final tithi = _map(p['tithi']);
    final shukla = tithi?['paksha'] != 'krishna';
    final lunarMonth = _map(p['lunarMonth']);
    final purnimanta = _names(_map(lunarMonth?['purnimanta']));
    final adhika = lunarMonth?['isAdhika'] == true;
    final tithiNames = _names(tithi);

    final nakshatra = _map(p['nakshatra']);
    final nakIndex = (nakshatra?['index'] as num?)?.toInt();
    final moonRashi = _names(_map(p['moonRashi']));
    final samvat = _map(p['samvat']);
    final nepal = _map(samvat?['nepal']);
    final nepalMonth = _names(_map(nepal?['month']));
    final windows = _map(p['windows']);

    final tithiTitle = (tithiNames != null && purnimanta != null)
        ? (
            ne:
                '${purnimanta.ne}${adhika ? ' अधिक' : ''} '
                '${shukla ? PanchangaNames.shuklaNe : PanchangaNames.krishnaNe} '
                '${tithiNames.ne}',
            en:
                '${adhika ? 'Adhika ' : ''}${purnimanta.en} '
                '${shukla ? PanchangaNames.shuklaEn : PanchangaNames.krishnaEn} '
                '${tithiNames.en}',
          )
        : null;

    final abhijit = _window(TimeWindowKind.abhijit, windows?['abhijit']);

    return base.copyWith(
      source: PanchangaSource.computed,
      sunrise: sunrise,
      sunset: sunset,
      moonrise: _local(p['moonriseLocal']) ?? base.moonrise,
      moonset: _local(p['moonsetLocal']) ?? base.moonset,
      tithi: _limb(base.tithi, tithi, sunrise),
      nakshatra: _limb(base.nakshatra, nakshatra, sunrise),
      yoga: _limb(base.yoga, _map(p['yoga']), sunrise),
      karana: _limb(base.karana, _map(p['karana']), sunrise),
      tithiTitleNe: tithiTitle?.ne ?? base.tithiTitleNe,
      tithiTitleEn: tithiTitle?.en ?? base.tithiTitleEn,
      chandraRashiNe: moonRashi?.ne ?? base.chandraRashiNe,
      chandraRashiEn: moonRashi?.en ?? base.chandraRashiEn,
      anandadiYogaNe: nakIndex == null
          ? base.anandadiYogaNe
          : PanchangaNames.anandadiNe[_anandadi(nakIndex, weekday)],
      anandadiYogaEn: nakIndex == null
          ? base.anandadiYogaEn
          : PanchangaNames.anandadiEn[_anandadi(nakIndex, weekday)],
      shakaSamvat: (samvat?['shaka'] as num?)?.toInt() ?? base.shakaSamvat,
      nepalSamvat: (nepal?['year'] as num?)?.toInt() ?? base.nepalSamvat,
      nepalSamvatMonthNe: nepalMonth == null
          ? base.nepalSamvatMonthNe
          : '${nepalMonth.ne}${shukla ? 'थ्व' : 'गा'}',
      nepalSamvatMonthEn: nepalMonth == null
          ? base.nepalSamvatMonthEn
          : '${nepalMonth.en}${shukla ? ' Thwa' : ' Ga'}',
      planets: _planets(p['planets']) ?? base.planets,
      rahuKaal:
          _window(TimeWindowKind.rahuKaal, windows?['rahuKaal']) ??
          base.rahuKaal,
      yamaganda:
          _window(TimeWindowKind.yamaganda, windows?['yamaganda']) ??
          base.yamaganda,
      gulikaKaal:
          _window(TimeWindowKind.gulikaKaal, windows?['gulikaKaal']) ??
          base.gulikaKaal,
      abhijitMuhurat:
          abhijit?.copyWith(
            nameNe: 'अभिजित',
            nameEn: 'Abhijit',
            quality: ChoghadiyaQuality.good,
          ) ??
          base.abhijitMuhurat,
      // Choghadiya is a pure function of sunrise and sunset, so it follows
      // the accurate ones rather than staying on the estimate's.
      choghadiya: MuhurtaWindows.choghadiya(weekday, sunrise, sunset),
      dayDetails: _details(base.dayDetails, p, sunrise),
    );
  }

  /// A limb's names and end time from the server; the ghati figures are
  /// derived from that end time, measured from the server's sunrise.
  static PanchangaElement _limb(
    PanchangaElement base,
    Map<String, dynamic>? m,
    DateTime sunrise,
  ) {
    if (m == null) return base;
    final names = _names(m);
    final next = _names(_map(m['next']));
    final endsAt = _local(m['endsAtLocal']) ?? base.endsAt;
    final remaining = endsAt.difference(sunrise).inSeconds / 86400 * 60;
    final bhogya = remaining < 0 ? 0.0 : remaining;
    final elapsed = base.spashta - bhogya;
    final bhukta = elapsed < 0 ? 0.0 : elapsed;
    return base.copyWith(
      nameNe: names?.ne ?? base.nameNe,
      nameEn: names?.en ?? base.nameEn,
      endsAt: endsAt,
      nextNe: next?.ne ?? base.nextNe,
      nextEn: next?.en ?? base.nextEn,
      ghatiPala: _ghatiPala(bhogya),
      bhogya: bhogya,
      bhukta: bhukta,
      spashta: bhukta + bhogya,
    );
  }

  /// The six planets the grid shows, in its order; `null` unless the server
  /// sent all of them, so the grid never mixes calculated and estimated rows.
  static List<PlanetPosition>? _planets(Object? raw) {
    if (raw is! List) return null;
    final byKey = {
      for (final entry in raw.whereType<Map>())
        '${entry['key']}': Map<String, dynamic>.from(entry),
    };
    const order = ['mars', 'mercury', 'jupiter', 'venus', 'saturn', 'rahu'];
    final planets = <PlanetPosition>[];
    for (final key in order) {
      final planet = byKey[key];
      final longitude = (planet?['siderealLongitude'] as num?)?.toDouble();
      final names = _names(planet);
      if (longitude == null || names == null) return null;
      planets.add(
        PlanetPosition(
          nameNe: names.ne,
          nameEn: names.en,
          value: SunCalculator.formatLongitude(longitude),
        ),
      );
    }
    return planets;
  }

  static List<PanchangaDetail> _details(
    List<PanchangaDetail> base,
    Map<String, dynamic> p,
    DateTime sunrise,
  ) {
    final at = _map(p['atSunrise']);
    if (at == null) return base;
    double? number(String key) => (at[key] as num?)?.toDouble();
    final sunSid = number('sunSiderealLongitude');
    final moonSid = number('moonSiderealLongitude');
    final sunTropical = number('sunTropicalLongitude');
    final ayanamsa = number('ayanamsa');
    final declination = number('sunDeclination');
    final dayLength = (p['dayLengthMinutes'] as num?)?.toDouble();
    final sunriseGhati =
        (sunrise.hour * 3600 + sunrise.minute * 60 + sunrise.second) /
        86400 *
        60;

    final replacements = <String, String?>{
      'Day length (ghati)': dayLength == null
          ? null
          : (dayLength / 24).toStringAsFixed(6),
      'Sun at sunrise': sunSid == null
          ? null
          : SunCalculator.formatLongitude(sunSid),
      'Moon at sunrise': moonSid == null
          ? null
          : SunCalculator.formatLongitude(moonSid),
      'Ayanamsha': ayanamsa?.toStringAsFixed(6),
      'Tropical sun': sunTropical == null
          ? null
          : SunCalculator.formatLongitude(sunTropical),
      'Declination': declination?.toStringAsFixed(6),
      'Sunrise (ghati)': sunriseGhati.toStringAsFixed(6),
      'Sunrise (hours)': (sunriseGhati / 2.5).toStringAsFixed(6),
      'Apparent moon at sunrise': moonSid?.toStringAsFixed(6),
      'Sun–moon difference': (sunSid == null || moonSid == null)
          ? null
          : (((moonSid - sunSid) % 360 + 360) % 360).toStringAsFixed(6),
      'Moon sign remaining (ghati)': moonSid == null
          ? null
          : ((30 - moonSid % 30) / 13.176 * 60).toStringAsFixed(6),
    };
    return [
      for (final detail in base)
        switch (replacements[detail.labelEn]) {
          final String value => detail.copyWith(value: value),
          _ => detail,
        },
    ];
  }

  // -------------------------------------------------------------- legacy

  /// The editorial shape: only the fields it carries replace the estimate.
  static Panchanga _legacy(Panchanga base, Map<String, dynamic> p) =>
      base.copyWith(
        tithi: _legacyElement(base.tithi, p['tithi'], base.date),
        nakshatra: _legacyElement(base.nakshatra, p['nakshatra'], base.date),
        yoga: _legacyElement(base.yoga, p['yoga'], base.date),
        karana: _legacyElement(base.karana, p['karana'], base.date),
        sunrise: _timeOn(base.date, p['sunrise']) ?? base.sunrise,
        sunset: _timeOn(base.date, p['sunset']) ?? base.sunset,
        moonrise: _timeOn(base.date, p['moonrise']) ?? base.moonrise,
        moonset: _timeOn(base.date, p['moonset']) ?? base.moonset,
      );

  static PanchangaElement _legacyElement(
    PanchangaElement base,
    Object? raw,
    DateTime date,
  ) {
    if (raw is! Map) return base;
    final published = Map<String, dynamic>.from(raw);
    return base.copyWith(
      nameEn: published['name'] as String? ?? base.nameEn,
      // The published name is a single string; Nepali readers keep the
      // Devanagari name rather than being shown a transliteration.
      nameNe: published['nameNe'] as String? ?? base.nameNe,
      endsAt: _timeOn(date, published['endsAt']) ?? base.endsAt,
    );
  }

  // ------------------------------------------------------------- helpers

  static Map<String, dynamic>? _map(Object? raw) =>
      raw is Map ? Map<String, dynamic>.from(raw) : null;

  static ({String ne, String en})? _names(Map<String, dynamic>? m) {
    final names = _map(m?['names']);
    final en = names?['en'];
    final ne = names?['ne'];
    if (en is! String || ne is! String) return null;
    return (ne: ne, en: en);
  }

  /// `YYYY-MM-DDTHH:mm:ss` wall clock, as the server writes it — read as local
  /// time without conversion, because a patro prints its city's clock.
  static DateTime? _local(Object? raw) {
    if (raw is! String || raw.length < 16) return null;
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return null;
    return parsed.isUtc ? parsed.toLocal() : parsed;
  }

  static TimeWindow? _window(TimeWindowKind kind, Object? raw) {
    final m = _map(raw);
    final start = _local(m?['startLocal']);
    final end = _local(m?['endLocal']);
    if (start == null || end == null) return null;
    return TimeWindow(kind: kind, start: start, end: end);
  }

  static int _anandadi(int nakshatraIndex, int weekday) =>
      ((nakshatraIndex - PanchangaNames.anandadiStart[weekday % 7]) % 27 + 27) %
      27;

  /// `"14:32"` on [date].
  static DateTime? _timeOn(DateTime date, Object? raw) {
    if (raw is! String) return null;
    final parts = raw.split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  /// `घडी:पला:विपला:प्रतिविपला` from a ghati value.
  static String _ghatiPala(double ghati) {
    final g = ghati.floor();
    final palaF = (ghati - g) * 60;
    final p = palaF.floor();
    final vipalaF = (palaF - p) * 60;
    final v = vipalaF.floor();
    final pv = ((vipalaF - v) * 60).floor();
    return '$g:$p:$v:$pv';
  }
}
