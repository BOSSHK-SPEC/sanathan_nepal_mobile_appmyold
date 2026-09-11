// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

/// Current wall-clock time (ticks periodically).
 DateTime get now; LoadState<MetalRates> get metalRates;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.now, now) || other.now == now)&&(identical(other.metalRates, metalRates) || other.metalRates == metalRates));
}


@override
int get hashCode => Object.hash(runtimeType,now,metalRates);

@override
String toString() {
  return 'HomeState(now: $now, metalRates: $metalRates)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 DateTime now, LoadState<MetalRates> metalRates
});


$LoadStateCopyWith<MetalRates, $Res> get metalRates;

}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? now = null,Object? metalRates = null,}) {
  return _then(_self.copyWith(
now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,metalRates: null == metalRates ? _self.metalRates : metalRates // ignore: cast_nullable_to_non_nullable
as LoadState<MetalRates>,
  ));
}
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<MetalRates, $Res> get metalRates {
  
  return $LoadStateCopyWith<MetalRates, $Res>(_self.metalRates, (value) {
    return _then(_self.copyWith(metalRates: value));
  });
}
}



/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({required this.now, this.metalRates = const LoadState.idle()});
  

/// Current wall-clock time (ticks periodically).
@override final  DateTime now;
@override@JsonKey() final  LoadState<MetalRates> metalRates;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.now, now) || other.now == now)&&(identical(other.metalRates, metalRates) || other.metalRates == metalRates));
}


@override
int get hashCode => Object.hash(runtimeType,now,metalRates);

@override
String toString() {
  return 'HomeState(now: $now, metalRates: $metalRates)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime now, LoadState<MetalRates> metalRates
});


@override $LoadStateCopyWith<MetalRates, $Res> get metalRates;

}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? now = null,Object? metalRates = null,}) {
  return _then(_HomeState(
now: null == now ? _self.now : now // ignore: cast_nullable_to_non_nullable
as DateTime,metalRates: null == metalRates ? _self.metalRates : metalRates // ignore: cast_nullable_to_non_nullable
as LoadState<MetalRates>,
  ));
}

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<MetalRates, $Res> get metalRates {
  
  return $LoadStateCopyWith<MetalRates, $Res>(_self.metalRates, (value) {
    return _then(_self.copyWith(metalRates: value));
  });
}
}

// dart format on
