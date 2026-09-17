// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'console_appointment_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsoleAppointmentState {

 LoadState<ConsoleAppointment> get appointment; bool get acting; ConsoleAppointmentAction? get lastAction; Failure? get actionFailure;
/// Create a copy of ConsoleAppointmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsoleAppointmentStateCopyWith<ConsoleAppointmentState> get copyWith => _$ConsoleAppointmentStateCopyWithImpl<ConsoleAppointmentState>(this as ConsoleAppointmentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsoleAppointmentState&&(identical(other.appointment, appointment) || other.appointment == appointment)&&(identical(other.acting, acting) || other.acting == acting)&&(identical(other.lastAction, lastAction) || other.lastAction == lastAction)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode => Object.hash(runtimeType,appointment,acting,lastAction,actionFailure);

@override
String toString() {
  return 'ConsoleAppointmentState(appointment: $appointment, acting: $acting, lastAction: $lastAction, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class $ConsoleAppointmentStateCopyWith<$Res>  {
  factory $ConsoleAppointmentStateCopyWith(ConsoleAppointmentState value, $Res Function(ConsoleAppointmentState) _then) = _$ConsoleAppointmentStateCopyWithImpl;
@useResult
$Res call({
 LoadState<ConsoleAppointment> appointment, bool acting, ConsoleAppointmentAction? lastAction, Failure? actionFailure
});


$LoadStateCopyWith<ConsoleAppointment, $Res> get appointment;$FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class _$ConsoleAppointmentStateCopyWithImpl<$Res>
    implements $ConsoleAppointmentStateCopyWith<$Res> {
  _$ConsoleAppointmentStateCopyWithImpl(this._self, this._then);

  final ConsoleAppointmentState _self;
  final $Res Function(ConsoleAppointmentState) _then;

/// Create a copy of ConsoleAppointmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointment = null,Object? acting = null,Object? lastAction = freezed,Object? actionFailure = freezed,}) {
  return _then(_self.copyWith(
appointment: null == appointment ? _self.appointment : appointment // ignore: cast_nullable_to_non_nullable
as LoadState<ConsoleAppointment>,acting: null == acting ? _self.acting : acting // ignore: cast_nullable_to_non_nullable
as bool,lastAction: freezed == lastAction ? _self.lastAction : lastAction // ignore: cast_nullable_to_non_nullable
as ConsoleAppointmentAction?,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of ConsoleAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ConsoleAppointment, $Res> get appointment {
  
  return $LoadStateCopyWith<ConsoleAppointment, $Res>(_self.appointment, (value) {
    return _then(_self.copyWith(appointment: value));
  });
}/// Create a copy of ConsoleAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}
}



/// @nodoc


class _ConsoleAppointmentState implements ConsoleAppointmentState {
  const _ConsoleAppointmentState({this.appointment = const LoadState.idle(), this.acting = false, this.lastAction, this.actionFailure});
  

@override@JsonKey() final  LoadState<ConsoleAppointment> appointment;
@override@JsonKey() final  bool acting;
@override final  ConsoleAppointmentAction? lastAction;
@override final  Failure? actionFailure;

/// Create a copy of ConsoleAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsoleAppointmentStateCopyWith<_ConsoleAppointmentState> get copyWith => __$ConsoleAppointmentStateCopyWithImpl<_ConsoleAppointmentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsoleAppointmentState&&(identical(other.appointment, appointment) || other.appointment == appointment)&&(identical(other.acting, acting) || other.acting == acting)&&(identical(other.lastAction, lastAction) || other.lastAction == lastAction)&&(identical(other.actionFailure, actionFailure) || other.actionFailure == actionFailure));
}


@override
int get hashCode => Object.hash(runtimeType,appointment,acting,lastAction,actionFailure);

@override
String toString() {
  return 'ConsoleAppointmentState(appointment: $appointment, acting: $acting, lastAction: $lastAction, actionFailure: $actionFailure)';
}


}

/// @nodoc
abstract mixin class _$ConsoleAppointmentStateCopyWith<$Res> implements $ConsoleAppointmentStateCopyWith<$Res> {
  factory _$ConsoleAppointmentStateCopyWith(_ConsoleAppointmentState value, $Res Function(_ConsoleAppointmentState) _then) = __$ConsoleAppointmentStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<ConsoleAppointment> appointment, bool acting, ConsoleAppointmentAction? lastAction, Failure? actionFailure
});


@override $LoadStateCopyWith<ConsoleAppointment, $Res> get appointment;@override $FailureCopyWith<$Res>? get actionFailure;

}
/// @nodoc
class __$ConsoleAppointmentStateCopyWithImpl<$Res>
    implements _$ConsoleAppointmentStateCopyWith<$Res> {
  __$ConsoleAppointmentStateCopyWithImpl(this._self, this._then);

  final _ConsoleAppointmentState _self;
  final $Res Function(_ConsoleAppointmentState) _then;

/// Create a copy of ConsoleAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointment = null,Object? acting = null,Object? lastAction = freezed,Object? actionFailure = freezed,}) {
  return _then(_ConsoleAppointmentState(
appointment: null == appointment ? _self.appointment : appointment // ignore: cast_nullable_to_non_nullable
as LoadState<ConsoleAppointment>,acting: null == acting ? _self.acting : acting // ignore: cast_nullable_to_non_nullable
as bool,lastAction: freezed == lastAction ? _self.lastAction : lastAction // ignore: cast_nullable_to_non_nullable
as ConsoleAppointmentAction?,actionFailure: freezed == actionFailure ? _self.actionFailure : actionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of ConsoleAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ConsoleAppointment, $Res> get appointment {
  
  return $LoadStateCopyWith<ConsoleAppointment, $Res>(_self.appointment, (value) {
    return _then(_self.copyWith(appointment: value));
  });
}/// Create a copy of ConsoleAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get actionFailure {
    if (_self.actionFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.actionFailure!, (value) {
    return _then(_self.copyWith(actionFailure: value));
  });
}
}

// dart format on
