import 'dart:math' as math;

import '../../../../core/calendar/calendar.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/panchanga.dart';
import '../../domain/entities/panchanga_detail.dart';
import '../../domain/entities/panchanga_element.dart';
import '../../domain/entities/planet_position.dart';
import '../../domain/entities/time_window.dart';
import '../models/panchanga_model.dart';
import '../models/suva_sait_model.dart';
import 'panchanga_data_source.dart';
import 'panchanga_names.dart';
import 'suva_sait_seed.dart';
import 'sun_calculator.dart';

/// Deterministic panchanga generator: sunrise/sunset from a rough solar
/// model for the active region's default city (Kathmandu / New Delhi),
/// tithi/nakshatra/yoga/karana from mean lunar motion, plus the weekday
/// based Rahu Kaal / Yamaganda / Gulika / Abhijit / Choghadiya windows.
/// Values are plausible and stable for a date but are NOT ephemeris-grade.
class MockPanchangaDataSource implements PanchangaDataSource {
  MockPanchangaDataSource({
    required RegionResolver resolver,
    DateTime Function()? now,
  }) : _resolver = resolver,
       _now = now ?? DateTime.now;

  final RegionResolver _resolver;
  final DateTime Function() _now;

  static const double _synodicDays = 29.530588853;
  static const double _tithiDays = _synodicDays / 30;
  static const double _nakshatraDays = 27.321582 / 27;
  static const double _ghatiPerDay = 60;

  /// Days elapsed since the start of the current kalpa / Vikram era at the
  /// J2000 epoch (Surya-Siddhanta style ahargana counters).
  static const double _kalpaAharganaAtJ2000 = 714404100000 + 1955885162.5;
  static const double _vikramAharganaAtJ2000 = 751267.5;

