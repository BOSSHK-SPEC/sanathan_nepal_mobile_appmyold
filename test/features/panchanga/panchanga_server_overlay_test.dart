import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/datasources/mock_panchanga_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/datasources/panchanga_server_overlay.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/entities/panchanga.dart';

/// The Panchanga page showed a mean-motion estimate that can put the tithi a
/// day out, and only overlaid a server row that never existed. These pin the
/// overlay of the server's ephemeris day onto every field the page shows.

Map<String, dynamic> _names(String en, String ne) => {
  'en': en,
  'ne': ne,
  'hi': ne,
};

Map<String, dynamic> _limb(
  int index,
  String en,
  String ne,
  String endsAtLocal,
  String nextEn,
  String nextNe,
) => {
  'index': index,
  'names': _names(en, ne),
  'endsAtLocal': endsAtLocal,
  'next': {'index': index + 1, 'names': _names(nextEn, nextNe)},
  'name': en,
  'nameNe': ne,
  'endsAt': endsAtLocal.substring(11, 16),
};

Map<String, dynamic> _window(String start, String end) => {
  'startLocal': start,
  'endLocal': end,
};

/// Kathmandu, Monday 2026-09-14, as the API serves it.
Map<String, dynamic> _kathmandu({bool adhika = false, bool withRahu = true}) =>
    {
      'schema': 'panchanga/v1',
      'source': 'computed',
      'date': '2026-09-14',
      'weekday': 1,
      'sunriseLocal': '2026-09-14T05:48:22',
      'sunsetLocal': '2026-09-14T18:09:56',
      'moonriseLocal': '2026-09-14T08:45:22',
      'moonsetLocal': '2026-09-14T19:47:10',
      'sunrise': '05:48',
      'sunset': '18:09',
      'tithi': {
        ..._limb(
          2,
          'Tritiya',
          'तृतीया',
          '2026-09-14T07:22:20',
          'Chaturthi',
          'चतुर्थी',
        ),
        'paksha': 'shukla',
      },
      'nakshatra': _limb(
        13,
        'Chitra',
        'चित्रा',
        '2026-09-14T14:10:02',
        'Swati',
        'स्वाती',
      ),
      'yoga': _limb(
        24,
        'Brahma',
        'ब्रह्म',
        '2026-09-14T13:01:30',
        'Indra',
        'ऐन्द्र',
      ),
      'karana': _limb(
        4,
        'Gara',
        'गर',
        '2026-09-14T07:22:20',
        'Vanija',
        'वणिज',
      ),
      'moonRashi': {'index': 6, 'names': _names('Libra', 'तुला')},
      'lunarMonth': {
        'amanta': {'index': 5, 'names': _names('Bhadrapada', 'भाद्र')},
        'purnimanta': {'index': 5, 'names': _names('Bhadrapada', 'भाद्र')},
        'isAdhika': adhika,
      },
      'samvat': {
        'shaka': 1948,
        'nepal': {
          'year': 1146,
          'month': {'index': 5, 'names': _names('Yanla', 'ञला')},
        },
      },
      'vrat': <String>[],
      'windows': {
        'rahuKaal': _window('2026-09-14T07:21:03', '2026-09-14T08:53:45'),
        'yamaganda': _window('2026-09-14T11:59:09', '2026-09-14T13:31:51'),
        'gulikaKaal': _window('2026-09-14T13:31:51', '2026-09-14T15:04:33'),
        'abhijit': _window('2026-09-14T11:34:12', '2026-09-14T12:23:40'),
      },
      'planets': [
        for (final (key, en, ne, lon) in [
          ('mars', 'Mars', 'मंगल', 75.1),
          ('mercury', 'Mercury', 'बुध', 160.2),
          ('jupiter', 'Jupiter', 'बृहस्पति', 99.3),
          ('venus', 'Venus', 'शुक्र', 190.4),
          ('saturn', 'Saturn', 'शनि', 340.5),
          if (withRahu) ('rahu', 'Rahu', 'राहु', 305.6),
          ('ketu', 'Ketu', 'केतु', 125.6),
        ])
          {
            'key': key,
            'names': _names(en, ne),
            'siderealLongitude': lon,
            'rashi': {'index': lon ~/ 30, 'names': _names('x', 'x')},
          },
      ],
      'atSunrise': {
        'ayanamsa': 24.2301,
        'sunTropicalLongitude': 171.2,
        'sunSiderealLongitude': 146.97,
        'moonSiderealLongitude': 182.2,
        'sunDeclination': 3.1,
      },
      'dayLengthMinutes': 741.57,
    };

