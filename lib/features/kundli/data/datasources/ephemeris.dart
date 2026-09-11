import 'dart:math';

import '../../domain/entities/birth_profile.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/entities/vedic_basics.dart';

/// Produces planetary longitudes for a birth moment.
///
/// Behind an interface because the arithmetic is the one part of this feature
/// that must eventually be replaced by a real ephemeris (Swiss Ephemeris or a
/// server endpoint). Every screen, the dasha engine and the matching engine
/// consume [KundliChart], so that swap changes nothing above this line.
abstract interface class Ephemeris {
  /// Sidereal longitudes for all nine grahas, plus the ascendant.
  ({double ascendant, List<PlanetPosition> positions}) cast(
    BirthProfile profile,
  );
}

/// Deterministic stand-in for a real ephemeris.
///
/// **This is not astronomically accurate.** Longitudes are derived from the
/// birth moment by a stable hash, so a given birth always produces the same
/// chart and the UI can be built and tested against consistent data.
///
/// What *is* correct, and will stay correct when a real ephemeris replaces
/// this: the structure. Twelve signs of 30°, twenty-seven nakshatras of
/// 13°20' with their classical rulers, four padas each, houses counted from
/// the ascendant, Rahu and Ketu exactly 180° apart and always retrograde,
/// and the Sun and Moon never retrograde. The dasha and matching engines
/// depend only on those invariants.
class DeterministicEphemeris implements Ephemeris {
  const DeterministicEphemeris();

  @override
  ({double ascendant, List<PlanetPosition> positions}) cast(
    BirthProfile profile,
  ) {
    final seed = _seedFor(profile);
    final random = Random(seed);

    // The ascendant advances roughly one sign every two hours, so deriving
    // it from the birth time keeps two people born the same day but hours
    // apart in different signs — the behaviour the UI needs to show.
    final minutesOfDay = profile.timeUnknown
        ? 0
        : profile.birthDateTime.hour * 60 + profile.birthDateTime.minute;
    final ascendant = (minutesOfDay / 1440 * 360 + seed % 30) % 360;

    final longitudes = <Graha, double>{};
    for (final graha in Graha.values) {
      if (graha == Graha.ketu) continue;
      longitudes[graha] = random.nextDouble() * 360;
    }
    // Ketu is always exactly opposite Rahu.
    longitudes[Graha.ketu] = (longitudes[Graha.rahu]! + 180) % 360;

    final positions = <PlanetPosition>[];
    for (final graha in Graha.values) {
      final longitude = longitudes[graha]!;
      positions.add(
        PlanetPosition(
          graha: graha,
          longitude: longitude,
          house: _houseOf(longitude, ascendant),
          retrograde:
              graha.isAlwaysRetrograde ||
              (graha.canRetrograde && random.nextInt(5) == 0),
        ),
      );
    }

    return (ascendant: ascendant, positions: positions);
  }

  /// Whole-sign houses: the ascendant's sign is the first house, and each
  /// subsequent sign is the next house. This is the standard North Indian
  /// treatment and keeps a graha's house consistent with its sign.
  int _houseOf(double longitude, double ascendant) {
    final ascSign = (ascendant ~/ 30) % 12;
    final planetSign = (longitude ~/ 30) % 12;
    return ((planetSign - ascSign + 12) % 12) + 1;
  }

  /// Stable across runs and platforms: derived only from the birth moment
  /// and place, never from `hashCode` of a String, which is not stable.
  int _seedFor(BirthProfile profile) {
    var hash = 17;
    for (final unit in [
      profile.birthDateTime.year,
      profile.birthDateTime.month,
      profile.birthDateTime.day,
      profile.timeUnknown ? 0 : profile.birthDateTime.hour,
      profile.timeUnknown ? 0 : profile.birthDateTime.minute,
    ]) {
      hash = (hash * 31 + unit) & 0x7fffffff;
    }
    for (final code in profile.birthPlace.trim().toLowerCase().codeUnits) {
      hash = (hash * 31 + code) & 0x7fffffff;
    }
    return hash;
  }
}