  @override
  Future<PanchangaModel> fetchPanchanga(DateTime date) async {
    // Region is read per call – the user can switch it at runtime.
    final config = _resolver.config;
    final city = config.defaultCity;
    final offsetHours = config.utcOffset.inMinutes / 60;
    final day = DateTime(date.year, date.month, date.day);
    final sunrise = SunCalculator.sunEvent(
      day,
      rise: true,
      lat: city.latitude,
      lon: city.longitude,
      utcOffsetHours: offsetHours,
    );
    final sunset = SunCalculator.sunEvent(
      day,
      rise: false,
      lat: city.latitude,
      lon: city.longitude,
      utcOffsetHours: offsetHours,
    );
    // Days since J2000 at the moment of sunrise.
    final d =
        SunCalculator.julianDays(day, utcOffsetHours: offsetHours) +
        (sunrise.hour * 60 + sunrise.minute) / 1440.0;

    final phase = SunCalculator.moonPhase(d);
    final tithiIndex = (phase * 30).floor().clamp(0, 29);
    final tithiFraction = phase * 30 - tithiIndex;
    final ayan = SunCalculator.ayanamsha(d);
    final sunSid = (SunCalculator.sunLongitude(d) - ayan + 360) % 360;
    final moonSid = (SunCalculator.moonLongitude(d) - ayan + 360) % 360;
    final nakIndex = (moonSid / (360 / 27)).floor() % 27;
    final nakFraction = (moonSid / (360 / 27)) - (moonSid / (360 / 27)).floor();
    final yogaPos = ((sunSid + moonSid) % 360) / (360 / 27);
    final yogaIndex = yogaPos.floor() % 27;
    final yogaFraction = yogaPos - yogaPos.floor();
    final karanaHalf = (phase * 60).floor().clamp(0, 59);
    final karanaFraction = phase * 60 - karanaHalf;

    // Traditional month of the active calendar (BS in Nepal, Saka in India)
    // names the lunar month in the tithi title.
    final traditional = config.calendar.fromGregorian(day);
    final shukla = tithiIndex < 15;

    final tithi = _element(
      names: _tithiName(tithiIndex),
      next: _tithiName((tithiIndex + 1) % 30),
      fraction: tithiFraction,
      lengthDays: _tithiDays,
      sunrise: sunrise,
    );
    final nakshatra = _element(
      names: (
        PanchangaNames.nakshatraNe[nakIndex],
        PanchangaNames.nakshatraEn[nakIndex],
      ),
      next: (
        PanchangaNames.nakshatraNe[(nakIndex + 1) % 27],
        PanchangaNames.nakshatraEn[(nakIndex + 1) % 27],
      ),
      fraction: nakFraction,
      lengthDays: _nakshatraDays,
      sunrise: sunrise,
    );
    final yoga = _element(
      names: (
        PanchangaNames.yogaNe[yogaIndex],
        PanchangaNames.yogaEn[yogaIndex],
      ),
      next: (
        PanchangaNames.yogaNe[(yogaIndex + 1) % 27],
        PanchangaNames.yogaEn[(yogaIndex + 1) % 27],
      ),
      fraction: yogaFraction,
      lengthDays: 27.321582 / 27 * 0.93,
      sunrise: sunrise,
    );
    final karana = _element(
      names: _karanaName(karanaHalf),
      next: _karanaName((karanaHalf + 1) % 60),
      fraction: karanaFraction,
      lengthDays: _tithiDays / 2,
      sunrise: sunrise,
    );

    final moonriseOffset = Duration(minutes: (tithiIndex * 48.8).round());
    final moonrise = _wrapToDay(day, sunrise.add(moonriseOffset));
    final moonset = _wrapToDay(day, sunset.add(moonriseOffset));

    final dinamanGhati =
        sunset.difference(sunrise).inSeconds / 86400 * _ghatiPerDay;
    final sunriseGhati =
        (sunrise.hour * 3600 + sunrise.minute * 60 + sunrise.second) /
        86400 *
        _ghatiPerDay;
    final decl = SunCalculator.declination(d);
    final chandraRashi = (moonSid / 30).floor() % 12;
    final weekday = day.weekday % 7; // 0 = Sunday
    final anandadi =
        ((nakIndex - PanchangaNames.anandadiStart[weekday]) % 27 + 27) % 27;

    final monthNe = config.calendar.monthName(
      traditional.month,
      languageCode: 'ne',
    );
    final monthEn = config.calendar.monthName(
      traditional.month,
      languageCode: 'en',
    );
    final pakshaNe = shukla
        ? PanchangaNames.shuklaNe
        : PanchangaNames.krishnaNe;
    final pakshaEn = shukla
        ? PanchangaNames.shuklaEn
        : PanchangaNames.krishnaEn;
    // Nepal Sambat months follow the Bikram Sambat month regardless of the
    // active region (only displayed in Nepal).
    final nsMonthIndex =
        (const BikramSambatCalendar().fromGregorian(day).month - 1) % 12;
    final nsSuffixNe = shukla ? 'थ्व' : 'गा';
    final nsSuffixEn = shukla ? ' Thwa' : ' Ga';

    final panchanga = Panchanga(
      date: day,
      shakaSamvat: _shakaSamvat(day),
      nepalSamvat: _nepalSamvat(day),
      nepalSamvatMonthNe:
          '${PanchangaNames.nepalSamvatMonthNe[nsMonthIndex]}$nsSuffixNe',
      nepalSamvatMonthEn:
          '${PanchangaNames.nepalSamvatMonthEn[nsMonthIndex]}$nsSuffixEn',
      tithiTitleNe: '$monthNe $pakshaNe ${tithi.nameNe}',
      tithiTitleEn: '$monthEn $pakshaEn ${tithi.nameEn}',
      tithi: tithi,
      nakshatra: nakshatra,
      karana: karana,
      yoga: yoga,
      sunrise: sunrise,
      sunset: sunset,
      moonrise: moonrise,
      moonset: moonset,
      dayDetails: [
        PanchangaDetail(
          labelNe: 'दिनमान (घडीमा)',
          labelEn: 'Day length (ghati)',
          value: dinamanGhati.toStringAsFixed(6),
        ),
        PanchangaDetail(
          labelNe: 'उदयकालीन सूर्यस्पष्ट',
          labelEn: 'Sun at sunrise',
          value: SunCalculator.formatLongitude(sunSid),
        ),
        PanchangaDetail(
          labelNe: 'उदयकालीन चन्द्रस्पष्ट',
          labelEn: 'Moon at sunrise',
          value: SunCalculator.formatLongitude(moonSid),
        ),
        const PanchangaDetail(
          labelNe: 'सूर्यस्पष्ट गति',
          labelEn: 'Sun daily motion',
          value: '0:0:59:8',
        ),
        const PanchangaDetail(
          labelNe: 'चन्द्रस्पष्ट गति',
          labelEn: 'Moon daily motion',
          value: '0:13:10:35',
        ),
        PanchangaDetail(
          labelNe: 'वेलान्तर (मिनेटमा)',
          labelEn: 'Equation of time (min)',
          value: SunCalculator.equationOfTime(d).toStringAsFixed(6),
        ),
        PanchangaDetail(
          labelNe: 'कल्पगत अहर्गण',
          labelEn: 'Kalpa ahargana',
          value: (_kalpaAharganaAtJ2000 + d).toStringAsFixed(6),
        ),
        PanchangaDetail(
          labelNe: 'विक्रम अहर्गण',
          labelEn: 'Vikram ahargana',
          value: (_vikramAharganaAtJ2000 + d).toStringAsFixed(6),
        ),
        PanchangaDetail(
          labelNe: 'अयनांश',
          labelEn: 'Ayanamsha',
          value: ayan.toStringAsFixed(6),
        ),
        PanchangaDetail(
          labelNe: 'सायन सूर्य',
          labelEn: 'Tropical sun',
          value: SunCalculator.formatLongitude(SunCalculator.sunLongitude(d)),
        ),
        const PanchangaDetail(
          labelNe: 'परम क्रान्ति',
          labelEn: 'Max declination',
          value: '23.439281',
        ),
        PanchangaDetail(
          labelNe: 'क्रान्ति',
          labelEn: 'Declination',
          value: decl.toStringAsFixed(6),
        ),
        PanchangaDetail(
          labelNe: 'सूर्योदय (घडीमा)',
          labelEn: 'Sunrise (ghati)',
          value: sunriseGhati.toStringAsFixed(6),
        ),
        PanchangaDetail(
          labelNe: 'सूर्योदय (घण्टामा)',
          labelEn: 'Sunrise (hours)',
          value: (sunriseGhati / 2.5).toStringAsFixed(6),
        ),
        PanchangaDetail(
          labelNe: 'उदयकालीन स्पष्ट चन्द्र',
          labelEn: 'Apparent moon at sunrise',
          value: moonSid.toStringAsFixed(6),
        ),
        PanchangaDetail(
          labelNe: 'स्पष्टान्तर',
          labelEn: 'Sun–moon difference',
          value: ((moonSid - sunSid) % 360).toStringAsFixed(6),
        ),
        const PanchangaDetail(
          labelNe: 'गति अन्तर',
          labelEn: 'Motion difference',
          value: '0:12:11:27',
        ),
        PanchangaDetail(
          labelNe: 'चन्द्रराशि भोग्य (घडीमा)',
          labelEn: 'Moon sign remaining (ghati)',
          value: ((30 - moonSid % 30) / 13.176 * _ghatiPerDay).toStringAsFixed(
            6,
          ),
        ),
      ],
      chandraRashiNe: PanchangaNames.rashiNe[chandraRashi],
      chandraRashiEn: PanchangaNames.rashiEn[chandraRashi],
      anandadiYogaNe: PanchangaNames.anandadiNe[anandadi],
      anandadiYogaEn: PanchangaNames.anandadiEn[anandadi],
      planets: _planets(d, ayan),
      rahuKaal: _kaal(TimeWindowKind.rahuKaal, weekday, sunrise, sunset),
      yamaganda: _kaal(TimeWindowKind.yamaganda, weekday, sunrise, sunset),
      gulikaKaal: _kaal(TimeWindowKind.gulikaKaal, weekday, sunrise, sunset),
      abhijitMuhurat: _abhijit(sunrise, sunset),
      choghadiya: _choghadiya(weekday, sunrise, sunset),
    );
    return PanchangaModel.fromEntity(panchanga);
  }

