// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'puja_booking_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PujaBookingState {

 LoadState<PujaBooking> get booking; bool get cancelling; String? get actionError;
/// Create a copy of PujaBookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PujaBookingStateCopyWith<PujaBookingState> get copyWith => _$PujaBookingStateCopyWithImpl<PujaBookingState>(this as PujaBookingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PujaBookingState&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.cancelling, cancelling) || other.cancelling == cancelling)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,booking,cancelling,actionError);

@override
String toString() {
  return 'PujaBookingState(booking: $booking, cancelling: $cancelling, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $PujaBookingStateCopyWith<$Res>  {
  factory $PujaBookingStateCopyWith(PujaBookingState value, $Res Function(PujaBookingState) _then) = _$PujaBookingStateCopyWithImpl;
@useResult
$Res call({
 LoadState<PujaBooking> booking, bool cancelling, String? actionError
});


$LoadStateCopyWith<PujaBooking, $Res> get booking;

}
/// @nodoc
class _$PujaBookingStateCopyWithImpl<$Res>
    implements $PujaBookingStateCopyWith<$Res> {
  _$PujaBookingStateCopyWithImpl(this._self, this._then);

  final PujaBookingState _self;
  final $Res Function(PujaBookingState) _then;

/// Create a copy of PujaBookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? booking = null,Object? cancelling = null,Object? actionError = freezed,}) {
  return _then(_self.copyWith(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as LoadState<PujaBooking>,cancelling: null == cancelling ? _self.cancelling : cancelling // ignore: cast_nullable_to_non_nullable
as bool,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PujaBookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PujaBooking, $Res> get booking {
  
  return $LoadStateCopyWith<PujaBooking, $Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}



/// @nodoc


class _PujaBookingState extends PujaBookingState {
  const _PujaBookingState({this.booking = const LoadState.idle(), this.cancelling = false, this.actionError}): super._();
  

@override@JsonKey() final  LoadState<PujaBooking> booking;
@override@JsonKey() final  bool cancelling;
@override final  String? actionError;

/// Create a copy of PujaBookingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PujaBookingStateCopyWith<_PujaBookingState> get copyWith => __$PujaBookingStateCopyWithImpl<_PujaBookingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PujaBookingState&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.cancelling, cancelling) || other.cancelling == cancelling)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,booking,cancelling,actionError);

@override
String toString() {
  return 'PujaBookingState(booking: $booking, cancelling: $cancelling, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class _$PujaBookingStateCopyWith<$Res> implements $PujaBookingStateCopyWith<$Res> {
  factory _$PujaBookingStateCopyWith(_PujaBookingState value, $Res Function(_PujaBookingState) _then) = __$PujaBookingStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<PujaBooking> booking, bool cancelling, String? actionError
});


@override $LoadStateCopyWith<PujaBooking, $Res> get booking;

}
/// @nodoc
class __$PujaBookingStateCopyWithImpl<$Res>
    implements _$PujaBookingStateCopyWith<$Res> {
  __$PujaBookingStateCopyWithImpl(this._self, this._then);

  final _PujaBookingState _self;
  final $Res Function(_PujaBookingState) _then;

/// Create a copy of PujaBookingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? booking = null,Object? cancelling = null,Object? actionError = freezed,}) {
  return _then(_PujaBookingState(
booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as LoadState<PujaBooking>,cancelling: null == cancelling ? _self.cancelling : cancelling // ignore: cast_nullable_to_non_nullable
as bool,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PujaBookingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PujaBooking, $Res> get booking {
  
  return $LoadStateCopyWith<PujaBooking, $Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}
}

// dart format on
