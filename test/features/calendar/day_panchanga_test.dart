import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/models/day_panchanga_model.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/entities/day_panchanga.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/entities/lunar_day.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/services/day_panchanga_estimate.dart';

/// The Patro grid printed a tithi from a mean-moon estimate. These pin how
/// the server's per-day panchanga is read, and that the estimate it falls
/// back to always says it is one.

Map<String, dynamic> _names(String en, String ne, [String? hi]) => {
  'en': en,
  'ne': ne,
  'hi': ?hi,
};

/// One `GET /almanac/panchanga/range` entry: Kathmandu, 2026-09-14.
Map<String, dynamic> kathmanduSummary({
  String date = '2026-09-14',
  List<String> vrat = const [],
  int tithiIndex = 2,
  String tithiEn = 'Tritiya',
  String tithiNe = 'तृतीया',
}) => {
  'date': date,
  'tithi': {
    'index': tithiIndex,
    'names': _names(tithiEn, tithiNe, tithiNe),
    'paksha': 'shukla',
    'endsAtLocal': '${date}T07:22:20',
  },
  'nakshatra': {'index': 13, 'names': _names('Chitra', 'चित्रा')},
  'yoga': {'index': 24, 'names': _names('Brahma', 'ब्रह्म')},
  'karana': {'index': 4, 'names': _names('Gara', 'गर')},
  'moonRashi': {'index': 6, 'names': _names('Libra', 'तुला')},
  'lunarMonth': {
    'amanta': {'index': 5, 'names': _names('Bhadrapada', 'भाद्र')},
    'purnimanta': {'index': 5, 'names': _names('Bhadrapada', 'भाद्र')},
    'isAdhika': false,
  },
  'vrat': vrat,
  'sunriseLocal': '${date}T05:48:22',
  'sunsetLocal': '${date}T18:09:56',
};

void main() {
  group('DayPanchangaModel.fromWire', () {
    test('reads a server day as exact', () {
      final day = DayPanchangaModel.fromWire(kathmanduSummary())!.toEntity();
      expect(day.date, DateTime(2026, 9, 14));
      expect(day.tithiIndex, 2);
      expect(day.tithi.resolve('en'), 'Tritiya');
      expect(day.tithi.resolve('ne'), 'तृतीया');
      expect(day.paksha, Paksha.shukla);
      expect(day.tithiEndsAt, DateTime(2026, 9, 14, 7, 22, 20));
      expect(day.nakshatra.resolve('en'), 'Chitra');
      expect(day.moonRashi.resolve('en'), 'Libra');
      expect(day.lunarMonth.resolve('en'), 'Bhadrapada');
      expect(day.sunrise, DateTime(2026, 9, 14, 5, 48, 22));
      expect(day.isApproximate, isFalse);
    });

    test('falls back from Hindi to Devanagari, never to English', () {
      final day = DayPanchangaModel.fromWire(kathmanduSummary())!.toEntity();
      expect(day.nakshatra.resolve('hi'), 'चित्रा');
    });

    test('keeps known vrat kinds and drops unknown ones', () {
      final day = DayPanchangaModel.fromWire(
        kathmanduSummary(vrat: ['ekadashi', 'something-new']),
      )!.toEntity();
      expect(day.vrat, [VratKind.ekadashi]);
      expect(day.isVrat, isTrue);
    });

    test('drops a malformed day instead of failing the month', () {
      expect(
        DayPanchangaModel.fromWire({...kathmanduSummary()}..remove('nakshatra')),
        isNull,
      );
      expect(
        DayPanchangaModel.fromWire({
          ...kathmanduSummary(),
          'tithi': {
            'index': 30,
            'names': _names('Tritiya', 'तृतीया'),
            'paksha': 'shukla',
          },
        }),
        isNull,
      );
      expect(
        DayPanchangaModel.fromWire({...kathmanduSummary(), 'date': 'soon'}),
        isNull,
      );
    });

    test('round-trips through the entity', () {
      final model = DayPanchangaModel.fromWire(kathmanduSummary())!;
      expect(DayPanchangaModel.fromEntity(model.toEntity()), model);
    });
  });

  group('DayPanchangaEstimate', () {
    test('is always marked approximate', () {
      final day = DayPanchangaEstimate.forDate(
        DateTime(2026, 9, 14),
        Region.nepal.config,
      );
      expect(day.isApproximate, isTrue);
      expect(day.tithiIndex, inInclusiveRange(0, 29));
      expect(day.tithiEndsAt, isNull);
    });
  });
}
