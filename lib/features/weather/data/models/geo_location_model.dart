import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/geo_location.dart';

part 'geo_location_model.freezed.dart';
part 'geo_location_model.g.dart';

/// Wire/persistence shape of [GeoLocation].
@freezed
abstract class GeoLocationModel with _$GeoLocationModel {
  const GeoLocationModel._();

  const factory GeoLocationModel({
    required double latitude,
    required double longitude,
    @Default('') String name,
    String? nameNe,
    String? nameHi,
  }) = _GeoLocationModel;

  factory GeoLocationModel.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationModelFromJson(json);

  factory GeoLocationModel.fromEntity(GeoLocation e) => GeoLocationModel(
    latitude: e.latitude,
    longitude: e.longitude,
    name: e.name,
    nameNe: e.nameNe,
    nameHi: e.nameHi,
  );

  GeoLocation toEntity() => GeoLocation(
    latitude: latitude,
    longitude: longitude,
    name: name,
    nameNe: nameNe,
    nameHi: nameHi,
  );
}
