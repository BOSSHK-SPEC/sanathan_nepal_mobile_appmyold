// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suva_sait.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SuvaSait {

 String get id;/// e.g. "होम गर्ने साइत".
 String get titleNe;/// e.g. "Hom (fire ritual) sait".
 String get titleEn;/// Auspicious dates, ascending.
 List<DateTime> get dates; String get noteNe; String get noteEn;
/// Create a copy of SuvaSait
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuvaSaitCopyWith<SuvaSait> get copyWith => _$SuvaSaitCopyWithImpl<SuvaSait>(this as SuvaSait, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuvaSait&&(identical(other.id, id) || other.id == id)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&const DeepCollectionEquality().equals(other.dates, dates)&&(identical(other.noteNe, noteNe) || other.noteNe == noteNe)&&(identical(other.noteEn, noteEn) || other.noteEn == noteEn));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleNe,titleEn,const DeepCollectionEquality().hash(dates),noteNe,noteEn);

@override
String toString() {
  return 'SuvaSait(id: $id, titleNe: $titleNe, titleEn: $titleEn, dates: $dates, noteNe: $noteNe, noteEn: $noteEn)';
}


}

/// @nodoc
abstract mixin class $SuvaSaitCopyWith<$Res>  {
  factory $SuvaSaitCopyWith(SuvaSait value, $Res Function(SuvaSait) _then) = _$SuvaSaitCopyWithImpl;
@useResult
$Res call({
 String id, String titleNe, String titleEn, List<DateTime> dates, String noteNe, String noteEn
});




}
/// @nodoc
class _$SuvaSaitCopyWithImpl<$Res>
    implements $SuvaSaitCopyWith<$Res> {
  _$SuvaSaitCopyWithImpl(this._self, this._then);

  final SuvaSait _self;
  final $Res Function(SuvaSait) _then;

/// Create a copy of SuvaSait
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


class _SuvaSait extends SuvaSait {
  const _SuvaSait({required this.id, required this.titleNe, required this.titleEn, required final  List<DateTime> dates, this.noteNe = '', this.noteEn = ''}): _dates = dates,super._();
  

@override final  String id;
/// e.g. "होम गर्ने साइत".
@override final  String titleNe;
/// e.g. "Hom (fire ritual) sait".
@override final  String titleEn;
/// Auspicious dates, ascending.
 final  List<DateTime> _dates;
/// Auspicious dates, ascending.
@override List<DateTime> get dates {
  if (_dates is EqualUnmodifiableListView) return _dates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dates);
}

@override@JsonKey() final  String noteNe;
@override@JsonKey() final  String noteEn;

/// Create a copy of SuvaSait
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuvaSaitCopyWith<_SuvaSait> get copyWith => __$SuvaSaitCopyWithImpl<_SuvaSait>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuvaSait&&(identical(other.id, id) || other.id == id)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&const DeepCollectionEquality().equals(other._dates, _dates)&&(identical(other.noteNe, noteNe) || other.noteNe == noteNe)&&(identical(other.noteEn, noteEn) || other.noteEn == noteEn));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleNe,titleEn,const DeepCollectionEquality().hash(_dates),noteNe,noteEn);

@override
String toString() {
  return 'SuvaSait(id: $id, titleNe: $titleNe, titleEn: $titleEn, dates: $dates, noteNe: $noteNe, noteEn: $noteEn)';
}


}

/// @nodoc
abstract mixin class _$SuvaSaitCopyWith<$Res> implements $SuvaSaitCopyWith<$Res> {
  factory _$SuvaSaitCopyWith(_SuvaSait value, $Res Function(_SuvaSait) _then) = __$SuvaSaitCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleNe, String titleEn, List<DateTime> dates, String noteNe, String noteEn
});




}
/// @nodoc
class __$SuvaSaitCopyWithImpl<$Res>
    implements _$SuvaSaitCopyWith<$Res> {
  __$SuvaSaitCopyWithImpl(this._self, this._then);

  final _SuvaSait _self;
  final $Res Function(_SuvaSait) _then;

/// Create a copy of SuvaSait
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleNe = null,Object? titleEn = null,Object? dates = null,Object? noteNe = null,Object? noteEn = null,}) {
  return _then(_SuvaSait(
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
