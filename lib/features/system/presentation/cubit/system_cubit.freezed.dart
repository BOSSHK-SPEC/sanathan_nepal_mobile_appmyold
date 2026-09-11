// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SystemState {

 AppStatus get status; bool get online;/// Optional update prompts are dismissible for the session; required
/// ones are not, which is why this only affects the former.
 bool get updateDismissed;
/// Create a copy of SystemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemStateCopyWith<SystemState> get copyWith => _$SystemStateCopyWithImpl<SystemState>(this as SystemState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemState&&(identical(other.status, status) || other.status == status)&&(identical(other.online, online) || other.online == online)&&(identical(other.updateDismissed, updateDismissed) || other.updateDismissed == updateDismissed));
}


@override
int get hashCode => Object.hash(runtimeType,status,online,updateDismissed);

@override
String toString() {
  return 'SystemState(status: $status, online: $online, updateDismissed: $updateDismissed)';
}


}

/// @nodoc
abstract mixin class $SystemStateCopyWith<$Res>  {
  factory $SystemStateCopyWith(SystemState value, $Res Function(SystemState) _then) = _$SystemStateCopyWithImpl;
@useResult
$Res call({
 AppStatus status, bool online, bool updateDismissed
});


$AppStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$SystemStateCopyWithImpl<$Res>
    implements $SystemStateCopyWith<$Res> {
  _$SystemStateCopyWithImpl(this._self, this._then);

  final SystemState _self;
  final $Res Function(SystemState) _then;

/// Create a copy of SystemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? online = null,Object? updateDismissed = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppStatus,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,updateDismissed: null == updateDismissed ? _self.updateDismissed : updateDismissed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SystemState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppStatusCopyWith<$Res> get status {
  
  return $AppStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}



/// @nodoc


class _SystemState extends SystemState {
  const _SystemState({this.status = const AppStatus(), this.online = true, this.updateDismissed = false}): super._();
  

@override@JsonKey() final  AppStatus status;
@override@JsonKey() final  bool online;
/// Optional update prompts are dismissible for the session; required
/// ones are not, which is why this only affects the former.
@override@JsonKey() final  bool updateDismissed;

/// Create a copy of SystemState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SystemStateCopyWith<_SystemState> get copyWith => __$SystemStateCopyWithImpl<_SystemState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SystemState&&(identical(other.status, status) || other.status == status)&&(identical(other.online, online) || other.online == online)&&(identical(other.updateDismissed, updateDismissed) || other.updateDismissed == updateDismissed));
}


@override
int get hashCode => Object.hash(runtimeType,status,online,updateDismissed);

@override
String toString() {
  return 'SystemState(status: $status, online: $online, updateDismissed: $updateDismissed)';
}


}

/// @nodoc
abstract mixin class _$SystemStateCopyWith<$Res> implements $SystemStateCopyWith<$Res> {
  factory _$SystemStateCopyWith(_SystemState value, $Res Function(_SystemState) _then) = __$SystemStateCopyWithImpl;
@override @useResult
$Res call({
 AppStatus status, bool online, bool updateDismissed
});


@override $AppStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$SystemStateCopyWithImpl<$Res>
    implements _$SystemStateCopyWith<$Res> {
  __$SystemStateCopyWithImpl(this._self, this._then);

  final _SystemState _self;
  final $Res Function(_SystemState) _then;

/// Create a copy of SystemState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? online = null,Object? updateDismissed = null,}) {
  return _then(_SystemState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppStatus,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,updateDismissed: null == updateDismissed ? _self.updateDismissed : updateDismissed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SystemState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppStatusCopyWith<$Res> get status {
  
  return $AppStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
