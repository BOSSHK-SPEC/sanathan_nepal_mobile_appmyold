import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/entities/time_window.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/services/day_periods.dart';

/// The Choghadiya and hora tables are published almanac rules, so they are
/// pinned here against the classical sequences rather than against whatever the
/// code happens to produce.
void main() {
  // A day with a deliberately uneven split: 11 h 20 m of light, 12 h 40 m of
  // dark, so day and night parts cannot accidentally be equal.
  final sunrise = DateTime(2026, 9, 18, 6, 20);
  final sunset = DateTime(2026, 9, 18, 17, 40);
  final nextSunrise = DateTime(2026, 9, 19, 6, 20);

  List<String> names(List<TimeWindow> w) =>
      w.map((e) => e.nameEn).toList(growable: false);

  group('night Choghadiya', () {
    // Published table, Sunday through Saturday.
    const expected = <int, List<String>>{
      0: ['Shubh', 'Amrit', 'Char', 'Rog', 'Kaal', 'Labh', 'Udveg', 'Shubh'],
      1: ['Char', 'Rog', 'Kaal', 'Labh', 'Udveg', 'Shubh', 'Amrit', 'Char'],
      2: ['Kaal', 'Labh', 'Udveg', 'Shubh', 'Amrit', 'Char', 'Rog', 'Kaal'],
      3: ['Udveg', 'Shubh', 'Amrit', 'Char', 'Rog', 'Kaal', 'Labh', 'Udveg'],
      4: ['Amrit', 'Char', 'Rog', 'Kaal', 'Labh', 'Udveg', 'Shubh', 'Amrit'],
      5: ['Rog', 'Kaal', 'Labh', 'Udveg', 'Shubh', 'Amrit', 'Char', 'Rog'],
      6: ['Labh', 'Udveg', 'Shubh', 'Amrit', 'Char', 'Rog', 'Kaal', 'Labh'],
    };

    expected.forEach((weekday, sequence) {
      test('weekday $weekday follows the published sequence', () {
        expect(
          names(DayPeriods.nightChoghadiya(weekday, sunset, nextSunrise)),
          sequence,
        );
      });
    });

    test('covers sunset to sunrise with no gap and no overlap', () {
      final night = DayPeriods.nightChoghadiya(0, sunset, nextSunrise);
      expect(night.first.start, sunset);
      expect(night.last.end, nextSunrise);
      for (var i = 1; i < night.length; i++) {
        expect(night[i].start, night[i - 1].end);
      }
    });

    test('an impossible night yields nothing rather than a guess', () {
      expect(DayPeriods.nightChoghadiya(0, sunset, sunset), isEmpty);
      expect(DayPeriods.nightChoghadiya(0, nextSunrise, sunset), isEmpty);
    });
  });

  group('horas', () {
    test('the first hora after sunrise belongs to the weekday lord', () {
      const lords = ['Surya', 'Chandra', 'Mangal', 'Budha', 'Guru', 'Shukra', 'Shani'];
      for (var weekday = 0; weekday < 7; weekday++) {
        final h = DayPeriods.horas(weekday, sunrise, sunset, nextSunrise);
        expect(h.first.nameEn, lords[weekday], reason: 'weekday $weekday');
      }
    });

    test('run in Chaldean order', () {
      // Sunday: Surya, then Shukra, Budha, Chandra, Shani, Guru, Mangal…
      expect(
        names(DayPeriods.horas(0, sunrise, sunset, nextSunrise)).take(8),
        ['Surya', 'Shukra', 'Budha', 'Chandra', 'Shani', 'Guru', 'Mangal', 'Surya'],
      );
    });

    test('twenty-four of them hand the next sunrise to the next weekday', () {
      // This is the whole point of the cycle: 24 steps through seven lords
      // lands on the lord of the following day, which is why the weekdays are
      // named as they are. If the sequence is ever wrong, this test says so.
      const lords = ['Surya', 'Chandra', 'Mangal', 'Budha', 'Guru', 'Shukra', 'Shani'];
      for (var weekday = 0; weekday < 7; weekday++) {
        final h = DayPeriods.horas(weekday, sunrise, sunset, nextSunrise);
        expect(h, hasLength(24));
        // The 25th hora is the first of the next day: one step on in Chaldean
        // order from the 24th.
        final last = HoraLord.values.firstWhere((l) => l.nameEn == h.last.nameEn);
        final next = HoraLord.values[(last.index + 1) % HoraLord.values.length];
        expect(next.nameEn, lords[(weekday + 1) % 7], reason: 'weekday $weekday');
      }
    });

    test('day horas and night horas are not the same length', () {
      final h = DayPeriods.horas(0, sunrise, sunset, nextSunrise);
      expect(h[0].duration, const Duration(minutes: 56, seconds: 40));
      expect(h[12].duration, const Duration(minutes: 63, seconds: 20));
      expect(h[11].end, sunset);
      expect(h.last.end, nextSunrise);
    });

    test('an impossible day yields nothing rather than a guess', () {
      expect(DayPeriods.horas(0, sunset, sunrise, nextSunrise), isEmpty);
      expect(DayPeriods.horas(0, sunrise, sunset, sunset), isEmpty);
    });
  });

  group('current', () {
    test('finds the running window, and only one', () {
      final h = DayPeriods.horas(0, sunrise, sunset, nextSunrise);
      final at = DateTime(2026, 9, 18, 7, 30);
      final now = DayPeriods.current(h, at);
      expect(now, isNotNull);
      expect(h.where((w) => w.contains(at)), hasLength(1));
      expect(now!.start.isAfter(at), isFalse);
      expect(now.end.isAfter(at), isTrue);
    });

    test('a boundary belongs to the window it opens', () {
      final h = DayPeriods.horas(0, sunrise, sunset, nextSunrise);
      expect(DayPeriods.current(h, sunrise), same(h.first));
      expect(DayPeriods.current(h, h[0].end), same(h[1]));
    });

    test('is null before sunrise and at the next sunrise', () {
      final h = DayPeriods.horas(0, sunrise, sunset, nextSunrise);
      expect(DayPeriods.current(h, sunrise.subtract(const Duration(minutes: 1))), isNull);
      expect(DayPeriods.current(h, nextSunrise), isNull);
    });
  });
}
