// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'console_pricing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsolePricing {

 Map<ConsultChannel, double> get ratePerMinute;/// Discounted rate for a seeker's first session, if offered.
 double? get firstSessionRate;/// Free minutes granted at the start of a first session.
 int get freeFirstMinutes;/// Platform cut, 0–1. Set by the platform, shown here so the astrologer
/// can see what a rate change actually earns them.
 double get commissionRate;
/// Create a copy of ConsolePricing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsolePricingCopyWith<ConsolePricing> get copyWith => _$ConsolePricingCopyWithImpl<ConsolePricing>(this as ConsolePricing, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsolePricing&&const DeepCollectionEquality().equals(other.ratePerMinute, ratePerMinute)&&(identical(other.firstSessionRate, firstSessionRate) || other.firstSessionRate == firstSessionRate)&&(identical(other.freeFirstMinutes, freeFirstMinutes) || other.freeFirstMinutes == freeFirstMinutes)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(ratePerMinute),firstSessionRate,freeFirstMinutes,commissionRate);

@override
String toString() {
  return 'ConsolePricing(ratePerMinute: $ratePerMinute, firstSessionRate: $firstSessionRate, freeFirstMinutes: $freeFirstMinutes, commissionRate: $commissionRate)';
}


}

/// @nodoc
abstract mixin class $ConsolePricingCopyWith<$Res>  {
  factory $ConsolePricingCopyWith(ConsolePricing value, $Res Function(ConsolePricing) _then) = _$ConsolePricingCopyWithImpl;
@useResult
$Res call({
 Map<ConsultChannel, double> ratePerMinute, double? firstSessionRate, int freeFirstMinutes, double commissionRate
});




}
/// @nodoc
class _$ConsolePricingCopyWithImpl<$Res>
    implements $ConsolePricingCopyWith<$Res> {
  _$ConsolePricingCopyWithImpl(this._self, this._then);

  final ConsolePricing _self;
  final $Res Function(ConsolePricing) _then;

/// Create a copy of ConsolePricing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ratePerMinute = null,Object? firstSessionRate = freezed,Object? freeFirstMinutes = null,Object? commissionRate = null,}) {
  return _then(_self.copyWith(
ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as Map<ConsultChannel, double>,firstSessionRate: freezed == firstSessionRate ? _self.firstSessionRate : firstSessionRate // ignore: cast_nullable_to_non_nullable
as double?,freeFirstMinutes: null == freeFirstMinutes ? _self.freeFirstMinutes : freeFirstMinutes // ignore: cast_nullable_to_non_nullable
as int,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc


class _ConsolePricing extends ConsolePricing {
  const _ConsolePricing({final  Map<ConsultChannel, double> ratePerMinute = const <ConsultChannel, double>{}, this.firstSessionRate, this.freeFirstMinutes = 0, this.commissionRate = 0.2}): _ratePerMinute = ratePerMinute,super._();
  

 final  Map<ConsultChannel, double> _ratePerMinute;
@override@JsonKey() Map<ConsultChannel, double> get ratePerMinute {
  if (_ratePerMinute is EqualUnmodifiableMapView) return _ratePerMinute;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratePerMinute);
}

/// Discounted rate for a seeker's first session, if offered.
@override final  double? firstSessionRate;
/// Free minutes granted at the start of a first session.
@override@JsonKey() final  int freeFirstMinutes;
/// Platform cut, 0–1. Set by the platform, shown here so the astrologer
/// can see what a rate change actually earns them.
@override@JsonKey() final  double commissionRate;

/// Create a copy of ConsolePricing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsolePricingCopyWith<_ConsolePricing> get copyWith => __$ConsolePricingCopyWithImpl<_ConsolePricing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsolePricing&&const DeepCollectionEquality().equals(other._ratePerMinute, _ratePerMinute)&&(identical(other.firstSessionRate, firstSessionRate) || other.firstSessionRate == firstSessionRate)&&(identical(other.freeFirstMinutes, freeFirstMinutes) || other.freeFirstMinutes == freeFirstMinutes)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_ratePerMinute),firstSessionRate,freeFirstMinutes,commissionRate);

@override
String toString() {
  return 'ConsolePricing(ratePerMinute: $ratePerMinute, firstSessionRate: $firstSessionRate, freeFirstMinutes: $freeFirstMinutes, commissionRate: $commissionRate)';
}


}

/// @nodoc
abstract mixin class _$ConsolePricingCopyWith<$Res> implements $ConsolePricingCopyWith<$Res> {
  factory _$ConsolePricingCopyWith(_ConsolePricing value, $Res Function(_ConsolePricing) _then) = __$ConsolePricingCopyWithImpl;
@override @useResult
$Res call({
 Map<ConsultChannel, double> ratePerMinute, double? firstSessionRate, int freeFirstMinutes, double commissionRate
});




}
/// @nodoc
class __$ConsolePricingCopyWithImpl<$Res>
    implements _$ConsolePricingCopyWith<$Res> {
  __$ConsolePricingCopyWithImpl(this._self, this._then);

  final _ConsolePricing _self;
  final $Res Function(_ConsolePricing) _then;

/// Create a copy of ConsolePricing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ratePerMinute = null,Object? firstSessionRate = freezed,Object? freeFirstMinutes = null,Object? commissionRate = null,}) {
  return _then(_ConsolePricing(
ratePerMinute: null == ratePerMinute ? _self._ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as Map<ConsultChannel, double>,firstSessionRate: freezed == firstSessionRate ? _self.firstSessionRate : firstSessionRate // ignore: cast_nullable_to_non_nullable
as double?,freeFirstMinutes: null == freeFirstMinutes ? _self.freeFirstMinutes : freeFirstMinutes // ignore: cast_nullable_to_non_nullable
as int,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
