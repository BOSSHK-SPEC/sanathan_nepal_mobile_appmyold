// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panchanga_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PanchangaDetailModel {

 String get labelNe; String get labelEn; String get value;
/// Create a copy of PanchangaDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanchangaDetailModelCopyWith<PanchangaDetailModel> get copyWith => _$PanchangaDetailModelCopyWithImpl<PanchangaDetailModel>(this as PanchangaDetailModel, _$identity);

  /// Serializes this PanchangaDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PanchangaDetailModel&&(identical(other.labelNe, labelNe) || other.labelNe == labelNe)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labelNe,labelEn,value);

@override
String toString() {
  return 'PanchangaDetailModel(labelNe: $labelNe, labelEn: $labelEn, value: $value)';
}


}

/// @nodoc
abstract mixin class $PanchangaDetailModelCopyWith<$Res>  {
  factory $PanchangaDetailModelCopyWith(PanchangaDetailModel value, $Res Function(PanchangaDetailModel) _then) = _$PanchangaDetailModelCopyWithImpl;
@useResult
$Res call({
 String labelNe, String labelEn, String value
});




}
/// @nodoc
class _$PanchangaDetailModelCopyWithImpl<$Res>
    implements $PanchangaDetailModelCopyWith<$Res> {
  _$PanchangaDetailModelCopyWithImpl(this._self, this._then);

  final PanchangaDetailModel _self;
  final $Res Function(PanchangaDetailModel) _then;

/// Create a copy of PanchangaDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? labelNe = null,Object? labelEn = null,Object? value = null,}) {
  return _then(_self.copyWith(
labelNe: null == labelNe ? _self.labelNe : labelNe // ignore: cast_nullable_to_non_nullable
as String,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _PanchangaDetailModel extends PanchangaDetailModel {
  const _PanchangaDetailModel({this.labelNe = '', this.labelEn = '', this.value = ''}): super._();
  factory _PanchangaDetailModel.fromJson(Map<String, dynamic> json) => _$PanchangaDetailModelFromJson(json);

@override@JsonKey() final  String labelNe;
@override@JsonKey() final  String labelEn;
@override@JsonKey() final  String value;

/// Create a copy of PanchangaDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanchangaDetailModelCopyWith<_PanchangaDetailModel> get copyWith => __$PanchangaDetailModelCopyWithImpl<_PanchangaDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PanchangaDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PanchangaDetailModel&&(identical(other.labelNe, labelNe) || other.labelNe == labelNe)&&(identical(other.labelEn, labelEn) || other.labelEn == labelEn)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labelNe,labelEn,value);

@override
String toString() {
  return 'PanchangaDetailModel(labelNe: $labelNe, labelEn: $labelEn, value: $value)';
}


}

/// @nodoc
abstract mixin class _$PanchangaDetailModelCopyWith<$Res> implements $PanchangaDetailModelCopyWith<$Res> {
  factory _$PanchangaDetailModelCopyWith(_PanchangaDetailModel value, $Res Function(_PanchangaDetailModel) _then) = __$PanchangaDetailModelCopyWithImpl;
@override @useResult
$Res call({
 String labelNe, String labelEn, String value
});




}
/// @nodoc
class __$PanchangaDetailModelCopyWithImpl<$Res>
    implements _$PanchangaDetailModelCopyWith<$Res> {
  __$PanchangaDetailModelCopyWithImpl(this._self, this._then);

  final _PanchangaDetailModel _self;
  final $Res Function(_PanchangaDetailModel) _then;

/// Create a copy of PanchangaDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? labelNe = null,Object? labelEn = null,Object? value = null,}) {
  return _then(_PanchangaDetailModel(
labelNe: null == labelNe ? _self.labelNe : labelNe // ignore: cast_nullable_to_non_nullable
as String,labelEn: null == labelEn ? _self.labelEn : labelEn // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
