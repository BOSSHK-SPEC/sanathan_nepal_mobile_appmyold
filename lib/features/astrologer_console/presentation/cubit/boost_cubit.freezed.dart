// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'boost_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConsoleBoostState {

 LoadState<List<BoostPlan>> get plans; LoadState<List<BoostCampaign>> get campaigns; LoadState<BoostCampaign> get buying; double get availableBalance; String? get selectedPlanId; String? get buyError;
/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConsoleBoostStateCopyWith<ConsoleBoostState> get copyWith => _$ConsoleBoostStateCopyWithImpl<ConsoleBoostState>(this as ConsoleBoostState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConsoleBoostState&&(identical(other.plans, plans) || other.plans == plans)&&(identical(other.campaigns, campaigns) || other.campaigns == campaigns)&&(identical(other.buying, buying) || other.buying == buying)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.selectedPlanId, selectedPlanId) || other.selectedPlanId == selectedPlanId)&&(identical(other.buyError, buyError) || other.buyError == buyError));
}


@override
int get hashCode => Object.hash(runtimeType,plans,campaigns,buying,availableBalance,selectedPlanId,buyError);

@override
String toString() {
  return 'ConsoleBoostState(plans: $plans, campaigns: $campaigns, buying: $buying, availableBalance: $availableBalance, selectedPlanId: $selectedPlanId, buyError: $buyError)';
}


}

/// @nodoc
abstract mixin class $ConsoleBoostStateCopyWith<$Res>  {
  factory $ConsoleBoostStateCopyWith(ConsoleBoostState value, $Res Function(ConsoleBoostState) _then) = _$ConsoleBoostStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<BoostPlan>> plans, LoadState<List<BoostCampaign>> campaigns, LoadState<BoostCampaign> buying, double availableBalance, String? selectedPlanId, String? buyError
});


$LoadStateCopyWith<List<BoostPlan>, $Res> get plans;$LoadStateCopyWith<List<BoostCampaign>, $Res> get campaigns;$LoadStateCopyWith<BoostCampaign, $Res> get buying;

}
/// @nodoc
class _$ConsoleBoostStateCopyWithImpl<$Res>
    implements $ConsoleBoostStateCopyWith<$Res> {
  _$ConsoleBoostStateCopyWithImpl(this._self, this._then);

  final ConsoleBoostState _self;
  final $Res Function(ConsoleBoostState) _then;

/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plans = null,Object? campaigns = null,Object? buying = null,Object? availableBalance = null,Object? selectedPlanId = freezed,Object? buyError = freezed,}) {
  return _then(_self.copyWith(
plans: null == plans ? _self.plans : plans // ignore: cast_nullable_to_non_nullable
as LoadState<List<BoostPlan>>,campaigns: null == campaigns ? _self.campaigns : campaigns // ignore: cast_nullable_to_non_nullable
as LoadState<List<BoostCampaign>>,buying: null == buying ? _self.buying : buying // ignore: cast_nullable_to_non_nullable
as LoadState<BoostCampaign>,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,selectedPlanId: freezed == selectedPlanId ? _self.selectedPlanId : selectedPlanId // ignore: cast_nullable_to_non_nullable
as String?,buyError: freezed == buyError ? _self.buyError : buyError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BoostPlan>, $Res> get plans {
  
  return $LoadStateCopyWith<List<BoostPlan>, $Res>(_self.plans, (value) {
    return _then(_self.copyWith(plans: value));
  });
}/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BoostCampaign>, $Res> get campaigns {
  
  return $LoadStateCopyWith<List<BoostCampaign>, $Res>(_self.campaigns, (value) {
    return _then(_self.copyWith(campaigns: value));
  });
}/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BoostCampaign, $Res> get buying {
  
  return $LoadStateCopyWith<BoostCampaign, $Res>(_self.buying, (value) {
    return _then(_self.copyWith(buying: value));
  });
}
}



/// @nodoc


class _ConsoleBoostState extends ConsoleBoostState {
  const _ConsoleBoostState({this.plans = const LoadState.idle(), this.campaigns = const LoadState.idle(), this.buying = const LoadState.idle(), this.availableBalance = 0, this.selectedPlanId, this.buyError}): super._();
  

@override@JsonKey() final  LoadState<List<BoostPlan>> plans;
@override@JsonKey() final  LoadState<List<BoostCampaign>> campaigns;
@override@JsonKey() final  LoadState<BoostCampaign> buying;
@override@JsonKey() final  double availableBalance;
@override final  String? selectedPlanId;
@override final  String? buyError;

/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConsoleBoostStateCopyWith<_ConsoleBoostState> get copyWith => __$ConsoleBoostStateCopyWithImpl<_ConsoleBoostState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConsoleBoostState&&(identical(other.plans, plans) || other.plans == plans)&&(identical(other.campaigns, campaigns) || other.campaigns == campaigns)&&(identical(other.buying, buying) || other.buying == buying)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.selectedPlanId, selectedPlanId) || other.selectedPlanId == selectedPlanId)&&(identical(other.buyError, buyError) || other.buyError == buyError));
}


