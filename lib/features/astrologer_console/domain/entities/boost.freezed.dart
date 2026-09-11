// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'boost.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoostPlan {

 String get id; BoostPlacement get placement; int get days; double get price;/// Impressions the platform expects to deliver — a range in reality, so
/// it is labelled as an estimate wherever it is shown.
 int get estimatedImpressions; bool get popular;
/// Create a copy of BoostPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoostPlanCopyWith<BoostPlan> get copyWith => _$BoostPlanCopyWithImpl<BoostPlan>(this as BoostPlan, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoostPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.days, days) || other.days == days)&&(identical(other.price, price) || other.price == price)&&(identical(other.estimatedImpressions, estimatedImpressions) || other.estimatedImpressions == estimatedImpressions)&&(identical(other.popular, popular) || other.popular == popular));
}


@override
int get hashCode => Object.hash(runtimeType,id,placement,days,price,estimatedImpressions,popular);

@override
String toString() {
  return 'BoostPlan(id: $id, placement: $placement, days: $days, price: $price, estimatedImpressions: $estimatedImpressions, popular: $popular)';
}


}

/// @nodoc
abstract mixin class $BoostPlanCopyWith<$Res>  {
  factory $BoostPlanCopyWith(BoostPlan value, $Res Function(BoostPlan) _then) = _$BoostPlanCopyWithImpl;
@useResult
$Res call({
 String id, BoostPlacement placement, int days, double price, int estimatedImpressions, bool popular
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placement = null,Object? days = null,Object? price = null,Object? estimatedImpressions = null,Object? popular = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as BoostPlacement,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,estimatedImpressions: null == estimatedImpressions ? _self.estimatedImpressions : estimatedImpressions // ignore: cast_nullable_to_non_nullable
as int,popular: null == popular ? _self.popular : popular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _BoostPlan extends BoostPlan {
  const _BoostPlan({required this.id, required this.placement, required this.days, required this.price, required this.estimatedImpressions, this.popular = false}): super._();
  

@override final  String id;
@override final  BoostPlacement placement;
@override final  int days;
@override final  double price;
/// Impressions the platform expects to deliver — a range in reality, so
/// it is labelled as an estimate wherever it is shown.
@override final  int estimatedImpressions;
@override@JsonKey() final  bool popular;

/// Create a copy of BoostPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoostPlanCopyWith<_BoostPlan> get copyWith => __$BoostPlanCopyWithImpl<_BoostPlan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoostPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.days, days) || other.days == days)&&(identical(other.price, price) || other.price == price)&&(identical(other.estimatedImpressions, estimatedImpressions) || other.estimatedImpressions == estimatedImpressions)&&(identical(other.popular, popular) || other.popular == popular));
}


@override
int get hashCode => Object.hash(runtimeType,id,placement,days,price,estimatedImpressions,popular);

@override
String toString() {
  return 'BoostPlan(id: $id, placement: $placement, days: $days, price: $price, estimatedImpressions: $estimatedImpressions, popular: $popular)';
}


}

/// @nodoc
abstract mixin class _$BoostPlanCopyWith<$Res> implements $BoostPlanCopyWith<$Res> {
  factory _$BoostPlanCopyWith(_BoostPlan value, $Res Function(_BoostPlan) _then) = __$BoostPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, BoostPlacement placement, int days, double price, int estimatedImpressions, bool popular
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placement = null,Object? days = null,Object? price = null,Object? estimatedImpressions = null,Object? popular = null,}) {
  return _then(_BoostPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as BoostPlacement,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,estimatedImpressions: null == estimatedImpressions ? _self.estimatedImpressions : estimatedImpressions // ignore: cast_nullable_to_non_nullable
as int,popular: null == popular ? _self.popular : popular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$BoostCampaign {

 String get id; BoostPlacement get placement; DateTime get startedAt; DateTime get endsAt; double get spent; int get impressions; int get profileViews; int get consultations;
/// Create a copy of BoostCampaign
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoostCampaignCopyWith<BoostCampaign> get copyWith => _$BoostCampaignCopyWithImpl<BoostCampaign>(this as BoostCampaign, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoostCampaign&&(identical(other.id, id) || other.id == id)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.impressions, impressions) || other.impressions == impressions)&&(identical(other.profileViews, profileViews) || other.profileViews == profileViews)&&(identical(other.consultations, consultations) || other.consultations == consultations));
}


@override
int get hashCode => Object.hash(runtimeType,id,placement,startedAt,endsAt,spent,impressions,profileViews,consultations);

@override
String toString() {
  return 'BoostCampaign(id: $id, placement: $placement, startedAt: $startedAt, endsAt: $endsAt, spent: $spent, impressions: $impressions, profileViews: $profileViews, consultations: $consultations)';
}


}