  @override
  Future<List<SuvaSaitModel>> fetchSuvaSaits() async =>
      SuvaSaitSeed.build(config: _resolver.config, today: _now());

  // ---------------------------------------------------------------- helpers

  /// 1-based day-segment (of 8 between sunrise and sunset) per weekday
  /// (0 = Sunday) for Rahu Kaal, Yamaganda and Gulika Kaal.
  static const List<int> _rahuSegment = [8, 2, 7, 5, 6, 4, 3];
  static const List<int> _yamaSegment = [5, 4, 3, 2, 1, 7, 6];
  static const List<int> _gulikaSegment = [7, 6, 5, 4, 3, 2, 1];

  /// Choghadiya cycle (index into [_choghadiyaNe]/[_choghadiyaEn]) and the
  /// starting index of the day sequence per weekday (0 = Sunday).
  static const List<String> _choghadiyaNe = [
    'उद्वेग',
    'चर',
    'लाभ',
    'अमृत',
    'काल',
    'शुभ',
    'रोग',
  ];
  static const List<String> _choghadiyaEn = [
    'Udveg',
    'Char',
    'Labh',
    'Amrit',
    'Kaal',
    'Shubh',
    'Rog',
  ];
  static const List<ChoghadiyaQuality> _choghadiyaQuality = [
    ChoghadiyaQuality.bad,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.bad,
    ChoghadiyaQuality.good,
    ChoghadiyaQuality.bad,
  ];
  static const List<int> _choghadiyaStart = [0, 3, 6, 2, 5, 1, 4];

  static TimeWindow _kaal(
    TimeWindowKind kind,
    int weekday,
    DateTime sunrise,
    DateTime sunset,
  ) {
    final table = switch (kind) {
      TimeWindowKind.rahuKaal => _rahuSegment,
      TimeWindowKind.yamaganda => _yamaSegment,
      _ => _gulikaSegment,
    };
    final segment = Duration(
      seconds: sunset.difference(sunrise).inSeconds ~/ 8,
    );
    final start = sunrise.add(segment * (table[weekday] - 1));
    return TimeWindow(kind: kind, start: start, end: start.add(segment));
  }

