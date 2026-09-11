import '../../domain/entities/dosha.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/entities/vedic_basics.dart';

/// Classical dosha checks, computed from house placements.
///
/// These rules are the real ones — they depend only on which house a graha
/// occupies, so they become genuinely correct the moment a real ephemeris
/// supplies the longitudes.
abstract final class DoshaCalculator {
  /// Manglik (Mangal dosha): Mars in the 1st, 2nd, 4th, 7th, 8th or 12th
  /// house from the ascendant.
  static const List<int> manglikHouses = [1, 2, 4, 7, 8, 12];

  static List<DoshaReading> forChart(KundliChart chart) => [
    manglik(chart),
    _kaalSarp(chart),
    _sadeSati(chart),
  ];

  static DoshaReading manglik(KundliChart chart) {
    final mars = chart.positionOf(Graha.mars);
    if (!manglikHouses.contains(mars.house)) {
      return const DoshaReading(
        kind: DoshaKind.manglik,
        severity: DoshaSeverity.none,
      );
    }

    // The 7th and 8th are the placements that matter most for marriage; the
    // 2nd and 12th are the mildest.
    final severity = switch (mars.house) {
      7 || 8 => DoshaSeverity.high,
      1 || 4 => DoshaSeverity.moderate,
      _ => DoshaSeverity.mild,
    };

    final cancellations = <String>[];
    // Mars in its own sign or exalted is a classical cancellation.
    if (mars.rashi == Rashi.mesha ||
        mars.rashi == Rashi.vrishchika ||
        mars.rashi == Rashi.makara) {
      cancellations.add('marsOwnOrExalted');
    }
    // Jupiter aspecting or conjunct the ascendant is another.
    final jupiter = chart.positionOf(Graha.jupiter);
    if (jupiter.house == 1 || jupiter.house == mars.house) {
      cancellations.add('jupiterInfluence');
    }

    return DoshaReading(
      kind: DoshaKind.manglik,
      severity: severity,
      factors: ['marsInHouse${mars.house}'],
      cancellations: cancellations,
    );
  }

  /// Kaal Sarp: every graha hemmed between Rahu and Ketu.
  static DoshaReading _kaalSarp(KundliChart chart) {
    final rahu = chart.positionOf(Graha.rahu).longitude;
    final ketu = chart.positionOf(Graha.ketu).longitude;

    // Walk the arc from Rahu to Ketu and see whether everything falls inside.
    bool between(double longitude) {
      final offset = (longitude - rahu + 360) % 360;
      final span = (ketu - rahu + 360) % 360;
      return offset > 0 && offset < span;
    }

    final others = chart.positions.where(
      (p) => p.graha != Graha.rahu && p.graha != Graha.ketu,
    );
    final allOneSide =
        others.every((p) => between(p.longitude)) ||
        others.every((p) => !between(p.longitude));

    return DoshaReading(
      kind: DoshaKind.kaalSarp,
      severity: allOneSide ? DoshaSeverity.moderate : DoshaSeverity.none,
      factors: allOneSide ? const ['allBetweenNodes'] : const [],
    );
  }

  /// Sade Sati: Saturn transiting the 12th, 1st or 2nd from the Moon sign.
  ///
  /// Strictly this depends on Saturn's *current* transit rather than its
  /// birth position; the natal check here stands in until a real ephemeris
  /// can supply transits.
  static DoshaReading _sadeSati(KundliChart chart) {
    final moonSign = chart.moonSign.index;
    final saturnSign = chart.positionOf(Graha.saturn).rashi.index;
    final distance = (saturnSign - moonSign + 12) % 12;
    final active = distance == 11 || distance == 0 || distance == 1;

    return DoshaReading(
      kind: DoshaKind.sadeSati,
      severity: active
          ? (distance == 0 ? DoshaSeverity.high : DoshaSeverity.moderate)
          : DoshaSeverity.none,
      factors: active ? ['saturnPhase$distance'] : const [],
    );
  }
}
