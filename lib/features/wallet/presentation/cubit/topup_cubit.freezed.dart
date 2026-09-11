// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topup_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TopUpState {

/// Payment rails offered in the active region.
 List<PaymentRail> get rails; LoadState<List<TopUpOption>> get options; LoadState<PaymentIntent> get intent;/// 0 = amount, 1 = payment method.
 int get step; double? get selectedAmount; String get customAmount; PaymentRail? get rail; TopUpAmountError? get amountError;
/// Create a copy of TopUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopUpStateCopyWith<TopUpState> get copyWith => _$TopUpStateCopyWithImpl<TopUpState>(this as TopUpState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopUpState&&const DeepCollectionEquality().equals(other.rails, rails)&&(identical(other.options, options) || other.options == options)&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.step, step) || other.step == step)&&(identical(other.selectedAmount, selectedAmount) || other.selectedAmount == selectedAmount)&&(identical(other.customAmount, customAmount) || other.customAmount == customAmount)&&(identical(other.rail, rail) || other.rail == rail)&&(identical(other.amountError, amountError) || other.amountError == amountError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(rails),options,intent,step,selectedAmount,customAmount,rail,amountError);

@override
String toString() {
  return 'TopUpState(rails: $rails, options: $options, intent: $intent, step: $step, selectedAmount: $selectedAmount, customAmount: $customAmount, rail: $rail, amountError: $amountError)';
}


}

/// @nodoc
abstract mixin class $TopUpStateCopyWith<$Res>  {
  factory $TopUpStateCopyWith(TopUpState value, $Res Function(TopUpState) _then) = _$TopUpStateCopyWithImpl;
@useResult
$Res call({
 List<PaymentRail> rails, LoadState<List<TopUpOption>> options, LoadState<PaymentIntent> intent, int step, double? selectedAmount, String customAmount, PaymentRail? rail, TopUpAmountError? amountError
});


$LoadStateCopyWith<List<TopUpOption>, $Res> get options;$LoadStateCopyWith<PaymentIntent, $Res> get intent;

}
/// @nodoc
class _$TopUpStateCopyWithImpl<$Res>
    implements $TopUpStateCopyWith<$Res> {
  _$TopUpStateCopyWithImpl(this._self, this._then);

  final TopUpState _self;
  final $Res Function(TopUpState) _then;

/// Create a copy of TopUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rails = null,Object? options = null,Object? intent = null,Object? step = null,Object? selectedAmount = freezed,Object? customAmount = null,Object? rail = freezed,Object? amountError = freezed,}) {
  return _then(_self.copyWith(
rails: null == rails ? _self.rails : rails // ignore: cast_nullable_to_non_nullable
as List<PaymentRail>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as LoadState<List<TopUpOption>>,intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as LoadState<PaymentIntent>,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,selectedAmount: freezed == selectedAmount ? _self.selectedAmount : selectedAmount // ignore: cast_nullable_to_non_nullable
as double?,customAmount: null == customAmount ? _self.customAmount : customAmount // ignore: cast_nullable_to_non_nullable
as String,rail: freezed == rail ? _self.rail : rail // ignore: cast_nullable_to_non_nullable
as PaymentRail?,amountError: freezed == amountError ? _self.amountError : amountError // ignore: cast_nullable_to_non_nullable
as TopUpAmountError?,
  ));
}
/// Create a copy of TopUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TopUpOption>, $Res> get options {
  
  return $LoadStateCopyWith<List<TopUpOption>, $Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of TopUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PaymentIntent, $Res> get intent {
  
  return $LoadStateCopyWith<PaymentIntent, $Res>(_self.intent, (value) {
    return _then(_self.copyWith(intent: value));
  });
}
}



/// @nodoc


