// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_intent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentIntent {

 String get id; double get amount; PaymentRail get rail; PaymentStatus get status; DateTime get createdAt;/// Promotional credit that lands alongside [amount] on success.
 double get bonus;/// Gateway's own reference, shown on the receipt for support queries.
 String? get gatewayReference;/// Where the payer completes the payment.
///
/// Its own field rather than being folded into [gatewayReference], which
/// is what used to happen: the URL was mapped onto the reference and only
/// ever printed as a row of text, so nobody was ever sent anywhere to pay.
/// The intent then sat unsettled until the poller gave up and said it was
/// "taking longer than usual".
 String? get checkoutUrl;/// Human-readable reason when [status] is failed.
 String? get failureReason;/// Guards against a double-charge if the request is retried.
 String? get idempotencyKey;
/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentIntentCopyWith<PaymentIntent> get copyWith => _$PaymentIntentCopyWithImpl<PaymentIntent>(this as PaymentIntent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentIntent&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.rail, rail) || other.rail == rail)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bonus, bonus) || other.bonus == bonus)&&(identical(other.gatewayReference, gatewayReference) || other.gatewayReference == gatewayReference)&&(identical(other.checkoutUrl, checkoutUrl) || other.checkoutUrl == checkoutUrl)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,rail,status,createdAt,bonus,gatewayReference,checkoutUrl,failureReason,idempotencyKey);

@override
String toString() {
  return 'PaymentIntent(id: $id, amount: $amount, rail: $rail, status: $status, createdAt: $createdAt, bonus: $bonus, gatewayReference: $gatewayReference, checkoutUrl: $checkoutUrl, failureReason: $failureReason, idempotencyKey: $idempotencyKey)';
}


}

/// @nodoc
abstract mixin class $PaymentIntentCopyWith<$Res>  {
  factory $PaymentIntentCopyWith(PaymentIntent value, $Res Function(PaymentIntent) _then) = _$PaymentIntentCopyWithImpl;
@useResult
$Res call({
 String id, double amount, PaymentRail rail, PaymentStatus status, DateTime createdAt, double bonus, String? gatewayReference, String? checkoutUrl, String? failureReason, String? idempotencyKey
});




}
/// @nodoc
class _$PaymentIntentCopyWithImpl<$Res>
    implements $PaymentIntentCopyWith<$Res> {
  _$PaymentIntentCopyWithImpl(this._self, this._then);

  final PaymentIntent _self;
  final $Res Function(PaymentIntent) _then;

/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? rail = null,Object? status = null,Object? createdAt = null,Object? bonus = null,Object? gatewayReference = freezed,Object? checkoutUrl = freezed,Object? failureReason = freezed,Object? idempotencyKey = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,rail: null == rail ? _self.rail : rail // ignore: cast_nullable_to_non_nullable
as PaymentRail,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,bonus: null == bonus ? _self.bonus : bonus // ignore: cast_nullable_to_non_nullable
as double,gatewayReference: freezed == gatewayReference ? _self.gatewayReference : gatewayReference // ignore: cast_nullable_to_non_nullable
as String?,checkoutUrl: freezed == checkoutUrl ? _self.checkoutUrl : checkoutUrl // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,idempotencyKey: freezed == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _PaymentIntent extends PaymentIntent {
  const _PaymentIntent({required this.id, required this.amount, required this.rail, required this.status, required this.createdAt, this.bonus = 0, this.gatewayReference, this.checkoutUrl, this.failureReason, this.idempotencyKey}): super._();
  

@override final  String id;
@override final  double amount;
@override final  PaymentRail rail;
@override final  PaymentStatus status;
@override final  DateTime createdAt;
/// Promotional credit that lands alongside [amount] on success.
@override@JsonKey() final  double bonus;
/// Gateway's own reference, shown on the receipt for support queries.
@override final  String? gatewayReference;
/// Where the payer completes the payment.
///
/// Its own field rather than being folded into [gatewayReference], which
/// is what used to happen: the URL was mapped onto the reference and only
/// ever printed as a row of text, so nobody was ever sent anywhere to pay.
/// The intent then sat unsettled until the poller gave up and said it was
/// "taking longer than usual".
@override final  String? checkoutUrl;
/// Human-readable reason when [status] is failed.
@override final  String? failureReason;
/// Guards against a double-charge if the request is retried.
@override final  String? idempotencyKey;

/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentIntentCopyWith<_PaymentIntent> get copyWith => __$PaymentIntentCopyWithImpl<_PaymentIntent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentIntent&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.rail, rail) || other.rail == rail)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.bonus, bonus) || other.bonus == bonus)&&(identical(other.gatewayReference, gatewayReference) || other.gatewayReference == gatewayReference)&&(identical(other.checkoutUrl, checkoutUrl) || other.checkoutUrl == checkoutUrl)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,rail,status,createdAt,bonus,gatewayReference,checkoutUrl,failureReason,idempotencyKey);

@override
String toString() {
  return 'PaymentIntent(id: $id, amount: $amount, rail: $rail, status: $status, createdAt: $createdAt, bonus: $bonus, gatewayReference: $gatewayReference, checkoutUrl: $checkoutUrl, failureReason: $failureReason, idempotencyKey: $idempotencyKey)';
}


}

/// @nodoc
abstract mixin class _$PaymentIntentCopyWith<$Res> implements $PaymentIntentCopyWith<$Res> {
  factory _$PaymentIntentCopyWith(_PaymentIntent value, $Res Function(_PaymentIntent) _then) = __$PaymentIntentCopyWithImpl;
@override @useResult
$Res call({
 String id, double amount, PaymentRail rail, PaymentStatus status, DateTime createdAt, double bonus, String? gatewayReference, String? checkoutUrl, String? failureReason, String? idempotencyKey
});




}
/// @nodoc
class __$PaymentIntentCopyWithImpl<$Res>
    implements _$PaymentIntentCopyWith<$Res> {
  __$PaymentIntentCopyWithImpl(this._self, this._then);

  final _PaymentIntent _self;
  final $Res Function(_PaymentIntent) _then;

/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? rail = null,Object? status = null,Object? createdAt = null,Object? bonus = null,Object? gatewayReference = freezed,Object? checkoutUrl = freezed,Object? failureReason = freezed,Object? idempotencyKey = freezed,}) {
  return _then(_PaymentIntent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,rail: null == rail ? _self.rail : rail // ignore: cast_nullable_to_non_nullable
as PaymentRail,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,bonus: null == bonus ? _self.bonus : bonus // ignore: cast_nullable_to_non_nullable
as double,gatewayReference: freezed == gatewayReference ? _self.gatewayReference : gatewayReference // ignore: cast_nullable_to_non_nullable
as String?,checkoutUrl: freezed == checkoutUrl ? _self.checkoutUrl : checkoutUrl // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,idempotencyKey: freezed == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
