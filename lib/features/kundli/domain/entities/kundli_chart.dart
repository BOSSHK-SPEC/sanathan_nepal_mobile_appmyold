import 'package:freezed_annotation/freezed_annotation.dart';

import 'birth_profile.dart';
import 'vedic_basics.dart';

part 'kundli_chart.freezed.dart';

/// Where one graha sits.
@freezed
abstract class PlanetPosition with _$PlanetPosition {
  const PlanetPosition._();

  const factory PlanetPosition({
    required Graha graha,

    /// Sidereal longitude, 0–360.
    required double longitude,

    /// House 1–12, counted from the ascendant.
    required int house,
    @Default(false) bool retrograde,
  }) = _PlanetPosition;

  Rashi get rashi => Rashi.fromDegrees(longitude);

  Nakshatra get nakshatra => Nakshatra.fromDegrees(longitude);

  int get pada => Nakshatra.padaFromDegrees(longitude);

  /// Degrees within the sign, which is how positions are conventionally
  /// quoted ("Mars 12°44' Kanya").
  double get degreesInSign => longitude % 30;

  String get formattedDegrees {
    final d = degreesInSign.floor();
    final m = ((degreesInSign - d) * 60).floor();
    return "$d°${m.toString().padLeft(2, '0')}'";
  }
}

/// A cast birth chart.
@freezed
abstract class KundliChart with _$KundliChart {
  const KundliChart._();

  const factory KundliChart({
    required BirthProfile profile,
    required double ascendantLongitude,
    required List<PlanetPosition> positions,
  }) = _KundliChart;

  Rashi get ascendant => Rashi.fromDegrees(ascendantLongitude);

  /// The Moon's sign — the "rashi" people usually mean when asked theirs.
  Rashi get moonSign => positionOf(Graha.moon).rashi;

  Rashi get sunSign => positionOf(Graha.sun).rashi;

  /// Birth star, which fixes the dasha sequence.
  Nakshatra get janmaNakshatra => positionOf(Graha.moon).nakshatra;

  PlanetPosition positionOf(Graha graha) =>
      positions.firstWhere((p) => p.graha == graha);

  /// Grahas sitting in a given house, for the chart diagram.
  List<PlanetPosition> inHouse(int house) =>
      positions.where((p) => p.house == house).toList();

  /// Sign occupying a given house, counted from the ascendant.
  Rashi signOfHouse(int house) =>
      Rashi.values[(ascendant.index + house - 1) % 12];

  /// Grahas sitting in a given sign, for the South Indian layout where the
  /// grid is fixed to signs rather than to houses.
  List<PlanetPosition> inSign(Rashi rashi) =>
      positions.where((p) => p.rashi == rashi).toList();
}
