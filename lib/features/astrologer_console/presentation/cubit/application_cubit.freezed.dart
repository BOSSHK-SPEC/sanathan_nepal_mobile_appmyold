// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplicationState implements DiagnosticableTreeMixin {

 LoadState<AstrologerApplication> get application; LoadState<AstrologerApplication> get submission; int get stepIndex;/// The document being discarded, while that is in flight.
///
/// Held per kind rather than as a bare flag so only the field being
/// removed shows progress — a spinner over all five would read as the
/// whole step reloading.
 KycDocumentKind? get removingDocument;
/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationStateCopyWith<ApplicationState> get copyWith => _$ApplicationStateCopyWithImpl<ApplicationState>(this as ApplicationState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ApplicationState'))
    ..add(DiagnosticsProperty('application', application))..add(DiagnosticsProperty('submission', submission))..add(DiagnosticsProperty('stepIndex', stepIndex))..add(DiagnosticsProperty('removingDocument', removingDocument));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationState&&(identical(other.application, application) || other.application == application)&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.stepIndex, stepIndex) || other.stepIndex == stepIndex)&&(identical(other.removingDocument, removingDocument) || other.removingDocument == removingDocument));
}


@override
int get hashCode => Object.hash(runtimeType,application,submission,stepIndex,removingDocument);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ApplicationState(application: $application, submission: $submission, stepIndex: $stepIndex, removingDocument: $removingDocument)';
}


}

/// @nodoc
abstract mixin class $ApplicationStateCopyWith<$Res>  {
  factory $ApplicationStateCopyWith(ApplicationState value, $Res Function(ApplicationState) _then) = _$ApplicationStateCopyWithImpl;
@useResult
$Res call({
 LoadState<AstrologerApplication> application, LoadState<AstrologerApplication> submission, int stepIndex, KycDocumentKind? removingDocument
});


$LoadStateCopyWith<AstrologerApplication, $Res> get application;$LoadStateCopyWith<AstrologerApplication, $Res> get submission;

}
/// @nodoc
class _$ApplicationStateCopyWithImpl<$Res>
    implements $ApplicationStateCopyWith<$Res> {
  _$ApplicationStateCopyWithImpl(this._self, this._then);

  final ApplicationState _self;
  final $Res Function(ApplicationState) _then;

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? application = null,Object? submission = null,Object? stepIndex = null,Object? removingDocument = freezed,}) {
  return _then(_self.copyWith(
application: null == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerApplication>,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerApplication>,stepIndex: null == stepIndex ? _self.stepIndex : stepIndex // ignore: cast_nullable_to_non_nullable
as int,removingDocument: freezed == removingDocument ? _self.removingDocument : removingDocument // ignore: cast_nullable_to_non_nullable
as KycDocumentKind?,
  ));
}
/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerApplication, $Res> get application {
  
  return $LoadStateCopyWith<AstrologerApplication, $Res>(_self.application, (value) {
    return _then(_self.copyWith(application: value));
  });
}/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerApplication, $Res> get submission {
  
  return $LoadStateCopyWith<AstrologerApplication, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}



/// @nodoc


class _ApplicationState extends ApplicationState with DiagnosticableTreeMixin {
  const _ApplicationState({this.application = const LoadState.idle(), this.submission = const LoadState.idle(), this.stepIndex = 0, this.removingDocument}): super._();
  

@override@JsonKey() final  LoadState<AstrologerApplication> application;
@override@JsonKey() final  LoadState<AstrologerApplication> submission;
@override@JsonKey() final  int stepIndex;
/// The document being discarded, while that is in flight.
///
/// Held per kind rather than as a bare flag so only the field being
/// removed shows progress — a spinner over all five would read as the
/// whole step reloading.
@override final  KycDocumentKind? removingDocument;

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationStateCopyWith<_ApplicationState> get copyWith => __$ApplicationStateCopyWithImpl<_ApplicationState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ApplicationState'))
    ..add(DiagnosticsProperty('application', application))..add(DiagnosticsProperty('submission', submission))..add(DiagnosticsProperty('stepIndex', stepIndex))..add(DiagnosticsProperty('removingDocument', removingDocument));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationState&&(identical(other.application, application) || other.application == application)&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.stepIndex, stepIndex) || other.stepIndex == stepIndex)&&(identical(other.removingDocument, removingDocument) || other.removingDocument == removingDocument));
}


@override
int get hashCode => Object.hash(runtimeType,application,submission,stepIndex,removingDocument);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ApplicationState(application: $application, submission: $submission, stepIndex: $stepIndex, removingDocument: $removingDocument)';
}


}

/// @nodoc
abstract mixin class _$ApplicationStateCopyWith<$Res> implements $ApplicationStateCopyWith<$Res> {
  factory _$ApplicationStateCopyWith(_ApplicationState value, $Res Function(_ApplicationState) _then) = __$ApplicationStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<AstrologerApplication> application, LoadState<AstrologerApplication> submission, int stepIndex, KycDocumentKind? removingDocument
});


@override $LoadStateCopyWith<AstrologerApplication, $Res> get application;@override $LoadStateCopyWith<AstrologerApplication, $Res> get submission;

}
/// @nodoc
class __$ApplicationStateCopyWithImpl<$Res>
    implements _$ApplicationStateCopyWith<$Res> {
  __$ApplicationStateCopyWithImpl(this._self, this._then);

  final _ApplicationState _self;
  final $Res Function(_ApplicationState) _then;

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? application = null,Object? submission = null,Object? stepIndex = null,Object? removingDocument = freezed,}) {
  return _then(_ApplicationState(
application: null == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerApplication>,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerApplication>,stepIndex: null == stepIndex ? _self.stepIndex : stepIndex // ignore: cast_nullable_to_non_nullable
as int,removingDocument: freezed == removingDocument ? _self.removingDocument : removingDocument // ignore: cast_nullable_to_non_nullable
as KycDocumentKind?,
  ));
}

/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerApplication, $Res> get application {
  
  return $LoadStateCopyWith<AstrologerApplication, $Res>(_self.application, (value) {
    return _then(_self.copyWith(application: value));
  });
}/// Create a copy of ApplicationState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerApplication, $Res> get submission {
  
  return $LoadStateCopyWith<AstrologerApplication, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}

// dart format on