@override
int get hashCode => Object.hash(runtimeType,plans,campaigns,buying,availableBalance,selectedPlanId,buyError);

@override
String toString() {
  return 'ConsoleBoostState(plans: $plans, campaigns: $campaigns, buying: $buying, availableBalance: $availableBalance, selectedPlanId: $selectedPlanId, buyError: $buyError)';
}


}

/// @nodoc
abstract mixin class _$ConsoleBoostStateCopyWith<$Res> implements $ConsoleBoostStateCopyWith<$Res> {
  factory _$ConsoleBoostStateCopyWith(_ConsoleBoostState value, $Res Function(_ConsoleBoostState) _then) = __$ConsoleBoostStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<BoostPlan>> plans, LoadState<List<BoostCampaign>> campaigns, LoadState<BoostCampaign> buying, double availableBalance, String? selectedPlanId, String? buyError
});


@override $LoadStateCopyWith<List<BoostPlan>, $Res> get plans;@override $LoadStateCopyWith<List<BoostCampaign>, $Res> get campaigns;@override $LoadStateCopyWith<BoostCampaign, $Res> get buying;

}
/// @nodoc
class __$ConsoleBoostStateCopyWithImpl<$Res>
    implements _$ConsoleBoostStateCopyWith<$Res> {
  __$ConsoleBoostStateCopyWithImpl(this._self, this._then);

  final _ConsoleBoostState _self;
  final $Res Function(_ConsoleBoostState) _then;

/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plans = null,Object? campaigns = null,Object? buying = null,Object? availableBalance = null,Object? selectedPlanId = freezed,Object? buyError = freezed,}) {
  return _then(_ConsoleBoostState(
plans: null == plans ? _self.plans : plans // ignore: cast_nullable_to_non_nullable
as LoadState<List<BoostPlan>>,campaigns: null == campaigns ? _self.campaigns : campaigns // ignore: cast_nullable_to_non_nullable
as LoadState<List<BoostCampaign>>,buying: null == buying ? _self.buying : buying // ignore: cast_nullable_to_non_nullable
as LoadState<BoostCampaign>,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,selectedPlanId: freezed == selectedPlanId ? _self.selectedPlanId : selectedPlanId // ignore: cast_nullable_to_non_nullable
as String?,buyError: freezed == buyError ? _self.buyError : buyError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BoostPlan>, $Res> get plans {
  
  return $LoadStateCopyWith<List<BoostPlan>, $Res>(_self.plans, (value) {
    return _then(_self.copyWith(plans: value));
  });
}/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BoostCampaign>, $Res> get campaigns {
  
  return $LoadStateCopyWith<List<BoostCampaign>, $Res>(_self.campaigns, (value) {
    return _then(_self.copyWith(campaigns: value));
  });
}/// Create a copy of ConsoleBoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BoostCampaign, $Res> get buying {
  
  return $LoadStateCopyWith<BoostCampaign, $Res>(_self.buying, (value) {
    return _then(_self.copyWith(buying: value));
  });
}
}

// dart format on
