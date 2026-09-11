// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panchanga_element_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PanchangaElementModel {

 String get nameNe; String get nameEn; DateTime get endsAt; String get nextNe; String get nextEn; String get ghatiPala; double get bhukta; double get bhogya; double get spashta;
/// Create a copy of PanchangaElementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PanchangaElementModelCopyWith<PanchangaElementModel> get copyWith => _$PanchangaElementModelCopyWithImpl<PanchangaElementModel>(this as PanchangaElementModel, _$identity);

  /// Serializes this PanchangaElementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PanchangaElementModel&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.nextNe, nextNe) || other.nextNe == nextNe)&&(identical(other.nextEn, nextEn) || other.nextEn == nextEn)&&(identical(other.ghatiPala, ghatiPala) || other.ghatiPala == ghatiPala)&&(identical(other.bhukta, bhukta) || other.bhukta == bhukta)&&(identical(other.bhogya, bhogya) || other.bhogya == bhogya)&&(identical(other.spashta, spashta) || other.spashta == spashta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nameNe,nameEn,endsAt,nextNe,nextEn,ghatiPala,bhukta,bhogya,spashta);

@override
String toString() {
  return 'PanchangaElementModel(nameNe: $nameNe, nameEn: $nameEn, endsAt: $endsAt, nextNe: $nextNe, nextEn: $nextEn, ghatiPala: $ghatiPala, bhukta: $bhukta, bhogya: $bhogya, spashta: $spashta)';
}


}

/// @nodoc
abstract mixin class $PanchangaElementModelCopyWith<$Res>  {
  factory $PanchangaElementModelCopyWith(PanchangaElementModel value, $Res Function(PanchangaElementModel) _then) = _$PanchangaElementModelCopyWithImpl;
@useResult
$Res call({
 String nameNe, String nameEn, DateTime endsAt, String nextNe, String nextEn, String ghatiPala, double bhukta, double bhogya, double spashta
});




}
/// @nodoc
class _$PanchangaElementModelCopyWithImpl<$Res>
    implements $PanchangaElementModelCopyWith<$Res> {
  _$PanchangaElementModelCopyWithImpl(this._self, this._then);

  final PanchangaElementModel _self;
  final $Res Function(PanchangaElementModel) _then;

/// Create a copy of PanchangaElementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nameNe = null,Object? nameEn = null,Object? endsAt = null,Object? nextNe = null,Object? nextEn = null,Object? ghatiPala = null,Object? bhukta = null,Object? bhogya = null,Object? spashta = null,}) {
  return _then(_self.copyWith(
nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,nextNe: null == nextNe ? _self.nextNe : nextNe // ignore: cast_nullable_to_non_nullable
as String,nextEn: null == nextEn ? _self.nextEn : nextEn // ignore: cast_nullable_to_non_nullable
as String,ghatiPala: null == ghatiPala ? _self.ghatiPala : ghatiPala // ignore: cast_nullable_to_non_nullable
as String,bhukta: null == bhukta ? _self.bhukta : bhukta // ignore: cast_nullable_to_non_nullable
as double,bhogya: null == bhogya ? _self.bhogya : bhogya // ignore: cast_nullable_to_non_nullable
as double,spashta: null == spashta ? _self.spashta : spashta // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _PanchangaElementModel extends PanchangaElementModel {
  const _PanchangaElementModel({this.nameNe = '', this.nameEn = '', required this.endsAt, this.nextNe = '', this.nextEn = '', this.ghatiPala = '', this.bhukta = 0, this.bhogya = 0, this.spashta = 0}): super._();
  factory _PanchangaElementModel.fromJson(Map<String, dynamic> json) => _$PanchangaElementModelFromJson(json);

@override@JsonKey() final  String nameNe;
@override@JsonKey() final  String nameEn;
@override final  DateTime endsAt;
@override@JsonKey() final  String nextNe;
@override@JsonKey() final  String nextEn;
@override@JsonKey() final  String ghatiPala;
@override@JsonKey() final  double bhukta;
@override@JsonKey() final  double bhogya;
@override@JsonKey() final  double spashta;

/// Create a copy of PanchangaElementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanchangaElementModelCopyWith<_PanchangaElementModel> get copyWith => __$PanchangaElementModelCopyWithImpl<_PanchangaElementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PanchangaElementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PanchangaElementModel&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.nextNe, nextNe) || other.nextNe == nextNe)&&(identical(other.nextEn, nextEn) || other.nextEn == nextEn)&&(identical(other.ghatiPala, ghatiPala) || other.ghatiPala == ghatiPala)&&(identical(other.bhukta, bhukta) || other.bhukta == bhukta)&&(identical(other.bhogya, bhogya) || other.bhogya == bhogya)&&(identical(other.spashta, spashta) || other.spashta == spashta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nameNe,nameEn,endsAt,nextNe,nextEn,ghatiPala,bhukta,bhogya,spashta);

@override
String toString() {
  return 'PanchangaElementModel(nameNe: $nameNe, nameEn: $nameEn, endsAt: $endsAt, nextNe: $nextNe, nextEn: $nextEn, ghatiPala: $ghatiPala, bhukta: $bhukta, bhogya: $bhogya, spashta: $spashta)';
}


}

/// @nodoc
abstract mixin class _$PanchangaElementModelCopyWith<$Res> implements $PanchangaElementModelCopyWith<$Res> {
  factory _$PanchangaElementModelCopyWith(_PanchangaElementModel value, $Res Function(_PanchangaElementModel) _then) = __$PanchangaElementModelCopyWithImpl;
@override @useResult
$Res call({
 String nameNe, String nameEn, DateTime endsAt, String nextNe, String nextEn, String ghatiPala, double bhukta, double bhogya, double spashta
});




}
/// @nodoc
class __$PanchangaElementModelCopyWithImpl<$Res>
    implements _$PanchangaElementModelCopyWith<$Res> {
  __$PanchangaElementModelCopyWithImpl(this._self, this._then);

  final _PanchangaElementModel _self;
  final $Res Function(_PanchangaElementModel) _then;

/// Create a copy of PanchangaElementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameNe = null,Object? nameEn = null,Object? endsAt = null,Object? nextNe = null,Object? nextEn = null,Object? ghatiPala = null,Object? bhukta = null,Object? bhogya = null,Object? spashta = null,}) {
  return _then(_PanchangaElementModel(
nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,nextNe: null == nextNe ? _self.nextNe : nextNe // ignore: cast_nullable_to_non_nullable
as String,nextEn: null == nextEn ? _self.nextEn : nextEn // ignore: cast_nullable_to_non_nullable
as String,ghatiPala: null == ghatiPala ? _self.ghatiPala : ghatiPala // ignore: cast_nullable_to_non_nullable
as String,bhukta: null == bhukta ? _self.bhukta : bhukta // ignore: cast_nullable_to_non_nullable
as double,bhogya: null == bhogya ? _self.bhogya : bhogya // ignore: cast_nullable_to_non_nullable
as double,spashta: null == spashta ? _self.spashta : spashta // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
