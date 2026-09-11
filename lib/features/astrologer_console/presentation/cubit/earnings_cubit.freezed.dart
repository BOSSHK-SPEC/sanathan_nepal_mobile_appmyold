// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earnings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarningsState {

 LoadState<EarningsSummary> get summary; LoadState<PerformanceMetrics> get performance; EarningsRange get range;/// Null once loaded means no payout account has been added yet, which is
/// different from "not loaded", hence the explicit flag.
 PayoutAccount? get account; bool get accountLoaded;
/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningsStateCopyWith<EarningsState> get copyWith => _$EarningsStateCopyWithImpl<EarningsState>(this as EarningsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningsState&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.performance, performance) || other.performance == performance)&&(identical(other.range, range) || other.range == range)&&(identical(other.account, account) || other.account == account)&&(identical(other.accountLoaded, accountLoaded) || other.accountLoaded == accountLoaded));
}


@override
int get hashCode => Object.hash(runtimeType,summary,performance,range,account,accountLoaded);

@override
String toString() {
  return 'EarningsState(summary: $summary, performance: $performance, range: $range, account: $account, accountLoaded: $accountLoaded)';
}


}

/// @nodoc
abstract mixin class $EarningsStateCopyWith<$Res>  {
  factory $EarningsStateCopyWith(EarningsState value, $Res Function(EarningsState) _then) = _$EarningsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<EarningsSummary> summary, LoadState<PerformanceMetrics> performance, EarningsRange range, PayoutAccount? account, bool accountLoaded
});


$LoadStateCopyWith<EarningsSummary, $Res> get summary;$LoadStateCopyWith<PerformanceMetrics, $Res> get performance;$PayoutAccountCopyWith<$Res>? get account;

}
/// @nodoc
class _$EarningsStateCopyWithImpl<$Res>
    implements $EarningsStateCopyWith<$Res> {
  _$EarningsStateCopyWithImpl(this._self, this._then);

  final EarningsState _self;
  final $Res Function(EarningsState) _then;

/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? performance = null,Object? range = null,Object? account = freezed,Object? accountLoaded = null,}) {
  return _then(_self.copyWith(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LoadState<EarningsSummary>,performance: null == performance ? _self.performance : performance // ignore: cast_nullable_to_non_nullable
as LoadState<PerformanceMetrics>,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as EarningsRange,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as PayoutAccount?,accountLoaded: null == accountLoaded ? _self.accountLoaded : accountLoaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<EarningsSummary, $Res> get summary {
  
  return $LoadStateCopyWith<EarningsSummary, $Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PerformanceMetrics, $Res> get performance {
  
  return $LoadStateCopyWith<PerformanceMetrics, $Res>(_self.performance, (value) {
    return _then(_self.copyWith(performance: value));
  });
}/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $PayoutAccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}



/// @nodoc


class _EarningsState extends EarningsState {
  const _EarningsState({this.summary = const LoadState.idle(), this.performance = const LoadState.idle(), this.range = EarningsRange.week, this.account, this.accountLoaded = false}): super._();
  

@override@JsonKey() final  LoadState<EarningsSummary> summary;
@override@JsonKey() final  LoadState<PerformanceMetrics> performance;
@override@JsonKey() final  EarningsRange range;
/// Null once loaded means no payout account has been added yet, which is
/// different from "not loaded", hence the explicit flag.
@override final  PayoutAccount? account;
@override@JsonKey() final  bool accountLoaded;

/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningsStateCopyWith<_EarningsState> get copyWith => __$EarningsStateCopyWithImpl<_EarningsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningsState&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.performance, performance) || other.performance == performance)&&(identical(other.range, range) || other.range == range)&&(identical(other.account, account) || other.account == account)&&(identical(other.accountLoaded, accountLoaded) || other.accountLoaded == accountLoaded));
}


@override
int get hashCode => Object.hash(runtimeType,summary,performance,range,account,accountLoaded);

@override
String toString() {
  return 'EarningsState(summary: $summary, performance: $performance, range: $range, account: $account, accountLoaded: $accountLoaded)';
}


}

/// @nodoc
abstract mixin class _$EarningsStateCopyWith<$Res> implements $EarningsStateCopyWith<$Res> {
  factory _$EarningsStateCopyWith(_EarningsState value, $Res Function(_EarningsState) _then) = __$EarningsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<EarningsSummary> summary, LoadState<PerformanceMetrics> performance, EarningsRange range, PayoutAccount? account, bool accountLoaded
});


@override $LoadStateCopyWith<EarningsSummary, $Res> get summary;@override $LoadStateCopyWith<PerformanceMetrics, $Res> get performance;@override $PayoutAccountCopyWith<$Res>? get account;

}
/// @nodoc
class __$EarningsStateCopyWithImpl<$Res>
    implements _$EarningsStateCopyWith<$Res> {
  __$EarningsStateCopyWithImpl(this._self, this._then);

  final _EarningsState _self;
  final $Res Function(_EarningsState) _then;

/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? performance = null,Object? range = null,Object? account = freezed,Object? accountLoaded = null,}) {
  return _then(_EarningsState(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LoadState<EarningsSummary>,performance: null == performance ? _self.performance : performance // ignore: cast_nullable_to_non_nullable
as LoadState<PerformanceMetrics>,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as EarningsRange,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as PayoutAccount?,accountLoaded: null == accountLoaded ? _self.accountLoaded : accountLoaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<EarningsSummary, $Res> get summary {
  
  return $LoadStateCopyWith<EarningsSummary, $Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PerformanceMetrics, $Res> get performance {
  
  return $LoadStateCopyWith<PerformanceMetrics, $Res>(_self.performance, (value) {
    return _then(_self.copyWith(performance: value));
  });
}/// Create a copy of EarningsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $PayoutAccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
