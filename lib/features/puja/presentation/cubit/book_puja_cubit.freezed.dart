// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_puja_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookPujaState {

 DateTime get date; LoadState<PujaService> get service; LoadState<List<DateTime>> get times; LoadState<PujaBooking> get booking; SankalpDetails get sankalp; bool get withSamagri; String get address; PujaMode? get mode; DateTime? get selectedTime; PaymentRail? get rail; String? get bookingError;
/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookPujaStateCopyWith<BookPujaState> get copyWith => _$BookPujaStateCopyWithImpl<BookPujaState>(this as BookPujaState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookPujaState&&(identical(other.date, date) || other.date == date)&&(identical(other.service, service) || other.service == service)&&(identical(other.times, times) || other.times == times)&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.sankalp, sankalp) || other.sankalp == sankalp)&&(identical(other.withSamagri, withSamagri) || other.withSamagri == withSamagri)&&(identical(other.address, address) || other.address == address)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime)&&(identical(other.rail, rail) || other.rail == rail)&&(identical(other.bookingError, bookingError) || other.bookingError == bookingError));
}


@override
int get hashCode => Object.hash(runtimeType,date,service,times,booking,sankalp,withSamagri,address,mode,selectedTime,rail,bookingError);

@override
String toString() {
  return 'BookPujaState(date: $date, service: $service, times: $times, booking: $booking, sankalp: $sankalp, withSamagri: $withSamagri, address: $address, mode: $mode, selectedTime: $selectedTime, rail: $rail, bookingError: $bookingError)';
}


}

/// @nodoc
abstract mixin class $BookPujaStateCopyWith<$Res>  {
  factory $BookPujaStateCopyWith(BookPujaState value, $Res Function(BookPujaState) _then) = _$BookPujaStateCopyWithImpl;
@useResult
$Res call({
 DateTime date, LoadState<PujaService> service, LoadState<List<DateTime>> times, LoadState<PujaBooking> booking, SankalpDetails sankalp, bool withSamagri, String address, PujaMode? mode, DateTime? selectedTime, PaymentRail? rail, String? bookingError
});


$LoadStateCopyWith<PujaService, $Res> get service;$LoadStateCopyWith<List<DateTime>, $Res> get times;$LoadStateCopyWith<PujaBooking, $Res> get booking;$SankalpDetailsCopyWith<$Res> get sankalp;

}
/// @nodoc
class _$BookPujaStateCopyWithImpl<$Res>
    implements $BookPujaStateCopyWith<$Res> {
  _$BookPujaStateCopyWithImpl(this._self, this._then);

  final BookPujaState _self;
  final $Res Function(BookPujaState) _then;

/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? service = null,Object? times = null,Object? booking = null,Object? sankalp = null,Object? withSamagri = null,Object? address = null,Object? mode = freezed,Object? selectedTime = freezed,Object? rail = freezed,Object? bookingError = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as LoadState<PujaService>,times: null == times ? _self.times : times // ignore: cast_nullable_to_non_nullable
as LoadState<List<DateTime>>,booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as LoadState<PujaBooking>,sankalp: null == sankalp ? _self.sankalp : sankalp // ignore: cast_nullable_to_non_nullable
as SankalpDetails,withSamagri: null == withSamagri ? _self.withSamagri : withSamagri // ignore: cast_nullable_to_non_nullable
as bool,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PujaMode?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,rail: freezed == rail ? _self.rail : rail // ignore: cast_nullable_to_non_nullable
as PaymentRail?,bookingError: freezed == bookingError ? _self.bookingError : bookingError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PujaService, $Res> get service {
  
  return $LoadStateCopyWith<PujaService, $Res>(_self.service, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DateTime>, $Res> get times {
  
  return $LoadStateCopyWith<List<DateTime>, $Res>(_self.times, (value) {
    return _then(_self.copyWith(times: value));
  });
}/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PujaBooking, $Res> get booking {
  
  return $LoadStateCopyWith<PujaBooking, $Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SankalpDetailsCopyWith<$Res> get sankalp {
  
  return $SankalpDetailsCopyWith<$Res>(_self.sankalp, (value) {
    return _then(_self.copyWith(sankalp: value));
  });
}
}



/// @nodoc


class _BookPujaState extends BookPujaState {
  const _BookPujaState({required this.date, this.service = const LoadState.idle(), this.times = const LoadState.idle(), this.booking = const LoadState.idle(), this.sankalp = const SankalpDetails(), this.withSamagri = false, this.address = '', this.mode, this.selectedTime, this.rail, this.bookingError}): super._();
  

@override final  DateTime date;
@override@JsonKey() final  LoadState<PujaService> service;
@override@JsonKey() final  LoadState<List<DateTime>> times;
@override@JsonKey() final  LoadState<PujaBooking> booking;
@override@JsonKey() final  SankalpDetails sankalp;
@override@JsonKey() final  bool withSamagri;
@override@JsonKey() final  String address;
@override final  PujaMode? mode;
@override final  DateTime? selectedTime;
@override final  PaymentRail? rail;
@override final  String? bookingError;

/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookPujaStateCopyWith<_BookPujaState> get copyWith => __$BookPujaStateCopyWithImpl<_BookPujaState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookPujaState&&(identical(other.date, date) || other.date == date)&&(identical(other.service, service) || other.service == service)&&(identical(other.times, times) || other.times == times)&&(identical(other.booking, booking) || other.booking == booking)&&(identical(other.sankalp, sankalp) || other.sankalp == sankalp)&&(identical(other.withSamagri, withSamagri) || other.withSamagri == withSamagri)&&(identical(other.address, address) || other.address == address)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime)&&(identical(other.rail, rail) || other.rail == rail)&&(identical(other.bookingError, bookingError) || other.bookingError == bookingError));
}


@override
int get hashCode => Object.hash(runtimeType,date,service,times,booking,sankalp,withSamagri,address,mode,selectedTime,rail,bookingError);

@override
String toString() {
  return 'BookPujaState(date: $date, service: $service, times: $times, booking: $booking, sankalp: $sankalp, withSamagri: $withSamagri, address: $address, mode: $mode, selectedTime: $selectedTime, rail: $rail, bookingError: $bookingError)';
}


}

