// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppointmentListState {

/// Astrologers offered in the active region.
 LoadState<List<BookableAstrologer>> get astrologers; LoadState<List<Appointment>> get appointments;
/// Create a copy of AppointmentListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentListStateCopyWith<AppointmentListState> get copyWith => _$AppointmentListStateCopyWithImpl<AppointmentListState>(this as AppointmentListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentListState&&(identical(other.astrologers, astrologers) || other.astrologers == astrologers)&&(identical(other.appointments, appointments) || other.appointments == appointments));
}


@override
int get hashCode => Object.hash(runtimeType,astrologers,appointments);

@override
String toString() {
  return 'AppointmentListState(astrologers: $astrologers, appointments: $appointments)';
}


}

/// @nodoc
abstract mixin class $AppointmentListStateCopyWith<$Res>  {
  factory $AppointmentListStateCopyWith(AppointmentListState value, $Res Function(AppointmentListState) _then) = _$AppointmentListStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<BookableAstrologer>> astrologers, LoadState<List<Appointment>> appointments
});


$LoadStateCopyWith<List<BookableAstrologer>, $Res> get astrologers;$LoadStateCopyWith<List<Appointment>, $Res> get appointments;

}
/// @nodoc
class _$AppointmentListStateCopyWithImpl<$Res>
    implements $AppointmentListStateCopyWith<$Res> {
  _$AppointmentListStateCopyWithImpl(this._self, this._then);

  final AppointmentListState _self;
  final $Res Function(AppointmentListState) _then;

/// Create a copy of AppointmentListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologers = null,Object? appointments = null,}) {
  return _then(_self.copyWith(
astrologers: null == astrologers ? _self.astrologers : astrologers // ignore: cast_nullable_to_non_nullable
as LoadState<List<BookableAstrologer>>,appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as LoadState<List<Appointment>>,
  ));
}
/// Create a copy of AppointmentListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BookableAstrologer>, $Res> get astrologers {
  
  return $LoadStateCopyWith<List<BookableAstrologer>, $Res>(_self.astrologers, (value) {
    return _then(_self.copyWith(astrologers: value));
  });
}/// Create a copy of AppointmentListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Appointment>, $Res> get appointments {
  
  return $LoadStateCopyWith<List<Appointment>, $Res>(_self.appointments, (value) {
    return _then(_self.copyWith(appointments: value));
  });
}
}



/// @nodoc


class _AppointmentListState extends AppointmentListState {
  const _AppointmentListState({this.astrologers = const LoadState.idle(), this.appointments = const LoadState.idle()}): super._();
  

/// Astrologers offered in the active region.
@override@JsonKey() final  LoadState<List<BookableAstrologer>> astrologers;
@override@JsonKey() final  LoadState<List<Appointment>> appointments;

/// Create a copy of AppointmentListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentListStateCopyWith<_AppointmentListState> get copyWith => __$AppointmentListStateCopyWithImpl<_AppointmentListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentListState&&(identical(other.astrologers, astrologers) || other.astrologers == astrologers)&&(identical(other.appointments, appointments) || other.appointments == appointments));
}


@override
int get hashCode => Object.hash(runtimeType,astrologers,appointments);

@override
String toString() {
  return 'AppointmentListState(astrologers: $astrologers, appointments: $appointments)';
}


}

/// @nodoc
abstract mixin class _$AppointmentListStateCopyWith<$Res> implements $AppointmentListStateCopyWith<$Res> {
  factory _$AppointmentListStateCopyWith(_AppointmentListState value, $Res Function(_AppointmentListState) _then) = __$AppointmentListStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<BookableAstrologer>> astrologers, LoadState<List<Appointment>> appointments
});


@override $LoadStateCopyWith<List<BookableAstrologer>, $Res> get astrologers;@override $LoadStateCopyWith<List<Appointment>, $Res> get appointments;

}
/// @nodoc
class __$AppointmentListStateCopyWithImpl<$Res>
    implements _$AppointmentListStateCopyWith<$Res> {
  __$AppointmentListStateCopyWithImpl(this._self, this._then);

  final _AppointmentListState _self;
  final $Res Function(_AppointmentListState) _then;

/// Create a copy of AppointmentListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologers = null,Object? appointments = null,}) {
  return _then(_AppointmentListState(
astrologers: null == astrologers ? _self.astrologers : astrologers // ignore: cast_nullable_to_non_nullable
as LoadState<List<BookableAstrologer>>,appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as LoadState<List<Appointment>>,
  ));
}

/// Create a copy of AppointmentListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BookableAstrologer>, $Res> get astrologers {
  
  return $LoadStateCopyWith<List<BookableAstrologer>, $Res>(_self.astrologers, (value) {
    return _then(_self.copyWith(astrologers: value));
  });
}/// Create a copy of AppointmentListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Appointment>, $Res> get appointments {
  
  return $LoadStateCopyWith<List<Appointment>, $Res>(_self.appointments, (value) {
    return _then(_self.copyWith(appointments: value));
  });
}
}

// dart format on
