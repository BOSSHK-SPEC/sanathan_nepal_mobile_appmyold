// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_preferences_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WorkPreferencesState {

 LoadState<WorkPreferences> get prefs; String? get saveError;
/// Create a copy of WorkPreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkPreferencesStateCopyWith<WorkPreferencesState> get copyWith => _$WorkPreferencesStateCopyWithImpl<WorkPreferencesState>(this as WorkPreferencesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkPreferencesState&&(identical(other.prefs, prefs) || other.prefs == prefs)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,prefs,saveError);

@override
String toString() {
  return 'WorkPreferencesState(prefs: $prefs, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class $WorkPreferencesStateCopyWith<$Res>  {
  factory $WorkPreferencesStateCopyWith(WorkPreferencesState value, $Res Function(WorkPreferencesState) _then) = _$WorkPreferencesStateCopyWithImpl;
@useResult
$Res call({
 LoadState<WorkPreferences> prefs, String? saveError
});


$LoadStateCopyWith<WorkPreferences, $Res> get prefs;

}
/// @nodoc
class _$WorkPreferencesStateCopyWithImpl<$Res>
    implements $WorkPreferencesStateCopyWith<$Res> {
  _$WorkPreferencesStateCopyWithImpl(this._self, this._then);

  final WorkPreferencesState _self;
  final $Res Function(WorkPreferencesState) _then;

/// Create a copy of WorkPreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prefs = null,Object? saveError = freezed,}) {
  return _then(_self.copyWith(
prefs: null == prefs ? _self.prefs : prefs // ignore: cast_nullable_to_non_nullable
as LoadState<WorkPreferences>,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of WorkPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<WorkPreferences, $Res> get prefs {
  
  return $LoadStateCopyWith<WorkPreferences, $Res>(_self.prefs, (value) {
    return _then(_self.copyWith(prefs: value));
  });
}
}



/// @nodoc


class _WorkPreferencesState extends WorkPreferencesState {
  const _WorkPreferencesState({this.prefs = const LoadState.idle(), this.saveError}): super._();
  

@override@JsonKey() final  LoadState<WorkPreferences> prefs;
@override final  String? saveError;

/// Create a copy of WorkPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkPreferencesStateCopyWith<_WorkPreferencesState> get copyWith => __$WorkPreferencesStateCopyWithImpl<_WorkPreferencesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkPreferencesState&&(identical(other.prefs, prefs) || other.prefs == prefs)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,prefs,saveError);

@override
String toString() {
  return 'WorkPreferencesState(prefs: $prefs, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class _$WorkPreferencesStateCopyWith<$Res> implements $WorkPreferencesStateCopyWith<$Res> {
  factory _$WorkPreferencesStateCopyWith(_WorkPreferencesState value, $Res Function(_WorkPreferencesState) _then) = __$WorkPreferencesStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<WorkPreferences> prefs, String? saveError
});


@override $LoadStateCopyWith<WorkPreferences, $Res> get prefs;

}
/// @nodoc
class __$WorkPreferencesStateCopyWithImpl<$Res>
    implements _$WorkPreferencesStateCopyWith<$Res> {
  __$WorkPreferencesStateCopyWithImpl(this._self, this._then);

  final _WorkPreferencesState _self;
  final $Res Function(_WorkPreferencesState) _then;

/// Create a copy of WorkPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prefs = null,Object? saveError = freezed,}) {
  return _then(_WorkPreferencesState(
prefs: null == prefs ? _self.prefs : prefs // ignore: cast_nullable_to_non_nullable
as LoadState<WorkPreferences>,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of WorkPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<WorkPreferences, $Res> get prefs {
  
  return $LoadStateCopyWith<WorkPreferences, $Res>(_self.prefs, (value) {
    return _then(_self.copyWith(prefs: value));
  });
}
}

// dart format on
