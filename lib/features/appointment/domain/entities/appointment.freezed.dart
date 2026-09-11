// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Appointment {

 String get id; String get astrologerId; LocalizedText get astrologerName; SittingOption get service; int get quantity;/// Gregorian date of the appointment (the traditional-calendar date is
/// derived in presentation from the active region).
 DateTime get date; TimeSlot get slot; AppointmentStatus get status; String get customerName; String get phone; String get email; String get country; PaymentMethod get paymentMethod; DateTime get createdAt; String? get birthPlace; DateTime? get birthDate;/// "HH:mm" 24h.
 String? get birthTime; String? get notes;/// Media id of the birth chart the customer already had, uploaded while
/// booking so the astrologer can read it before the sitting.
 String? get cheenaMediaId;/// Media id of the transfer receipt, for the rails that are settled by
/// hand rather than through a gateway.
 String? get receiptMediaId;
/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentCopyWith<Appointment> get copyWith => _$AppointmentCopyWithImpl<Appointment>(this as Appointment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Appointment&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.astrologerName, astrologerName) || other.astrologerName == astrologerName)&&(identical(other.service, service) || other.service == service)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.date, date) || other.date == date)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.status, status) || other.status == status)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.cheenaMediaId, cheenaMediaId) || other.cheenaMediaId == cheenaMediaId)&&(identical(other.receiptMediaId, receiptMediaId) || other.receiptMediaId == receiptMediaId));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,astrologerId,astrologerName,service,quantity,date,slot,status,customerName,phone,email,country,paymentMethod,createdAt,birthPlace,birthDate,birthTime,notes,cheenaMediaId,receiptMediaId]);

@override
String toString() {
  return 'Appointment(id: $id, astrologerId: $astrologerId, astrologerName: $astrologerName, service: $service, quantity: $quantity, date: $date, slot: $slot, status: $status, customerName: $customerName, phone: $phone, email: $email, country: $country, paymentMethod: $paymentMethod, createdAt: $createdAt, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime, notes: $notes, cheenaMediaId: $cheenaMediaId, receiptMediaId: $receiptMediaId)';
}


}

/// @nodoc
abstract mixin class $AppointmentCopyWith<$Res>  {
  factory $AppointmentCopyWith(Appointment value, $Res Function(Appointment) _then) = _$AppointmentCopyWithImpl;
@useResult
$Res call({
 String id, String astrologerId, LocalizedText astrologerName, SittingOption service, int quantity, DateTime date, TimeSlot slot, AppointmentStatus status, String customerName, String phone, String email, String country, PaymentMethod paymentMethod, DateTime createdAt, String? birthPlace, DateTime? birthDate, String? birthTime, String? notes, String? cheenaMediaId, String? receiptMediaId
});


$LocalizedTextCopyWith<$Res> get astrologerName;$SittingOptionCopyWith<$Res> get service;$TimeSlotCopyWith<$Res> get slot;

}
/// @nodoc
class _$AppointmentCopyWithImpl<$Res>
    implements $AppointmentCopyWith<$Res> {
  _$AppointmentCopyWithImpl(this._self, this._then);

  final Appointment _self;
  final $Res Function(Appointment) _then;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? astrologerId = null,Object? astrologerName = null,Object? service = null,Object? quantity = null,Object? date = null,Object? slot = null,Object? status = null,Object? customerName = null,Object? phone = null,Object? email = null,Object? country = null,Object? paymentMethod = null,Object? createdAt = null,Object? birthPlace = freezed,Object? birthDate = freezed,Object? birthTime = freezed,Object? notes = freezed,Object? cheenaMediaId = freezed,Object? receiptMediaId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,astrologerName: null == astrologerName ? _self.astrologerName : astrologerName // ignore: cast_nullable_to_non_nullable
as LocalizedText,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as SittingOption,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as TimeSlot,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppointmentStatus,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,cheenaMediaId: freezed == cheenaMediaId ? _self.cheenaMediaId : cheenaMediaId // ignore: cast_nullable_to_non_nullable
as String?,receiptMediaId: freezed == receiptMediaId ? _self.receiptMediaId : receiptMediaId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get astrologerName {
  
  return $LocalizedTextCopyWith<$Res>(_self.astrologerName, (value) {
    return _then(_self.copyWith(astrologerName: value));
  });
}/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SittingOptionCopyWith<$Res> get service {
  
  return $SittingOptionCopyWith<$Res>(_self.service, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeSlotCopyWith<$Res> get slot {
  
  return $TimeSlotCopyWith<$Res>(_self.slot, (value) {
    return _then(_self.copyWith(slot: value));
  });
}
}



/// @nodoc


class _Appointment extends Appointment {
  const _Appointment({required this.id, required this.astrologerId, required this.astrologerName, required this.service, required this.quantity, required this.date, required this.slot, required this.status, required this.customerName, required this.phone, required this.email, required this.country, required this.paymentMethod, required this.createdAt, this.birthPlace, this.birthDate, this.birthTime, this.notes, this.cheenaMediaId, this.receiptMediaId}): super._();
  

@override final  String id;
@override final  String astrologerId;
@override final  LocalizedText astrologerName;
@override final  SittingOption service;
@override final  int quantity;
/// Gregorian date of the appointment (the traditional-calendar date is
/// derived in presentation from the active region).
@override final  DateTime date;
@override final  TimeSlot slot;
@override final  AppointmentStatus status;
@override final  String customerName;
@override final  String phone;
@override final  String email;
@override final  String country;
@override final  PaymentMethod paymentMethod;
@override final  DateTime createdAt;
@override final  String? birthPlace;
@override final  DateTime? birthDate;
/// "HH:mm" 24h.
@override final  String? birthTime;
@override final  String? notes;
/// Media id of the birth chart the customer already had, uploaded while
/// booking so the astrologer can read it before the sitting.
@override final  String? cheenaMediaId;
/// Media id of the transfer receipt, for the rails that are settled by
/// hand rather than through a gateway.
@override final  String? receiptMediaId;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentCopyWith<_Appointment> get copyWith => __$AppointmentCopyWithImpl<_Appointment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Appointment&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.astrologerName, astrologerName) || other.astrologerName == astrologerName)&&(identical(other.service, service) || other.service == service)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.date, date) || other.date == date)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.status, status) || other.status == status)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.cheenaMediaId, cheenaMediaId) || other.cheenaMediaId == cheenaMediaId)&&(identical(other.receiptMediaId, receiptMediaId) || other.receiptMediaId == receiptMediaId));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,astrologerId,astrologerName,service,quantity,date,slot,status,customerName,phone,email,country,paymentMethod,createdAt,birthPlace,birthDate,birthTime,notes,cheenaMediaId,receiptMediaId]);

