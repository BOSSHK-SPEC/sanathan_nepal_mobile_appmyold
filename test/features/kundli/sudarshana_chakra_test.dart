import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/birth_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/kundli_chart.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/domain/entities/vedic_basics.dart';
import 'package:sanathan_nepal_mobile_app/features/kundli/presentation/widgets/sudarshana_chakra.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// The chakra's whole claim is that the same chart is read from three
/// different first houses. If a ring ever starts from the wrong sign the
/// picture still looks perfectly plausible, so it is pinned here.
void main() {
  KundliChart chartWith({
    required double ascendant,
    required double moon,
    required double sun,
  }) => KundliChart(
    profile: BirthProfile(
      id: 'a',
      name: 'Test',
      birthDateTime: DateTime(1994, 3, 12, 4, 35),
      birthPlace: 'Bengaluru',
    ),
    ascendantLongitude: ascendant,
    positions: [
      PlanetPosition(graha: Graha.sun, longitude: sun, house: 4),
      PlanetPosition(graha: Graha.moon, longitude: moon, house: 1),
      const PlanetPosition(graha: Graha.mars, longitude: 265, house: 3),
      const PlanetPosition(graha: Graha.mercury, longitude: 318, house: 4),
      const PlanetPosition(graha: Graha.jupiter, longitude: 95, house: 9),
      const PlanetPosition(graha: Graha.venus, longitude: 20, house: 6),
      const PlanetPosition(graha: Graha.saturn, longitude: 160, house: 11),
      const PlanetPosition(graha: Graha.rahu, longitude: 55, house: 7),
      const PlanetPosition(graha: Graha.ketu, longitude: 235, house: 1),
    ],
  );

  test('each ring starts from its own reference sign', () {
    // Lagna in Vrishchika, Moon in Dhanu, Sun in Kumbha — deliberately three
    // different signs so a ring reading the wrong one cannot pass.
    final chart = chartWith(ascendant: 228, moon: 250, sun: 310);
    expect(SudarshanaRing.lagna.firstSignOf(chart), Rashi.vrishchika);
    expect(SudarshanaRing.chandra.firstSignOf(chart), Rashi.dhanu);
    expect(SudarshanaRing.surya.firstSignOf(chart), Rashi.kumbha);
  });

  test('the rings collapse onto each other when the references coincide', () {
    // Sun and Moon in the same sign as the lagna: all three rings are then the
    // same reading, which is correct rather than a bug.
    final chart = chartWith(ascendant: 228, moon: 222, sun: 235);
    final first = SudarshanaRing.values
        .map((r) => r.firstSignOf(chart))
        .toSet();
    expect(first, {Rashi.vrishchika});
  });

  test('the grahas in a sign do not change between rings', () {
    // The diagram only re-numbers the houses; it never moves a graha.
    final chart = chartWith(ascendant: 228, moon: 250, sun: 310);
    expect(chart.inSign(Rashi.kumbha).map((p) => p.graha), [
      Graha.sun,
      Graha.mercury,
    ]);
  });

  testWidgets('describes itself to a screen reader', (tester) async {
    final chart = chartWith(ascendant: 228, moon: 250, sun: 310);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: SudarshanaChakra(chart: chart)),
      ),
    );
    await tester.pumpAndSettle();
    // A CustomPaint is silent unless it is labelled; the label names the three
    // signs the rings are read from.
    expect(
      find.bySemanticsLabel(RegExp(r'Sudarshana.*Vrishchika.*Dhanu.*Kumbha')),
      findsOneWidget,
    );
  });
}
