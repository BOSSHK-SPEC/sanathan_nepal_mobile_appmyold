// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_status_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentStatusState {

 LoadState<PaymentIntent> get intent; int get attempts;
/// Create a copy of PaymentStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentStatusStateCopyWith<PaymentStatusState> get copyWith => _$PaymentStatusStateCopyWithImpl<PaymentStatusState>(this as PaymentStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentStatusState&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.attempts, attempts) || other.attempts == attempts));
}


@override
int get hashCode => Object.hash(runtimeType,intent,attempts);

@override
String toString() {
  return 'PaymentStatusState(intent: $intent, attempts: $attempts)';
}


}

/// @nodoc
abstract mixin class $PaymentStatusStateCopyWith<$Res>  {
  factory $PaymentStatusStateCopyWith(PaymentStatusState value, $Res Function(PaymentStatusState) _then) = _$PaymentStatusStateCopyWithImpl;
@useResult
$Res call({
 LoadState<PaymentIntent> intent, int attempts
});


$LoadStateCopyWith<PaymentIntent, $Res> get intent;

}
/// @nodoc
class _$PaymentStatusStateCopyWithImpl<$Res>
    implements $PaymentStatusStateCopyWith<$Res> {
  _$PaymentStatusStateCopyWithImpl(this._self, this._then);

  final PaymentStatusState _self;
  final $Res Function(PaymentStatusState) _then;

/// Create a copy of PaymentStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? intent = null,Object? attempts = null,}) {
  return _then(_self.copyWith(
intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as LoadState<PaymentIntent>,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PaymentStatusState
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


class _PaymentStatusState extends PaymentStatusState {
  const _PaymentStatusState({this.intent = const LoadState.idle(), this.attempts = 0}): super._();
  

@override@JsonKey() final  LoadState<PaymentIntent> intent;
@override@JsonKey() final  int attempts;

/// Create a copy of PaymentStatusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentStatusStateCopyWith<_PaymentStatusState> get copyWith => __$PaymentStatusStateCopyWithImpl<_PaymentStatusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentStatusState&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.attempts, attempts) || other.attempts == attempts));
}


@override
int get hashCode => Object.hash(runtimeType,intent,attempts);

@override
String toString() {
  return 'PaymentStatusState(intent: $intent, attempts: $attempts)';
}


}

/// @nodoc
abstract mixin class _$PaymentStatusStateCopyWith<$Res> implements $PaymentStatusStateCopyWith<$Res> {
  factory _$PaymentStatusStateCopyWith(_PaymentStatusState value, $Res Function(_PaymentStatusState) _then) = __$PaymentStatusStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<PaymentIntent> intent, int attempts
});


@override $LoadStateCopyWith<PaymentIntent, $Res> get intent;

}
/// @nodoc
class __$PaymentStatusStateCopyWithImpl<$Res>
    implements _$PaymentStatusStateCopyWith<$Res> {
  __$PaymentStatusStateCopyWithImpl(this._self, this._then);

  final _PaymentStatusState _self;
  final $Res Function(_PaymentStatusState) _then;

/// Create a copy of PaymentStatusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? intent = null,Object? attempts = null,}) {
  return _then(_PaymentStatusState(
intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as LoadState<PaymentIntent>,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PaymentStatusState
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