@override
String toString() {
  return 'Appointment(id: $id, astrologerId: $astrologerId, astrologerName: $astrologerName, service: $service, quantity: $quantity, date: $date, slot: $slot, status: $status, customerName: $customerName, phone: $phone, email: $email, country: $country, paymentMethod: $paymentMethod, createdAt: $createdAt, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime, notes: $notes, cheenaMediaId: $cheenaMediaId, receiptMediaId: $receiptMediaId)';
}


}

/// @nodoc
abstract mixin class _$AppointmentCopyWith<$Res> implements $AppointmentCopyWith<$Res> {
  factory _$AppointmentCopyWith(_Appointment value, $Res Function(_Appointment) _then) = __$AppointmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String astrologerId, LocalizedText astrologerName, SittingOption service, int quantity, DateTime date, TimeSlot slot, AppointmentStatus status, String customerName, String phone, String email, String country, PaymentMethod paymentMethod, DateTime createdAt, String? birthPlace, DateTime? birthDate, String? birthTime, String? notes, String? cheenaMediaId, String? receiptMediaId
});


@override $LocalizedTextCopyWith<$Res> get astrologerName;@override $SittingOptionCopyWith<$Res> get service;@override $TimeSlotCopyWith<$Res> get slot;

}
/// @nodoc
class __$AppointmentCopyWithImpl<$Res>
    implements _$AppointmentCopyWith<$Res> {
  __$AppointmentCopyWithImpl(this._self, this._then);

  final _Appointment _self;
  final $Res Function(_Appointment) _then;

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? astrologerId = null,Object? astrologerName = null,Object? service = null,Object? quantity = null,Object? date = null,Object? slot = null,Object? status = null,Object? customerName = null,Object? phone = null,Object? email = null,Object? country = null,Object? paymentMethod = null,Object? createdAt = null,Object? birthPlace = freezed,Object? birthDate = freezed,Object? birthTime = freezed,Object? notes = freezed,Object? cheenaMediaId = freezed,Object? receiptMediaId = freezed,}) {
  return _then(_Appointment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,astrologerName: null == astrologerName ? _self.astrologerName : astrologerName // ignore: cast_nullable_to_non_nullable
as LocalizedText,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as SittingOption,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as TimeSlot,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AppointmentStatus,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,cheenaMediaId: freezed == cheenaMediaId ? _self.cheenaMediaId : cheenaMediaId // ignore: cast_nullable_to_non_nullable
as String?,receiptMediaId: freezed == receiptMediaId ? _self.receiptMediaId : receiptMediaId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get astrologerName {
  
  return $LocalizedTextCopyWith<$Res>(_self.astrologerName, (value) {
    return _then(_self.copyWith(astrologerName: value));
  });
}/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SittingOptionCopyWith<$Res> get service {
  
  return $SittingOptionCopyWith<$Res>(_self.service, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of Appointment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeSlotCopyWith<$Res> get slot {
  
  return $TimeSlotCopyWith<$Res>(_self.slot, (value) {
    return _then(_self.copyWith(slot: value));
  });
}
}

// dart format on
