// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PayoutAccount {

 PayoutDestination get destination;/// Account number, wallet id or UPI handle depending on [destination].
 String get identifier; String get holderName;/// Bank name / branch, only for [PayoutDestination.bankAccount].
 String get bankName; VerificationState get verification; String? get failureReason;
/// Create a copy of PayoutAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<PayoutAccount> get copyWith => _$PayoutAccountCopyWithImpl<PayoutAccount>(this as PayoutAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayoutAccount&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.verification, verification) || other.verification == verification)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason));
}


@override
int get hashCode => Object.hash(runtimeType,destination,identifier,holderName,bankName,verification,failureReason);

@override
String toString() {
  return 'PayoutAccount(destination: $destination, identifier: $identifier, holderName: $holderName, bankName: $bankName, verification: $verification, failureReason: $failureReason)';
}


}

/// @nodoc
abstract mixin class $PayoutAccountCopyWith<$Res>  {
  factory $PayoutAccountCopyWith(PayoutAccount value, $Res Function(PayoutAccount) _then) = _$PayoutAccountCopyWithImpl;
@useResult
$Res call({
 PayoutDestination destination, String identifier, String holderName, String bankName, VerificationState verification, String? failureReason
});




}
/// @nodoc
class _$PayoutAccountCopyWithImpl<$Res>
    implements $PayoutAccountCopyWith<$Res> {
  _$PayoutAccountCopyWithImpl(this._self, this._then);

  final PayoutAccount _self;
  final $Res Function(PayoutAccount) _then;

/// Create a copy of PayoutAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? destination = null,Object? identifier = null,Object? holderName = null,Object? bankName = null,Object? verification = null,Object? failureReason = freezed,}) {
  return _then(_self.copyWith(
destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as PayoutDestination,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,verification: null == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as VerificationState,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _PayoutAccount extends PayoutAccount {
  const _PayoutAccount({required this.destination, this.identifier = '', this.holderName = '', this.bankName = '', this.verification = VerificationState.unverified, this.failureReason}): super._();
  

@override final  PayoutDestination destination;
/// Account number, wallet id or UPI handle depending on [destination].
@override@JsonKey() final  String identifier;
@override@JsonKey() final  String holderName;
/// Bank name / branch, only for [PayoutDestination.bankAccount].
@override@JsonKey() final  String bankName;
@override@JsonKey() final  VerificationState verification;
@override final  String? failureReason;

/// Create a copy of PayoutAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutAccountCopyWith<_PayoutAccount> get copyWith => __$PayoutAccountCopyWithImpl<_PayoutAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayoutAccount&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.verification, verification) || other.verification == verification)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason));
}


@override
int get hashCode => Object.hash(runtimeType,destination,identifier,holderName,bankName,verification,failureReason);

@override
String toString() {
  return 'PayoutAccount(destination: $destination, identifier: $identifier, holderName: $holderName, bankName: $bankName, verification: $verification, failureReason: $failureReason)';
}


}

/// @nodoc
abstract mixin class _$PayoutAccountCopyWith<$Res> implements $PayoutAccountCopyWith<$Res> {
  factory _$PayoutAccountCopyWith(_PayoutAccount value, $Res Function(_PayoutAccount) _then) = __$PayoutAccountCopyWithImpl;
@override @useResult
$Res call({
 PayoutDestination destination, String identifier, String holderName, String bankName, VerificationState verification, String? failureReason
});




}
/// @nodoc
class __$PayoutAccountCopyWithImpl<$Res>
    implements _$PayoutAccountCopyWith<$Res> {
  __$PayoutAccountCopyWithImpl(this._self, this._then);

  final _PayoutAccount _self;
  final $Res Function(_PayoutAccount) _then;

/// Create a copy of PayoutAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? destination = null,Object? identifier = null,Object? holderName = null,Object? bankName = null,Object? verification = null,Object? failureReason = freezed,}) {
  return _then(_PayoutAccount(
destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as PayoutDestination,identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,verification: null == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as VerificationState,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PayoutRequest {

 String get id; double get amount; PayoutStatus get status; DateTime get requestedAt;/// Deducted from [amount]; shown before the request is confirmed.
 double get fee; DateTime? get settledAt; String? get reference; String? get failureReason;
/// Create a copy of PayoutRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutRequestCopyWith<PayoutRequest> get copyWith => _$PayoutRequestCopyWithImpl<PayoutRequest>(this as PayoutRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayoutRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,status,requestedAt,fee,settledAt,reference,failureReason);

@override
String toString() {
  return 'PayoutRequest(id: $id, amount: $amount, status: $status, requestedAt: $requestedAt, fee: $fee, settledAt: $settledAt, reference: $reference, failureReason: $failureReason)';
}


}

/// @nodoc
abstract mixin class $PayoutRequestCopyWith<$Res>  {
  factory $PayoutRequestCopyWith(PayoutRequest value, $Res Function(PayoutRequest) _then) = _$PayoutRequestCopyWithImpl;
@useResult
$Res call({
 String id, double amount, PayoutStatus status, DateTime requestedAt, double fee, DateTime? settledAt, String? reference, String? failureReason
});




}
/// @nodoc
class _$PayoutRequestCopyWithImpl<$Res>
    implements $PayoutRequestCopyWith<$Res> {
  _$PayoutRequestCopyWithImpl(this._self, this._then);

  final PayoutRequest _self;
  final $Res Function(PayoutRequest) _then;

/// Create a copy of PayoutRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? status = null,Object? requestedAt = null,Object? fee = null,Object? settledAt = freezed,Object? reference = freezed,Object? failureReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PayoutStatus,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _PayoutRequest extends PayoutRequest {
  const _PayoutRequest({required this.id, required this.amount, required this.status, required this.requestedAt, this.fee = 0, this.settledAt, this.reference, this.failureReason}): super._();
  

@override final  String id;
@override final  double amount;
@override final  PayoutStatus status;
@override final  DateTime requestedAt;
/// Deducted from [amount]; shown before the request is confirmed.
@override@JsonKey() final  double fee;
@override final  DateTime? settledAt;
@override final  String? reference;
@override final  String? failureReason;

/// Create a copy of PayoutRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutRequestCopyWith<_PayoutRequest> get copyWith => __$PayoutRequestCopyWithImpl<_PayoutRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayoutRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,status,requestedAt,fee,settledAt,reference,failureReason);

@override
String toString() {
  return 'PayoutRequest(id: $id, amount: $amount, status: $status, requestedAt: $requestedAt, fee: $fee, settledAt: $settledAt, reference: $reference, failureReason: $failureReason)';
}


}

/// @nodoc
abstract mixin class _$PayoutRequestCopyWith<$Res> implements $PayoutRequestCopyWith<$Res> {
  factory _$PayoutRequestCopyWith(_PayoutRequest value, $Res Function(_PayoutRequest) _then) = __$PayoutRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, double amount, PayoutStatus status, DateTime requestedAt, double fee, DateTime? settledAt, String? reference, String? failureReason
});




}
/// @nodoc
class __$PayoutRequestCopyWithImpl<$Res>
    implements _$PayoutRequestCopyWith<$Res> {
  __$PayoutRequestCopyWithImpl(this._self, this._then);

  final _PayoutRequest _self;
  final $Res Function(_PayoutRequest) _then;

/// Create a copy of PayoutRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? status = null,Object? requestedAt = null,Object? fee = null,Object? settledAt = freezed,Object? reference = freezed,Object? failureReason = freezed,}) {
  return _then(_PayoutRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PayoutStatus,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TaxDocument {

 String get id; String get title; String get financialYear; double get amount; DateTime get issuedAt;
/// Create a copy of TaxDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxDocumentCopyWith<TaxDocument> get copyWith => _$TaxDocumentCopyWithImpl<TaxDocument>(this as TaxDocument, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.financialYear, financialYear) || other.financialYear == financialYear)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,financialYear,amount,issuedAt);

@override
String toString() {
  return 'TaxDocument(id: $id, title: $title, financialYear: $financialYear, amount: $amount, issuedAt: $issuedAt)';
}


}

/// @nodoc
abstract mixin class $TaxDocumentCopyWith<$Res>  {
  factory $TaxDocumentCopyWith(TaxDocument value, $Res Function(TaxDocument) _then) = _$TaxDocumentCopyWithImpl;
@useResult
$Res call({
 String id, String title, String financialYear, double amount, DateTime issuedAt
});




}
/// @nodoc
class _$TaxDocumentCopyWithImpl<$Res>
    implements $TaxDocumentCopyWith<$Res> {
  _$TaxDocumentCopyWithImpl(this._self, this._then);

  final TaxDocument _self;
  final $Res Function(TaxDocument) _then;

/// Create a copy of TaxDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? financialYear = null,Object? amount = null,Object? issuedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,financialYear: null == financialYear ? _self.financialYear : financialYear // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}



/// @nodoc


class _TaxDocument implements TaxDocument {
  const _TaxDocument({required this.id, required this.title, required this.financialYear, required this.amount, required this.issuedAt});
  

@override final  String id;
@override final  String title;
@override final  String financialYear;
@override final  double amount;
@override final  DateTime issuedAt;

/// Create a copy of TaxDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxDocumentCopyWith<_TaxDocument> get copyWith => __$TaxDocumentCopyWithImpl<_TaxDocument>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxDocument&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.financialYear, financialYear) || other.financialYear == financialYear)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,financialYear,amount,issuedAt);

@override
String toString() {
  return 'TaxDocument(id: $id, title: $title, financialYear: $financialYear, amount: $amount, issuedAt: $issuedAt)';
}


}

/// @nodoc
abstract mixin class _$TaxDocumentCopyWith<$Res> implements $TaxDocumentCopyWith<$Res> {
  factory _$TaxDocumentCopyWith(_TaxDocument value, $Res Function(_TaxDocument) _then) = __$TaxDocumentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String financialYear, double amount, DateTime issuedAt
});




}
/// @nodoc
class __$TaxDocumentCopyWithImpl<$Res>
    implements _$TaxDocumentCopyWith<$Res> {
  __$TaxDocumentCopyWithImpl(this._self, this._then);

  final _TaxDocument _self;
  final $Res Function(_TaxDocument) _then;

/// Create a copy of TaxDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? financialYear = null,Object? amount = null,Object? issuedAt = null,}) {
  return _then(_TaxDocument(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,financialYear: null == financialYear ? _self.financialYear : financialYear // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
