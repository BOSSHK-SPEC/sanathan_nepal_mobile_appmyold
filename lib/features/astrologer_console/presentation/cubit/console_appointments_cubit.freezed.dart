// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'console_appointments_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsoleAppointmentsState {

 AppointmentScope get scope; LoadState<List<ConsoleAppointment>> get upcoming; LoadState<List<ConsoleAppointment>> get past;
/// Create a copy of ConsoleAppointmentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsoleAppointmentsStateCopyWith<ConsoleAppointmentsState> get copyWith => _$ConsoleAppointmentsStateCopyWithImpl<ConsoleAppointmentsState>(this as ConsoleAppointmentsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsoleAppointmentsState&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.past, past) || other.past == past));
}


@override
int get hashCode => Object.hash(runtimeType,scope,upcoming,past);

@override
String toString() {
  return 'ConsoleAppointmentsState(scope: $scope, upcoming: $upcoming, past: $past)';
}


}

/// @nodoc
abstract mixin class $ConsoleAppointmentsStateCopyWith<$Res>  {
  factory $ConsoleAppointmentsStateCopyWith(ConsoleAppointmentsState value, $Res Function(ConsoleAppointmentsState) _then) = _$ConsoleAppointmentsStateCopyWithImpl;
@useResult
$Res call({
 AppointmentScope scope, LoadState<List<ConsoleAppointment>> upcoming, LoadState<List<ConsoleAppointment>> past
});


$LoadStateCopyWith<List<ConsoleAppointment>, $Res> get upcoming;$LoadStateCopyWith<List<ConsoleAppointment>, $Res> get past;

}
/// @nodoc
class _$ConsoleAppointmentsStateCopyWithImpl<$Res>
    implements $ConsoleAppointmentsStateCopyWith<$Res> {
  _$ConsoleAppointmentsStateCopyWithImpl(this._self, this._then);

  final ConsoleAppointmentsState _self;
  final $Res Function(ConsoleAppointmentsState) _then;

/// Create a copy of ConsoleAppointmentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scope = null,Object? upcoming = null,Object? past = null,}) {
  return _then(_self.copyWith(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as AppointmentScope,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as LoadState<List<ConsoleAppointment>>,past: null == past ? _self.past : past // ignore: cast_nullable_to_non_nullable
as LoadState<List<ConsoleAppointment>>,
  ));
}
/// Create a copy of ConsoleAppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ConsoleAppointment>, $Res> get upcoming {
  
  return $LoadStateCopyWith<List<ConsoleAppointment>, $Res>(_self.upcoming, (value) {
    return _then(_self.copyWith(upcoming: value));
  });
}/// Create a copy of ConsoleAppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ConsoleAppointment>, $Res> get past {
  
  return $LoadStateCopyWith<List<ConsoleAppointment>, $Res>(_self.past, (value) {
    return _then(_self.copyWith(past: value));
  });
}
}



/// @nodoc


class _ConsoleAppointmentsState extends ConsoleAppointmentsState {
  const _ConsoleAppointmentsState({this.scope = AppointmentScope.upcoming, this.upcoming = const LoadState.idle(), this.past = const LoadState.idle()}): super._();
  

@override@JsonKey() final  AppointmentScope scope;
@override@JsonKey() final  LoadState<List<ConsoleAppointment>> upcoming;
@override@JsonKey() final  LoadState<List<ConsoleAppointment>> past;

/// Create a copy of ConsoleAppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsoleAppointmentsStateCopyWith<_ConsoleAppointmentsState> get copyWith => __$ConsoleAppointmentsStateCopyWithImpl<_ConsoleAppointmentsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsoleAppointmentsState&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.past, past) || other.past == past));
}


@override
int get hashCode => Object.hash(runtimeType,scope,upcoming,past);

@override
String toString() {
  return 'ConsoleAppointmentsState(scope: $scope, upcoming: $upcoming, past: $past)';
}


}

/// @nodoc
abstract mixin class _$ConsoleAppointmentsStateCopyWith<$Res> implements $ConsoleAppointmentsStateCopyWith<$Res> {
  factory _$ConsoleAppointmentsStateCopyWith(_ConsoleAppointmentsState value, $Res Function(_ConsoleAppointmentsState) _then) = __$ConsoleAppointmentsStateCopyWithImpl;
@override @useResult
$Res call({
 AppointmentScope scope, LoadState<List<ConsoleAppointment>> upcoming, LoadState<List<ConsoleAppointment>> past
});


@override $LoadStateCopyWith<List<ConsoleAppointment>, $Res> get upcoming;@override $LoadStateCopyWith<List<ConsoleAppointment>, $Res> get past;

}
/// @nodoc
class __$ConsoleAppointmentsStateCopyWithImpl<$Res>
    implements _$ConsoleAppointmentsStateCopyWith<$Res> {
  __$ConsoleAppointmentsStateCopyWithImpl(this._self, this._then);

  final _ConsoleAppointmentsState _self;
  final $Res Function(_ConsoleAppointmentsState) _then;

/// Create a copy of ConsoleAppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scope = null,Object? upcoming = null,Object? past = null,}) {
  return _then(_ConsoleAppointmentsState(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as AppointmentScope,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as LoadState<List<ConsoleAppointment>>,past: null == past ? _self.past : past // ignore: cast_nullable_to_non_nullable
as LoadState<List<ConsoleAppointment>>,
  ));
}

/// Create a copy of ConsoleAppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ConsoleAppointment>, $Res> get upcoming {
  
  return $LoadStateCopyWith<List<ConsoleAppointment>, $Res>(_self.upcoming, (value) {
    return _then(_self.copyWith(upcoming: value));
  });
}/// Create a copy of ConsoleAppointmentsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ConsoleAppointment>, $Res> get past {
  
  return $LoadStateCopyWith<List<ConsoleAppointment>, $Res>(_self.past, (value) {
    return _then(_self.copyWith(past: value));
  });
}
}

// dart format on
