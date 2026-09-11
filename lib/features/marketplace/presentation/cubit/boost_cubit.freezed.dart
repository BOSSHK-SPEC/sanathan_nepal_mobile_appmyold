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
mixin _$BoostState {

 BoostStep get step; LoadState<List<Product>> get products; LoadState<List<BoostPlan>> get plans; Set<String> get selectedIds; ProductSort get sort; BoostPlan? get plan;/// Result of the last submit (loading while in flight).
 LoadState<BoostReceipt> get submission;
/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoostStateCopyWith<BoostState> get copyWith => _$BoostStateCopyWithImpl<BoostState>(this as BoostState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoostState&&(identical(other.step, step) || other.step == step)&&(identical(other.products, products) || other.products == products)&&(identical(other.plans, plans) || other.plans == plans)&&const DeepCollectionEquality().equals(other.selectedIds, selectedIds)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,step,products,plans,const DeepCollectionEquality().hash(selectedIds),sort,plan,submission);

@override
String toString() {
  return 'BoostState(step: $step, products: $products, plans: $plans, selectedIds: $selectedIds, sort: $sort, plan: $plan, submission: $submission)';
}


}

/// @nodoc
abstract mixin class $BoostStateCopyWith<$Res>  {
  factory $BoostStateCopyWith(BoostState value, $Res Function(BoostState) _then) = _$BoostStateCopyWithImpl;
@useResult
$Res call({
 BoostStep step, LoadState<List<Product>> products, LoadState<List<BoostPlan>> plans, Set<String> selectedIds, ProductSort sort, BoostPlan? plan, LoadState<BoostReceipt> submission
});


$LoadStateCopyWith<List<Product>, $Res> get products;$LoadStateCopyWith<List<BoostPlan>, $Res> get plans;$BoostPlanCopyWith<$Res>? get plan;$LoadStateCopyWith<BoostReceipt, $Res> get submission;

}
/// @nodoc
class _$BoostStateCopyWithImpl<$Res>
    implements $BoostStateCopyWith<$Res> {
  _$BoostStateCopyWithImpl(this._self, this._then);

  final BoostState _self;
  final $Res Function(BoostState) _then;

/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? products = null,Object? plans = null,Object? selectedIds = null,Object? sort = null,Object? plan = freezed,Object? submission = null,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as BoostStep,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,plans: null == plans ? _self.plans : plans // ignore: cast_nullable_to_non_nullable
as LoadState<List<BoostPlan>>,selectedIds: null == selectedIds ? _self.selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProductSort,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as BoostPlan?,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<BoostReceipt>,
  ));
}
/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get products {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.products, (value) {
    return _then(_self.copyWith(products: value));
  });
}/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BoostPlan>, $Res> get plans {
  
  return $LoadStateCopyWith<List<BoostPlan>, $Res>(_self.plans, (value) {
    return _then(_self.copyWith(plans: value));
  });
}/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoostPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $BoostPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BoostReceipt, $Res> get submission {
  
  return $LoadStateCopyWith<BoostReceipt, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}



/// @nodoc


class _BoostState extends BoostState {
  const _BoostState({this.step = BoostStep.select, this.products = const LoadState.idle(), this.plans = const LoadState.idle(), final  Set<String> selectedIds = const {}, this.sort = ProductSort.latest, this.plan, this.submission = const LoadState.idle()}): _selectedIds = selectedIds,super._();
  

@override@JsonKey() final  BoostStep step;
@override@JsonKey() final  LoadState<List<Product>> products;
@override@JsonKey() final  LoadState<List<BoostPlan>> plans;
 final  Set<String> _selectedIds;
@override@JsonKey() Set<String> get selectedIds {
  if (_selectedIds is EqualUnmodifiableSetView) return _selectedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedIds);
}

@override@JsonKey() final  ProductSort sort;
@override final  BoostPlan? plan;
/// Result of the last submit (loading while in flight).
@override@JsonKey() final  LoadState<BoostReceipt> submission;

/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoostStateCopyWith<_BoostState> get copyWith => __$BoostStateCopyWithImpl<_BoostState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoostState&&(identical(other.step, step) || other.step == step)&&(identical(other.products, products) || other.products == products)&&(identical(other.plans, plans) || other.plans == plans)&&const DeepCollectionEquality().equals(other._selectedIds, _selectedIds)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,step,products,plans,const DeepCollectionEquality().hash(_selectedIds),sort,plan,submission);

@override
String toString() {
  return 'BoostState(step: $step, products: $products, plans: $plans, selectedIds: $selectedIds, sort: $sort, plan: $plan, submission: $submission)';
}


}

/// @nodoc
abstract mixin class _$BoostStateCopyWith<$Res> implements $BoostStateCopyWith<$Res> {
  factory _$BoostStateCopyWith(_BoostState value, $Res Function(_BoostState) _then) = __$BoostStateCopyWithImpl;
@override @useResult
$Res call({
 BoostStep step, LoadState<List<Product>> products, LoadState<List<BoostPlan>> plans, Set<String> selectedIds, ProductSort sort, BoostPlan? plan, LoadState<BoostReceipt> submission
});


@override $LoadStateCopyWith<List<Product>, $Res> get products;@override $LoadStateCopyWith<List<BoostPlan>, $Res> get plans;@override $BoostPlanCopyWith<$Res>? get plan;@override $LoadStateCopyWith<BoostReceipt, $Res> get submission;

}
/// @nodoc
class __$BoostStateCopyWithImpl<$Res>
    implements _$BoostStateCopyWith<$Res> {
  __$BoostStateCopyWithImpl(this._self, this._then);

  final _BoostState _self;
  final $Res Function(_BoostState) _then;

/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? products = null,Object? plans = null,Object? selectedIds = null,Object? sort = null,Object? plan = freezed,Object? submission = null,}) {
  return _then(_BoostState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as BoostStep,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as LoadState<List<Product>>,plans: null == plans ? _self.plans : plans // ignore: cast_nullable_to_non_nullable
as LoadState<List<BoostPlan>>,selectedIds: null == selectedIds ? _self._selectedIds : selectedIds // ignore: cast_nullable_to_non_nullable
as Set<String>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProductSort,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as BoostPlan?,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<BoostReceipt>,
  ));
}

/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<Product>, $Res> get products {
  
  return $LoadStateCopyWith<List<Product>, $Res>(_self.products, (value) {
    return _then(_self.copyWith(products: value));
  });
}/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BoostPlan>, $Res> get plans {
  
  return $LoadStateCopyWith<List<BoostPlan>, $Res>(_self.plans, (value) {
    return _then(_self.copyWith(plans: value));
  });
}/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoostPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $BoostPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of BoostState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BoostReceipt, $Res> get submission {
  
  return $LoadStateCopyWith<BoostReceipt, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}

// dart format on
