// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planet_position_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanetPositionModel {

 String get nameNe; String get nameEn; String get value;
/// Create a copy of PlanetPositionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanetPositionModelCopyWith<PlanetPositionModel> get copyWith => _$PlanetPositionModelCopyWithImpl<PlanetPositionModel>(this as PlanetPositionModel, _$identity);

  /// Serializes this PlanetPositionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanetPositionModel&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nameNe,nameEn,value);

@override
String toString() {
  return 'PlanetPositionModel(nameNe: $nameNe, nameEn: $nameEn, value: $value)';
}


}

/// @nodoc
abstract mixin class $PlanetPositionModelCopyWith<$Res>  {
  factory $PlanetPositionModelCopyWith(PlanetPositionModel value, $Res Function(PlanetPositionModel) _then) = _$PlanetPositionModelCopyWithImpl;
@useResult
$Res call({
 String nameNe, String nameEn, String value
});




}
/// @nodoc
class _$PlanetPositionModelCopyWithImpl<$Res>
    implements $PlanetPositionModelCopyWith<$Res> {
  _$PlanetPositionModelCopyWithImpl(this._self, this._then);

  final PlanetPositionModel _self;
  final $Res Function(PlanetPositionModel) _then;

/// Create a copy of PlanetPositionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nameNe = null,Object? nameEn = null,Object? value = null,}) {
  return _then(_self.copyWith(
nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _PlanetPositionModel extends PlanetPositionModel {
  const _PlanetPositionModel({this.nameNe = '', this.nameEn = '', this.value = ''}): super._();
  factory _PlanetPositionModel.fromJson(Map<String, dynamic> json) => _$PlanetPositionModelFromJson(json);

@override@JsonKey() final  String nameNe;
@override@JsonKey() final  String nameEn;
@override@JsonKey() final  String value;

/// Create a copy of PlanetPositionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanetPositionModelCopyWith<_PlanetPositionModel> get copyWith => __$PlanetPositionModelCopyWithImpl<_PlanetPositionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanetPositionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanetPositionModel&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nameNe,nameEn,value);

@override
String toString() {
  return 'PlanetPositionModel(nameNe: $nameNe, nameEn: $nameEn, value: $value)';
}


}

/// @nodoc
abstract mixin class _$PlanetPositionModelCopyWith<$Res> implements $PlanetPositionModelCopyWith<$Res> {
  factory _$PlanetPositionModelCopyWith(_PlanetPositionModel value, $Res Function(_PlanetPositionModel) _then) = __$PlanetPositionModelCopyWithImpl;
@override @useResult
$Res call({
 String nameNe, String nameEn, String value
});




}
/// @nodoc
class __$PlanetPositionModelCopyWithImpl<$Res>
    implements _$PlanetPositionModelCopyWith<$Res> {
  __$PlanetPositionModelCopyWithImpl(this._self, this._then);

  final _PlanetPositionModel _self;
  final $Res Function(_PlanetPositionModel) _then;

/// Create a copy of PlanetPositionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameNe = null,Object? nameEn = null,Object? value = null,}) {
  return _then(_PlanetPositionModel(
nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
