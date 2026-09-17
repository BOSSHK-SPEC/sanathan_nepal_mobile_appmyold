// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'console_appointment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsoleAppointment {

 String get id;/// Empty for a live session, which has no booking reference.
 String get reference; ConsoleAppointmentKind get kind;/// `chat`, `voice` or `video` for a live session; null for a sitting.
 String? get channel; ConsoleAppointmentStatus get status; DateTime get startsAt; DateTime get endsAt; double get price; String get currency; int get quantity; String? get paymentMethod; String get clientId; String get clientName; String get clientPhone; String get clientEmail; String get country;/// As the client typed it: `YYYY-MM-DD`.
 String? get birthDate;/// 24-hour `HH:mm`.
 String? get birthTime; String? get birthPlace; String get note; String? get cancelReason; bool get hasBirthChart; bool get hasReceipt;/// Short-lived links, present only when one appointment is opened.
 String? get birthChartUrl; String? get receiptUrl;/// What the astrologer wrote up after a live session, and what they
/// prescribed. Sent only when one appointment is opened.
 String get adviceNotes; List<Remedy> get remedies; DateTime? get followUpAt;
/// Create a copy of ConsoleAppointment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsoleAppointmentCopyWith<ConsoleAppointment> get copyWith => _$ConsoleAppointmentCopyWithImpl<ConsoleAppointment>(this as ConsoleAppointment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsoleAppointment&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.clientEmail, clientEmail) || other.clientEmail == clientEmail)&&(identical(other.country, country) || other.country == country)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.note, note) || other.note == note)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&(identical(other.hasBirthChart, hasBirthChart) || other.hasBirthChart == hasBirthChart)&&(identical(other.hasReceipt, hasReceipt) || other.hasReceipt == hasReceipt)&&(identical(other.birthChartUrl, birthChartUrl) || other.birthChartUrl == birthChartUrl)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl)&&(identical(other.adviceNotes, adviceNotes) || other.adviceNotes == adviceNotes)&&const DeepCollectionEquality().equals(other.remedies, remedies)&&(identical(other.followUpAt, followUpAt) || other.followUpAt == followUpAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,reference,kind,channel,status,startsAt,endsAt,price,currency,quantity,paymentMethod,clientId,clientName,clientPhone,clientEmail,country,birthDate,birthTime,birthPlace,note,cancelReason,hasBirthChart,hasReceipt,birthChartUrl,receiptUrl,adviceNotes,const DeepCollectionEquality().hash(remedies),followUpAt]);

@override
String toString() {
  return 'ConsoleAppointment(id: $id, reference: $reference, kind: $kind, channel: $channel, status: $status, startsAt: $startsAt, endsAt: $endsAt, price: $price, currency: $currency, quantity: $quantity, paymentMethod: $paymentMethod, clientId: $clientId, clientName: $clientName, clientPhone: $clientPhone, clientEmail: $clientEmail, country: $country, birthDate: $birthDate, birthTime: $birthTime, birthPlace: $birthPlace, note: $note, cancelReason: $cancelReason, hasBirthChart: $hasBirthChart, hasReceipt: $hasReceipt, birthChartUrl: $birthChartUrl, receiptUrl: $receiptUrl, adviceNotes: $adviceNotes, remedies: $remedies, followUpAt: $followUpAt)';
}


}