  static TimeWindow _abhijit(DateTime sunrise, DateTime sunset) {
    final midday = sunrise.add(
      Duration(seconds: sunset.difference(sunrise).inSeconds ~/ 2),
    );
    const half = Duration(minutes: 24);
    return TimeWindow(
      kind: TimeWindowKind.abhijit,
      start: midday.subtract(half),
      end: midday.add(half),
      nameNe: 'अभिजित',
      nameEn: 'Abhijit',
      quality: ChoghadiyaQuality.good,
    );
  }

  static List<TimeWindow> _choghadiya(
    int weekday,
    DateTime sunrise,
    DateTime sunset,
  ) {
    final segment = Duration(
      seconds: sunset.difference(sunrise).inSeconds ~/ 8,
    );
    return [
      for (var i = 0; i < 8; i++)
        () {
          final idx = (_choghadiyaStart[weekday] + i) % 7;
          final start = sunrise.add(segment * i);
          return TimeWindow(
            kind: TimeWindowKind.choghadiya,
            start: start,
            end: i == 7 ? sunset : start.add(segment),
            nameNe: _choghadiyaNe[idx],
            nameEn: _choghadiyaEn[idx],
            quality: _choghadiyaQuality[idx],
          );
        }(),
    ];
  }

  PanchangaElement _element({
    required (String, String) names,
    required (String, String) next,
    required double fraction,
    required double lengthDays,
    required DateTime sunrise,
  }) {
    final remainingDays = (1 - fraction) * lengthDays;
    final endsAt = sunrise.add(
      Duration(seconds: (remainingDays * 86400).round()),
    );
    final bhogya = remainingDays * _ghatiPerDay;
    final bhukta = fraction * lengthDays * _ghatiPerDay;
    return PanchangaElement(
      nameNe: names.$1,
      nameEn: names.$2,
      endsAt: endsAt,
      nextNe: next.$1,
      nextEn: next.$2,
      ghatiPala: _ghatiPala(bhogya),
      bhukta: bhukta,
      bhogya: bhogya,
      spashta: bhukta + bhogya,
    );
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

  static (String, String) _tithiName(int index) {
    final i = index % 15;
    if (i == 14) {
      return index < 15
          ? (PanchangaNames.purnimaNe, PanchangaNames.purnimaEn)
          : (PanchangaNames.amavasyaNe, PanchangaNames.amavasyaEn);
    }
    return (PanchangaNames.tithiNe[i], PanchangaNames.tithiEn[i]);
  }

  static (String, String) _karanaName(int half) {
    // half 0 = Kimstughna, 1..56 = movable cycle, 57..59 = fixed.
    final int i;
    if (half == 0) {
      i = 10;
    } else if (half <= 56) {
      i = (half - 1) % 7;
    } else {
      i = 7 + (half - 57);
    }
    return (PanchangaNames.karanaNe[i], PanchangaNames.karanaEn[i]);
  }

  static DateTime _wrapToDay(DateTime day, DateTime t) {
    var r = t;
    while (r.day != day.day || r.month != day.month) {
      r = r.subtract(const Duration(days: 1));
    }
    return r;
  }

  static int _shakaSamvat(DateTime d) =>
      d.year - (d.month < 3 || (d.month == 3 && d.day < 22) ? 79 : 78);

  static int _nepalSamvat(DateTime d) =>
      d.year - (d.month < 10 || (d.month == 10 && d.day < 20) ? 880 : 879);

  static List<PlanetPosition> _planets(double d, double ayan) {
    // Mean daily motions (deg/day) and J2000 mean longitudes.
    const rates = [0.5240, 4.0923, 0.0831, 1.6021, 0.0335, -0.0530];
    const epoch = [355.45, 252.25, 34.40, 181.98, 49.94, 125.04];
    final sun = SunCalculator.sunLongitude(d);
    final positions = <double>[];
    for (var i = 0; i < rates.length; i++) {
      var lon = (epoch[i] + rates[i] * d) % 360;
      // Inner planets stay within elongation limits of the Sun.
      if (i == 1) lon = sun + 22 * math.sin(lon * math.pi / 180);
      if (i == 3) lon = sun + 45 * math.sin(lon * math.pi / 180);
      positions.add(((lon - ayan) % 360 + 360) % 360);
    }
    return [
      for (var i = 0; i < positions.length; i++)
        PlanetPosition(
          nameNe: PanchangaNames.planetNe[i],
          nameEn: PanchangaNames.planetEn[i],
          value: SunCalculator.formatLongitude(positions[i]),
        ),
    ];
  }
}