class _TopUpState extends TopUpState {
  const _TopUpState({required final  List<PaymentRail> rails, this.options = const LoadState.idle(), this.intent = const LoadState.idle(), this.step = 0, this.selectedAmount, this.customAmount = '', this.rail, this.amountError}): _rails = rails,super._();
  

/// Payment rails offered in the active region.
 final  List<PaymentRail> _rails;
/// Payment rails offered in the active region.
@override List<PaymentRail> get rails {
  if (_rails is EqualUnmodifiableListView) return _rails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rails);
}

@override@JsonKey() final  LoadState<List<TopUpOption>> options;
@override@JsonKey() final  LoadState<PaymentIntent> intent;
/// 0 = amount, 1 = payment method.
@override@JsonKey() final  int step;
@override final  double? selectedAmount;
@override@JsonKey() final  String customAmount;
@override final  PaymentRail? rail;
@override final  TopUpAmountError? amountError;

/// Create a copy of TopUpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopUpStateCopyWith<_TopUpState> get copyWith => __$TopUpStateCopyWithImpl<_TopUpState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopUpState&&const DeepCollectionEquality().equals(other._rails, _rails)&&(identical(other.options, options) || other.options == options)&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.step, step) || other.step == step)&&(identical(other.selectedAmount, selectedAmount) || other.selectedAmount == selectedAmount)&&(identical(other.customAmount, customAmount) || other.customAmount == customAmount)&&(identical(other.rail, rail) || other.rail == rail)&&(identical(other.amountError, amountError) || other.amountError == amountError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rails),options,intent,step,selectedAmount,customAmount,rail,amountError);

@override
String toString() {
  return 'TopUpState(rails: $rails, options: $options, intent: $intent, step: $step, selectedAmount: $selectedAmount, customAmount: $customAmount, rail: $rail, amountError: $amountError)';
}


}

/// @nodoc
abstract mixin class _$TopUpStateCopyWith<$Res> implements $TopUpStateCopyWith<$Res> {
  factory _$TopUpStateCopyWith(_TopUpState value, $Res Function(_TopUpState) _then) = __$TopUpStateCopyWithImpl;
@override @useResult
$Res call({
 List<PaymentRail> rails, LoadState<List<TopUpOption>> options, LoadState<PaymentIntent> intent, int step, double? selectedAmount, String customAmount, PaymentRail? rail, TopUpAmountError? amountError
});


@override $LoadStateCopyWith<List<TopUpOption>, $Res> get options;@override $LoadStateCopyWith<PaymentIntent, $Res> get intent;

}
/// @nodoc
class __$TopUpStateCopyWithImpl<$Res>
    implements _$TopUpStateCopyWith<$Res> {
  __$TopUpStateCopyWithImpl(this._self, this._then);

  final _TopUpState _self;
  final $Res Function(_TopUpState) _then;

/// Create a copy of TopUpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rails = null,Object? options = null,Object? intent = null,Object? step = null,Object? selectedAmount = freezed,Object? customAmount = null,Object? rail = freezed,Object? amountError = freezed,}) {
  return _then(_TopUpState(
rails: null == rails ? _self._rails : rails // ignore: cast_nullable_to_non_nullable
as List<PaymentRail>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as LoadState<List<TopUpOption>>,intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as LoadState<PaymentIntent>,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,selectedAmount: freezed == selectedAmount ? _self.selectedAmount : selectedAmount // ignore: cast_nullable_to_non_nullable
as double?,customAmount: null == customAmount ? _self.customAmount : customAmount // ignore: cast_nullable_to_non_nullable
as String,rail: freezed == rail ? _self.rail : rail // ignore: cast_nullable_to_non_nullable
as PaymentRail?,amountError: freezed == amountError ? _self.amountError : amountError // ignore: cast_nullable_to_non_nullable
as TopUpAmountError?,
  ));
}

/// Create a copy of TopUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TopUpOption>, $Res> get options {
  
  return $LoadStateCopyWith<List<TopUpOption>, $Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of TopUpState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<PaymentIntent, $Res> get intent {
  
  return $LoadStateCopyWith<PaymentIntent, $Res>(_self.intent, (value) {
    return _then(_self.copyWith(intent: value));
  });
}
}

// dart format on
