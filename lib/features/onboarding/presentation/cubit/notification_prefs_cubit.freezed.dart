// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_prefs_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationPrefsState {

 LoadState<NotificationPrefs> get prefs; LoadState<void> get save;
/// Create a copy of NotificationPrefsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPrefsStateCopyWith<NotificationPrefsState> get copyWith => _$NotificationPrefsStateCopyWithImpl<NotificationPrefsState>(this as NotificationPrefsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPrefsState&&(identical(other.prefs, prefs) || other.prefs == prefs)&&(identical(other.save, save) || other.save == save));
}


@override
int get hashCode => Object.hash(runtimeType,prefs,save);

@override
String toString() {
  return 'NotificationPrefsState(prefs: $prefs, save: $save)';
}


}

/// @nodoc
abstract mixin class $NotificationPrefsStateCopyWith<$Res>  {
  factory $NotificationPrefsStateCopyWith(NotificationPrefsState value, $Res Function(NotificationPrefsState) _then) = _$NotificationPrefsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<NotificationPrefs> prefs, LoadState<void> save
});


$LoadStateCopyWith<NotificationPrefs, $Res> get prefs;$LoadStateCopyWith<void, $Res> get save;

}
/// @nodoc
class _$NotificationPrefsStateCopyWithImpl<$Res>
    implements $NotificationPrefsStateCopyWith<$Res> {
  _$NotificationPrefsStateCopyWithImpl(this._self, this._then);

  final NotificationPrefsState _self;
  final $Res Function(NotificationPrefsState) _then;

/// Create a copy of NotificationPrefsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prefs = null,Object? save = null,}) {
  return _then(_self.copyWith(
prefs: null == prefs ? _self.prefs : prefs // ignore: cast_nullable_to_non_nullable
as LoadState<NotificationPrefs>,save: null == save ? _self.save : save // ignore: cast_nullable_to_non_nullable
as LoadState<void>,
  ));
}
/// Create a copy of NotificationPrefsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<NotificationPrefs, $Res> get prefs {
  
  return $LoadStateCopyWith<NotificationPrefs, $Res>(_self.prefs, (value) {
    return _then(_self.copyWith(prefs: value));
  });
}/// Create a copy of NotificationPrefsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<void, $Res> get save {
  
  return $LoadStateCopyWith<void, $Res>(_self.save, (value) {
    return _then(_self.copyWith(save: value));
  });
}
}



/// @nodoc


class _NotificationPrefsState extends NotificationPrefsState {
  const _NotificationPrefsState({this.prefs = const LoadState.idle(), this.save = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<NotificationPrefs> prefs;
@override@JsonKey() final  LoadState<void> save;

/// Create a copy of NotificationPrefsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPrefsStateCopyWith<_NotificationPrefsState> get copyWith => __$NotificationPrefsStateCopyWithImpl<_NotificationPrefsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPrefsState&&(identical(other.prefs, prefs) || other.prefs == prefs)&&(identical(other.save, save) || other.save == save));
}


@override
int get hashCode => Object.hash(runtimeType,prefs,save);

@override
String toString() {
  return 'NotificationPrefsState(prefs: $prefs, save: $save)';
}


}

/// @nodoc
abstract mixin class _$NotificationPrefsStateCopyWith<$Res> implements $NotificationPrefsStateCopyWith<$Res> {
  factory _$NotificationPrefsStateCopyWith(_NotificationPrefsState value, $Res Function(_NotificationPrefsState) _then) = __$NotificationPrefsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<NotificationPrefs> prefs, LoadState<void> save
});


@override $LoadStateCopyWith<NotificationPrefs, $Res> get prefs;@override $LoadStateCopyWith<void, $Res> get save;

}
/// @nodoc
class __$NotificationPrefsStateCopyWithImpl<$Res>
    implements _$NotificationPrefsStateCopyWith<$Res> {
  __$NotificationPrefsStateCopyWithImpl(this._self, this._then);

  final _NotificationPrefsState _self;
  final $Res Function(_NotificationPrefsState) _then;

/// Create a copy of NotificationPrefsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prefs = null,Object? save = null,}) {
  return _then(_NotificationPrefsState(
prefs: null == prefs ? _self.prefs : prefs // ignore: cast_nullable_to_non_nullable
as LoadState<NotificationPrefs>,save: null == save ? _self.save : save // ignore: cast_nullable_to_non_nullable
as LoadState<void>,
  ));
}

/// Create a copy of NotificationPrefsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<NotificationPrefs, $Res> get prefs {
  
  return $LoadStateCopyWith<NotificationPrefs, $Res>(_self.prefs, (value) {
    return _then(_self.copyWith(prefs: value));
  });
}/// Create a copy of NotificationPrefsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<void, $Res> get save {
  
  return $LoadStateCopyWith<void, $Res>(_self.save, (value) {
    return _then(_self.copyWith(save: value));
  });
}
}

// dart format on
