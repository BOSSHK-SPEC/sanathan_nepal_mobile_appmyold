// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_appointment_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookAppointmentState {

 BookableAstrologer get astrologer; String get serviceId; DateTime get date; BookingStep get step;/// Always one. A sitting is a single half hour in one diary: booking it
/// twice is not a bigger booking, it is the same slot claimed twice, which
/// the server refuses. Kept in state because the request carries it.
/// Days in the astrologer's published fortnight that still have a free
/// slot, so the calendar can dim the ones that never will.
 List<DateTime> get availableDays; int get quantity; DateMode get dateMode;/// Slots of the selected [date].
 LoadState<List<TimeSlot>> get slots; String? get slotId; String get customerName; String get phone; String get email; String get country; String get birthPlace; DateTime? get birthDate; String? get birthTime; String get notes; PaymentMethod get paymentMethod;/// Media id of the birth chart attached in step 2, once uploaded.
 String? get cheenaMediaId;/// Media id of the transfer receipt attached in step 3, once uploaded.
 String? get receiptMediaId;/// Booking call; `loaded` carries the created appointment.
 LoadState<Appointment> get submission;
/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookAppointmentStateCopyWith<BookAppointmentState> get copyWith => _$BookAppointmentStateCopyWithImpl<BookAppointmentState>(this as BookAppointmentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookAppointmentState&&(identical(other.astrologer, astrologer) || other.astrologer == astrologer)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.date, date) || other.date == date)&&(identical(other.step, step) || other.step == step)&&const DeepCollectionEquality().equals(other.availableDays, availableDays)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.dateMode, dateMode) || other.dateMode == dateMode)&&(identical(other.slots, slots) || other.slots == slots)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.cheenaMediaId, cheenaMediaId) || other.cheenaMediaId == cheenaMediaId)&&(identical(other.receiptMediaId, receiptMediaId) || other.receiptMediaId == receiptMediaId)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hashAll([runtimeType,astrologer,serviceId,date,step,const DeepCollectionEquality().hash(availableDays),quantity,dateMode,slots,slotId,customerName,phone,email,country,birthPlace,birthDate,birthTime,notes,paymentMethod,cheenaMediaId,receiptMediaId,submission]);

@override
String toString() {
  return 'BookAppointmentState(astrologer: $astrologer, serviceId: $serviceId, date: $date, step: $step, availableDays: $availableDays, quantity: $quantity, dateMode: $dateMode, slots: $slots, slotId: $slotId, customerName: $customerName, phone: $phone, email: $email, country: $country, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime, notes: $notes, paymentMethod: $paymentMethod, cheenaMediaId: $cheenaMediaId, receiptMediaId: $receiptMediaId, submission: $submission)';
}


}

/// @nodoc
abstract mixin class $BookAppointmentStateCopyWith<$Res>  {
  factory $BookAppointmentStateCopyWith(BookAppointmentState value, $Res Function(BookAppointmentState) _then) = _$BookAppointmentStateCopyWithImpl;
@useResult
$Res call({
 BookableAstrologer astrologer, String serviceId, DateTime date, BookingStep step, List<DateTime> availableDays, int quantity, DateMode dateMode, LoadState<List<TimeSlot>> slots, String? slotId, String customerName, String phone, String email, String country, String birthPlace, DateTime? birthDate, String? birthTime, String notes, PaymentMethod paymentMethod, String? cheenaMediaId, String? receiptMediaId, LoadState<Appointment> submission
});


$BookableAstrologerCopyWith<$Res> get astrologer;$LoadStateCopyWith<List<TimeSlot>, $Res> get slots;$LoadStateCopyWith<Appointment, $Res> get submission;

}
/// @nodoc
class _$BookAppointmentStateCopyWithImpl<$Res>
    implements $BookAppointmentStateCopyWith<$Res> {
  _$BookAppointmentStateCopyWithImpl(this._self, this._then);

  final BookAppointmentState _self;
  final $Res Function(BookAppointmentState) _then;

/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologer = null,Object? serviceId = null,Object? date = null,Object? step = null,Object? availableDays = null,Object? quantity = null,Object? dateMode = null,Object? slots = null,Object? slotId = freezed,Object? customerName = null,Object? phone = null,Object? email = null,Object? country = null,Object? birthPlace = null,Object? birthDate = freezed,Object? birthTime = freezed,Object? notes = null,Object? paymentMethod = null,Object? cheenaMediaId = freezed,Object? receiptMediaId = freezed,Object? submission = null,}) {
  return _then(_self.copyWith(
astrologer: null == astrologer ? _self.astrologer : astrologer // ignore: cast_nullable_to_non_nullable
as BookableAstrologer,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as BookingStep,availableDays: null == availableDays ? _self.availableDays : availableDays // ignore: cast_nullable_to_non_nullable
as List<DateTime>,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,dateMode: null == dateMode ? _self.dateMode : dateMode // ignore: cast_nullable_to_non_nullable
as DateMode,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as LoadState<List<TimeSlot>>,slotId: freezed == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,cheenaMediaId: freezed == cheenaMediaId ? _self.cheenaMediaId : cheenaMediaId // ignore: cast_nullable_to_non_nullable
as String?,receiptMediaId: freezed == receiptMediaId ? _self.receiptMediaId : receiptMediaId // ignore: cast_nullable_to_non_nullable
as String?,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<Appointment>,
  ));
}
/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookableAstrologerCopyWith<$Res> get astrologer {
  
  return $BookableAstrologerCopyWith<$Res>(_self.astrologer, (value) {
    return _then(_self.copyWith(astrologer: value));
  });
}/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TimeSlot>, $Res> get slots {
  
  return $LoadStateCopyWith<List<TimeSlot>, $Res>(_self.slots, (value) {
    return _then(_self.copyWith(slots: value));
  });
}/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Appointment, $Res> get submission {
  
  return $LoadStateCopyWith<Appointment, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}



