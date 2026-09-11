// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'boost_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoostPlan {

 int get hours; double get pricePerProduct;
/// Create a copy of BoostPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoostPlanCopyWith<BoostPlan> get copyWith => _$BoostPlanCopyWithImpl<BoostPlan>(this as BoostPlan, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoostPlan&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.pricePerProduct, pricePerProduct) || other.pricePerProduct == pricePerProduct));
}


@override
int get hashCode => Object.hash(runtimeType,hours,pricePerProduct);

@override
String toString() {
  return 'BoostPlan(hours: $hours, pricePerProduct: $pricePerProduct)';
}


}

/// @nodoc
abstract mixin class $BoostPlanCopyWith<$Res>  {
  factory $BoostPlanCopyWith(BoostPlan value, $Res Function(BoostPlan) _then) = _$BoostPlanCopyWithImpl;
@useResult
$Res call({
 int hours, double pricePerProduct
});




}
/// @nodoc
class _$BoostPlanCopyWithImpl<$Res>
    implements $BoostPlanCopyWith<$Res> {
  _$BoostPlanCopyWithImpl(this._self, this._then);

  final BoostPlan _self;
  final $Res Function(BoostPlan) _then;

/// Create a copy of BoostPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hours = null,Object? pricePerProduct = null,}) {
  return _then(_self.copyWith(
hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,pricePerProduct: null == pricePerProduct ? _self.pricePerProduct : pricePerProduct // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc


class _BoostPlan implements BoostPlan {
  const _BoostPlan({required this.hours, required this.pricePerProduct});
  

@override final  int hours;
@override final  double pricePerProduct;

/// Create a copy of BoostPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoostPlanCopyWith<_BoostPlan> get copyWith => __$BoostPlanCopyWithImpl<_BoostPlan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoostPlan&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.pricePerProduct, pricePerProduct) || other.pricePerProduct == pricePerProduct));
}


@override
int get hashCode => Object.hash(runtimeType,hours,pricePerProduct);

@override
String toString() {
  return 'BoostPlan(hours: $hours, pricePerProduct: $pricePerProduct)';
}


}

/// @nodoc
abstract mixin class _$BoostPlanCopyWith<$Res> implements $BoostPlanCopyWith<$Res> {
  factory _$BoostPlanCopyWith(_BoostPlan value, $Res Function(_BoostPlan) _then) = __$BoostPlanCopyWithImpl;
@override @useResult
$Res call({
 int hours, double pricePerProduct
});




}
/// @nodoc
class __$BoostPlanCopyWithImpl<$Res>
    implements _$BoostPlanCopyWith<$Res> {
  __$BoostPlanCopyWithImpl(this._self, this._then);

  final _BoostPlan _self;
  final $Res Function(_BoostPlan) _then;

/// Create a copy of BoostPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hours = null,Object? pricePerProduct = null,}) {
  return _then(_BoostPlan(
hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,pricePerProduct: null == pricePerProduct ? _self.pricePerProduct : pricePerProduct // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$BoostRequest {

 List<String> get productIds; BoostPlan get plan; String get firstName; String get lastName; String get phone; String get productLink; String? get receiptPath;
/// Create a copy of BoostRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoostRequestCopyWith<BoostRequest> get copyWith => _$BoostRequestCopyWithImpl<BoostRequest>(this as BoostRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoostRequest&&const DeepCollectionEquality().equals(other.productIds, productIds)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.productLink, productLink) || other.productLink == productLink)&&(identical(other.receiptPath, receiptPath) || other.receiptPath == receiptPath));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(productIds),plan,firstName,lastName,phone,productLink,receiptPath);

@override
String toString() {
  return 'BoostRequest(productIds: $productIds, plan: $plan, firstName: $firstName, lastName: $lastName, phone: $phone, productLink: $productLink, receiptPath: $receiptPath)';
}


}

/// @nodoc
abstract mixin class $BoostRequestCopyWith<$Res>  {
  factory $BoostRequestCopyWith(BoostRequest value, $Res Function(BoostRequest) _then) = _$BoostRequestCopyWithImpl;
@useResult
$Res call({
 List<String> productIds, BoostPlan plan, String firstName, String lastName, String phone, String productLink, String? receiptPath
});


$BoostPlanCopyWith<$Res> get plan;

}
/// @nodoc
class _$BoostRequestCopyWithImpl<$Res>
    implements $BoostRequestCopyWith<$Res> {
  _$BoostRequestCopyWithImpl(this._self, this._then);

  final BoostRequest _self;
  final $Res Function(BoostRequest) _then;

/// Create a copy of BoostRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productIds = null,Object? plan = null,Object? firstName = null,Object? lastName = null,Object? phone = null,Object? productLink = null,Object? receiptPath = freezed,}) {
  return _then(_self.copyWith(
productIds: null == productIds ? _self.productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as BoostPlan,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,productLink: null == productLink ? _self.productLink : productLink // ignore: cast_nullable_to_non_nullable
as String,receiptPath: freezed == receiptPath ? _self.receiptPath : receiptPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of BoostRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoostPlanCopyWith<$Res> get plan {
  
  return $BoostPlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}



/// @nodoc


class _BoostRequest extends BoostRequest {
  const _BoostRequest({required final  List<String> productIds, required this.plan, required this.firstName, required this.lastName, required this.phone, required this.productLink, this.receiptPath}): _productIds = productIds,super._();
  

 final  List<String> _productIds;
@override List<String> get productIds {
  if (_productIds is EqualUnmodifiableListView) return _productIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_productIds);
}

@override final  BoostPlan plan;
@override final  String firstName;
@override final  String lastName;
@override final  String phone;
@override final  String productLink;
@override final  String? receiptPath;

/// Create a copy of BoostRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoostRequestCopyWith<_BoostRequest> get copyWith => __$BoostRequestCopyWithImpl<_BoostRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoostRequest&&const DeepCollectionEquality().equals(other._productIds, _productIds)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.productLink, productLink) || other.productLink == productLink)&&(identical(other.receiptPath, receiptPath) || other.receiptPath == receiptPath));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_productIds),plan,firstName,lastName,phone,productLink,receiptPath);

@override
String toString() {
  return 'BoostRequest(productIds: $productIds, plan: $plan, firstName: $firstName, lastName: $lastName, phone: $phone, productLink: $productLink, receiptPath: $receiptPath)';
}


}

/// @nodoc
abstract mixin class _$BoostRequestCopyWith<$Res> implements $BoostRequestCopyWith<$Res> {
  factory _$BoostRequestCopyWith(_BoostRequest value, $Res Function(_BoostRequest) _then) = __$BoostRequestCopyWithImpl;
@override @useResult
$Res call({
 List<String> productIds, BoostPlan plan, String firstName, String lastName, String phone, String productLink, String? receiptPath
});


@override $BoostPlanCopyWith<$Res> get plan;

}
/// @nodoc
class __$BoostRequestCopyWithImpl<$Res>
    implements _$BoostRequestCopyWith<$Res> {
  __$BoostRequestCopyWithImpl(this._self, this._then);

  final _BoostRequest _self;
  final $Res Function(_BoostRequest) _then;

/// Create a copy of BoostRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productIds = null,Object? plan = null,Object? firstName = null,Object? lastName = null,Object? phone = null,Object? productLink = null,Object? receiptPath = freezed,}) {
  return _then(_BoostRequest(
productIds: null == productIds ? _self._productIds : productIds // ignore: cast_nullable_to_non_nullable
as List<String>,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as BoostPlan,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,productLink: null == productLink ? _self.productLink : productLink // ignore: cast_nullable_to_non_nullable
as String,receiptPath: freezed == receiptPath ? _self.receiptPath : receiptPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of BoostRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoostPlanCopyWith<$Res> get plan {
  
  return $BoostPlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

/// @nodoc
mixin _$BoostReceipt {

 String get referenceId; double get total; DateTime get submittedAt;
/// Create a copy of BoostReceipt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoostReceiptCopyWith<BoostReceipt> get copyWith => _$BoostReceiptCopyWithImpl<BoostReceipt>(this as BoostReceipt, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoostReceipt&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.total, total) || other.total == total)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}


@override
int get hashCode => Object.hash(runtimeType,referenceId,total,submittedAt);

@override
String toString() {
  return 'BoostReceipt(referenceId: $referenceId, total: $total, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class $BoostReceiptCopyWith<$Res>  {
  factory $BoostReceiptCopyWith(BoostReceipt value, $Res Function(BoostReceipt) _then) = _$BoostReceiptCopyWithImpl;
@useResult
$Res call({
 String referenceId, double total, DateTime submittedAt
});




}
/// @nodoc
class _$BoostReceiptCopyWithImpl<$Res>
    implements $BoostReceiptCopyWith<$Res> {
  _$BoostReceiptCopyWithImpl(this._self, this._then);

  final BoostReceipt _self;
  final $Res Function(BoostReceipt) _then;

/// Create a copy of BoostReceipt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? referenceId = null,Object? total = null,Object? submittedAt = null,}) {
  return _then(_self.copyWith(
referenceId: null == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}



/// @nodoc


class _BoostReceipt implements BoostReceipt {
  const _BoostReceipt({required this.referenceId, required this.total, required this.submittedAt});
  

@override final  String referenceId;
@override final  double total;
@override final  DateTime submittedAt;

/// Create a copy of BoostReceipt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoostReceiptCopyWith<_BoostReceipt> get copyWith => __$BoostReceiptCopyWithImpl<_BoostReceipt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoostReceipt&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.total, total) || other.total == total)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}


@override
int get hashCode => Object.hash(runtimeType,referenceId,total,submittedAt);

@override
String toString() {
  return 'BoostReceipt(referenceId: $referenceId, total: $total, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$BoostReceiptCopyWith<$Res> implements $BoostReceiptCopyWith<$Res> {
  factory _$BoostReceiptCopyWith(_BoostReceipt value, $Res Function(_BoostReceipt) _then) = __$BoostReceiptCopyWithImpl;
@override @useResult
$Res call({
 String referenceId, double total, DateTime submittedAt
});




}
/// @nodoc
class __$BoostReceiptCopyWithImpl<$Res>
    implements _$BoostReceiptCopyWith<$Res> {
  __$BoostReceiptCopyWithImpl(this._self, this._then);

  final _BoostReceipt _self;
  final $Res Function(_BoostReceipt) _then;

/// Create a copy of BoostReceipt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? referenceId = null,Object? total = null,Object? submittedAt = null,}) {
  return _then(_BoostReceipt(
referenceId: null == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
