// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moderation_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ModerationState {

 bool get showResolved; LoadState<List<AbuseReport>> get reports; String? get resolvingId; String? get actionError;
/// Create a copy of ModerationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModerationStateCopyWith<ModerationState> get copyWith => _$ModerationStateCopyWithImpl<ModerationState>(this as ModerationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModerationState&&(identical(other.showResolved, showResolved) || other.showResolved == showResolved)&&(identical(other.reports, reports) || other.reports == reports)&&(identical(other.resolvingId, resolvingId) || other.resolvingId == resolvingId)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,showResolved,reports,resolvingId,actionError);

@override
String toString() {
  return 'ModerationState(showResolved: $showResolved, reports: $reports, resolvingId: $resolvingId, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $ModerationStateCopyWith<$Res>  {
  factory $ModerationStateCopyWith(ModerationState value, $Res Function(ModerationState) _then) = _$ModerationStateCopyWithImpl;
@useResult
$Res call({
 bool showResolved, LoadState<List<AbuseReport>> reports, String? resolvingId, String? actionError
});


$LoadStateCopyWith<List<AbuseReport>, $Res> get reports;

}
/// @nodoc
class _$ModerationStateCopyWithImpl<$Res>
    implements $ModerationStateCopyWith<$Res> {
  _$ModerationStateCopyWithImpl(this._self, this._then);

  final ModerationState _self;
  final $Res Function(ModerationState) _then;

/// Create a copy of ModerationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showResolved = null,Object? reports = null,Object? resolvingId = freezed,Object? actionError = freezed,}) {
  return _then(_self.copyWith(
showResolved: null == showResolved ? _self.showResolved : showResolved // ignore: cast_nullable_to_non_nullable
as bool,reports: null == reports ? _self.reports : reports // ignore: cast_nullable_to_non_nullable
as LoadState<List<AbuseReport>>,resolvingId: freezed == resolvingId ? _self.resolvingId : resolvingId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ModerationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AbuseReport>, $Res> get reports {
  
  return $LoadStateCopyWith<List<AbuseReport>, $Res>(_self.reports, (value) {
    return _then(_self.copyWith(reports: value));
  });
}
}



/// @nodoc


class _ModerationState extends ModerationState {
  const _ModerationState({this.showResolved = false, this.reports = const LoadState<List<AbuseReport>>.idle(), this.resolvingId, this.actionError}): super._();
  

@override@JsonKey() final  bool showResolved;
@override@JsonKey() final  LoadState<List<AbuseReport>> reports;
@override final  String? resolvingId;
@override final  String? actionError;

/// Create a copy of ModerationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModerationStateCopyWith<_ModerationState> get copyWith => __$ModerationStateCopyWithImpl<_ModerationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModerationState&&(identical(other.showResolved, showResolved) || other.showResolved == showResolved)&&(identical(other.reports, reports) || other.reports == reports)&&(identical(other.resolvingId, resolvingId) || other.resolvingId == resolvingId)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,showResolved,reports,resolvingId,actionError);

@override
String toString() {
  return 'ModerationState(showResolved: $showResolved, reports: $reports, resolvingId: $resolvingId, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class _$ModerationStateCopyWith<$Res> implements $ModerationStateCopyWith<$Res> {
  factory _$ModerationStateCopyWith(_ModerationState value, $Res Function(_ModerationState) _then) = __$ModerationStateCopyWithImpl;
@override @useResult
$Res call({
 bool showResolved, LoadState<List<AbuseReport>> reports, String? resolvingId, String? actionError
});


@override $LoadStateCopyWith<List<AbuseReport>, $Res> get reports;

}
/// @nodoc
class __$ModerationStateCopyWithImpl<$Res>
    implements _$ModerationStateCopyWith<$Res> {
  __$ModerationStateCopyWithImpl(this._self, this._then);

  final _ModerationState _self;
  final $Res Function(_ModerationState) _then;

/// Create a copy of ModerationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showResolved = null,Object? reports = null,Object? resolvingId = freezed,Object? actionError = freezed,}) {
  return _then(_ModerationState(
showResolved: null == showResolved ? _self.showResolved : showResolved // ignore: cast_nullable_to_non_nullable
as bool,reports: null == reports ? _self.reports : reports // ignore: cast_nullable_to_non_nullable
as LoadState<List<AbuseReport>>,resolvingId: freezed == resolvingId ? _self.resolvingId : resolvingId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ModerationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AbuseReport>, $Res> get reports {
  
  return $LoadStateCopyWith<List<AbuseReport>, $Res>(_self.reports, (value) {
    return _then(_self.copyWith(reports: value));
  });
}
}

// dart format on
