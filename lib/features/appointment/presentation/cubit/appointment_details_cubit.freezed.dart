// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppointmentDetailsState {

 LoadState<Appointment> get appointment; LoadState<BookableAstrologer> get astrologer;/// Slots for the reschedule sheet.
 LoadState<List<TimeSlot>> get slots;/// Last cancel / reschedule call (loading while in flight).
 LoadState<Appointment> get action;
/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentDetailsStateCopyWith<AppointmentDetailsState> get copyWith => _$AppointmentDetailsStateCopyWithImpl<AppointmentDetailsState>(this as AppointmentDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentDetailsState&&(identical(other.appointment, appointment) || other.appointment == appointment)&&(identical(other.astrologer, astrologer) || other.astrologer == astrologer)&&(identical(other.slots, slots) || other.slots == slots)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,appointment,astrologer,slots,action);

@override
String toString() {
  return 'AppointmentDetailsState(appointment: $appointment, astrologer: $astrologer, slots: $slots, action: $action)';
}


}

/// @nodoc
abstract mixin class $AppointmentDetailsStateCopyWith<$Res>  {
  factory $AppointmentDetailsStateCopyWith(AppointmentDetailsState value, $Res Function(AppointmentDetailsState) _then) = _$AppointmentDetailsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Appointment> appointment, LoadState<BookableAstrologer> astrologer, LoadState<List<TimeSlot>> slots, LoadState<Appointment> action
});


$LoadStateCopyWith<Appointment, $Res> get appointment;$LoadStateCopyWith<BookableAstrologer, $Res> get astrologer;$LoadStateCopyWith<List<TimeSlot>, $Res> get slots;$LoadStateCopyWith<Appointment, $Res> get action;

}
/// @nodoc
class _$AppointmentDetailsStateCopyWithImpl<$Res>
    implements $AppointmentDetailsStateCopyWith<$Res> {
  _$AppointmentDetailsStateCopyWithImpl(this._self, this._then);

  final AppointmentDetailsState _self;
  final $Res Function(AppointmentDetailsState) _then;

/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointment = null,Object? astrologer = null,Object? slots = null,Object? action = null,}) {
  return _then(_self.copyWith(
appointment: null == appointment ? _self.appointment : appointment // ignore: cast_nullable_to_non_nullable
as LoadState<Appointment>,astrologer: null == astrologer ? _self.astrologer : astrologer // ignore: cast_nullable_to_non_nullable
as LoadState<BookableAstrologer>,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as LoadState<List<TimeSlot>>,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as LoadState<Appointment>,
  ));
}
/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Appointment, $Res> get appointment {
  
  return $LoadStateCopyWith<Appointment, $Res>(_self.appointment, (value) {
    return _then(_self.copyWith(appointment: value));
  });
}/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BookableAstrologer, $Res> get astrologer {
  
  return $LoadStateCopyWith<BookableAstrologer, $Res>(_self.astrologer, (value) {
    return _then(_self.copyWith(astrologer: value));
  });
}/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TimeSlot>, $Res> get slots {
  
  return $LoadStateCopyWith<List<TimeSlot>, $Res>(_self.slots, (value) {
    return _then(_self.copyWith(slots: value));
  });
}/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Appointment, $Res> get action {
  
  return $LoadStateCopyWith<Appointment, $Res>(_self.action, (value) {
    return _then(_self.copyWith(action: value));
  });
}
}



/// @nodoc


class _AppointmentDetailsState implements AppointmentDetailsState {
  const _AppointmentDetailsState({this.appointment = const LoadState.idle(), this.astrologer = const LoadState.idle(), this.slots = const LoadState.idle(), this.action = const LoadState.idle()});
  

@override@JsonKey() final  LoadState<Appointment> appointment;
@override@JsonKey() final  LoadState<BookableAstrologer> astrologer;
/// Slots for the reschedule sheet.
@override@JsonKey() final  LoadState<List<TimeSlot>> slots;
/// Last cancel / reschedule call (loading while in flight).
@override@JsonKey() final  LoadState<Appointment> action;

/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentDetailsStateCopyWith<_AppointmentDetailsState> get copyWith => __$AppointmentDetailsStateCopyWithImpl<_AppointmentDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentDetailsState&&(identical(other.appointment, appointment) || other.appointment == appointment)&&(identical(other.astrologer, astrologer) || other.astrologer == astrologer)&&(identical(other.slots, slots) || other.slots == slots)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,appointment,astrologer,slots,action);

@override
String toString() {
  return 'AppointmentDetailsState(appointment: $appointment, astrologer: $astrologer, slots: $slots, action: $action)';
}


}

/// @nodoc
abstract mixin class _$AppointmentDetailsStateCopyWith<$Res> implements $AppointmentDetailsStateCopyWith<$Res> {
  factory _$AppointmentDetailsStateCopyWith(_AppointmentDetailsState value, $Res Function(_AppointmentDetailsState) _then) = __$AppointmentDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Appointment> appointment, LoadState<BookableAstrologer> astrologer, LoadState<List<TimeSlot>> slots, LoadState<Appointment> action
});


@override $LoadStateCopyWith<Appointment, $Res> get appointment;@override $LoadStateCopyWith<BookableAstrologer, $Res> get astrologer;@override $LoadStateCopyWith<List<TimeSlot>, $Res> get slots;@override $LoadStateCopyWith<Appointment, $Res> get action;

}
/// @nodoc
class __$AppointmentDetailsStateCopyWithImpl<$Res>
    implements _$AppointmentDetailsStateCopyWith<$Res> {
  __$AppointmentDetailsStateCopyWithImpl(this._self, this._then);

  final _AppointmentDetailsState _self;
  final $Res Function(_AppointmentDetailsState) _then;

/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointment = null,Object? astrologer = null,Object? slots = null,Object? action = null,}) {
  return _then(_AppointmentDetailsState(
appointment: null == appointment ? _self.appointment : appointment // ignore: cast_nullable_to_non_nullable
as LoadState<Appointment>,astrologer: null == astrologer ? _self.astrologer : astrologer // ignore: cast_nullable_to_non_nullable
as LoadState<BookableAstrologer>,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as LoadState<List<TimeSlot>>,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as LoadState<Appointment>,
  ));
}

/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Appointment, $Res> get appointment {
  
  return $LoadStateCopyWith<Appointment, $Res>(_self.appointment, (value) {
    return _then(_self.copyWith(appointment: value));
  });
}/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BookableAstrologer, $Res> get astrologer {
  
  return $LoadStateCopyWith<BookableAstrologer, $Res>(_self.astrologer, (value) {
    return _then(_self.copyWith(astrologer: value));
  });
}/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TimeSlot>, $Res> get slots {
  
  return $LoadStateCopyWith<List<TimeSlot>, $Res>(_self.slots, (value) {
    return _then(_self.copyWith(slots: value));
  });
}/// Create a copy of AppointmentDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Appointment, $Res> get action {
  
  return $LoadStateCopyWith<Appointment, $Res>(_self.action, (value) {
    return _then(_self.copyWith(action: value));
  });
}
}

// dart format on
