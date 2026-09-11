import 'package:freezed_annotation/freezed_annotation.dart';

part 'planet_position.freezed.dart';

/// Apparent position of a planet at sunrise
/// (`राशि:अंश:कला:विकला`, e.g. `10:9:49:55`).
@freezed
abstract class PlanetPosition with _$PlanetPosition {
  const PlanetPosition._();

  const factory PlanetPosition({
    required String nameNe,
    required String nameEn,

    /// `rashi:deg:min:sec` with ASCII digits.
    required String value,
  }) = _PlanetPosition;

  String name({required bool nepali}) => nepali ? nameNe : nameEn;
}