/// @nodoc
abstract mixin class _$BookPujaStateCopyWith<$Res> implements $BookPujaStateCopyWith<$Res> {
  factory _$BookPujaStateCopyWith(_BookPujaState value, $Res Function(_BookPujaState) _then) = __$BookPujaStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, LoadState<PujaService> service, LoadState<List<DateTime>> times, LoadState<PujaBooking> booking, SankalpDetails sankalp, bool withSamagri, String address, PujaMode? mode, DateTime? selectedTime, PaymentRail? rail, String? bookingError
});


@override $LoadStateCopyWith<PujaService, $Res> get service;@override $LoadStateCopyWith<List<DateTime>, $Res> get times;@override $LoadStateCopyWith<PujaBooking, $Res> get booking;@override $SankalpDetailsCopyWith<$Res> get sankalp;

}
/// @nodoc
class __$BookPujaStateCopyWithImpl<$Res>
    implements _$BookPujaStateCopyWith<$Res> {
  __$BookPujaStateCopyWithImpl(this._self, this._then);

  final _BookPujaState _self;
  final $Res Function(_BookPujaState) _then;

/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? service = null,Object? times = null,Object? booking = null,Object? sankalp = null,Object? withSamagri = null,Object? address = null,Object? mode = freezed,Object? selectedTime = freezed,Object? rail = freezed,Object? bookingError = freezed,}) {
  return _then(_BookPujaState(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as LoadState<PujaService>,times: null == times ? _self.times : times // ignore: cast_nullable_to_non_nullable
as LoadState<List<DateTime>>,booking: null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as LoadState<PujaBooking>,sankalp: null == sankalp ? _self.sankalp : sankalp // ignore: cast_nullable_to_non_nullable
as SankalpDetails,withSamagri: null == withSamagri ? _self.withSamagri : withSamagri // ignore: cast_nullable_to_non_nullable
as bool,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PujaMode?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,rail: freezed == rail ? _self.rail : rail // ignore: cast_nullable_to_non_nullable
as PaymentRail?,bookingError: freezed == bookingError ? _self.bookingError : bookingError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PujaService, $Res> get service {
  
  return $LoadStateCopyWith<PujaService, $Res>(_self.service, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<DateTime>, $Res> get times {
  
  return $LoadStateCopyWith<List<DateTime>, $Res>(_self.times, (value) {
    return _then(_self.copyWith(times: value));
  });
}/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PujaBooking, $Res> get booking {
  
  return $LoadStateCopyWith<PujaBooking, $Res>(_self.booking, (value) {
    return _then(_self.copyWith(booking: value));
  });
}/// Create a copy of BookPujaState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SankalpDetailsCopyWith<$Res> get sankalp {
  
  return $SankalpDetailsCopyWith<$Res>(_self.sankalp, (value) {
    return _then(_self.copyWith(sankalp: value));
  });
}
}

// dart format on
