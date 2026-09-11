import 'dart:math' as math;

import '../../../../core/region/region.dart';
import '../entities/panchanga_info.dart';
import 'lunar_calculator.dart';

/// Deterministic, ephemeris-free Panchanga approximation.
///
/// Good enough for UI decoration – NOT for ritual timing. Everything is
/// derived from the mean solar longitude and mean moon age so results are
/// stable across runs and platforms. Sunrise/sunset are computed for the
/// given location (default: Kathmandu / NST; pass `RegionConfig` for the
/// region's default city – New Delhi / IST in India).
abstract final class PanchangaApproximator {
  static const double _kathmanduLat = 27.7172;
  static const double _kathmanduLon = 85.3240;
  static const Duration _nptOffset = Duration(hours: 5, minutes: 45);

  static const List<String> nakshatraNe = [
    'अश्विनी',
    'भरणी',
    'कृत्तिका',
    'रोहिणी',
    'मृगशिरा',
    'आर्द्रा',
    'पुनर्वसु',
    'पुष्य',
    'आश्लेषा',
    'मघा',
    'पूर्वफाल्गुनी',
    'उत्तरफाल्गुनी',
    'हस्त',
    'चित्रा',
    'स्वाती',
    'विशाखा',
    'अनुराधा',
    'ज्येष्ठा',
    'मूल',
    'पूर्वाषाढा',
    'उत्तराषाढा',
    'श्रवण',
    'धनिष्ठा',
    'शतभिषा',
    'पूर्वभाद्रपदा',
    'उत्तरभाद्रपदा',
    'रेवती',
  ];
  static const List<String> nakshatraEn = [
    'Ashwini',
    'Bharani',
    'Krittika',
    'Rohini',
    'Mrigashira',
    'Ardra',
    'Punarvasu',
    'Pushya',
    'Ashlesha',
    'Magha',
    'Purva Phalguni',
    'Uttara Phalguni',
    'Hasta',
    'Chitra',
    'Swati',
    'Vishakha',
    'Anuradha',
    'Jyeshtha',
    'Mula',
    'Purva Ashadha',
    'Uttara Ashadha',
    'Shravana',
    'Dhanishtha',
    'Shatabhisha',
    'Purva Bhadrapada',
    'Uttara Bhadrapada',
    'Revati',
  ];
  static const List<String> yogNe = [
    'विष्कम्भ',
    'प्रीति',
    'आयुष्मान',
    'सौभाग्य',
    'शोभन',
    'अतिगण्ड',
    'सुकर्मा',
    'धृति',
    'शूल',
    'गण्ड',
    'वृद्धि',
    'ध्रुव',
    'व्याघात',
    'हर्षण',
    'वज्र',
    'सिद्धि',
    'व्यतीपात',
    'वरीयान',
    'परिघ',
    'शिव',
    'सिद्ध',
    'साध्य',
    'शुभ',
    'शुक्ल',
    'ब्रह्म',
    'इन्द्र',
    'वैधृति',
  ];
  static const List<String> yogEn = [
    'Vishkambha',
    'Priti',
    'Ayushman',
    'Saubhagya',
    'Shobhana',
    'Atiganda',
    'Sukarma',
    'Dhriti',
    'Shula',
    'Ganda',
    'Vriddhi',
    'Dhruva',
    'Vyaghata',
    'Harshana',
    'Vajra',
    'Siddhi',
    'Vyatipata',
    'Variyan',
    'Parigha',
    'Shiva',
    'Siddha',
    'Sadhya',
    'Shubha',
    'Shukla',
    'Brahma',
    'Indra',
    'Vaidhriti',
  ];
  static const List<String> karanNe = [
    'बव',
    'बालव',
    'कौलव',
    'तैतिल',
    'गर',
    'वणिज',
    'विष्टि',
  ];
  static const List<String> karanEn = [
    'Bava',
    'Balava',
    'Kaulava',
    'Taitila',
    'Gara',
    'Vanija',
    'Vishti',
  ];
  static const List<String> rashiNe = [
    'मेष',
    'वृष',
    'मिथुन',
    'कर्कट',
    'सिंह',
    'कन्या',
    'तुला',
    'वृश्चिक',
    'धनु',
    'मकर',
    'कुम्भ',
    'मीन',
  ];
  static const List<String> rashiEn = [
    'Mesh',
    'Brish',
    'Mithun',
    'Karkat',
    'Singha',
    'Kanya',
    'Tula',
    'Brishchik',
    'Dhanu',
    'Makar',
    'Kumbha',
    'Meen',
  ];

  /// Panchanga for [date] at the region's default city (`config.defaultCity`
  /// / `config.utcOffset`).
  static PanchangaInfo forRegion(DateTime date, RegionConfig config) => forDate(
    date,
    latitude: config.defaultCity.latitude,
    longitude: config.defaultCity.longitude,
    utcOffset: config.utcOffset,
  );

