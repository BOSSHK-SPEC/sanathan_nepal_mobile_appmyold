// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FinancialSummary {

 double get grossRevenue; double get consultationRevenue; double get marketplaceRevenue; double get walletTopUps; double get refunds; double get pendingPayouts; int get orderCount; int get consultationCount;/// The window this covers, echoed back so a chart can label itself without
/// the page having to remember what it asked for.
 int get days;
/// Create a copy of FinancialSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialSummaryCopyWith<FinancialSummary> get copyWith => _$FinancialSummaryCopyWithImpl<FinancialSummary>(this as FinancialSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialSummary&&(identical(other.grossRevenue, grossRevenue) || other.grossRevenue == grossRevenue)&&(identical(other.consultationRevenue, consultationRevenue) || other.consultationRevenue == consultationRevenue)&&(identical(other.marketplaceRevenue, marketplaceRevenue) || other.marketplaceRevenue == marketplaceRevenue)&&(identical(other.walletTopUps, walletTopUps) || other.walletTopUps == walletTopUps)&&(identical(other.refunds, refunds) || other.refunds == refunds)&&(identical(other.pendingPayouts, pendingPayouts) || other.pendingPayouts == pendingPayouts)&&(identical(other.orderCount, orderCount) || other.orderCount == orderCount)&&(identical(other.consultationCount, consultationCount) || other.consultationCount == consultationCount)&&(identical(other.days, days) || other.days == days));
}


@override
int get hashCode => Object.hash(runtimeType,grossRevenue,consultationRevenue,marketplaceRevenue,walletTopUps,refunds,pendingPayouts,orderCount,consultationCount,days);

@override
String toString() {
  return 'FinancialSummary(grossRevenue: $grossRevenue, consultationRevenue: $consultationRevenue, marketplaceRevenue: $marketplaceRevenue, walletTopUps: $walletTopUps, refunds: $refunds, pendingPayouts: $pendingPayouts, orderCount: $orderCount, consultationCount: $consultationCount, days: $days)';
}


}

