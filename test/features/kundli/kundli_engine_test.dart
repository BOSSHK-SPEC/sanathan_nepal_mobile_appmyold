import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/data/datasources/dasha_calculator.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/data/datasources/dosha_calculator.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/data/datasources/ephemeris.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/data/datasources/gun_milan_calculator.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/data/datasources/local_kundli_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/birth_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/dosha.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/gun_milan.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/kundli_chart.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/vedic_basics.dart';

void main() {
  const ephemeris = DeterministicEphemeris();

  BirthProfile profile({
    String id = 'p1',
    String name = 'Test',
    int year = 1995,
    int month = 6,
    int day = 15,
    int hour = 9,
    int minute = 30,
    String place = 'Kathmandu',
    bool timeUnknown = false,
    bool isFemale = false,
  }) => BirthProfile(
    id: id,
    name: name,
    birthDateTime: DateTime(year, month, day, hour, minute),
    birthPlace: place,
    timeUnknown: timeUnknown,
    isFemale: isFemale,
  );

  KundliChart chartFor(BirthProfile p) {
    final cast = ephemeris.cast(p);
    return KundliChart(
      profile: p,
      ascendantLongitude: cast.ascendant,
      positions: cast.positions,
    );
  }

  group('Zodiac primitives', () {
    test('signs are 30° each, starting at Aries', () {
      expect(Rashi.fromDegrees(0), Rashi.mesha);
      expect(Rashi.fromDegrees(29.99), Rashi.mesha);
      expect(Rashi.fromDegrees(30), Rashi.vrishabha);
      expect(Rashi.fromDegrees(359), Rashi.meena);
    });

    test('nakshatras are 13°20\' each with four padas', () {
      expect(Nakshatra.fromDegrees(0), Nakshatra.ashwini);
      expect(Nakshatra.padaFromDegrees(0), 1);
      expect(Nakshatra.padaFromDegrees(3.4), 2);
      expect(Nakshatra.fromDegrees(13.4), Nakshatra.bharani);
      expect(Nakshatra.values.length, 27);
    });

    test('Vimshottari periods total 120 years', () {
      final total = Vimshottari.years.values.reduce((a, b) => a + b);
      expect(total, Vimshottari.totalYears);
      expect(Vimshottari.order.length, 9);
      expect(Vimshottari.order.toSet().length, 9);
    });

    test('every sign has a ruling graha', () {
      for (final rashi in Rashi.values) {
        expect(rashi.lord, isNotNull);
      }
      expect(Rashi.simha.lord, Graha.sun);
      expect(Rashi.karka.lord, Graha.moon);
    });
  });

  group('Ephemeris invariants', () {
    test('is deterministic — the same birth gives the same chart', () {
      final a = chartFor(profile());
      final b = chartFor(profile());
      expect(a.ascendantLongitude, b.ascendantLongitude);
      for (var i = 0; i < a.positions.length; i++) {
        expect(a.positions[i].longitude, b.positions[i].longitude);
      }
    });

    test('different birth moments give different charts', () {
      final a = chartFor(profile());
      final b = chartFor(profile(day: 16));
      expect(a.positions.first.longitude, isNot(b.positions.first.longitude));
    });

    test('places all nine grahas exactly once', () {
      final chart = chartFor(profile());
      expect(chart.positions, hasLength(9));
      expect(chart.positions.map((p) => p.graha).toSet(), Graha.values.toSet());
    });

    test('Ketu is always exactly opposite Rahu', () {
      for (var day = 1; day <= 28; day++) {
        final chart = chartFor(profile(day: day));
        final rahu = chart.positionOf(Graha.rahu).longitude;
        final ketu = chart.positionOf(Graha.ketu).longitude;
        expect((ketu - rahu + 360) % 360, closeTo(180, 0.001));
      }
    });

    test('the luminaries never retrograde; the nodes always do', () {
      for (var day = 1; day <= 28; day++) {
        final chart = chartFor(profile(day: day));
        expect(chart.positionOf(Graha.sun).retrograde, isFalse);
        expect(chart.positionOf(Graha.moon).retrograde, isFalse);
        expect(chart.positionOf(Graha.rahu).retrograde, isTrue);
        expect(chart.positionOf(Graha.ketu).retrograde, isTrue);
      }
    });

    test('houses are 1–12 and consistent with signs', () {
      final chart = chartFor(profile());
      for (final p in chart.positions) {
        expect(p.house, inInclusiveRange(1, 12));
        // Whole-sign houses: the sign of a house must match the planet's.
        expect(chart.signOfHouse(p.house), p.rashi);
      }
    });

    test('longitudes stay within the circle', () {
      final chart = chartFor(profile());
      expect(chart.ascendantLongitude, inInclusiveRange(0, 360));
      for (final p in chart.positions) {
        expect(p.longitude, inInclusiveRange(0, 360));
        expect(p.degreesInSign, lessThan(30));
      }
    });
  });

  group('Vimshottari dasha', () {
    test('starts at the birth-star lord and runs all nine', () {
      final chart = chartFor(profile());
      final dashas = DashaCalculator.forChart(chart);
      expect(dashas, hasLength(9));
      expect(dashas.first.graha, chart.janmaNakshatra.lord);
      expect(dashas.map((d) => d.graha).toSet(), Graha.values.toSet());
    });

    test('periods are contiguous with no gaps', () {
      final dashas = DashaCalculator.forChart(chartFor(profile()));
      for (var i = 1; i < dashas.length; i++) {
        expect(dashas[i].start, dashas[i - 1].end);
      }
    });

    test('the first mahadasha is partial — the balance at birth', () {
      final chart = chartFor(profile());
      final dashas = DashaCalculator.forChart(chart);
      final fullYears = Vimshottari.years[dashas.first.graha]!;
      final firstDays = dashas.first.length.inDays;
      expect(
        firstDays,
        lessThanOrEqualTo((fullYears * DashaCalculator.daysPerYear).ceil()),
      );
    });

    test('the whole cycle spans about 120 years', () {
      final chart = chartFor(profile());
      final dashas = DashaCalculator.forChart(chart);
      final years =
          dashas.last.end.difference(dashas.first.start).inDays /
          DashaCalculator.daysPerYear;
      // Less than 120 because the first period starts partway through.
      expect(years, greaterThan(100));
      expect(years, lessThanOrEqualTo(121));
    });

    test('antardashas exactly fill their mahadasha', () {
      final dashas = DashaCalculator.forChart(chartFor(profile()));
      for (final maha in dashas) {
        expect(maha.children, hasLength(9));
        expect(maha.children.first.start, maha.start);
        expect(maha.children.last.end, maha.end);
        for (var i = 1; i < maha.children.length; i++) {
          expect(maha.children[i].start, maha.children[i - 1].end);
        }
      }
    });

    test('antardashas start with their own mahadasha lord', () {
      final dashas = DashaCalculator.forChart(chartFor(profile()));
      for (final maha in dashas) {
        expect(maha.children.first.graha, maha.graha);
      }
    });
  });

  group('Doshas', () {
    test('Manglik follows Mars house placement', () {
      // Scan births until both a Manglik and a non-Manglik chart appear,
      // then assert the rule rather than a specific chart.
      var sawManglik = false;
      var sawClean = false;
      for (var day = 1; day <= 28 && !(sawManglik && sawClean); day++) {
        final chart = chartFor(profile(day: day));
        final reading = DoshaCalculator.manglik(chart);
        final marsHouse = chart.positionOf(Graha.mars).house;
        final expected = DoshaCalculator.manglikHouses.contains(marsHouse);
        expect(reading.isPresent, expected);
        if (expected) {
          sawManglik = true;
        } else {
          sawClean = true;
        }
      }
      expect(sawManglik, isTrue);
      expect(sawClean, isTrue);
    });

    test('the 7th and 8th houses are the strongest placements', () {
      for (var day = 1; day <= 28; day++) {
        final chart = chartFor(profile(day: day));
        final reading = DoshaCalculator.manglik(chart);
        final house = chart.positionOf(Graha.mars).house;
        if (house == 7 || house == 8) {
          expect(reading.severity, DoshaSeverity.high);
        }
      }
    });

    test('every chart gets a reading for each checked dosha', () {
      final readings = DoshaCalculator.forChart(chartFor(profile()));
      expect(readings.map((r) => r.kind).toSet(), {
        DoshaKind.manglik,
        DoshaKind.kaalSarp,
        DoshaKind.sadeSati,
      });
    });
  });

  group('Gun Milan', () {
    test('scores all eight kootas within their maximums', () {
      final result = GunMilanCalculator.match(
        bride: chartFor(profile(id: 'b', isFemale: true)),
        groom: chartFor(profile(id: 'g', day: 20)),
      );
      expect(result.scores, hasLength(8));
      for (final score in result.scores) {
        expect(score.points, inInclusiveRange(0, score.maxPoints));
      }
      expect(result.total, inInclusiveRange(0, Koota.totalPoints));
    });

    test('is symmetric in the kootas that are defined symmetrically', () {
      final a = chartFor(profile(id: 'a'));
      final b = chartFor(profile(id: 'b', day: 20));
      final forward = GunMilanCalculator.match(bride: a, groom: b);
      final backward = GunMilanCalculator.match(bride: b, groom: a);

      int pointsFor(GunMilanResult r, Koota k) =>
          r.scores.firstWhere((s) => s.koota == k).points;

      for (final koota in [
        Koota.tara,
        Koota.yoni,
        Koota.bhakoot,
        Koota.nadi,
        Koota.vashya,
      ]) {
        expect(
          pointsFor(forward, koota),
          pointsFor(backward, koota),
          reason: '$koota should not depend on which side is the bride',
        );
      }
    });

    test('a chart matched with itself shares a nadi, so nadi is zero', () {
      final chart = chartFor(profile());
      final result = GunMilanCalculator.match(bride: chart, groom: chart);
      final nadi = result.scores.firstWhere((s) => s.koota == Koota.nadi);
      expect(nadi.points, 0);
      expect(nadi.isBlocking, isTrue);
      expect(result.verdict, MatchVerdict.poor);
    });

    test('a blocking koota forces a poor verdict regardless of total', () {
      const scores = [
        KootaScore(koota: Koota.varna, points: 1),
        KootaScore(koota: Koota.vashya, points: 2),
        KootaScore(koota: Koota.tara, points: 3),
        KootaScore(koota: Koota.yoni, points: 4),
        KootaScore(koota: Koota.grahaMaitri, points: 5),
        KootaScore(koota: Koota.gana, points: 6),
        KootaScore(koota: Koota.bhakoot, points: 7),
        KootaScore(koota: Koota.nadi, points: 0),
      ];
      const clean = DoshaReading(
        kind: DoshaKind.manglik,
        severity: DoshaSeverity.none,
      );
      const result = GunMilanResult(
        brideProfileId: 'b',
        groomProfileId: 'g',
        scores: scores,
        brideManglik: clean,
        groomManglik: clean,
      );
      expect(result.total, 28);
      expect(result.verdict, MatchVerdict.poor);
    });

    test('Manglik only mismatches when it is one-sided', () {
      const present = DoshaReading(
        kind: DoshaKind.manglik,
        severity: DoshaSeverity.high,
      );
      const absent = DoshaReading(
        kind: DoshaKind.manglik,
        severity: DoshaSeverity.none,
      );
      GunMilanResult build(DoshaReading bride, DoshaReading groom) =>
          GunMilanResult(
            brideProfileId: 'b',
            groomProfileId: 'g',
            scores: const [],
            brideManglik: bride,
            groomManglik: groom,
          );
      expect(build(present, present).manglikMismatch, isFalse);
      expect(build(absent, absent).manglikMismatch, isFalse);
      expect(build(present, absent).manglikMismatch, isTrue);
    });
  });

  group('Saved profiles', () {
    late InMemoryKeyValueStore store;
    late LocalKundliDataSource source;

    setUp(() {
      store = InMemoryKeyValueStore();
      source = LocalKundliDataSource(store, ephemeris);
    });

    test('saving assigns an id and round-trips', () async {
      final saved = await source.saveProfile(profile(id: ''));
      expect(saved.id, isNotEmpty);
      final all = await source.profiles();
      expect(all.single.name, 'Test');
    });

    test('rejects a blank name and a blank place', () async {
      expect(
        () => source.saveProfile(profile(id: '', name: '  ')),
        throwsA(isA<ValidationException>()),
      );
      expect(
        () => source.saveProfile(profile(id: '', place: '  ')),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rejects a future birth date', () async {
      expect(
        () =>
            source.saveProfile(profile(id: '', year: DateTime.now().year + 1)),
        throwsA(isA<ValidationException>()),
      );
    });

    test('deleting removes only that profile', () async {
      final a = await source.saveProfile(profile(id: '', name: 'A'));
      await source.saveProfile(profile(id: '', name: 'B', day: 20));
      await source.deleteProfile(a.id);
      final all = await source.profiles();
      expect(all.single.name, 'B');
    });

    test('matching a chart against itself is rejected', () async {
      final a = await source.saveProfile(profile(id: ''));
      expect(
        () => source.match(brideProfileId: a.id, groomProfileId: a.id),
        throwsA(isA<ValidationException>()),
      );
    });

    test('an unknown chart id is a not-found error', () async {
      expect(() => source.chart('nope'), throwsA(isA<NotFoundException>()));
    });

    test('a chart saved without a birth time reports no houses', () async {
      final saved = await source.saveProfile(
        profile(id: '', timeUnknown: true),
      );
      expect(saved.supportsHouses, isFalse);
      final chart = await source.chart(saved.id);
      // Planets are still placed in signs.
      expect(chart.positions, hasLength(9));
    });
  });
}
