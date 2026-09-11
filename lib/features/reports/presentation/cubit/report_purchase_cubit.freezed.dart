// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_purchase_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportPurchaseState {

 LoadState<ReportProduct> get product; LoadState<List<BirthProfile>> get profiles; LoadState<PurchasedReport> get purchase; double get balance; String? get selectedProfileId; String? get partnerProfileId; String? get purchaseError;
/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportPurchaseStateCopyWith<ReportPurchaseState> get copyWith => _$ReportPurchaseStateCopyWithImpl<ReportPurchaseState>(this as ReportPurchaseState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportPurchaseState&&(identical(other.product, product) || other.product == product)&&(identical(other.profiles, profiles) || other.profiles == profiles)&&(identical(other.purchase, purchase) || other.purchase == purchase)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.selectedProfileId, selectedProfileId) || other.selectedProfileId == selectedProfileId)&&(identical(other.partnerProfileId, partnerProfileId) || other.partnerProfileId == partnerProfileId)&&(identical(other.purchaseError, purchaseError) || other.purchaseError == purchaseError));
}


@override
int get hashCode => Object.hash(runtimeType,product,profiles,purchase,balance,selectedProfileId,partnerProfileId,purchaseError);

@override
String toString() {
  return 'ReportPurchaseState(product: $product, profiles: $profiles, purchase: $purchase, balance: $balance, selectedProfileId: $selectedProfileId, partnerProfileId: $partnerProfileId, purchaseError: $purchaseError)';
}


}

/// @nodoc
abstract mixin class $ReportPurchaseStateCopyWith<$Res>  {
  factory $ReportPurchaseStateCopyWith(ReportPurchaseState value, $Res Function(ReportPurchaseState) _then) = _$ReportPurchaseStateCopyWithImpl;
@useResult
$Res call({
 LoadState<ReportProduct> product, LoadState<List<BirthProfile>> profiles, LoadState<PurchasedReport> purchase, double balance, String? selectedProfileId, String? partnerProfileId, String? purchaseError
});


$LoadStateCopyWith<ReportProduct, $Res> get product;$LoadStateCopyWith<List<BirthProfile>, $Res> get profiles;$LoadStateCopyWith<PurchasedReport, $Res> get purchase;

}
/// @nodoc
class _$ReportPurchaseStateCopyWithImpl<$Res>
    implements $ReportPurchaseStateCopyWith<$Res> {
  _$ReportPurchaseStateCopyWithImpl(this._self, this._then);

  final ReportPurchaseState _self;
  final $Res Function(ReportPurchaseState) _then;

/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? product = null,Object? profiles = null,Object? purchase = null,Object? balance = null,Object? selectedProfileId = freezed,Object? partnerProfileId = freezed,Object? purchaseError = freezed,}) {
  return _then(_self.copyWith(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as LoadState<ReportProduct>,profiles: null == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as LoadState<List<BirthProfile>>,purchase: null == purchase ? _self.purchase : purchase // ignore: cast_nullable_to_non_nullable
as LoadState<PurchasedReport>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,selectedProfileId: freezed == selectedProfileId ? _self.selectedProfileId : selectedProfileId // ignore: cast_nullable_to_non_nullable
as String?,partnerProfileId: freezed == partnerProfileId ? _self.partnerProfileId : partnerProfileId // ignore: cast_nullable_to_non_nullable
as String?,purchaseError: freezed == purchaseError ? _self.purchaseError : purchaseError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ReportProduct, $Res> get product {
  
  return $LoadStateCopyWith<ReportProduct, $Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BirthProfile>, $Res> get profiles {
  
  return $LoadStateCopyWith<List<BirthProfile>, $Res>(_self.profiles, (value) {
    return _then(_self.copyWith(profiles: value));
  });
}/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PurchasedReport, $Res> get purchase {
  
  return $LoadStateCopyWith<PurchasedReport, $Res>(_self.purchase, (value) {
    return _then(_self.copyWith(purchase: value));
  });
}
}



/// @nodoc


class _ReportPurchaseState extends ReportPurchaseState {
  const _ReportPurchaseState({this.product = const LoadState.idle(), this.profiles = const LoadState.idle(), this.purchase = const LoadState.idle(), this.balance = 0, this.selectedProfileId, this.partnerProfileId, this.purchaseError}): super._();
  

@override@JsonKey() final  LoadState<ReportProduct> product;
@override@JsonKey() final  LoadState<List<BirthProfile>> profiles;
@override@JsonKey() final  LoadState<PurchasedReport> purchase;
@override@JsonKey() final  double balance;
@override final  String? selectedProfileId;
@override final  String? partnerProfileId;
@override final  String? purchaseError;

/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportPurchaseStateCopyWith<_ReportPurchaseState> get copyWith => __$ReportPurchaseStateCopyWithImpl<_ReportPurchaseState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportPurchaseState&&(identical(other.product, product) || other.product == product)&&(identical(other.profiles, profiles) || other.profiles == profiles)&&(identical(other.purchase, purchase) || other.purchase == purchase)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.selectedProfileId, selectedProfileId) || other.selectedProfileId == selectedProfileId)&&(identical(other.partnerProfileId, partnerProfileId) || other.partnerProfileId == partnerProfileId)&&(identical(other.purchaseError, purchaseError) || other.purchaseError == purchaseError));
}


