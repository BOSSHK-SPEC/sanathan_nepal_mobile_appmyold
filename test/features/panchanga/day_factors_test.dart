import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/services/panchanga_names.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/services/day_factors.dart';

/// These are published almanac rules, so they are checked against the rule
/// rather than against whatever the code returns.
void main() {
  group('tara bala', () {
    test('the birth star itself is Janma', () {
      for (var n = 0; n < 27; n++) {
        expect(
          DayFactors.tara(janmaNakshatra: n, todayNakshatra: n),
          Tara.janma,
        );
      }
    });

    test('runs through the nine in order from the birth star', () {
      // Ashwini-born: the next nine stars give the nine taras in sequence.
      expect(
        [
          for (var i = 0; i < 9; i++)
            DayFactors.tara(janmaNakshatra: 0, todayNakshatra: i),
        ],
        Tara.values,
      );
    });

    test('the cycle repeats three times across the twenty-seven', () {
      for (var n = 0; n < 27; n++) {
        expect(
          DayFactors.tara(janmaNakshatra: 0, todayNakshatra: n),
          DayFactors.tara(janmaNakshatra: 0, todayNakshatra: (n + 9) % 27),
          reason: 'star $n',
        );
      }
    });

    test('wraps backwards past Revati without going negative', () {
      // Born under Revati (26), today Ashwini (0): the count is 1, so Sampat.
      expect(
        DayFactors.tara(janmaNakshatra: 26, todayNakshatra: 0),
        Tara.sampat,
      );
    });

    test('the malefic taras are the 3rd, 5th and 7th', () {
      expect(
        Tara.values.where((t) => t.quality == DayQuality.bad),
        [Tara.vipat, Tara.pratyari, Tara.vadha],
      );
    });
  });

  group('chandra bala', () {
    test('the birth sign itself is the first house', () {
      expect(DayFactors.moonHouse(janmaRashi: 5, moonRashi: 5), 1);
    });

    test('counts forward and wraps at twelve', () {
      expect(DayFactors.moonHouse(janmaRashi: 10, moonRashi: 0), 3);
      expect(DayFactors.moonHouse(janmaRashi: 0, moonRashi: 11), 12);
    });

    test('1, 3, 6, 7, 10 and 11 are favourable; 4, 8 and 12 are not', () {
      final good = <int>[];
      final bad = <int>[];
      for (var m = 0; m < 12; m++) {
        final q = DayFactors.chandraBala(janmaRashi: 0, moonRashi: m);
        final house = DayFactors.moonHouse(janmaRashi: 0, moonRashi: m);
        if (q == DayQuality.good) good.add(house);
        if (q == DayQuality.bad) bad.add(house);
      }
      expect(good..sort(), [1, 3, 6, 7, 10, 11]);
      expect(bad..sort(), [4, 8, 12]);
    });

    test('chandrashtama is exactly the eighth, and only once a month', () {
      final hits = [
        for (var m = 0; m < 12; m++)
          if (DayFactors.isChandrashtama(janmaRashi: 4, moonRashi: m)) m,
      ];
      expect(hits, hasLength(1));
      expect(DayFactors.moonHouse(janmaRashi: 4, moonRashi: hits.single), 8);
    });
  });

  group('ritu and ayana', () {
    test('two signs to a season, six seasons to the year', () {
      expect(DayFactors.ritu(0), Ritu.vasanta); // Mesha
      expect(DayFactors.ritu(35), Ritu.vasanta); // Vrishabha
      expect(DayFactors.ritu(65), Ritu.grishma); // Mithuna
      expect(DayFactors.ritu(150), Ritu.varsha); // Kanya
      expect(DayFactors.ritu(200), Ritu.sharad); // Tula
      expect(DayFactors.ritu(280), Ritu.hemanta); // Makara
      expect(DayFactors.ritu(340), Ritu.shishira); // Meena
    });

    test('every sign maps to a season and each season takes two', () {
      final counts = <Ritu, int>{};
      for (var sign = 0; sign < 12; sign++) {
        counts.update(
          DayFactors.ritu(sign * 30 + 15),
          (v) => v + 1,
          ifAbsent: () => 1,
        );
      }
      expect(counts.length, 6);
      expect(counts.values.every((c) => c == 2), isTrue);
    });

    test('uttarayana runs Makara to Mithuna, not from the solstice', () {
      expect(DayFactors.ayana(275), Ayana.uttarayana); // Makara
      expect(DayFactors.ayana(85), Ayana.uttarayana); // Mithuna, last of it
      expect(DayFactors.ayana(95), Ayana.dakshinayana); // Karka
      expect(DayFactors.ayana(265), Ayana.dakshinayana); // Dhanu
    });

    test('the two ayanas divide the year in half', () {
      final uttara = [
        for (var sign = 0; sign < 12; sign++)
          if (DayFactors.ayana(sign * 30 + 15) == Ayana.uttarayana) sign,
      ];
      expect(uttara, hasLength(6));
    });

    test('the ayanamsa advances, and is sane for this century', () {
      final now = DayFactors.lahiriAyanamsa(DateTime.utc(2026));
      expect(now, greaterThan(24.0));
      expect(now, lessThan(24.5));
      expect(
        DayFactors.lahiriAyanamsa(DateTime.utc(2050)),
        greaterThan(now),
      );
    });

    test('a sidereal longitude trails the tropical one by the ayanamsa', () {
      final sidereal = DayFactors.sunSidereal(30, DateTime.utc(2026));
      expect(sidereal, closeTo(30 - 24.2, 0.3));
    });

    test('wrapping past Mesha stays inside the circle', () {
      final sidereal = DayFactors.sunSidereal(5, DateTime.utc(2026));
      expect(sidereal, greaterThan(340));
      expect(sidereal, lessThan(360));
    });
  });

  group('disha shool', () {
    test('follows the published weekday table', () {
      expect(DayFactors.dishaShool(0), Disha.west); // Sunday
      expect(DayFactors.dishaShool(1), Disha.east); // Monday
      expect(DayFactors.dishaShool(2), Disha.north); // Tuesday
      expect(DayFactors.dishaShool(3), Disha.north); // Wednesday
      expect(DayFactors.dishaShool(4), Disha.south); // Thursday
      expect(DayFactors.dishaShool(5), Disha.west); // Friday
      expect(DayFactors.dishaShool(6), Disha.east); // Saturday
    });

    test('a weekday outside 0-6 still resolves', () {
      expect(DayFactors.dishaShool(7), DayFactors.dishaShool(0));
      expect(DayFactors.dishaShool(13), DayFactors.dishaShool(6));
    });
  });

  group('reading indices off the panchanga', () {
    test('nakshatra and rashi names resolve to their positions', () {
      expect(DayFactors.indexOf(PanchangaNames.nakshatraEn, 'Ashwini'), 0);
      expect(DayFactors.indexOf(PanchangaNames.rashiEn, 'Aries'), 0);
      expect(PanchangaNames.nakshatraEn, hasLength(27));
      expect(PanchangaNames.rashiEn, hasLength(12));
    });

    test('an unknown name is absent rather than wrong', () {
      // A renamed or translated value must drop the factor, not silently
      // resolve to whatever sits at index 0.
      expect(DayFactors.indexOf(PanchangaNames.nakshatraEn, 'Nonesuch'), isNull);
    });
  });

  group('birth pada fixes the birth sign', () {
    // Nine of the twenty-seven stars straddle a sign boundary, so a star alone
    // cannot fix the sign chandra bala is counted from. The pada can.
    int rashiOfPada(int pada) => pada ~/ 9;
    int starOfPada(int pada) => pada ~/ 4;

    test('Krittika begins in Mesha and finishes in Vrishabha', () {
      // Krittika is the third star: padas 8, 9, 10, 11.
      expect(starOfPada(8), 2);
      expect(rashiOfPada(8), 0); // pada 1 → Mesha
      expect(rashiOfPada(9), 1); // pada 2 → Vrishabha
      expect(rashiOfPada(11), 1);
    });

    test('every sign takes nine padas, every star four', () {
      final perSign = <int, int>{};
      for (var pada = 0; pada < 108; pada++) {
        perSign.update(rashiOfPada(pada), (v) => v + 1, ifAbsent: () => 1);
      }
      expect(perSign.length, 12);
      expect(perSign.values.every((c) => c == 9), isTrue);
      expect(starOfPada(107), 26);
    });

    test('the straddling stars are exactly the nine expected', () {
      final straddling = [
        for (var star = 0; star < 27; star++)
          if (rashiOfPada(star * 4) != rashiOfPada(star * 4 + 3)) star,
      ];
      // Krittika, Mrigashira, Punarvasu, Uttara Phalguni, Chitra, Vishakha,
      // Uttara Ashadha, Dhanishta, Purva Bhadrapada.
      expect(straddling, [2, 4, 6, 11, 13, 15, 20, 22, 24]);
    });
  });
}
