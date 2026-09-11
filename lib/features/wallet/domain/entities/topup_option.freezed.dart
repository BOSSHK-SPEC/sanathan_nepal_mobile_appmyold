// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topup_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TopUpOption {

 double get amount;/// Extra promotional credit granted on this tier.
 double get bonus;/// Highlighted in the picker as the suggested tier.
 bool get popular;
/// Create a copy of TopUpOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopUpOptionCopyWith<TopUpOption> get copyWith => _$TopUpOptionCopyWithImpl<TopUpOption>(this as TopUpOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopUpOption&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bonus, bonus) || other.bonus == bonus)&&(identical(other.popular, popular) || other.popular == popular));
}


@override
int get hashCode => Object.hash(runtimeType,amount,bonus,popular);

@override
String toString() {
  return 'TopUpOption(amount: $amount, bonus: $bonus, popular: $popular)';
}


}

/// @nodoc
abstract mixin class $TopUpOptionCopyWith<$Res>  {
  factory $TopUpOptionCopyWith(TopUpOption value, $Res Function(TopUpOption) _then) = _$TopUpOptionCopyWithImpl;
@useResult
$Res call({
 double amount, double bonus, bool popular
});




}
/// @nodoc
class _$TopUpOptionCopyWithImpl<$Res>
    implements $TopUpOptionCopyWith<$Res> {
  _$TopUpOptionCopyWithImpl(this._self, this._then);

  final TopUpOption _self;
  final $Res Function(TopUpOption) _then;

/// Create a copy of TopUpOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? bonus = null,Object? popular = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,bonus: null == bonus ? _self.bonus : bonus // ignore: cast_nullable_to_non_nullable
as double,popular: null == popular ? _self.popular : popular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _TopUpOption extends TopUpOption {
  const _TopUpOption({required this.amount, this.bonus = 0, this.popular = false}): super._();
  

@override final  double amount;
/// Extra promotional credit granted on this tier.
@override@JsonKey() final  double bonus;
/// Highlighted in the picker as the suggested tier.
@override@JsonKey() final  bool popular;

/// Create a copy of TopUpOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopUpOptionCopyWith<_TopUpOption> get copyWith => __$TopUpOptionCopyWithImpl<_TopUpOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopUpOption&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bonus, bonus) || other.bonus == bonus)&&(identical(other.popular, popular) || other.popular == popular));
}


@override
int get hashCode => Object.hash(runtimeType,amount,bonus,popular);

@override
String toString() {
  return 'TopUpOption(amount: $amount, bonus: $bonus, popular: $popular)';
}


}

/// @nodoc
abstract mixin class _$TopUpOptionCopyWith<$Res> implements $TopUpOptionCopyWith<$Res> {
  factory _$TopUpOptionCopyWith(_TopUpOption value, $Res Function(_TopUpOption) _then) = __$TopUpOptionCopyWithImpl;
@override @useResult
$Res call({
 double amount, double bonus, bool popular
});




}
/// @nodoc
class __$TopUpOptionCopyWithImpl<$Res>
    implements _$TopUpOptionCopyWith<$Res> {
  __$TopUpOptionCopyWithImpl(this._self, this._then);

  final _TopUpOption _self;
  final $Res Function(_TopUpOption) _then;

/// Create a copy of TopUpOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? bonus = null,Object? popular = null,}) {
  return _then(_TopUpOption(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,bonus: null == bonus ? _self.bonus : bonus // ignore: cast_nullable_to_non_nullable
as double,popular: null == popular ? _self.popular : popular // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
