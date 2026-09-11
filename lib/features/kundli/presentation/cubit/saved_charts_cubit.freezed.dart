// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_charts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedChartsState {

 LoadState<List<BirthProfile>> get profiles;
/// Create a copy of SavedChartsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedChartsStateCopyWith<SavedChartsState> get copyWith => _$SavedChartsStateCopyWithImpl<SavedChartsState>(this as SavedChartsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedChartsState&&(identical(other.profiles, profiles) || other.profiles == profiles));
}


@override
int get hashCode => Object.hash(runtimeType,profiles);

@override
String toString() {
  return 'SavedChartsState(profiles: $profiles)';
}


}

/// @nodoc
abstract mixin class $SavedChartsStateCopyWith<$Res>  {
  factory $SavedChartsStateCopyWith(SavedChartsState value, $Res Function(SavedChartsState) _then) = _$SavedChartsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<BirthProfile>> profiles
});


$LoadStateCopyWith<List<BirthProfile>, $Res> get profiles;

}
/// @nodoc
class _$SavedChartsStateCopyWithImpl<$Res>
    implements $SavedChartsStateCopyWith<$Res> {
  _$SavedChartsStateCopyWithImpl(this._self, this._then);

  final SavedChartsState _self;
  final $Res Function(SavedChartsState) _then;

/// Create a copy of SavedChartsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profiles = null,}) {
  return _then(_self.copyWith(
profiles: null == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as LoadState<List<BirthProfile>>,
  ));
}
/// Create a copy of SavedChartsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BirthProfile>, $Res> get profiles {
  
  return $LoadStateCopyWith<List<BirthProfile>, $Res>(_self.profiles, (value) {
    return _then(_self.copyWith(profiles: value));
  });
}
}



/// @nodoc


class _SavedChartsState extends SavedChartsState {
  const _SavedChartsState({this.profiles = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<List<BirthProfile>> profiles;

/// Create a copy of SavedChartsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedChartsStateCopyWith<_SavedChartsState> get copyWith => __$SavedChartsStateCopyWithImpl<_SavedChartsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedChartsState&&(identical(other.profiles, profiles) || other.profiles == profiles));
}


@override
int get hashCode => Object.hash(runtimeType,profiles);

@override
String toString() {
  return 'SavedChartsState(profiles: $profiles)';
}


}

/// @nodoc
abstract mixin class _$SavedChartsStateCopyWith<$Res> implements $SavedChartsStateCopyWith<$Res> {
  factory _$SavedChartsStateCopyWith(_SavedChartsState value, $Res Function(_SavedChartsState) _then) = __$SavedChartsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<BirthProfile>> profiles
});


@override $LoadStateCopyWith<List<BirthProfile>, $Res> get profiles;

}
/// @nodoc
class __$SavedChartsStateCopyWithImpl<$Res>
    implements _$SavedChartsStateCopyWith<$Res> {
  __$SavedChartsStateCopyWithImpl(this._self, this._then);

  final _SavedChartsState _self;
  final $Res Function(_SavedChartsState) _then;

/// Create a copy of SavedChartsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profiles = null,}) {
  return _then(_SavedChartsState(
profiles: null == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as LoadState<List<BirthProfile>>,
  ));
}

/// Create a copy of SavedChartsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BirthProfile>, $Res> get profiles {
  
  return $LoadStateCopyWith<List<BirthProfile>, $Res>(_self.profiles, (value) {
    return _then(_self.copyWith(profiles: value));
  });
}
}

// dart format on
