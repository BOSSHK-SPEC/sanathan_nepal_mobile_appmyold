// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingRequest {

/// The astrologer being booked.
///
/// Their slots come from the weekly hours they keep in the console, so an
/// astrologer who is offline can still be booked for later — which is what
/// the profile now offers instead of a button that led to a 404.
 String get astrologerId;/// Which channel the sitting is held on (`chat` / `voice` / `video`) —
/// the id of the chosen [SittingOption]. It decides the price, so an empty
/// one lets the server fall back to the astrologer's chat rate.
 String get serviceId; int get quantity; DateTime get date; String get slotId; String get customerName; String get phone; String get email; String get country; PaymentMethod get paymentMethod; String? get birthPlace; DateTime? get birthDate; String? get birthTime; String? get notes;/// Media ids of the files attached in the form (birth chart, receipt).
 String? get cheenaMediaId; String? get receiptMediaId;
/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingRequestCopyWith<BookingRequest> get copyWith => _$BookingRequestCopyWithImpl<BookingRequest>(this as BookingRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingRequest&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.date, date) || other.date == date)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.cheenaMediaId, cheenaMediaId) || other.cheenaMediaId == cheenaMediaId)&&(identical(other.receiptMediaId, receiptMediaId) || other.receiptMediaId == receiptMediaId));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,serviceId,quantity,date,slotId,customerName,phone,email,country,paymentMethod,birthPlace,birthDate,birthTime,notes,cheenaMediaId,receiptMediaId);

@override
String toString() {
  return 'BookingRequest(astrologerId: $astrologerId, serviceId: $serviceId, quantity: $quantity, date: $date, slotId: $slotId, customerName: $customerName, phone: $phone, email: $email, country: $country, paymentMethod: $paymentMethod, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime, notes: $notes, cheenaMediaId: $cheenaMediaId, receiptMediaId: $receiptMediaId)';
}


}

/// @nodoc
abstract mixin class $BookingRequestCopyWith<$Res>  {
  factory $BookingRequestCopyWith(BookingRequest value, $Res Function(BookingRequest) _then) = _$BookingRequestCopyWithImpl;
@useResult
$Res call({
 String astrologerId, String serviceId, int quantity, DateTime date, String slotId, String customerName, String phone, String email, String country, PaymentMethod paymentMethod, String? birthPlace, DateTime? birthDate, String? birthTime, String? notes, String? cheenaMediaId, String? receiptMediaId
});




}
/// @nodoc
class _$BookingRequestCopyWithImpl<$Res>
    implements $BookingRequestCopyWith<$Res> {
  _$BookingRequestCopyWithImpl(this._self, this._then);

  final BookingRequest _self;
  final $Res Function(BookingRequest) _then;

/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologerId = null,Object? serviceId = null,Object? quantity = null,Object? date = null,Object? slotId = null,Object? customerName = null,Object? phone = null,Object? email = null,Object? country = null,Object? paymentMethod = null,Object? birthPlace = freezed,Object? birthDate = freezed,Object? birthTime = freezed,Object? notes = freezed,Object? cheenaMediaId = freezed,Object? receiptMediaId = freezed,}) {
  return _then(_self.copyWith(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,cheenaMediaId: freezed == cheenaMediaId ? _self.cheenaMediaId : cheenaMediaId // ignore: cast_nullable_to_non_nullable
as String?,receiptMediaId: freezed == receiptMediaId ? _self.receiptMediaId : receiptMediaId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _BookingRequest implements BookingRequest {
  const _BookingRequest({this.astrologerId = '', this.serviceId = '', required this.quantity, required this.date, required this.slotId, required this.customerName, required this.phone, required this.email, required this.country, required this.paymentMethod, this.birthPlace, this.birthDate, this.birthTime, this.notes, this.cheenaMediaId, this.receiptMediaId});
  

/// The astrologer being booked.
///
/// Their slots come from the weekly hours they keep in the console, so an
/// astrologer who is offline can still be booked for later — which is what
/// the profile now offers instead of a button that led to a 404.
@override@JsonKey() final  String astrologerId;
/// Which channel the sitting is held on (`chat` / `voice` / `video`) —
/// the id of the chosen [SittingOption]. It decides the price, so an empty
/// one lets the server fall back to the astrologer's chat rate.
@override@JsonKey() final  String serviceId;
@override final  int quantity;
@override final  DateTime date;
@override final  String slotId;
@override final  String customerName;
@override final  String phone;
@override final  String email;
@override final  String country;
@override final  PaymentMethod paymentMethod;
@override final  String? birthPlace;
@override final  DateTime? birthDate;
@override final  String? birthTime;
@override final  String? notes;
/// Media ids of the files attached in the form (birth chart, receipt).
@override final  String? cheenaMediaId;
@override final  String? receiptMediaId;

/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingRequestCopyWith<_BookingRequest> get copyWith => __$BookingRequestCopyWithImpl<_BookingRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingRequest&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.date, date) || other.date == date)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.cheenaMediaId, cheenaMediaId) || other.cheenaMediaId == cheenaMediaId)&&(identical(other.receiptMediaId, receiptMediaId) || other.receiptMediaId == receiptMediaId));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,serviceId,quantity,date,slotId,customerName,phone,email,country,paymentMethod,birthPlace,birthDate,birthTime,notes,cheenaMediaId,receiptMediaId);

