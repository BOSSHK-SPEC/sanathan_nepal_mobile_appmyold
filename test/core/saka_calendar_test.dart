import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/calendar.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_format.dart';

void main() {
  const saka = SakaCalendar();

  test('Republic Day 26 Jan 2026 = Magha 6, 1947 Saka', () {
    expect(
      saka.fromGregorian(DateTime(2026, 1, 26)),
      const TraditionalDate(1947, 11, 6),
    );
  });

  test('Independence Day 15 Aug 2026 = Shravana 24, 1948 Saka', () {
    expect(
      saka.fromGregorian(DateTime(2026, 8, 15)),
      const TraditionalDate(1948, 5, 24),
    );
  });

  test('Chaitra 1 is 22 March (21 March in Gregorian leap years)', () {
    expect(
      saka.fromGregorian(DateTime(2026, 3, 22)),
      const TraditionalDate(1948, 1, 1),
    );
    expect(
      saka.fromGregorian(DateTime(2028, 3, 21)),
      const TraditionalDate(1950, 1, 1),
    );
    expect(saka.daysInMonth(1950, 1), 31);
    expect(saka.daysInMonth(1948, 1), 30);
    expect(saka.daysInMonth(1948, 6), 31);
    expect(saka.daysInMonth(1948, 7), 30);
  });

  test('round-trips every day of a Saka year', () {
    for (var m = 1; m <= 12; m++) {
      for (var d = 1; d <= saka.daysInMonth(1948, m); d++) {
        final t = TraditionalDate(1948, m, d);
        expect(saka.fromGregorian(saka.toGregorian(t)), t);
      }
    }
  });

  test('Vikram Samvat = Saka + 135', () {
    expect(VikramSamvat.yearFor(DateTime(2026, 8, 18)), 2083);
    expect(VikramSamvat.yearFor(DateTime(2026, 2, 1)), 2082);
  });

  test('Bikram Sambat calendar wraps nepali_utils', () {
    const bs = BikramSambatCalendar();
    expect(
      bs.fromGregorian(DateTime(2023, 2, 23)),
      const TraditionalDate(2079, 11, 11),
    );
    expect(
      bs.toGregorian(const TraditionalDate(2079, 11, 11)),
      DateTime(2023, 2, 23),
    );
    expect(bs.weekendWeekdays, [6]);
    expect(saka.weekendWeekdays, [0]);
  });

  test('RegionFormat.money uses region symbol + lakh grouping + digits', () {
    expect(
      RegionFormat.money(
        1234567,
        config: RegionConfig.india,
        languageCode: 'en',
      ),
      '₹12,34,567',
    );
    expect(
      RegionFormat.money(
        101000,
        config: RegionConfig.nepal,
        languageCode: 'ne',
      ),
      'रु. १,०१,०००',
    );
    expect(
      RegionFormat.money(
        999.5,
        config: RegionConfig.india,
        languageCode: 'hi',
        decimals: 1,
      ),
      '₹९९९.५',
    );
  });

  test('Region config basics', () {
    expect(Region.fromCode('IN'), Region.india);
    expect(Region.fromCode(null), Region.nepal);
    expect(RegionConfig.india.calendar.id, 'saka');
    expect(RegionConfig.nepal.languageCodes, ['ne', 'en']);
    expect(RegionConfig.india.languageCodes, ['en', 'hi']);
  });
}
