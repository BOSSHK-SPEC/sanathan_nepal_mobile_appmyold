// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppointmentModel {

 String get id; String get astrologerId; LocalizedTextModel get astrologerName; SittingOptionModel get service; int get quantity; DateTime get date; TimeSlotModel get slot;@JsonKey(unknownEnumValue: AppointmentStatus.booked) AppointmentStatus get status; String get customerName; String get phone; String get email; String get country;@JsonKey(unknownEnumValue: PaymentMethod.esewa) PaymentMethod get paymentMethod; DateTime get createdAt; String? get birthPlace; DateTime? get birthDate; String? get birthTime; String? get notes; String? get cheenaMediaId; String? get receiptMediaId;
/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentModelCopyWith<AppointmentModel> get copyWith => _$AppointmentModelCopyWithImpl<AppointmentModel>(this as AppointmentModel, _$identity);

  /// Serializes this AppointmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.astrologerName, astrologerName) || other.astrologerName == astrologerName)&&(identical(other.service, service) || other.service == service)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.date, date) || other.date == date)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.status, status) || other.status == status)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.cheenaMediaId, cheenaMediaId) || other.cheenaMediaId == cheenaMediaId)&&(identical(other.receiptMediaId, receiptMediaId) || other.receiptMediaId == receiptMediaId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,astrologerId,astrologerName,service,quantity,date,slot,status,customerName,phone,email,country,paymentMethod,createdAt,birthPlace,birthDate,birthTime,notes,cheenaMediaId,receiptMediaId]);

@override
String toString() {
  return 'AppointmentModel(id: $id, astrologerId: $astrologerId, astrologerName: $astrologerName, service: $service, quantity: $quantity, date: $date, slot: $slot, status: $status, customerName: $customerName, phone: $phone, email: $email, country: $country, paymentMethod: $paymentMethod, createdAt: $createdAt, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime, notes: $notes, cheenaMediaId: $cheenaMediaId, receiptMediaId: $receiptMediaId)';
}


}

/// @nodoc
abstract mixin class $AppointmentModelCopyWith<$Res>  {
  factory $AppointmentModelCopyWith(AppointmentModel value, $Res Function(AppointmentModel) _then) = _$AppointmentModelCopyWithImpl;
@useResult
$Res call({
 String id, String astrologerId, LocalizedTextModel astrologerName, SittingOptionModel service, int quantity, DateTime date, TimeSlotModel slot,@JsonKey(unknownEnumValue: AppointmentStatus.booked) AppointmentStatus status, String customerName, String phone, String email, String country,@JsonKey(unknownEnumValue: PaymentMethod.esewa) PaymentMethod paymentMethod, DateTime createdAt, String? birthPlace, DateTime? birthDate, String? birthTime, String? notes, String? cheenaMediaId, String? receiptMediaId
});


$LocalizedTextModelCopyWith<$Res> get astrologerName;$SittingOptionModelCopyWith<$Res> get service;$TimeSlotModelCopyWith<$Res> get slot;

}
/// @nodoc
class _$AppointmentModelCopyWithImpl<$Res>
    implements $AppointmentModelCopyWith<$Res> {
  _$AppointmentModelCopyWithImpl(this._self, this._then);

  final AppointmentModel _self;
  final $Res Function(AppointmentModel) _then;

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? astrologerId = null,Object? astrologerName = null,Object? service = null,Object? quantity = null,Object? date = null,Object? slot = null,Object? status = null,Object? customerName = null,Object? phone = null,Object? email = null,Object? country = null,Object? paymentMethod = null,Object? createdAt = null,Object? birthPlace = freezed,Object? birthDate = freezed,Object? birthTime = freezed,Object? notes = freezed,Object? cheenaMediaId = freezed,Object? receiptMediaId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,astrologerName: null == astrologerName ? _self.astrologerName : astrologerName // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as SittingOptionModel,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as TimeSlotModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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
/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get astrologerName {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.astrologerName, (value) {
    return _then(_self.copyWith(astrologerName: value));
  });
}/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SittingOptionModelCopyWith<$Res> get service {
  
  return $SittingOptionModelCopyWith<$Res>(_self.service, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeSlotModelCopyWith<$Res> get slot {
  
  return $TimeSlotModelCopyWith<$Res>(_self.slot, (value) {
    return _then(_self.copyWith(slot: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _AppointmentModel extends AppointmentModel {
  const _AppointmentModel({required this.id, required this.astrologerId, required this.astrologerName, required this.service, this.quantity = 1, required this.date, required this.slot, @JsonKey(unknownEnumValue: AppointmentStatus.booked) this.status = AppointmentStatus.booked, this.customerName = '', this.phone = '', this.email = '', this.country = '', @JsonKey(unknownEnumValue: PaymentMethod.esewa) this.paymentMethod = PaymentMethod.esewa, required this.createdAt, this.birthPlace, this.birthDate, this.birthTime, this.notes, this.cheenaMediaId, this.receiptMediaId}): super._();
  factory _AppointmentModel.fromJson(Map<String, dynamic> json) => _$AppointmentModelFromJson(json);

@override final  String id;
@override final  String astrologerId;
@override final  LocalizedTextModel astrologerName;
@override final  SittingOptionModel service;
@override@JsonKey() final  int quantity;
@override final  DateTime date;
@override final  TimeSlotModel slot;
@override@JsonKey(unknownEnumValue: AppointmentStatus.booked) final  AppointmentStatus status;
@override@JsonKey() final  String customerName;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String email;
@override@JsonKey() final  String country;
@override@JsonKey(unknownEnumValue: PaymentMethod.esewa) final  PaymentMethod paymentMethod;
@override final  DateTime createdAt;
@override final  String? birthPlace;
@override final  DateTime? birthDate;
@override final  String? birthTime;
@override final  String? notes;
@override final  String? cheenaMediaId;
@override final  String? receiptMediaId;

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentModelCopyWith<_AppointmentModel> get copyWith => __$AppointmentModelCopyWithImpl<_AppointmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.astrologerName, astrologerName) || other.astrologerName == astrologerName)&&(identical(other.service, service) || other.service == service)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.date, date) || other.date == date)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.status, status) || other.status == status)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.cheenaMediaId, cheenaMediaId) || other.cheenaMediaId == cheenaMediaId)&&(identical(other.receiptMediaId, receiptMediaId) || other.receiptMediaId == receiptMediaId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,astrologerId,astrologerName,service,quantity,date,slot,status,customerName,phone,email,country,paymentMethod,createdAt,birthPlace,birthDate,birthTime,notes,cheenaMediaId,receiptMediaId]);