@override
int get hashCode => Object.hash(runtimeType,product,profiles,purchase,balance,selectedProfileId,partnerProfileId,purchaseError);

@override
String toString() {
  return 'ReportPurchaseState(product: $product, profiles: $profiles, purchase: $purchase, balance: $balance, selectedProfileId: $selectedProfileId, partnerProfileId: $partnerProfileId, purchaseError: $purchaseError)';
}


}

/// @nodoc
abstract mixin class _$ReportPurchaseStateCopyWith<$Res> implements $ReportPurchaseStateCopyWith<$Res> {
  factory _$ReportPurchaseStateCopyWith(_ReportPurchaseState value, $Res Function(_ReportPurchaseState) _then) = __$ReportPurchaseStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<ReportProduct> product, LoadState<List<BirthProfile>> profiles, LoadState<PurchasedReport> purchase, double balance, String? selectedProfileId, String? partnerProfileId, String? purchaseError
});


@override $LoadStateCopyWith<ReportProduct, $Res> get product;@override $LoadStateCopyWith<List<BirthProfile>, $Res> get profiles;@override $LoadStateCopyWith<PurchasedReport, $Res> get purchase;

}
/// @nodoc
class __$ReportPurchaseStateCopyWithImpl<$Res>
    implements _$ReportPurchaseStateCopyWith<$Res> {
  __$ReportPurchaseStateCopyWithImpl(this._self, this._then);

  final _ReportPurchaseState _self;
  final $Res Function(_ReportPurchaseState) _then;

/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? product = null,Object? profiles = null,Object? purchase = null,Object? balance = null,Object? selectedProfileId = freezed,Object? partnerProfileId = freezed,Object? purchaseError = freezed,}) {
  return _then(_ReportPurchaseState(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as LoadState<ReportProduct>,profiles: null == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as LoadState<List<BirthProfile>>,purchase: null == purchase ? _self.purchase : purchase // ignore: cast_nullable_to_non_nullable
as LoadState<PurchasedReport>,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,selectedProfileId: freezed == selectedProfileId ? _self.selectedProfileId : selectedProfileId // ignore: cast_nullable_to_non_nullable
as String?,partnerProfileId: freezed == partnerProfileId ? _self.partnerProfileId : partnerProfileId // ignore: cast_nullable_to_non_nullable
as String?,purchaseError: freezed == purchaseError ? _self.purchaseError : purchaseError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ReportProduct, $Res> get product {
  
  return $LoadStateCopyWith<ReportProduct, $Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BirthProfile>, $Res> get profiles {
  
  return $LoadStateCopyWith<List<BirthProfile>, $Res>(_self.profiles, (value) {
    return _then(_self.copyWith(profiles: value));
  });
}/// Create a copy of ReportPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PurchasedReport, $Res> get purchase {
  
  return $LoadStateCopyWith<PurchasedReport, $Res>(_self.purchase, (value) {
    return _then(_self.copyWith(purchase: value));
  });
}
}

// dart format on
