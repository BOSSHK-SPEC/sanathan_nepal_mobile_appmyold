// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ComplianceState {

 LoadState<List<ComplianceNotice>> get notices;/// The notice a request is in flight for, so only its row shows a spinner.
 String? get busyNoticeId; String? get actionError;
/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceStateCopyWith<ComplianceState> get copyWith => _$ComplianceStateCopyWithImpl<ComplianceState>(this as ComplianceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceState&&(identical(other.notices, notices) || other.notices == notices)&&(identical(other.busyNoticeId, busyNoticeId) || other.busyNoticeId == busyNoticeId)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,notices,busyNoticeId,actionError);

@override
String toString() {
  return 'ComplianceState(notices: $notices, busyNoticeId: $busyNoticeId, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $ComplianceStateCopyWith<$Res>  {
  factory $ComplianceStateCopyWith(ComplianceState value, $Res Function(ComplianceState) _then) = _$ComplianceStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<ComplianceNotice>> notices, String? busyNoticeId, String? actionError
});


$LoadStateCopyWith<List<ComplianceNotice>, $Res> get notices;

}
/// @nodoc
class _$ComplianceStateCopyWithImpl<$Res>
    implements $ComplianceStateCopyWith<$Res> {
  _$ComplianceStateCopyWithImpl(this._self, this._then);

  final ComplianceState _self;
  final $Res Function(ComplianceState) _then;

/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notices = null,Object? busyNoticeId = freezed,Object? actionError = freezed,}) {
  return _then(_self.copyWith(
notices: null == notices ? _self.notices : notices // ignore: cast_nullable_to_non_nullable
as LoadState<List<ComplianceNotice>>,busyNoticeId: freezed == busyNoticeId ? _self.busyNoticeId : busyNoticeId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ComplianceNotice>, $Res> get notices {
  
  return $LoadStateCopyWith<List<ComplianceNotice>, $Res>(_self.notices, (value) {
    return _then(_self.copyWith(notices: value));
  });
}
}



/// @nodoc


class _ComplianceState extends ComplianceState {
  const _ComplianceState({this.notices = const LoadState.idle(), this.busyNoticeId, this.actionError}): super._();
  

@override@JsonKey() final  LoadState<List<ComplianceNotice>> notices;
/// The notice a request is in flight for, so only its row shows a spinner.
@override final  String? busyNoticeId;
@override final  String? actionError;

/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplianceStateCopyWith<_ComplianceState> get copyWith => __$ComplianceStateCopyWithImpl<_ComplianceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceState&&(identical(other.notices, notices) || other.notices == notices)&&(identical(other.busyNoticeId, busyNoticeId) || other.busyNoticeId == busyNoticeId)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,notices,busyNoticeId,actionError);

@override
String toString() {
  return 'ComplianceState(notices: $notices, busyNoticeId: $busyNoticeId, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class _$ComplianceStateCopyWith<$Res> implements $ComplianceStateCopyWith<$Res> {
  factory _$ComplianceStateCopyWith(_ComplianceState value, $Res Function(_ComplianceState) _then) = __$ComplianceStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<ComplianceNotice>> notices, String? busyNoticeId, String? actionError
});


@override $LoadStateCopyWith<List<ComplianceNotice>, $Res> get notices;

}
/// @nodoc
class __$ComplianceStateCopyWithImpl<$Res>
    implements _$ComplianceStateCopyWith<$Res> {
  __$ComplianceStateCopyWithImpl(this._self, this._then);

  final _ComplianceState _self;
  final $Res Function(_ComplianceState) _then;

/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notices = null,Object? busyNoticeId = freezed,Object? actionError = freezed,}) {
  return _then(_ComplianceState(
notices: null == notices ? _self.notices : notices // ignore: cast_nullable_to_non_nullable
as LoadState<List<ComplianceNotice>>,busyNoticeId: freezed == busyNoticeId ? _self.busyNoticeId : busyNoticeId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ComplianceNotice>, $Res> get notices {
  
  return $LoadStateCopyWith<List<ComplianceNotice>, $Res>(_self.notices, (value) {
    return _then(_self.copyWith(notices: value));
  });
}
}

// dart format on
