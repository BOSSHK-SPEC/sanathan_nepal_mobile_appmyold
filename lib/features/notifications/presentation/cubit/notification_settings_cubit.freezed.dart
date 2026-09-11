// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationSettingsState {

/// Persisted settings (loaded once, then updated optimistically).
 LoadState<NotificationSettings> get settings;/// Outcome of the most recent save.
 LoadState<void> get save;
/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsStateCopyWith<NotificationSettingsState> get copyWith => _$NotificationSettingsStateCopyWithImpl<NotificationSettingsState>(this as NotificationSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.save, save) || other.save == save));
}


@override
int get hashCode => Object.hash(runtimeType,settings,save);

@override
String toString() {
  return 'NotificationSettingsState(settings: $settings, save: $save)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsStateCopyWith<$Res>  {
  factory $NotificationSettingsStateCopyWith(NotificationSettingsState value, $Res Function(NotificationSettingsState) _then) = _$NotificationSettingsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<NotificationSettings> settings, LoadState<void> save
});


$LoadStateCopyWith<NotificationSettings, $Res> get settings;$LoadStateCopyWith<void, $Res> get save;

}
/// @nodoc
class _$NotificationSettingsStateCopyWithImpl<$Res>
    implements $NotificationSettingsStateCopyWith<$Res> {
  _$NotificationSettingsStateCopyWithImpl(this._self, this._then);

  final NotificationSettingsState _self;
  final $Res Function(NotificationSettingsState) _then;

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? save = null,}) {
  return _then(_self.copyWith(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as LoadState<NotificationSettings>,save: null == save ? _self.save : save // ignore: cast_nullable_to_non_nullable
as LoadState<void>,
  ));
}
/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<NotificationSettings, $Res> get settings {
  
  return $LoadStateCopyWith<NotificationSettings, $Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of NotificationSettingsState
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


class _NotificationSettingsState extends NotificationSettingsState {
  const _NotificationSettingsState({this.settings = const LoadState.idle(), this.save = const LoadState.idle()}): super._();
  

/// Persisted settings (loaded once, then updated optimistically).
@override@JsonKey() final  LoadState<NotificationSettings> settings;
/// Outcome of the most recent save.
@override@JsonKey() final  LoadState<void> save;

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsStateCopyWith<_NotificationSettingsState> get copyWith => __$NotificationSettingsStateCopyWithImpl<_NotificationSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.save, save) || other.save == save));
}


@override
int get hashCode => Object.hash(runtimeType,settings,save);

@override
String toString() {
  return 'NotificationSettingsState(settings: $settings, save: $save)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsStateCopyWith<$Res> implements $NotificationSettingsStateCopyWith<$Res> {
  factory _$NotificationSettingsStateCopyWith(_NotificationSettingsState value, $Res Function(_NotificationSettingsState) _then) = __$NotificationSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<NotificationSettings> settings, LoadState<void> save
});


@override $LoadStateCopyWith<NotificationSettings, $Res> get settings;@override $LoadStateCopyWith<void, $Res> get save;

}
/// @nodoc
class __$NotificationSettingsStateCopyWithImpl<$Res>
    implements _$NotificationSettingsStateCopyWith<$Res> {
  __$NotificationSettingsStateCopyWithImpl(this._self, this._then);

  final _NotificationSettingsState _self;
  final $Res Function(_NotificationSettingsState) _then;

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? save = null,}) {
  return _then(_NotificationSettingsState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as LoadState<NotificationSettings>,save: null == save ? _self.save : save // ignore: cast_nullable_to_non_nullable
as LoadState<void>,
  ));
}

/// Create a copy of NotificationSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<NotificationSettings, $Res> get settings {
  
  return $LoadStateCopyWith<NotificationSettings, $Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of NotificationSettingsState
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
