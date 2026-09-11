// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suva_sait_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuvaSaitModel {

 String get id; String get titleNe; String get titleEn; List<DateTime> get dates; String get noteNe; String get noteEn;
/// Create a copy of SuvaSaitModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuvaSaitModelCopyWith<SuvaSaitModel> get copyWith => _$SuvaSaitModelCopyWithImpl<SuvaSaitModel>(this as SuvaSaitModel, _$identity);

  /// Serializes this SuvaSaitModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuvaSaitModel&&(identical(other.id, id) || other.id == id)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&const DeepCollectionEquality().equals(other.dates, dates)&&(identical(other.noteNe, noteNe) || other.noteNe == noteNe)&&(identical(other.noteEn, noteEn) || other.noteEn == noteEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titleNe,titleEn,const DeepCollectionEquality().hash(dates),noteNe,noteEn);

@override
String toString() {
  return 'SuvaSaitModel(id: $id, titleNe: $titleNe, titleEn: $titleEn, dates: $dates, noteNe: $noteNe, noteEn: $noteEn)';
}


}

/// @nodoc
abstract mixin class $SuvaSaitModelCopyWith<$Res>  {
  factory $SuvaSaitModelCopyWith(SuvaSaitModel value, $Res Function(SuvaSaitModel) _then) = _$SuvaSaitModelCopyWithImpl;
@useResult
$Res call({
 String id, String titleNe, String titleEn, List<DateTime> dates, String noteNe, String noteEn
});




}
/// @nodoc
class _$SuvaSaitModelCopyWithImpl<$Res>
    implements $SuvaSaitModelCopyWith<$Res> {
  _$SuvaSaitModelCopyWithImpl(this._self, this._then);

  final SuvaSaitModel _self;
  final $Res Function(SuvaSaitModel) _then;

/// Create a copy of SuvaSaitModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleNe = null,Object? titleEn = null,Object? dates = null,Object? noteNe = null,Object? noteEn = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,dates: null == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,noteNe: null == noteNe ? _self.noteNe : noteNe // ignore: cast_nullable_to_non_nullable
as String,noteEn: null == noteEn ? _self.noteEn : noteEn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _SuvaSaitModel extends SuvaSaitModel {
  const _SuvaSaitModel({required this.id, this.titleNe = '', this.titleEn = '', final  List<DateTime> dates = const [], this.noteNe = '', this.noteEn = ''}): _dates = dates,super._();
  factory _SuvaSaitModel.fromJson(Map<String, dynamic> json) => _$SuvaSaitModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String titleNe;
@override@JsonKey() final  String titleEn;
 final  List<DateTime> _dates;
@override@JsonKey() List<DateTime> get dates {
  if (_dates is EqualUnmodifiableListView) return _dates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dates);
}

@override@JsonKey() final  String noteNe;
@override@JsonKey() final  String noteEn;

/// Create a copy of SuvaSaitModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuvaSaitModelCopyWith<_SuvaSaitModel> get copyWith => __$SuvaSaitModelCopyWithImpl<_SuvaSaitModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuvaSaitModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuvaSaitModel&&(identical(other.id, id) || other.id == id)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&const DeepCollectionEquality().equals(other._dates, _dates)&&(identical(other.noteNe, noteNe) || other.noteNe == noteNe)&&(identical(other.noteEn, noteEn) || other.noteEn == noteEn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titleNe,titleEn,const DeepCollectionEquality().hash(_dates),noteNe,noteEn);

@override
String toString() {
  return 'SuvaSaitModel(id: $id, titleNe: $titleNe, titleEn: $titleEn, dates: $dates, noteNe: $noteNe, noteEn: $noteEn)';
}


}

/// @nodoc
abstract mixin class _$SuvaSaitModelCopyWith<$Res> implements $SuvaSaitModelCopyWith<$Res> {
  factory _$SuvaSaitModelCopyWith(_SuvaSaitModel value, $Res Function(_SuvaSaitModel) _then) = __$SuvaSaitModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleNe, String titleEn, List<DateTime> dates, String noteNe, String noteEn
});




}
/// @nodoc
class __$SuvaSaitModelCopyWithImpl<$Res>
    implements _$SuvaSaitModelCopyWith<$Res> {
  __$SuvaSaitModelCopyWithImpl(this._self, this._then);

  final _SuvaSaitModel _self;
  final $Res Function(_SuvaSaitModel) _then;

/// Create a copy of SuvaSaitModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleNe = null,Object? titleEn = null,Object? dates = null,Object? noteNe = null,Object? noteEn = null,}) {
  return _then(_SuvaSaitModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,dates: null == dates ? _self._dates : dates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,noteNe: null == noteNe ? _self.noteNe : noteNe // ignore: cast_nullable_to_non_nullable
as String,noteEn: null == noteEn ? _self.noteEn : noteEn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