void main() {
  late Panchanga base;

  setUp(() async {
    final local = MockPanchangaDataSource(
      resolver: const FixedRegionResolver(Region.nepal),
    );
    base = (await local.fetchPanchanga(DateTime(2026, 9, 14))).toEntity();
  });

  test('the on-device calculation is marked approximate', () {
    expect(base.isApproximate, isTrue);
  });

  group('panchanga/v1', () {
    test('replaces the estimate and marks the day computed', () {
      final day = PanchangaServerOverlay.apply(base, _kathmandu());
      expect(day.source, PanchangaSource.computed);
      expect(day.isApproximate, isFalse);
    });

    test('takes the limbs, with their end times and what follows', () {
      final day = PanchangaServerOverlay.apply(base, _kathmandu());
      expect(day.tithi.nameEn, 'Tritiya');
      expect(day.tithi.nameNe, 'तृतीया');
      expect(day.tithi.endsAt, DateTime(2026, 9, 14, 7, 22, 20));
      expect(day.tithi.nextEn, 'Chaturthi');
      expect(day.nakshatra.nameEn, 'Chitra');
      expect(day.yoga.nameEn, 'Brahma');
      expect(day.karana.nameEn, 'Gara');
    });

    test('derives the remaining ghati from the server sunrise', () {
      final day = PanchangaServerOverlay.apply(base, _kathmandu());
      // 05:48:22 → 07:22:20 is 5,638 s = 3.915 ghati.
      expect(day.tithi.bhogya, closeTo(3.915, 0.001));
      expect(day.tithi.spashta, closeTo(day.tithi.bhukta + day.tithi.bhogya, 1e-9));
    });

    test('titles the tithi with the purnimanta month and paksha', () {
      final day = PanchangaServerOverlay.apply(base, _kathmandu());
      expect(day.tithiTitleEn, 'Bhadrapada Shukla Tritiya');
      expect(day.tithiTitleNe, 'भाद्र शुक्ल तृतीया');
    });

    test('names an adhika month in the title', () {
      final day = PanchangaServerOverlay.apply(base, _kathmandu(adhika: true));
      expect(day.tithiTitleEn, 'Adhika Bhadrapada Shukla Tritiya');
      expect(day.tithiTitleNe, startsWith('भाद्र अधिक'));
    });

    test('takes sunrise, sunset and the moon times as city wall clock', () {
      final day = PanchangaServerOverlay.apply(base, _kathmandu());
      expect(day.sunrise, DateTime(2026, 9, 14, 5, 48, 22));
      expect(day.sunset, DateTime(2026, 9, 14, 18, 9, 56));
      expect(day.moonrise, DateTime(2026, 9, 14, 8, 45, 22));
    });

    test('takes the windows and rebuilds Choghadiya on the server sunrise', () {
      final day = PanchangaServerOverlay.apply(base, _kathmandu());
      expect(day.rahuKaal?.start, DateTime(2026, 9, 14, 7, 21, 3));
      expect(day.abhijitMuhurat?.nameEn, 'Abhijit');
      expect(day.choghadiya, hasLength(8));
      expect(day.choghadiya.first.start, day.sunrise);
      expect(day.choghadiya.last.end, day.sunset);
    });

    test('takes moon sign, samvat and the sunrise figures', () {
      final day = PanchangaServerOverlay.apply(base, _kathmandu());
      expect(day.chandraRashiEn, 'Libra');
      expect(day.shakaSamvat, 1948);
      expect(day.nepalSamvat, 1146);
      expect(day.nepalSamvatMonthEn, 'Yanla Thwa');
      final ayanamsa = day.dayDetails.firstWhere((d) => d.labelEn == 'Ayanamsha');
      expect(ayanamsa.value, '24.230100');
    });

    test('shows the six planets of the grid in order', () {
      final day = PanchangaServerOverlay.apply(base, _kathmandu());
      expect(day.planets.map((p) => p.nameEn), [
        'Mars',
        'Mercury',
        'Jupiter',
        'Venus',
        'Saturn',
        'Rahu',
      ]);
    });

    test('keeps the calculated planets rather than mixing in a partial list', () {
      final day = PanchangaServerOverlay.apply(
        base,
        _kathmandu(withRahu: false),
      );
      expect(day.planets, base.planets);
    });
  });

  group('editorial shape', () {
    test('overlays only what it carries and stays approximate', () {
      final day = PanchangaServerOverlay.apply(base, {
        'tithi': {'name': 'Shukla Panchami', 'endsAt': '14:32'},
        'sunrise': '06:12',
      });
      expect(day.isApproximate, isTrue);
      expect(day.tithi.nameEn, 'Shukla Panchami');
      expect(day.tithi.endsAt, DateTime(2026, 9, 14, 14, 32));
      expect(day.sunrise, DateTime(2026, 9, 14, 6, 12));
      expect(day.nakshatra, base.nakshatra);
    });
  });
}
