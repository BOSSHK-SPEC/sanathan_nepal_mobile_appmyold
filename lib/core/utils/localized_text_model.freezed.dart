// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localized_text_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalizedTextModel {

 String get ne; String get en; String? get hi;
/// Create a copy of LocalizedTextModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<LocalizedTextModel> get copyWith => _$LocalizedTextModelCopyWithImpl<LocalizedTextModel>(this as LocalizedTextModel, _$identity);

  /// Serializes this LocalizedTextModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizedTextModel&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LocalizedTextModel(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class $LocalizedTextModelCopyWith<$Res>  {
  factory $LocalizedTextModelCopyWith(LocalizedTextModel value, $Res Function(LocalizedTextModel) _then) = _$LocalizedTextModelCopyWithImpl;
@useResult
$Res call({
 String ne, String en, String? hi
});




}
/// @nodoc
class _$LocalizedTextModelCopyWithImpl<$Res>
    implements $LocalizedTextModelCopyWith<$Res> {
  _$LocalizedTextModelCopyWithImpl(this._self, this._then);

  final LocalizedTextModel _self;
  final $Res Function(LocalizedTextModel) _then;

/// Create a copy of LocalizedTextModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ne = null,Object? en = null,Object? hi = freezed,}) {
  return _then(_self.copyWith(
ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,hi: freezed == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _LocalizedTextModel extends LocalizedTextModel {
  const _LocalizedTextModel({this.ne = '', this.en = '', this.hi}): super._();
  factory _LocalizedTextModel.fromJson(Map<String, dynamic> json) => _$LocalizedTextModelFromJson(json);

@override@JsonKey() final  String ne;
@override@JsonKey() final  String en;
@override final  String? hi;

/// Create a copy of LocalizedTextModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalizedTextModelCopyWith<_LocalizedTextModel> get copyWith => __$LocalizedTextModelCopyWithImpl<_LocalizedTextModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalizedTextModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalizedTextModel&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LocalizedTextModel(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class _$LocalizedTextModelCopyWith<$Res> implements $LocalizedTextModelCopyWith<$Res> {
  factory _$LocalizedTextModelCopyWith(_LocalizedTextModel value, $Res Function(_LocalizedTextModel) _then) = __$LocalizedTextModelCopyWithImpl;
@override @useResult
$Res call({
 String ne, String en, String? hi
});




}
/// @nodoc
class __$LocalizedTextModelCopyWithImpl<$Res>
    implements _$LocalizedTextModelCopyWith<$Res> {
  __$LocalizedTextModelCopyWithImpl(this._self, this._then);

  final _LocalizedTextModel _self;
  final $Res Function(_LocalizedTextModel) _then;

/// Create a copy of LocalizedTextModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ne = null,Object? en = null,Object? hi = freezed,}) {
  return _then(_LocalizedTextModel(
ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,hi: freezed == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
