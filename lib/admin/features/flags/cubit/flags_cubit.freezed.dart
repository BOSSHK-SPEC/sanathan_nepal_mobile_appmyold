// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flags_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlagsState {

 LoadState<List<FeatureFlag>> get flags; String? get savingKey; String? get actionError;
/// Create a copy of FlagsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlagsStateCopyWith<FlagsState> get copyWith => _$FlagsStateCopyWithImpl<FlagsState>(this as FlagsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlagsState&&(identical(other.flags, flags) || other.flags == flags)&&(identical(other.savingKey, savingKey) || other.savingKey == savingKey)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,flags,savingKey,actionError);

@override
String toString() {
  return 'FlagsState(flags: $flags, savingKey: $savingKey, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $FlagsStateCopyWith<$Res>  {
  factory $FlagsStateCopyWith(FlagsState value, $Res Function(FlagsState) _then) = _$FlagsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<FeatureFlag>> flags, String? savingKey, String? actionError
});


$LoadStateCopyWith<List<FeatureFlag>, $Res> get flags;

}
/// @nodoc
class _$FlagsStateCopyWithImpl<$Res>
    implements $FlagsStateCopyWith<$Res> {
  _$FlagsStateCopyWithImpl(this._self, this._then);

  final FlagsState _self;
  final $Res Function(FlagsState) _then;

/// Create a copy of FlagsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flags = null,Object? savingKey = freezed,Object? actionError = freezed,}) {
  return _then(_self.copyWith(
flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as LoadState<List<FeatureFlag>>,savingKey: freezed == savingKey ? _self.savingKey : savingKey // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FlagsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<FeatureFlag>, $Res> get flags {
  
  return $LoadStateCopyWith<List<FeatureFlag>, $Res>(_self.flags, (value) {
    return _then(_self.copyWith(flags: value));
  });
}
}



/// @nodoc


class _FlagsState extends FlagsState {
  const _FlagsState({this.flags = const LoadState<List<FeatureFlag>>.idle(), this.savingKey, this.actionError}): super._();
  

@override@JsonKey() final  LoadState<List<FeatureFlag>> flags;
@override final  String? savingKey;
@override final  String? actionError;

/// Create a copy of FlagsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlagsStateCopyWith<_FlagsState> get copyWith => __$FlagsStateCopyWithImpl<_FlagsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlagsState&&(identical(other.flags, flags) || other.flags == flags)&&(identical(other.savingKey, savingKey) || other.savingKey == savingKey)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,flags,savingKey,actionError);

@override
String toString() {
  return 'FlagsState(flags: $flags, savingKey: $savingKey, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class _$FlagsStateCopyWith<$Res> implements $FlagsStateCopyWith<$Res> {
  factory _$FlagsStateCopyWith(_FlagsState value, $Res Function(_FlagsState) _then) = __$FlagsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<FeatureFlag>> flags, String? savingKey, String? actionError
});


@override $LoadStateCopyWith<List<FeatureFlag>, $Res> get flags;

}
/// @nodoc
class __$FlagsStateCopyWithImpl<$Res>
    implements _$FlagsStateCopyWith<$Res> {
  __$FlagsStateCopyWithImpl(this._self, this._then);

  final _FlagsState _self;
  final $Res Function(_FlagsState) _then;

/// Create a copy of FlagsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flags = null,Object? savingKey = freezed,Object? actionError = freezed,}) {
  return _then(_FlagsState(
flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as LoadState<List<FeatureFlag>>,savingKey: freezed == savingKey ? _self.savingKey : savingKey // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FlagsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<FeatureFlag>, $Res> get flags {
  
  return $LoadStateCopyWith<List<FeatureFlag>, $Res>(_self.flags, (value) {
    return _then(_self.copyWith(flags: value));
  });
}
}

// dart format on