  static PanchangaInfo forDate(
    DateTime date, {
    double latitude = _kathmanduLat,
    double longitude = _kathmanduLon,
    Duration utcOffset = _nptOffset,
  }) {
    final lunarDay = LunarCalculator.forDate(date);
    final age = LunarCalculator.moonAge(date);
    final sunLon = _meanSunLongitude(date); // sidereal-ish, degrees
    final moonLon =
        (sunLon + age / LunarCalculator.synodicMonthDays * 360) % 360;
    final nak = (moonLon / (360 / 27)).floor() % 27;
    final yog = (((sunLon + moonLon) % 360) / (360 / 27)).floor() % 27;
    final tithi30 = (age / LunarCalculator.synodicMonthDays * 30).floor();
    final karan = _karanIndex(tithi30);
    final rashi = (moonLon / 30).floor() % 12;
    final sun = _sunTimes(date, latitude, longitude, utcOffset);
    return PanchangaInfo(
      lunarDay: lunarDay,
      nakshatraNe: nakshatraNe[nak],
      nakshatraEn: nakshatraEn[nak],
      karanNe: karanNe[karan],
      karanEn: karanEn[karan],
      yogNe: yogNe[yog],
      yogEn: yogEn[yog],
      chandraRashiNe: rashiNe[rashi],
      chandraRashiEn: rashiEn[rashi],
      sunrise: sun.$1,
      sunset: sun.$2,
    );
  }

  /// First-half karan of the tithi (index 0..29 → 0..6 in the classic cycle).
  static int _karanIndex(int tithi30) {
    final half = tithi30 * 2; // 0..59
    if (half == 0) return 6; // Kimstughna ≈ shown as Vishti slot
    if (half >= 57) return 6;
    return (half - 1) % 7;
  }

  /// Sidereal solar month index for [date]: 0 = Mesha (≈ mid-April, the
  /// month of Vaishakh) … 11 = Meena (Chaitra). Used to name the lunar month
  /// approximately, independent of the region's civil calendar.
  static int siderealMonthIndex(DateTime date) =>
      (_meanSunLongitude(date) / 30).floor() % 12;

  /// Mean sidereal solar longitude (Nirayana) – ~24° behind tropical.
  static double _meanSunLongitude(DateTime date) {
    final j2000 = DateTime.utc(2000, 1, 1, 12);
    final d = date.toUtc().difference(j2000).inMinutes / 1440;
    final tropical = (280.46 + 0.9856474 * d) % 360;
    return (tropical - 24.1 + 360) % 360;
  }

  /// NOAA-style sunrise/sunset for [lat]/[lon], returned as wall-clock time
  /// at [utcOffset].
  static (DateTime, DateTime) _sunTimes(
    DateTime date,
    double lat,
    double lon,
    Duration utcOffset,
  ) {
    // Whole days since J2000.0 (2000-01-01 12:00 UTC).
    final utcNoon = DateTime.utc(date.year, date.month, date.day, 12);
    final n = utcNoon.difference(DateTime.utc(2000, 1, 1, 12)).inDays + 0.0008;
    // Mean solar noon (east longitude positive).
    final jStar = n - lon / 360;
    final m = (357.5291 + 0.98560028 * jStar) % 360;
    final mRad = m * math.pi / 180;
    final c =
        1.9148 * math.sin(mRad) +
        0.02 * math.sin(2 * mRad) +
        0.0003 * math.sin(3 * mRad);
    final lambda = (m + c + 180 + 102.9372) % 360;
    final lRad = lambda * math.pi / 180;
    final jTransit =
        2451545.0 +
        jStar +
        0.0053 * math.sin(mRad) -
        0.0069 * math.sin(2 * lRad);
    final sinDec = math.sin(lRad) * math.sin(23.44 * math.pi / 180);
    final dec = math.asin(sinDec);
    final latRad = lat * math.pi / 180;
    final cosH =
        (math.sin(-0.83 * math.pi / 180) - math.sin(latRad) * sinDec) /
        (math.cos(latRad) * math.cos(dec));
    final h = math.acos(cosH.clamp(-1.0, 1.0)) * 180 / math.pi;
    final rise = jTransit - h / 360;
    final set = jTransit + h / 360;
    return (_fromJulian(rise, utcOffset), _fromJulian(set, utcOffset));
  }

  static DateTime _fromJulian(double jd, Duration utcOffset) {
    final ms = ((jd - 2440587.5) * 86400000).round();
    final local = DateTime.fromMillisecondsSinceEpoch(
      ms,
      isUtc: true,
    ).add(utcOffset);
    // Wall-clock local time (device timezone independent).
    return DateTime(
      local.year,
      local.month,
      local.day,
      local.hour,
      local.minute,
    );
  }
}