/// @nodoc
abstract mixin class $ConsoleAppointmentCopyWith<$Res>  {
  factory $ConsoleAppointmentCopyWith(ConsoleAppointment value, $Res Function(ConsoleAppointment) _then) = _$ConsoleAppointmentCopyWithImpl;
@useResult
$Res call({
 String id, String reference, ConsoleAppointmentKind kind, String? channel, ConsoleAppointmentStatus status, DateTime startsAt, DateTime endsAt, double price, String currency, int quantity, String? paymentMethod, String clientId, String clientName, String clientPhone, String clientEmail, String country, String? birthDate, String? birthTime, String? birthPlace, String note, String? cancelReason, bool hasBirthChart, bool hasReceipt, String? birthChartUrl, String? receiptUrl, String adviceNotes, List<Remedy> remedies, DateTime? followUpAt
});




}
/// @nodoc
class _$ConsoleAppointmentCopyWithImpl<$Res>
    implements $ConsoleAppointmentCopyWith<$Res> {
  _$ConsoleAppointmentCopyWithImpl(this._self, this._then);

  final ConsoleAppointment _self;
  final $Res Function(ConsoleAppointment) _then;

/// Create a copy of ConsoleAppointment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? kind = null,Object? channel = freezed,Object? status = null,Object? startsAt = null,Object? endsAt = null,Object? price = null,Object? currency = null,Object? quantity = null,Object? paymentMethod = freezed,Object? clientId = null,Object? clientName = null,Object? clientPhone = null,Object? clientEmail = null,Object? country = null,Object? birthDate = freezed,Object? birthTime = freezed,Object? birthPlace = freezed,Object? note = null,Object? cancelReason = freezed,Object? hasBirthChart = null,Object? hasReceipt = null,Object? birthChartUrl = freezed,Object? receiptUrl = freezed,Object? adviceNotes = null,Object? remedies = null,Object? followUpAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ConsoleAppointmentKind,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConsoleAppointmentStatus,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clientPhone: null == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String,clientEmail: null == clientEmail ? _self.clientEmail : clientEmail // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,hasBirthChart: null == hasBirthChart ? _self.hasBirthChart : hasBirthChart // ignore: cast_nullable_to_non_nullable
as bool,hasReceipt: null == hasReceipt ? _self.hasReceipt : hasReceipt // ignore: cast_nullable_to_non_nullable
as bool,birthChartUrl: freezed == birthChartUrl ? _self.birthChartUrl : birthChartUrl // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,adviceNotes: null == adviceNotes ? _self.adviceNotes : adviceNotes // ignore: cast_nullable_to_non_nullable
as String,remedies: null == remedies ? _self.remedies : remedies // ignore: cast_nullable_to_non_nullable
as List<Remedy>,followUpAt: freezed == followUpAt ? _self.followUpAt : followUpAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}



/// @nodoc


class _ConsoleAppointment extends ConsoleAppointment {
  const _ConsoleAppointment({required this.id, required this.reference, this.kind = ConsoleAppointmentKind.appointment, this.channel, required this.status, required this.startsAt, required this.endsAt, required this.price, required this.currency, this.quantity = 1, this.paymentMethod, required this.clientId, required this.clientName, this.clientPhone = '', this.clientEmail = '', this.country = '', this.birthDate, this.birthTime, this.birthPlace, this.note = '', this.cancelReason, this.hasBirthChart = false, this.hasReceipt = false, this.birthChartUrl, this.receiptUrl, this.adviceNotes = '', final  List<Remedy> remedies = const <Remedy>[], this.followUpAt}): _remedies = remedies,super._();
  

@override final  String id;
/// Empty for a live session, which has no booking reference.
@override final  String reference;
@override@JsonKey() final  ConsoleAppointmentKind kind;
/// `chat`, `voice` or `video` for a live session; null for a sitting.
@override final  String? channel;
@override final  ConsoleAppointmentStatus status;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  double price;
@override final  String currency;
@override@JsonKey() final  int quantity;
@override final  String? paymentMethod;
@override final  String clientId;
@override final  String clientName;
@override@JsonKey() final  String clientPhone;
@override@JsonKey() final  String clientEmail;
@override@JsonKey() final  String country;
/// As the client typed it: `YYYY-MM-DD`.
@override final  String? birthDate;
/// 24-hour `HH:mm`.
@override final  String? birthTime;
@override final  String? birthPlace;
@override@JsonKey() final  String note;
@override final  String? cancelReason;
@override@JsonKey() final  bool hasBirthChart;
@override@JsonKey() final  bool hasReceipt;
/// Short-lived links, present only when one appointment is opened.
@override final  String? birthChartUrl;
@override final  String? receiptUrl;
/// What the astrologer wrote up after a live session, and what they
/// prescribed. Sent only when one appointment is opened.
@override@JsonKey() final  String adviceNotes;
 final  List<Remedy> _remedies;
@override@JsonKey() List<Remedy> get remedies {
  if (_remedies is EqualUnmodifiableListView) return _remedies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_remedies);
}

@override final  DateTime? followUpAt;

