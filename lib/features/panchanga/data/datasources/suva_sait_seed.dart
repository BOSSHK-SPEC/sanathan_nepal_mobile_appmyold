import '../../../../core/calendar/calendar.dart';
import '../../../../core/region/region.dart';
import '../models/suva_sait_model.dart';

/// Deterministic seed of the eight suva-sait / muhurat categories shown in
/// the Figma "MONTHY SAIT" / yearly tables (पास्नी, रुद्री, बिवाह, होम,
/// पसल खोल्ने, जग राख्ने, घर सर्ने, ब्रतबन्ध).
///
/// Dates are generated for the previous, current and next traditional year
/// of the region (B.S. in Nepal, Saka in India) so month/year browsing works
/// offline; the day pattern is stable per category and month, and every
/// category also gets a couple of "today"-relative dates so the home
/// section always has something to show.
abstract final class SuvaSaitSeed {
  /// Category ids in design order.
  static const List<String> ids = [
    'pasni',
    'rudri',
    'bibaha',
    'hom',
    'shop',
    'foundation',
    'shifting',
    'bratabandha',
  ];

  // (Nepali, English, Hindi, English-India)
  static const List<(String, String, String, String)> _titles = [
    (
      'पास्नी गर्ने साइत',
      'Pasni (rice feeding) sait',
      'अन्नप्राशन मुहूर्त',
      'Annaprashan muhurat',
    ),
    (
      'रुद्री गर्ने साइत',
      'Rudri sait',
      'रुद्राभिषेक मुहूर्त',
      'Rudrabhishek muhurat',
    ),
    ('विवाह गर्ने साइत', 'Wedding sait', 'विवाह मुहूर्त', 'Vivah muhurat'),
    (
      'होम गर्ने साइत',
      'Hom (fire ritual) sait',
      'हवन मुहूर्त',
      'Havan muhurat',
    ),
    (
      'पसल खोल्ने साइत',
      'Shop opening sait',
      'दुकान उद्घाटन मुहूर्त',
      'Shop opening muhurat',
    ),
    (
      'जग राख्ने साइत',
      'Foundation laying sait',
      'शिलान्यास मुहूर्त',
      'Shilanyas muhurat',
    ),
    (
      'घर सर्ने साइत',
      'House-warming sait',
      'गृह प्रवेश मुहूर्त',
      'Griha Pravesh muhurat',
    ),
    (
      'ब्रतबन्ध गर्ने साइत',
      'Bratabandha sait',
      'उपनयन मुहूर्त',
      'Upanayan muhurat',
    ),
  ];

  /// Offsets (days from today) that are always included, per category – keeps
  /// the compact home list populated regardless of the month pattern.
  static const List<List<int>> _todayOffsets = [
    [6, 13, 20],
    [3, 17, 24],
    [0, 5, 12, 26],
    [0, 2, 9, 16, 23],
    [1, 4, 8, 15],
    [7, 21],
    [10, 19, 28],
    [11, 25],
  ];

  static List<SuvaSaitModel> build({
    required RegionConfig config,
    required DateTime today,
  }) {
    final calendar = config.calendar;
    final day = DateTime(today.year, today.month, today.day);
    final year = calendar.fromGregorian(day).year;
    final india = config.isIndia;
    return [
      for (var k = 0; k < ids.length; k++)
        SuvaSaitModel(
          id: ids[k],
          titleNe: india ? _titles[k].$3 : _titles[k].$1,
          titleEn: india ? _titles[k].$4 : _titles[k].$2,
          dates: _dates(calendar, year, k, day),
        ),
    ];
  }

  static List<DateTime> _dates(
    TraditionalCalendar calendar,
    int year,
    int k,
    DateTime today,
  ) {
    final set = <DateTime>{
      for (final o in _todayOffsets[k]) today.add(Duration(days: o)),
    };
    for (var y = year - 1; y <= year + 1; y++) {
      if (y < calendar.minYear || y > calendar.maxYear) continue;
      for (var m = 1; m <= 12; m++) {
        final dim = calendar.daysInMonth(y, m);
        // 4–6 stable days per month; pattern depends on category and month.
        final count = 4 + (k + m) % 3;
        for (var i = 0; i < count; i++) {
          final d = ((k * 7 + m * 3 + i * 5 + (i * i)) % dim) + 1;
          set.add(calendar.toGregorian(TraditionalDate(y, m, d)));
        }
      }
    }
    return set.toList(growable: false)..sort();
  }
}
