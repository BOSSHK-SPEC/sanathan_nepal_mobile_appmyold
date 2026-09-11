// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WalletState {

 LoadState<WalletBalance> get balance; LoadState<List<TopUpOption>> get options;
/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletStateCopyWith<WalletState> get copyWith => _$WalletStateCopyWithImpl<WalletState>(this as WalletState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletState&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.options, options) || other.options == options));
}


@override
int get hashCode => Object.hash(runtimeType,balance,options);

@override
String toString() {
  return 'WalletState(balance: $balance, options: $options)';
}


}

/// @nodoc
abstract mixin class $WalletStateCopyWith<$Res>  {
  factory $WalletStateCopyWith(WalletState value, $Res Function(WalletState) _then) = _$WalletStateCopyWithImpl;
@useResult
$Res call({
 LoadState<WalletBalance> balance, LoadState<List<TopUpOption>> options
});


$LoadStateCopyWith<WalletBalance, $Res> get balance;$LoadStateCopyWith<List<TopUpOption>, $Res> get options;

}
/// @nodoc
class _$WalletStateCopyWithImpl<$Res>
    implements $WalletStateCopyWith<$Res> {
  _$WalletStateCopyWithImpl(this._self, this._then);

  final WalletState _self;
  final $Res Function(WalletState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,Object? options = null,}) {
  return _then(_self.copyWith(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as LoadState<WalletBalance>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as LoadState<List<TopUpOption>>,
  ));
}
/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<WalletBalance, $Res> get balance {
  
  return $LoadStateCopyWith<WalletBalance, $Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TopUpOption>, $Res> get options {
  
  return $LoadStateCopyWith<List<TopUpOption>, $Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}
}



/// @nodoc


class _WalletState extends WalletState {
  const _WalletState({this.balance = const LoadState.idle(), this.options = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<WalletBalance> balance;
@override@JsonKey() final  LoadState<List<TopUpOption>> options;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletStateCopyWith<_WalletState> get copyWith => __$WalletStateCopyWithImpl<_WalletState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletState&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.options, options) || other.options == options));
}


@override
int get hashCode => Object.hash(runtimeType,balance,options);

@override
String toString() {
  return 'WalletState(balance: $balance, options: $options)';
}


}

/// @nodoc
abstract mixin class _$WalletStateCopyWith<$Res> implements $WalletStateCopyWith<$Res> {
  factory _$WalletStateCopyWith(_WalletState value, $Res Function(_WalletState) _then) = __$WalletStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<WalletBalance> balance, LoadState<List<TopUpOption>> options
});


@override $LoadStateCopyWith<WalletBalance, $Res> get balance;@override $LoadStateCopyWith<List<TopUpOption>, $Res> get options;

}
/// @nodoc
class __$WalletStateCopyWithImpl<$Res>
    implements _$WalletStateCopyWith<$Res> {
  __$WalletStateCopyWithImpl(this._self, this._then);

  final _WalletState _self;
  final $Res Function(_WalletState) _then;

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? options = null,}) {
  return _then(_WalletState(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as LoadState<WalletBalance>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as LoadState<List<TopUpOption>>,
  ));
}

/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<WalletBalance, $Res> get balance {
  
  return $LoadStateCopyWith<WalletBalance, $Res>(_self.balance, (value) {
    return _then(_self.copyWith(balance: value));
  });
}/// Create a copy of WalletState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TopUpOption>, $Res> get options {
  
  return $LoadStateCopyWith<List<TopUpOption>, $Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}
}

// dart format on