@override
String toString() {
  return 'BookingRequest(astrologerId: $astrologerId, serviceId: $serviceId, quantity: $quantity, date: $date, slotId: $slotId, customerName: $customerName, phone: $phone, email: $email, country: $country, paymentMethod: $paymentMethod, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime, notes: $notes, cheenaMediaId: $cheenaMediaId, receiptMediaId: $receiptMediaId)';
}


}

/// @nodoc
abstract mixin class _$BookingRequestCopyWith<$Res> implements $BookingRequestCopyWith<$Res> {
  factory _$BookingRequestCopyWith(_BookingRequest value, $Res Function(_BookingRequest) _then) = __$BookingRequestCopyWithImpl;
@override @useResult
$Res call({
 String astrologerId, String serviceId, int quantity, DateTime date, String slotId, String customerName, String phone, String email, String country, PaymentMethod paymentMethod, String? birthPlace, DateTime? birthDate, String? birthTime, String? notes, String? cheenaMediaId, String? receiptMediaId
});




}
/// @nodoc
class __$BookingRequestCopyWithImpl<$Res>
    implements _$BookingRequestCopyWith<$Res> {
  __$BookingRequestCopyWithImpl(this._self, this._then);

  final _BookingRequest _self;
  final $Res Function(_BookingRequest) _then;

/// Create a copy of BookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologerId = null,Object? serviceId = null,Object? quantity = null,Object? date = null,Object? slotId = null,Object? customerName = null,Object? phone = null,Object? email = null,Object? country = null,Object? paymentMethod = null,Object? birthPlace = freezed,Object? birthDate = freezed,Object? birthTime = freezed,Object? notes = freezed,Object? cheenaMediaId = freezed,Object? receiptMediaId = freezed,}) {
  return _then(_BookingRequest(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,cheenaMediaId: freezed == cheenaMediaId ? _self.cheenaMediaId : cheenaMediaId // ignore: cast_nullable_to_non_nullable
as String?,receiptMediaId: freezed == receiptMediaId ? _self.receiptMediaId : receiptMediaId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$RescheduleRequest {

 String get appointmentId; DateTime get date; String get slotId;
/// Create a copy of RescheduleRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RescheduleRequestCopyWith<RescheduleRequest> get copyWith => _$RescheduleRequestCopyWithImpl<RescheduleRequest>(this as RescheduleRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RescheduleRequest&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.date, date) || other.date == date)&&(identical(other.slotId, slotId) || other.slotId == slotId));
}


@override
int get hashCode => Object.hash(runtimeType,appointmentId,date,slotId);

@override
String toString() {
  return 'RescheduleRequest(appointmentId: $appointmentId, date: $date, slotId: $slotId)';
}


}

/// @nodoc
abstract mixin class $RescheduleRequestCopyWith<$Res>  {
  factory $RescheduleRequestCopyWith(RescheduleRequest value, $Res Function(RescheduleRequest) _then) = _$RescheduleRequestCopyWithImpl;
@useResult
$Res call({
 String appointmentId, DateTime date, String slotId
});




}
/// @nodoc
class _$RescheduleRequestCopyWithImpl<$Res>
    implements $RescheduleRequestCopyWith<$Res> {
  _$RescheduleRequestCopyWithImpl(this._self, this._then);

  final RescheduleRequest _self;
  final $Res Function(RescheduleRequest) _then;

/// Create a copy of RescheduleRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointmentId = null,Object? date = null,Object? slotId = null,}) {
  return _then(_self.copyWith(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _RescheduleRequest implements RescheduleRequest {
  const _RescheduleRequest({required this.appointmentId, required this.date, required this.slotId});
  

@override final  String appointmentId;
@override final  DateTime date;
@override final  String slotId;

/// Create a copy of RescheduleRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RescheduleRequestCopyWith<_RescheduleRequest> get copyWith => __$RescheduleRequestCopyWithImpl<_RescheduleRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RescheduleRequest&&(identical(other.appointmentId, appointmentId) || other.appointmentId == appointmentId)&&(identical(other.date, date) || other.date == date)&&(identical(other.slotId, slotId) || other.slotId == slotId));
}


@override
int get hashCode => Object.hash(runtimeType,appointmentId,date,slotId);

@override
String toString() {
  return 'RescheduleRequest(appointmentId: $appointmentId, date: $date, slotId: $slotId)';
}


}

/// @nodoc
abstract mixin class _$RescheduleRequestCopyWith<$Res> implements $RescheduleRequestCopyWith<$Res> {
  factory _$RescheduleRequestCopyWith(_RescheduleRequest value, $Res Function(_RescheduleRequest) _then) = __$RescheduleRequestCopyWithImpl;
@override @useResult
$Res call({
 String appointmentId, DateTime date, String slotId
});




}
/// @nodoc
class __$RescheduleRequestCopyWithImpl<$Res>
    implements _$RescheduleRequestCopyWith<$Res> {
  __$RescheduleRequestCopyWithImpl(this._self, this._then);

  final _RescheduleRequest _self;
  final $Res Function(_RescheduleRequest) _then;

/// Create a copy of RescheduleRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointmentId = null,Object? date = null,Object? slotId = null,}) {
  return _then(_RescheduleRequest(
appointmentId: null == appointmentId ? _self.appointmentId : appointmentId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SlotQuery {

 String get astrologerId; DateTime get date; String? get serviceId;
/// Create a copy of SlotQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotQueryCopyWith<SlotQuery> get copyWith => _$SlotQueryCopyWithImpl<SlotQuery>(this as SlotQuery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotQuery&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.date, date) || other.date == date)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,date,serviceId);

@override
String toString() {
  return 'SlotQuery(astrologerId: $astrologerId, date: $date, serviceId: $serviceId)';
}


}

/// @nodoc
abstract mixin class $SlotQueryCopyWith<$Res>  {
  factory $SlotQueryCopyWith(SlotQuery value, $Res Function(SlotQuery) _then) = _$SlotQueryCopyWithImpl;
@useResult
$Res call({
 String astrologerId, DateTime date, String? serviceId
});




}
/// @nodoc
class _$SlotQueryCopyWithImpl<$Res>
    implements $SlotQueryCopyWith<$Res> {
  _$SlotQueryCopyWithImpl(this._self, this._then);

  final SlotQuery _self;
  final $Res Function(SlotQuery) _then;

/// Create a copy of SlotQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologerId = null,Object? date = null,Object? serviceId = freezed,}) {
  return _then(_self.copyWith(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _SlotQuery implements SlotQuery {
  const _SlotQuery({required this.astrologerId, required this.date, this.serviceId});
  

@override final  String astrologerId;
@override final  DateTime date;
@override final  String? serviceId;

/// Create a copy of SlotQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotQueryCopyWith<_SlotQuery> get copyWith => __$SlotQueryCopyWithImpl<_SlotQuery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotQuery&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.date, date) || other.date == date)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,date,serviceId);

@override
String toString() {
  return 'SlotQuery(astrologerId: $astrologerId, date: $date, serviceId: $serviceId)';
}


}

/// @nodoc
abstract mixin class _$SlotQueryCopyWith<$Res> implements $SlotQueryCopyWith<$Res> {
  factory _$SlotQueryCopyWith(_SlotQuery value, $Res Function(_SlotQuery) _then) = __$SlotQueryCopyWithImpl;
@override @useResult
$Res call({
 String astrologerId, DateTime date, String? serviceId
});




}
/// @nodoc
class __$SlotQueryCopyWithImpl<$Res>
    implements _$SlotQueryCopyWith<$Res> {
  __$SlotQueryCopyWithImpl(this._self, this._then);

  final _SlotQuery _self;
  final $Res Function(_SlotQuery) _then;

/// Create a copy of SlotQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologerId = null,Object? date = null,Object? serviceId = freezed,}) {
  return _then(_SlotQuery(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