/// @nodoc
abstract mixin class $BoostCampaignCopyWith<$Res>  {
  factory $BoostCampaignCopyWith(BoostCampaign value, $Res Function(BoostCampaign) _then) = _$BoostCampaignCopyWithImpl;
@useResult
$Res call({
 String id, BoostPlacement placement, DateTime startedAt, DateTime endsAt, double spent, int impressions, int profileViews, int consultations
});




}
/// @nodoc
class _$BoostCampaignCopyWithImpl<$Res>
    implements $BoostCampaignCopyWith<$Res> {
  _$BoostCampaignCopyWithImpl(this._self, this._then);

  final BoostCampaign _self;
  final $Res Function(BoostCampaign) _then;

/// Create a copy of BoostCampaign
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placement = null,Object? startedAt = null,Object? endsAt = null,Object? spent = null,Object? impressions = null,Object? profileViews = null,Object? consultations = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as BoostPlacement,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,impressions: null == impressions ? _self.impressions : impressions // ignore: cast_nullable_to_non_nullable
as int,profileViews: null == profileViews ? _self.profileViews : profileViews // ignore: cast_nullable_to_non_nullable
as int,consultations: null == consultations ? _self.consultations : consultations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _BoostCampaign extends BoostCampaign {
  const _BoostCampaign({required this.id, required this.placement, required this.startedAt, required this.endsAt, required this.spent, this.impressions = 0, this.profileViews = 0, this.consultations = 0}): super._();
  

@override final  String id;
@override final  BoostPlacement placement;
@override final  DateTime startedAt;
@override final  DateTime endsAt;
@override final  double spent;
@override@JsonKey() final  int impressions;
@override@JsonKey() final  int profileViews;
@override@JsonKey() final  int consultations;

/// Create a copy of BoostCampaign
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoostCampaignCopyWith<_BoostCampaign> get copyWith => __$BoostCampaignCopyWithImpl<_BoostCampaign>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoostCampaign&&(identical(other.id, id) || other.id == id)&&(identical(other.placement, placement) || other.placement == placement)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.spent, spent) || other.spent == spent)&&(identical(other.impressions, impressions) || other.impressions == impressions)&&(identical(other.profileViews, profileViews) || other.profileViews == profileViews)&&(identical(other.consultations, consultations) || other.consultations == consultations));
}


@override
int get hashCode => Object.hash(runtimeType,id,placement,startedAt,endsAt,spent,impressions,profileViews,consultations);

@override
String toString() {
  return 'BoostCampaign(id: $id, placement: $placement, startedAt: $startedAt, endsAt: $endsAt, spent: $spent, impressions: $impressions, profileViews: $profileViews, consultations: $consultations)';
}


}

/// @nodoc
abstract mixin class _$BoostCampaignCopyWith<$Res> implements $BoostCampaignCopyWith<$Res> {
  factory _$BoostCampaignCopyWith(_BoostCampaign value, $Res Function(_BoostCampaign) _then) = __$BoostCampaignCopyWithImpl;
@override @useResult
$Res call({
 String id, BoostPlacement placement, DateTime startedAt, DateTime endsAt, double spent, int impressions, int profileViews, int consultations
});




}
/// @nodoc
class __$BoostCampaignCopyWithImpl<$Res>
    implements _$BoostCampaignCopyWith<$Res> {
  __$BoostCampaignCopyWithImpl(this._self, this._then);

  final _BoostCampaign _self;
  final $Res Function(_BoostCampaign) _then;

/// Create a copy of BoostCampaign
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placement = null,Object? startedAt = null,Object? endsAt = null,Object? spent = null,Object? impressions = null,Object? profileViews = null,Object? consultations = null,}) {
  return _then(_BoostCampaign(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placement: null == placement ? _self.placement : placement // ignore: cast_nullable_to_non_nullable
as BoostPlacement,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,spent: null == spent ? _self.spent : spent // ignore: cast_nullable_to_non_nullable
as double,impressions: null == impressions ? _self.impressions : impressions // ignore: cast_nullable_to_non_nullable
as int,profileViews: null == profileViews ? _self.profileViews : profileViews // ignore: cast_nullable_to_non_nullable
as int,consultations: null == consultations ? _self.consultations : consultations // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
