import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/planet_position.dart';

part 'planet_position_model.freezed.dart';
part 'planet_position_model.g.dart';

/// Wire shape of [PlanetPosition].
@freezed
abstract class PlanetPositionModel with _$PlanetPositionModel {
  const PlanetPositionModel._();

  const factory PlanetPositionModel({
    @Default('') String nameNe,
    @Default('') String nameEn,
    @Default('') String value,
  }) = _PlanetPositionModel;

  factory PlanetPositionModel.fromJson(Map<String, dynamic> json) =>
      _$PlanetPositionModelFromJson(json);

  factory PlanetPositionModel.fromEntity(PlanetPosition e) =>
      PlanetPositionModel(nameNe: e.nameNe, nameEn: e.nameEn, value: e.value);

  PlanetPosition toEntity() =>
      PlanetPosition(nameNe: nameNe, nameEn: nameEn, value: value);
}
