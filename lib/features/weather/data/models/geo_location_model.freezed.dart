// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geo_location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeoLocationModel {

 double get latitude; double get longitude; String get name; String? get nameNe; String? get nameHi;
/// Create a copy of GeoLocationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeoLocationModelCopyWith<GeoLocationModel> get copyWith => _$GeoLocationModelCopyWithImpl<GeoLocationModel>(this as GeoLocationModel, _$identity);

  /// Serializes this GeoLocationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoLocationModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameHi, nameHi) || other.nameHi == nameHi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,name,nameNe,nameHi);

@override
String toString() {
  return 'GeoLocationModel(latitude: $latitude, longitude: $longitude, name: $name, nameNe: $nameNe, nameHi: $nameHi)';
}


}

/// @nodoc
abstract mixin class $GeoLocationModelCopyWith<$Res>  {
  factory $GeoLocationModelCopyWith(GeoLocationModel value, $Res Function(GeoLocationModel) _then) = _$GeoLocationModelCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, String name, String? nameNe, String? nameHi
});




}
/// @nodoc
class _$GeoLocationModelCopyWithImpl<$Res>
    implements $GeoLocationModelCopyWith<$Res> {
  _$GeoLocationModelCopyWithImpl(this._self, this._then);

  final GeoLocationModel _self;
  final $Res Function(GeoLocationModel) _then;

/// Create a copy of GeoLocationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? name = null,Object? nameNe = freezed,Object? nameHi = freezed,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nameNe: freezed == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String?,nameHi: freezed == nameHi ? _self.nameHi : nameHi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _GeoLocationModel extends GeoLocationModel {
  const _GeoLocationModel({required this.latitude, required this.longitude, this.name = '', this.nameNe, this.nameHi}): super._();
  factory _GeoLocationModel.fromJson(Map<String, dynamic> json) => _$GeoLocationModelFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override@JsonKey() final  String name;
@override final  String? nameNe;
@override final  String? nameHi;

/// Create a copy of GeoLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeoLocationModelCopyWith<_GeoLocationModel> get copyWith => __$GeoLocationModelCopyWithImpl<_GeoLocationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeoLocationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeoLocationModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameHi, nameHi) || other.nameHi == nameHi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,name,nameNe,nameHi);

@override
String toString() {
  return 'GeoLocationModel(latitude: $latitude, longitude: $longitude, name: $name, nameNe: $nameNe, nameHi: $nameHi)';
}


}

/// @nodoc
abstract mixin class _$GeoLocationModelCopyWith<$Res> implements $GeoLocationModelCopyWith<$Res> {
  factory _$GeoLocationModelCopyWith(_GeoLocationModel value, $Res Function(_GeoLocationModel) _then) = __$GeoLocationModelCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, String name, String? nameNe, String? nameHi
});




}
/// @nodoc
class __$GeoLocationModelCopyWithImpl<$Res>
    implements _$GeoLocationModelCopyWith<$Res> {
  __$GeoLocationModelCopyWithImpl(this._self, this._then);

  final _GeoLocationModel _self;
  final $Res Function(_GeoLocationModel) _then;

/// Create a copy of GeoLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? name = null,Object? nameNe = freezed,Object? nameHi = freezed,}) {
  return _then(_GeoLocationModel(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nameNe: freezed == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String?,nameHi: freezed == nameHi ? _self.nameHi : nameHi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