/// Create a copy of ConsoleAppointment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsoleAppointmentCopyWith<_ConsoleAppointment> get copyWith => __$ConsoleAppointmentCopyWithImpl<_ConsoleAppointment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsoleAppointment&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.status, status) || other.status == status)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.clientEmail, clientEmail) || other.clientEmail == clientEmail)&&(identical(other.country, country) || other.country == country)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.note, note) || other.note == note)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&(identical(other.hasBirthChart, hasBirthChart) || other.hasBirthChart == hasBirthChart)&&(identical(other.hasReceipt, hasReceipt) || other.hasReceipt == hasReceipt)&&(identical(other.birthChartUrl, birthChartUrl) || other.birthChartUrl == birthChartUrl)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl)&&(identical(other.adviceNotes, adviceNotes) || other.adviceNotes == adviceNotes)&&const DeepCollectionEquality().equals(other._remedies, _remedies)&&(identical(other.followUpAt, followUpAt) || other.followUpAt == followUpAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,reference,kind,channel,status,startsAt,endsAt,price,currency,quantity,paymentMethod,clientId,clientName,clientPhone,clientEmail,country,birthDate,birthTime,birthPlace,note,cancelReason,hasBirthChart,hasReceipt,birthChartUrl,receiptUrl,adviceNotes,const DeepCollectionEquality().hash(_remedies),followUpAt]);

@override
String toString() {
  return 'ConsoleAppointment(id: $id, reference: $reference, kind: $kind, channel: $channel, status: $status, startsAt: $startsAt, endsAt: $endsAt, price: $price, currency: $currency, quantity: $quantity, paymentMethod: $paymentMethod, clientId: $clientId, clientName: $clientName, clientPhone: $clientPhone, clientEmail: $clientEmail, country: $country, birthDate: $birthDate, birthTime: $birthTime, birthPlace: $birthPlace, note: $note, cancelReason: $cancelReason, hasBirthChart: $hasBirthChart, hasReceipt: $hasReceipt, birthChartUrl: $birthChartUrl, receiptUrl: $receiptUrl, adviceNotes: $adviceNotes, remedies: $remedies, followUpAt: $followUpAt)';
}


}

/// @nodoc
abstract mixin class _$ConsoleAppointmentCopyWith<$Res> implements $ConsoleAppointmentCopyWith<$Res> {
  factory _$ConsoleAppointmentCopyWith(_ConsoleAppointment value, $Res Function(_ConsoleAppointment) _then) = __$ConsoleAppointmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, ConsoleAppointmentKind kind, String? channel, ConsoleAppointmentStatus status, DateTime startsAt, DateTime endsAt, double price, String currency, int quantity, String? paymentMethod, String clientId, String clientName, String clientPhone, String clientEmail, String country, String? birthDate, String? birthTime, String? birthPlace, String note, String? cancelReason, bool hasBirthChart, bool hasReceipt, String? birthChartUrl, String? receiptUrl, String adviceNotes, List<Remedy> remedies, DateTime? followUpAt
});




}
/// @nodoc
class __$ConsoleAppointmentCopyWithImpl<$Res>
    implements _$ConsoleAppointmentCopyWith<$Res> {
  __$ConsoleAppointmentCopyWithImpl(this._self, this._then);

  final _ConsoleAppointment _self;
  final $Res Function(_ConsoleAppointment) _then;

/// Create a copy of ConsoleAppointment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? kind = null,Object? channel = freezed,Object? status = null,Object? startsAt = null,Object? endsAt = null,Object? price = null,Object? currency = null,Object? quantity = null,Object? paymentMethod = freezed,Object? clientId = null,Object? clientName = null,Object? clientPhone = null,Object? clientEmail = null,Object? country = null,Object? birthDate = freezed,Object? birthTime = freezed,Object? birthPlace = freezed,Object? note = null,Object? cancelReason = freezed,Object? hasBirthChart = null,Object? hasReceipt = null,Object? birthChartUrl = freezed,Object? receiptUrl = freezed,Object? adviceNotes = null,Object? remedies = null,Object? followUpAt = freezed,}) {
  return _then(_ConsoleAppointment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ConsoleAppointmentKind,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConsoleAppointmentStatus,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientName: null == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String,clientPhone: null == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String,clientEmail: null == clientEmail ? _self.clientEmail : clientEmail // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,hasBirthChart: null == hasBirthChart ? _self.hasBirthChart : hasBirthChart // ignore: cast_nullable_to_non_nullable
as bool,hasReceipt: null == hasReceipt ? _self.hasReceipt : hasReceipt // ignore: cast_nullable_to_non_nullable
as bool,birthChartUrl: freezed == birthChartUrl ? _self.birthChartUrl : birthChartUrl // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,adviceNotes: null == adviceNotes ? _self.adviceNotes : adviceNotes // ignore: cast_nullable_to_non_nullable
as String,remedies: null == remedies ? _self._remedies : remedies // ignore: cast_nullable_to_non_nullable
as List<Remedy>,followUpAt: freezed == followUpAt ? _self.followUpAt : followUpAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