/// @nodoc
abstract mixin class $FinancialSummaryCopyWith<$Res>  {
  factory $FinancialSummaryCopyWith(FinancialSummary value, $Res Function(FinancialSummary) _then) = _$FinancialSummaryCopyWithImpl;
@useResult
$Res call({
 double grossRevenue, double consultationRevenue, double marketplaceRevenue, double walletTopUps, double refunds, double pendingPayouts, int orderCount, int consultationCount, int days
});




}
/// @nodoc
class _$FinancialSummaryCopyWithImpl<$Res>
    implements $FinancialSummaryCopyWith<$Res> {
  _$FinancialSummaryCopyWithImpl(this._self, this._then);

  final FinancialSummary _self;
  final $Res Function(FinancialSummary) _then;

/// Create a copy of FinancialSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? grossRevenue = null,Object? consultationRevenue = null,Object? marketplaceRevenue = null,Object? walletTopUps = null,Object? refunds = null,Object? pendingPayouts = null,Object? orderCount = null,Object? consultationCount = null,Object? days = null,}) {
  return _then(_self.copyWith(
grossRevenue: null == grossRevenue ? _self.grossRevenue : grossRevenue // ignore: cast_nullable_to_non_nullable
as double,consultationRevenue: null == consultationRevenue ? _self.consultationRevenue : consultationRevenue // ignore: cast_nullable_to_non_nullable
as double,marketplaceRevenue: null == marketplaceRevenue ? _self.marketplaceRevenue : marketplaceRevenue // ignore: cast_nullable_to_non_nullable
as double,walletTopUps: null == walletTopUps ? _self.walletTopUps : walletTopUps // ignore: cast_nullable_to_non_nullable
as double,refunds: null == refunds ? _self.refunds : refunds // ignore: cast_nullable_to_non_nullable
as double,pendingPayouts: null == pendingPayouts ? _self.pendingPayouts : pendingPayouts // ignore: cast_nullable_to_non_nullable
as double,orderCount: null == orderCount ? _self.orderCount : orderCount // ignore: cast_nullable_to_non_nullable
as int,consultationCount: null == consultationCount ? _self.consultationCount : consultationCount // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _FinancialSummary extends FinancialSummary {
  const _FinancialSummary({this.grossRevenue = 0, this.consultationRevenue = 0, this.marketplaceRevenue = 0, this.walletTopUps = 0, this.refunds = 0, this.pendingPayouts = 0, this.orderCount = 0, this.consultationCount = 0, this.days = 30}): super._();
  

@override@JsonKey() final  double grossRevenue;
@override@JsonKey() final  double consultationRevenue;
@override@JsonKey() final  double marketplaceRevenue;
@override@JsonKey() final  double walletTopUps;
@override@JsonKey() final  double refunds;
@override@JsonKey() final  double pendingPayouts;
@override@JsonKey() final  int orderCount;
@override@JsonKey() final  int consultationCount;
/// The window this covers, echoed back so a chart can label itself without
/// the page having to remember what it asked for.
@override@JsonKey() final  int days;

/// Create a copy of FinancialSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialSummaryCopyWith<_FinancialSummary> get copyWith => __$FinancialSummaryCopyWithImpl<_FinancialSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialSummary&&(identical(other.grossRevenue, grossRevenue) || other.grossRevenue == grossRevenue)&&(identical(other.consultationRevenue, consultationRevenue) || other.consultationRevenue == consultationRevenue)&&(identical(other.marketplaceRevenue, marketplaceRevenue) || other.marketplaceRevenue == marketplaceRevenue)&&(identical(other.walletTopUps, walletTopUps) || other.walletTopUps == walletTopUps)&&(identical(other.refunds, refunds) || other.refunds == refunds)&&(identical(other.pendingPayouts, pendingPayouts) || other.pendingPayouts == pendingPayouts)&&(identical(other.orderCount, orderCount) || other.orderCount == orderCount)&&(identical(other.consultationCount, consultationCount) || other.consultationCount == consultationCount)&&(identical(other.days, days) || other.days == days));
}


@override
int get hashCode => Object.hash(runtimeType,grossRevenue,consultationRevenue,marketplaceRevenue,walletTopUps,refunds,pendingPayouts,orderCount,consultationCount,days);

@override
String toString() {
  return 'FinancialSummary(grossRevenue: $grossRevenue, consultationRevenue: $consultationRevenue, marketplaceRevenue: $marketplaceRevenue, walletTopUps: $walletTopUps, refunds: $refunds, pendingPayouts: $pendingPayouts, orderCount: $orderCount, consultationCount: $consultationCount, days: $days)';
}


}

/// @nodoc
abstract mixin class _$FinancialSummaryCopyWith<$Res> implements $FinancialSummaryCopyWith<$Res> {
  factory _$FinancialSummaryCopyWith(_FinancialSummary value, $Res Function(_FinancialSummary) _then) = __$FinancialSummaryCopyWithImpl;
@override @useResult
$Res call({
 double grossRevenue, double consultationRevenue, double marketplaceRevenue, double walletTopUps, double refunds, double pendingPayouts, int orderCount, int consultationCount, int days
});




}
/// @nodoc
class __$FinancialSummaryCopyWithImpl<$Res>
    implements _$FinancialSummaryCopyWith<$Res> {
  __$FinancialSummaryCopyWithImpl(this._self, this._then);

  final _FinancialSummary _self;
  final $Res Function(_FinancialSummary) _then;

/// Create a copy of FinancialSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? grossRevenue = null,Object? consultationRevenue = null,Object? marketplaceRevenue = null,Object? walletTopUps = null,Object? refunds = null,Object? pendingPayouts = null,Object? orderCount = null,Object? consultationCount = null,Object? days = null,}) {
  return _then(_FinancialSummary(
grossRevenue: null == grossRevenue ? _self.grossRevenue : grossRevenue // ignore: cast_nullable_to_non_nullable
as double,consultationRevenue: null == consultationRevenue ? _self.consultationRevenue : consultationRevenue // ignore: cast_nullable_to_non_nullable
as double,marketplaceRevenue: null == marketplaceRevenue ? _self.marketplaceRevenue : marketplaceRevenue // ignore: cast_nullable_to_non_nullable
as double,walletTopUps: null == walletTopUps ? _self.walletTopUps : walletTopUps // ignore: cast_nullable_to_non_nullable
as double,refunds: null == refunds ? _self.refunds : refunds // ignore: cast_nullable_to_non_nullable
as double,pendingPayouts: null == pendingPayouts ? _self.pendingPayouts : pendingPayouts // ignore: cast_nullable_to_non_nullable
as double,orderCount: null == orderCount ? _self.orderCount : orderCount // ignore: cast_nullable_to_non_nullable
as int,consultationCount: null == consultationCount ? _self.consultationCount : consultationCount // ignore: cast_nullable_to_non_nullable
as int,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
