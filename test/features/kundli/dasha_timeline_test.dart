import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/data/datasources/dasha_calculator.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/birth_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/kundli_chart.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/vedic_basics.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/presentation/widgets/dasha_timeline.dart';

/// The bar draws each mahadasha as wide as it is long, so its axis has to
/// describe the run the chart actually covers — which is never the full 120
/// years, because a life starts part-way through its first dasha.
void main() {
  KundliChart chartWithMoon(double moon) {
    final profile = BirthProfile(
      id: 'a',
      name: 'Test',
      birthDateTime: DateTime(1994, 3, 12, 4, 35),
      birthPlace: 'Bengaluru',
    );
    return KundliChart(
      profile: profile,
      ascendantLongitude: 228,
      positions: [
        PlanetPosition(graha: Graha.moon, longitude: moon, house: 2),
        const PlanetPosition(graha: Graha.sun, longitude: 310, house: 4),
        const PlanetPosition(graha: Graha.mars, longitude: 265, house: 3),
        const PlanetPosition(graha: Graha.mercury, longitude: 318, house: 4),
        const PlanetPosition(graha: Graha.jupiter, longitude: 95, house: 9),
        const PlanetPosition(graha: Graha.venus, longitude: 20, house: 6),
        const PlanetPosition(graha: Graha.saturn, longitude: 160, house: 11),
        const PlanetPosition(graha: Graha.rahu, longitude: 55, house: 7),
        const PlanetPosition(graha: Graha.ketu, longitude: 235, house: 1),
      ],
    );
  }

  test('the axis covers the run from birth, never a flat 120 years', () {
    final dashas = DashaCalculator.forChart(chartWithMoon(250));
    final ticks = DashaTimeline.ageTicks(dashas);
    expect(ticks.first, 0);
    // Short of 120 by the part of the first mahadasha already elapsed at
    // birth — the bug this replaces labelled every chart 0–120.
    expect(ticks.last, lessThan(120));
    expect(ticks.last, greaterThan(100));
  });

  test('ticks are evenly spaced and rise', () {
    final ticks = DashaTimeline.ageTicks(
      DashaCalculator.forChart(chartWithMoon(95)),
    );
    expect(ticks, hasLength(5));
    for (var i = 1; i < ticks.length; i++) {
      expect(ticks[i], greaterThan(ticks[i - 1]));
    }
    // Evenly spaced to within the rounding to whole years.
    final step = ticks.last / 4;
    for (var i = 0; i < ticks.length; i++) {
      expect((ticks[i] - step * i).abs(), lessThanOrEqualTo(1));
    }
  });

  test('a chart whose Moon sits elsewhere starts on a different lord', () {
    // The birth star fixes the sequence, so two charts start differently and
    // therefore carry different balances — and different axes.
    final a = DashaCalculator.forChart(chartWithMoon(250));
    final b = DashaCalculator.forChart(chartWithMoon(95));
    expect(a.first.graha, isNot(b.first.graha));
  });

  test('no periods means no axis rather than a crash', () {
    expect(DashaTimeline.ageTicks(const []), isEmpty);
  });
}
