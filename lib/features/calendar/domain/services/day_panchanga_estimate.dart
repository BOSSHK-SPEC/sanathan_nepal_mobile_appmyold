import '../../../../core/region/region.dart';
import '../entities/day_panchanga.dart';
import '../entities/lunar_day.dart';
import 'panchanga_approximator.dart';

/// The on-device mean-motion estimate as a [DayPanchanga], always marked
/// `isApproximate`.
///
/// It can put the tithi a day out, so it is only ever a labelled fallback: in
/// mock mode, or when a day was never fetched from the server and the device
/// is offline.
abstract final class DayPanchangaEstimate {
  static DayPanchanga forDate(DateTime date, RegionConfig config) {
    final info = PanchangaApproximator.forRegion(date, config);
    final lunar = info.lunarDay;
    final shukla = lunar.paksha == Paksha.shukla;
    final index = shukla ? lunar.tithiIndex - 1 : 14 + lunar.tithiIndex;
    final month = PanchangaApproximator.siderealMonthIndex(date);
    return DayPanchanga(
      date: DateTime(date.year, date.month, date.day),
      tithiIndex: index,
      tithi: PanchangaText(
        en: lunar.tithiName(nepali: false),
        ne: lunar.tithiName(nepali: true),
      ),
      paksha: lunar.paksha,
      nakshatra: PanchangaText(en: info.nakshatraEn, ne: info.nakshatraNe),
      yoga: PanchangaText(en: info.yogEn, ne: info.yogNe),
      karana: PanchangaText(en: info.karanEn, ne: info.karanNe),
      moonRashi: PanchangaText(
        en: info.chandraRashiEn,
        ne: info.chandraRashiNe,
      ),
      lunarMonth: PanchangaText(
        en: _lunarMonthEn[month],
        ne: _lunarMonthNe[month],
      ),
      vrat: switch (index) {
        10 || 25 => const [VratKind.ekadashi],
        14 => const [VratKind.purnima],
        29 => const [VratKind.amavasya],
        _ => const [],
      },
      sunrise: info.sunrise,
      sunset: info.sunset,
      isApproximate: true,
    );
  }

  /// Lunar month names indexed by sidereal solar month (0 = Mesha/Vaishakh).
  static const List<String> _lunarMonthNe = [
    'वैशाख',
    'ज्येष्ठ',
    'आषाढ',
    'श्रावण',
    'भाद्र',
    'आश्विन',
    'कार्तिक',
    'मार्ग',
    'पौष',
    'माघ',
    'फाल्गुण',
    'चैत्र',
  ];
  static const List<String> _lunarMonthEn = [
    'Vaishakh',
    'Jyeshtha',
    'Ashadh',
    'Shrawan',
    'Bhadra',
    'Ashwin',
    'Kartik',
    'Marga',
    'Poush',
    'Magh',
    'Falgun',
    'Chaitra',
  ];
}
