// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applications_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationsState {

 LoadState<List<AstrologerApplication>> get applications;/// The row currently being decided, so only its buttons show a spinner
/// while the rest of the queue stays usable.
 String? get decidingId;/// A decision that failed. Separate from the list's own failure: the queue
/// on screen is still valid, only the action was refused.
 String? get decisionError;
/// Create a copy of ApplicationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationsStateCopyWith<ApplicationsState> get copyWith => _$ApplicationsStateCopyWithImpl<ApplicationsState>(this as ApplicationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationsState&&(identical(other.applications, applications) || other.applications == applications)&&(identical(other.decidingId, decidingId) || other.decidingId == decidingId)&&(identical(other.decisionError, decisionError) || other.decisionError == decisionError));
}


@override
int get hashCode => Object.hash(runtimeType,applications,decidingId,decisionError);

@override
String toString() {
  return 'ApplicationsState(applications: $applications, decidingId: $decidingId, decisionError: $decisionError)';
}


}

/// @nodoc
abstract mixin class $ApplicationsStateCopyWith<$Res>  {
  factory $ApplicationsStateCopyWith(ApplicationsState value, $Res Function(ApplicationsState) _then) = _$ApplicationsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<AstrologerApplication>> applications, String? decidingId, String? decisionError
});


$LoadStateCopyWith<List<AstrologerApplication>, $Res> get applications;

}
/// @nodoc
class _$ApplicationsStateCopyWithImpl<$Res>
    implements $ApplicationsStateCopyWith<$Res> {
  _$ApplicationsStateCopyWithImpl(this._self, this._then);

  final ApplicationsState _self;
  final $Res Function(ApplicationsState) _then;

/// Create a copy of ApplicationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? applications = null,Object? decidingId = freezed,Object? decisionError = freezed,}) {
  return _then(_self.copyWith(
applications: null == applications ? _self.applications : applications // ignore: cast_nullable_to_non_nullable
as LoadState<List<AstrologerApplication>>,decidingId: freezed == decidingId ? _self.decidingId : decidingId // ignore: cast_nullable_to_non_nullable
as String?,decisionError: freezed == decisionError ? _self.decisionError : decisionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ApplicationsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AstrologerApplication>, $Res> get applications {
  
  return $LoadStateCopyWith<List<AstrologerApplication>, $Res>(_self.applications, (value) {
    return _then(_self.copyWith(applications: value));
  });
}
}



/// @nodoc


class _ApplicationsState extends ApplicationsState {
  const _ApplicationsState({this.applications = const LoadState<List<AstrologerApplication>>.idle(), this.decidingId, this.decisionError}): super._();
  

@override@JsonKey() final  LoadState<List<AstrologerApplication>> applications;
/// The row currently being decided, so only its buttons show a spinner
/// while the rest of the queue stays usable.
@override final  String? decidingId;
/// A decision that failed. Separate from the list's own failure: the queue
/// on screen is still valid, only the action was refused.
@override final  String? decisionError;

/// Create a copy of ApplicationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationsStateCopyWith<_ApplicationsState> get copyWith => __$ApplicationsStateCopyWithImpl<_ApplicationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationsState&&(identical(other.applications, applications) || other.applications == applications)&&(identical(other.decidingId, decidingId) || other.decidingId == decidingId)&&(identical(other.decisionError, decisionError) || other.decisionError == decisionError));
}


@override
int get hashCode => Object.hash(runtimeType,applications,decidingId,decisionError);

@override
String toString() {
  return 'ApplicationsState(applications: $applications, decidingId: $decidingId, decisionError: $decisionError)';
}


}

/// @nodoc
abstract mixin class _$ApplicationsStateCopyWith<$Res> implements $ApplicationsStateCopyWith<$Res> {
  factory _$ApplicationsStateCopyWith(_ApplicationsState value, $Res Function(_ApplicationsState) _then) = __$ApplicationsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<AstrologerApplication>> applications, String? decidingId, String? decisionError
});


@override $LoadStateCopyWith<List<AstrologerApplication>, $Res> get applications;

}
/// @nodoc
class __$ApplicationsStateCopyWithImpl<$Res>
    implements _$ApplicationsStateCopyWith<$Res> {
  __$ApplicationsStateCopyWithImpl(this._self, this._then);

  final _ApplicationsState _self;
  final $Res Function(_ApplicationsState) _then;

/// Create a copy of ApplicationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? applications = null,Object? decidingId = freezed,Object? decisionError = freezed,}) {
  return _then(_ApplicationsState(
applications: null == applications ? _self.applications : applications // ignore: cast_nullable_to_non_nullable
as LoadState<List<AstrologerApplication>>,decidingId: freezed == decidingId ? _self.decidingId : decidingId // ignore: cast_nullable_to_non_nullable
as String?,decisionError: freezed == decisionError ? _self.decisionError : decisionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ApplicationsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AstrologerApplication>, $Res> get applications {
  
  return $LoadStateCopyWith<List<AstrologerApplication>, $Res>(_self.applications, (value) {
    return _then(_self.copyWith(applications: value));
  });
}
}

// dart format on