@override
String toString() {
  return 'AppointmentModel(id: $id, astrologerId: $astrologerId, astrologerName: $astrologerName, service: $service, quantity: $quantity, date: $date, slot: $slot, status: $status, customerName: $customerName, phone: $phone, email: $email, country: $country, paymentMethod: $paymentMethod, createdAt: $createdAt, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime, notes: $notes, cheenaMediaId: $cheenaMediaId, receiptMediaId: $receiptMediaId)';
}


}

/// @nodoc
abstract mixin class _$AppointmentModelCopyWith<$Res> implements $AppointmentModelCopyWith<$Res> {
  factory _$AppointmentModelCopyWith(_AppointmentModel value, $Res Function(_AppointmentModel) _then) = __$AppointmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String astrologerId, LocalizedTextModel astrologerName, SittingOptionModel service, int quantity, DateTime date, TimeSlotModel slot,@JsonKey(unknownEnumValue: AppointmentStatus.booked) AppointmentStatus status, String customerName, String phone, String email, String country,@JsonKey(unknownEnumValue: PaymentMethod.esewa) PaymentMethod paymentMethod, DateTime createdAt, String? birthPlace, DateTime? birthDate, String? birthTime, String? notes, String? cheenaMediaId, String? receiptMediaId
});


@override $LocalizedTextModelCopyWith<$Res> get astrologerName;@override $SittingOptionModelCopyWith<$Res> get service;@override $TimeSlotModelCopyWith<$Res> get slot;

}
/// @nodoc
class __$AppointmentModelCopyWithImpl<$Res>
    implements _$AppointmentModelCopyWith<$Res> {
  __$AppointmentModelCopyWithImpl(this._self, this._then);

  final _AppointmentModel _self;
  final $Res Function(_AppointmentModel) _then;

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? astrologerId = null,Object? astrologerName = null,Object? service = null,Object? quantity = null,Object? date = null,Object? slot = null,Object? status = null,Object? customerName = null,Object? phone = null,Object? email = null,Object? country = null,Object? paymentMethod = null,Object? createdAt = null,Object? birthPlace = freezed,Object? birthDate = freezed,Object? birthTime = freezed,Object? notes = freezed,Object? cheenaMediaId = freezed,Object? receiptMediaId = freezed,}) {
  return _then(_AppointmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,astrologerName: null == astrologerName ? _self.astrologerName : astrologerName // ignore: cast_nullable_to_non_nullable
as LocalizedTextModel,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as SittingOptionModel,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as TimeSlotModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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

/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextModelCopyWith<$Res> get astrologerName {
  
  return $LocalizedTextModelCopyWith<$Res>(_self.astrologerName, (value) {
    return _then(_self.copyWith(astrologerName: value));
  });
}/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SittingOptionModelCopyWith<$Res> get service {
  
  return $SittingOptionModelCopyWith<$Res>(_self.service, (value) {
    return _then(_self.copyWith(service: value));
  });
}/// Create a copy of AppointmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeSlotModelCopyWith<$Res> get slot {
  
  return $TimeSlotModelCopyWith<$Res>(_self.slot, (value) {
    return _then(_self.copyWith(slot: value));
  });
}
}

// dart format on
