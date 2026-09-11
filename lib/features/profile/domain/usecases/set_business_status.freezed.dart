// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_business_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetBusinessStatusParams {

 String get id; BusinessStatus get status;/// Optional reason (rejection) shown to the owner.
 String get note;
/// Create a copy of SetBusinessStatusParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetBusinessStatusParamsCopyWith<SetBusinessStatusParams> get copyWith => _$SetBusinessStatusParamsCopyWithImpl<SetBusinessStatusParams>(this as SetBusinessStatusParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetBusinessStatusParams&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,note);

@override
String toString() {
  return 'SetBusinessStatusParams(id: $id, status: $status, note: $note)';
}


}

/// @nodoc
abstract mixin class $SetBusinessStatusParamsCopyWith<$Res>  {
  factory $SetBusinessStatusParamsCopyWith(SetBusinessStatusParams value, $Res Function(SetBusinessStatusParams) _then) = _$SetBusinessStatusParamsCopyWithImpl;
@useResult
$Res call({
 String id, BusinessStatus status, String note
});




}
/// @nodoc
class _$SetBusinessStatusParamsCopyWithImpl<$Res>
    implements $SetBusinessStatusParamsCopyWith<$Res> {
  _$SetBusinessStatusParamsCopyWithImpl(this._self, this._then);

  final SetBusinessStatusParams _self;
  final $Res Function(SetBusinessStatusParams) _then;

/// Create a copy of SetBusinessStatusParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? note = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BusinessStatus,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _SetBusinessStatusParams implements SetBusinessStatusParams {
  const _SetBusinessStatusParams({required this.id, required this.status, this.note = ''});
  

@override final  String id;
@override final  BusinessStatus status;
/// Optional reason (rejection) shown to the owner.
@override@JsonKey() final  String note;

/// Create a copy of SetBusinessStatusParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetBusinessStatusParamsCopyWith<_SetBusinessStatusParams> get copyWith => __$SetBusinessStatusParamsCopyWithImpl<_SetBusinessStatusParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetBusinessStatusParams&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,status,note);

@override
String toString() {
  return 'SetBusinessStatusParams(id: $id, status: $status, note: $note)';
}


}

/// @nodoc
abstract mixin class _$SetBusinessStatusParamsCopyWith<$Res> implements $SetBusinessStatusParamsCopyWith<$Res> {
  factory _$SetBusinessStatusParamsCopyWith(_SetBusinessStatusParams value, $Res Function(_SetBusinessStatusParams) _then) = __$SetBusinessStatusParamsCopyWithImpl;
@override @useResult
$Res call({
 String id, BusinessStatus status, String note
});




}
/// @nodoc
class __$SetBusinessStatusParamsCopyWithImpl<$Res>
    implements _$SetBusinessStatusParamsCopyWith<$Res> {
  __$SetBusinessStatusParamsCopyWithImpl(this._self, this._then);

  final _SetBusinessStatusParams _self;
  final $Res Function(_SetBusinessStatusParams) _then;

/// Create a copy of SetBusinessStatusParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? note = null,}) {
  return _then(_SetBusinessStatusParams(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BusinessStatus,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