/// @nodoc


class _BookAppointmentState extends BookAppointmentState {
  const _BookAppointmentState({required this.astrologer, required this.serviceId, required this.date, this.step = BookingStep.basicInfo, final  List<DateTime> availableDays = const <DateTime>[], this.quantity = 1, this.dateMode = DateMode.traditional, this.slots = const LoadState.idle(), this.slotId, this.customerName = '', this.phone = '', this.email = '', this.country = 'Nepal', this.birthPlace = '', this.birthDate, this.birthTime, this.notes = '', this.paymentMethod = PaymentMethod.esewa, this.cheenaMediaId, this.receiptMediaId, this.submission = const LoadState.idle()}): _availableDays = availableDays,super._();
  

@override final  BookableAstrologer astrologer;
@override final  String serviceId;
@override final  DateTime date;
@override@JsonKey() final  BookingStep step;
/// Always one. A sitting is a single half hour in one diary: booking it
/// twice is not a bigger booking, it is the same slot claimed twice, which
/// the server refuses. Kept in state because the request carries it.
/// Days in the astrologer's published fortnight that still have a free
/// slot, so the calendar can dim the ones that never will.
 final  List<DateTime> _availableDays;
/// Always one. A sitting is a single half hour in one diary: booking it
/// twice is not a bigger booking, it is the same slot claimed twice, which
/// the server refuses. Kept in state because the request carries it.
/// Days in the astrologer's published fortnight that still have a free
/// slot, so the calendar can dim the ones that never will.
@override@JsonKey() List<DateTime> get availableDays {
  if (_availableDays is EqualUnmodifiableListView) return _availableDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableDays);
}

@override@JsonKey() final  int quantity;
@override@JsonKey() final  DateMode dateMode;
/// Slots of the selected [date].
@override@JsonKey() final  LoadState<List<TimeSlot>> slots;
@override final  String? slotId;
@override@JsonKey() final  String customerName;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String email;
@override@JsonKey() final  String country;
@override@JsonKey() final  String birthPlace;
@override final  DateTime? birthDate;
@override final  String? birthTime;
@override@JsonKey() final  String notes;
@override@JsonKey() final  PaymentMethod paymentMethod;
/// Media id of the birth chart attached in step 2, once uploaded.
@override final  String? cheenaMediaId;
/// Media id of the transfer receipt attached in step 3, once uploaded.
@override final  String? receiptMediaId;
/// Booking call; `loaded` carries the created appointment.
@override@JsonKey() final  LoadState<Appointment> submission;

/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookAppointmentStateCopyWith<_BookAppointmentState> get copyWith => __$BookAppointmentStateCopyWithImpl<_BookAppointmentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookAppointmentState&&(identical(other.astrologer, astrologer) || other.astrologer == astrologer)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.date, date) || other.date == date)&&(identical(other.step, step) || other.step == step)&&const DeepCollectionEquality().equals(other._availableDays, _availableDays)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.dateMode, dateMode) || other.dateMode == dateMode)&&(identical(other.slots, slots) || other.slots == slots)&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.country, country) || other.country == country)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.cheenaMediaId, cheenaMediaId) || other.cheenaMediaId == cheenaMediaId)&&(identical(other.receiptMediaId, receiptMediaId) || other.receiptMediaId == receiptMediaId)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hashAll([runtimeType,astrologer,serviceId,date,step,const DeepCollectionEquality().hash(_availableDays),quantity,dateMode,slots,slotId,customerName,phone,email,country,birthPlace,birthDate,birthTime,notes,paymentMethod,cheenaMediaId,receiptMediaId,submission]);

