import '../../domain/entities/dasha.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/entities/vedic_basics.dart';

/// Builds the Vimshottari dasha sequence for a chart.
///
/// Unlike the planetary longitudes, this arithmetic is the real thing: given
/// a Moon longitude, the sequence, the balance at birth and the antardasha
/// subdivisions are all classical and deterministic. Swapping in a real
/// ephemeris makes these results genuinely correct, with no change here.
abstract final class DashaCalculator {
  /// Average days per year used to convert dasha years into dates.
  static const double daysPerYear = 365.25;

  static List<DashaPeriod> forChart(KundliChart chart) {
    final moon = chart.positionOf(Graha.moon);
    final nakshatra = moon.nakshatra;
    final startLord = nakshatra.lord;

    // How far the Moon has travelled into its nakshatra decides how much of
    // the first mahadasha has already elapsed at birth.
    final intoNakshatra = (moon.longitude % 360) % Nakshatra.span;
    final elapsedFraction = intoNakshatra / Nakshatra.span;

    final startIndex = Vimshottari.order.indexOf(startLord);
    var cursor = chart.profile.birthDateTime;
    final periods = <DashaPeriod>[];

    for (var i = 0; i < Vimshottari.order.length; i++) {
      final graha = Vimshottari.order[(startIndex + i) % 9];
      final fullYears = Vimshottari.years[graha]!.toDouble();
      // Only the first mahadasha is partial — the balance at birth.
      final years = i == 0 ? fullYears * (1 - elapsedFraction) : fullYears;
      final end = cursor.add(Duration(days: (years * daysPerYear).round()));
      periods.add(
        DashaPeriod(
          graha: graha,
          start: cursor,
          end: end,
          children: _antardashas(graha, cursor, end),
        ),
      );
      cursor = end;
    }
    return periods;
  }

  /// Each mahadasha subdivides into all nine antardashas, starting with its
  /// own lord, in proportion to their Vimshottari years.
  static List<DashaPeriod> _antardashas(
    Graha mahaLord,
    DateTime start,
    DateTime end,
  ) {
    final total = end.difference(start).inSeconds;
    final startIndex = Vimshottari.order.indexOf(mahaLord);
    var cursor = start;
    final children = <DashaPeriod>[];

    for (var i = 0; i < Vimshottari.order.length; i++) {
      final graha = Vimshottari.order[(startIndex + i) % 9];
      final share = Vimshottari.years[graha]! / Vimshottari.totalYears;
      // The last slice absorbs rounding so the children exactly fill the
      // parent — otherwise the timeline shows a gap at the end.
      final childEnd = i == Vimshottari.order.length - 1
          ? end
          : cursor.add(Duration(seconds: (total * share).round()));
      children.add(DashaPeriod(graha: graha, start: cursor, end: childEnd));
      cursor = childEnd;
    }
    return children;
  }
}