@override
String toString() {
  return 'BookAppointmentState(astrologer: $astrologer, serviceId: $serviceId, date: $date, step: $step, availableDays: $availableDays, quantity: $quantity, dateMode: $dateMode, slots: $slots, slotId: $slotId, customerName: $customerName, phone: $phone, email: $email, country: $country, birthPlace: $birthPlace, birthDate: $birthDate, birthTime: $birthTime, notes: $notes, paymentMethod: $paymentMethod, cheenaMediaId: $cheenaMediaId, receiptMediaId: $receiptMediaId, submission: $submission)';
}


}

/// @nodoc
abstract mixin class _$BookAppointmentStateCopyWith<$Res> implements $BookAppointmentStateCopyWith<$Res> {
  factory _$BookAppointmentStateCopyWith(_BookAppointmentState value, $Res Function(_BookAppointmentState) _then) = __$BookAppointmentStateCopyWithImpl;
@override @useResult
$Res call({
 BookableAstrologer astrologer, String serviceId, DateTime date, BookingStep step, List<DateTime> availableDays, int quantity, DateMode dateMode, LoadState<List<TimeSlot>> slots, String? slotId, String customerName, String phone, String email, String country, String birthPlace, DateTime? birthDate, String? birthTime, String notes, PaymentMethod paymentMethod, String? cheenaMediaId, String? receiptMediaId, LoadState<Appointment> submission
});


@override $BookableAstrologerCopyWith<$Res> get astrologer;@override $LoadStateCopyWith<List<TimeSlot>, $Res> get slots;@override $LoadStateCopyWith<Appointment, $Res> get submission;

}
/// @nodoc
class __$BookAppointmentStateCopyWithImpl<$Res>
    implements _$BookAppointmentStateCopyWith<$Res> {
  __$BookAppointmentStateCopyWithImpl(this._self, this._then);

  final _BookAppointmentState _self;
  final $Res Function(_BookAppointmentState) _then;

/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologer = null,Object? serviceId = null,Object? date = null,Object? step = null,Object? availableDays = null,Object? quantity = null,Object? dateMode = null,Object? slots = null,Object? slotId = freezed,Object? customerName = null,Object? phone = null,Object? email = null,Object? country = null,Object? birthPlace = null,Object? birthDate = freezed,Object? birthTime = freezed,Object? notes = null,Object? paymentMethod = null,Object? cheenaMediaId = freezed,Object? receiptMediaId = freezed,Object? submission = null,}) {
  return _then(_BookAppointmentState(
astrologer: null == astrologer ? _self.astrologer : astrologer // ignore: cast_nullable_to_non_nullable
as BookableAstrologer,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as BookingStep,availableDays: null == availableDays ? _self._availableDays : availableDays // ignore: cast_nullable_to_non_nullable
as List<DateTime>,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,dateMode: null == dateMode ? _self.dateMode : dateMode // ignore: cast_nullable_to_non_nullable
as DateMode,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as LoadState<List<TimeSlot>>,slotId: freezed == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String?,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,cheenaMediaId: freezed == cheenaMediaId ? _self.cheenaMediaId : cheenaMediaId // ignore: cast_nullable_to_non_nullable
as String?,receiptMediaId: freezed == receiptMediaId ? _self.receiptMediaId : receiptMediaId // ignore: cast_nullable_to_non_nullable
as String?,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<Appointment>,
  ));
}

/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookableAstrologerCopyWith<$Res> get astrologer {
  
  return $BookableAstrologerCopyWith<$Res>(_self.astrologer, (value) {
    return _then(_self.copyWith(astrologer: value));
  });
}/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TimeSlot>, $Res> get slots {
  
  return $LoadStateCopyWith<List<TimeSlot>, $Res>(_self.slots, (value) {
    return _then(_self.copyWith(slots: value));
  });
}/// Create a copy of BookAppointmentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Appointment, $Res> get submission {
  
  return $LoadStateCopyWith<Appointment, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}

// dart format on
