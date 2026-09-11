// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueueAcceptRequest {

 String get queueEntryId; String get seekerName; ConsultChannel get channel; double get ratePerMinute; String get question;/// Birth details the seeker gave at intake, shown in the console's side
/// panel so the astrologer does not have to ask again.
 String? get birthDetails;
/// Create a copy of QueueAcceptRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueAcceptRequestCopyWith<QueueAcceptRequest> get copyWith => _$QueueAcceptRequestCopyWithImpl<QueueAcceptRequest>(this as QueueAcceptRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueAcceptRequest&&(identical(other.queueEntryId, queueEntryId) || other.queueEntryId == queueEntryId)&&(identical(other.seekerName, seekerName) || other.seekerName == seekerName)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.ratePerMinute, ratePerMinute) || other.ratePerMinute == ratePerMinute)&&(identical(other.question, question) || other.question == question)&&(identical(other.birthDetails, birthDetails) || other.birthDetails == birthDetails));
}


@override
int get hashCode => Object.hash(runtimeType,queueEntryId,seekerName,channel,ratePerMinute,question,birthDetails);

@override
String toString() {
  return 'QueueAcceptRequest(queueEntryId: $queueEntryId, seekerName: $seekerName, channel: $channel, ratePerMinute: $ratePerMinute, question: $question, birthDetails: $birthDetails)';
}


}

/// @nodoc
abstract mixin class $QueueAcceptRequestCopyWith<$Res>  {
  factory $QueueAcceptRequestCopyWith(QueueAcceptRequest value, $Res Function(QueueAcceptRequest) _then) = _$QueueAcceptRequestCopyWithImpl;
@useResult
$Res call({
 String queueEntryId, String seekerName, ConsultChannel channel, double ratePerMinute, String question, String? birthDetails
});




}
/// @nodoc
class _$QueueAcceptRequestCopyWithImpl<$Res>
    implements $QueueAcceptRequestCopyWith<$Res> {
  _$QueueAcceptRequestCopyWithImpl(this._self, this._then);

  final QueueAcceptRequest _self;
  final $Res Function(QueueAcceptRequest) _then;

/// Create a copy of QueueAcceptRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? queueEntryId = null,Object? seekerName = null,Object? channel = null,Object? ratePerMinute = null,Object? question = null,Object? birthDetails = freezed,}) {
  return _then(_self.copyWith(
queueEntryId: null == queueEntryId ? _self.queueEntryId : queueEntryId // ignore: cast_nullable_to_non_nullable
as String,seekerName: null == seekerName ? _self.seekerName : seekerName // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ConsultChannel,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as double,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,birthDetails: freezed == birthDetails ? _self.birthDetails : birthDetails // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _QueueAcceptRequest implements QueueAcceptRequest {
  const _QueueAcceptRequest({required this.queueEntryId, required this.seekerName, required this.channel, required this.ratePerMinute, this.question = '', this.birthDetails});
  

@override final  String queueEntryId;
@override final  String seekerName;
@override final  ConsultChannel channel;
@override final  double ratePerMinute;
@override@JsonKey() final  String question;
/// Birth details the seeker gave at intake, shown in the console's side
/// panel so the astrologer does not have to ask again.
@override final  String? birthDetails;

/// Create a copy of QueueAcceptRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueAcceptRequestCopyWith<_QueueAcceptRequest> get copyWith => __$QueueAcceptRequestCopyWithImpl<_QueueAcceptRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueAcceptRequest&&(identical(other.queueEntryId, queueEntryId) || other.queueEntryId == queueEntryId)&&(identical(other.seekerName, seekerName) || other.seekerName == seekerName)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.ratePerMinute, ratePerMinute) || other.ratePerMinute == ratePerMinute)&&(identical(other.question, question) || other.question == question)&&(identical(other.birthDetails, birthDetails) || other.birthDetails == birthDetails));
}


@override
int get hashCode => Object.hash(runtimeType,queueEntryId,seekerName,channel,ratePerMinute,question,birthDetails);

@override
String toString() {
  return 'QueueAcceptRequest(queueEntryId: $queueEntryId, seekerName: $seekerName, channel: $channel, ratePerMinute: $ratePerMinute, question: $question, birthDetails: $birthDetails)';
}


}

/// @nodoc
abstract mixin class _$QueueAcceptRequestCopyWith<$Res> implements $QueueAcceptRequestCopyWith<$Res> {
  factory _$QueueAcceptRequestCopyWith(_QueueAcceptRequest value, $Res Function(_QueueAcceptRequest) _then) = __$QueueAcceptRequestCopyWithImpl;
@override @useResult
$Res call({
 String queueEntryId, String seekerName, ConsultChannel channel, double ratePerMinute, String question, String? birthDetails
});




}
/// @nodoc
class __$QueueAcceptRequestCopyWithImpl<$Res>
    implements _$QueueAcceptRequestCopyWith<$Res> {
  __$QueueAcceptRequestCopyWithImpl(this._self, this._then);

  final _QueueAcceptRequest _self;
  final $Res Function(_QueueAcceptRequest) _then;

/// Create a copy of QueueAcceptRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? queueEntryId = null,Object? seekerName = null,Object? channel = null,Object? ratePerMinute = null,Object? question = null,Object? birthDetails = freezed,}) {
  return _then(_QueueAcceptRequest(
queueEntryId: null == queueEntryId ? _self.queueEntryId : queueEntryId // ignore: cast_nullable_to_non_nullable
as String,seekerName: null == seekerName ? _self.seekerName : seekerName // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ConsultChannel,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as double,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,birthDetails: freezed == birthDetails ? _self.birthDetails : birthDetails // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SessionNotesDraft {

 String get consultationId; String get notes; List<Remedy> get remedies;
/// Create a copy of SessionNotesDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionNotesDraftCopyWith<SessionNotesDraft> get copyWith => _$SessionNotesDraftCopyWithImpl<SessionNotesDraft>(this as SessionNotesDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionNotesDraft&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.remedies, remedies));
}


@override
int get hashCode => Object.hash(runtimeType,consultationId,notes,const DeepCollectionEquality().hash(remedies));

@override
String toString() {
  return 'SessionNotesDraft(consultationId: $consultationId, notes: $notes, remedies: $remedies)';
}


}

/// @nodoc
abstract mixin class $SessionNotesDraftCopyWith<$Res>  {
  factory $SessionNotesDraftCopyWith(SessionNotesDraft value, $Res Function(SessionNotesDraft) _then) = _$SessionNotesDraftCopyWithImpl;
@useResult
$Res call({
 String consultationId, String notes, List<Remedy> remedies
});




}
/// @nodoc
class _$SessionNotesDraftCopyWithImpl<$Res>
    implements $SessionNotesDraftCopyWith<$Res> {
  _$SessionNotesDraftCopyWithImpl(this._self, this._then);

  final SessionNotesDraft _self;
  final $Res Function(SessionNotesDraft) _then;

/// Create a copy of SessionNotesDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? consultationId = null,Object? notes = null,Object? remedies = null,}) {
  return _then(_self.copyWith(
consultationId: null == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,remedies: null == remedies ? _self.remedies : remedies // ignore: cast_nullable_to_non_nullable
as List<Remedy>,
  ));
}

}



/// @nodoc


class _SessionNotesDraft extends SessionNotesDraft {
  const _SessionNotesDraft({required this.consultationId, this.notes = '', final  List<Remedy> remedies = const <Remedy>[]}): _remedies = remedies,super._();
  

@override final  String consultationId;
@override@JsonKey() final  String notes;
 final  List<Remedy> _remedies;
@override@JsonKey() List<Remedy> get remedies {
  if (_remedies is EqualUnmodifiableListView) return _remedies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_remedies);
}


/// Create a copy of SessionNotesDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionNotesDraftCopyWith<_SessionNotesDraft> get copyWith => __$SessionNotesDraftCopyWithImpl<_SessionNotesDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionNotesDraft&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._remedies, _remedies));
}


@override
int get hashCode => Object.hash(runtimeType,consultationId,notes,const DeepCollectionEquality().hash(_remedies));

@override
String toString() {
  return 'SessionNotesDraft(consultationId: $consultationId, notes: $notes, remedies: $remedies)';
}


}

/// @nodoc
abstract mixin class _$SessionNotesDraftCopyWith<$Res> implements $SessionNotesDraftCopyWith<$Res> {
  factory _$SessionNotesDraftCopyWith(_SessionNotesDraft value, $Res Function(_SessionNotesDraft) _then) = __$SessionNotesDraftCopyWithImpl;
@override @useResult
$Res call({
 String consultationId, String notes, List<Remedy> remedies
});




}
/// @nodoc
class __$SessionNotesDraftCopyWithImpl<$Res>
    implements _$SessionNotesDraftCopyWith<$Res> {
  __$SessionNotesDraftCopyWithImpl(this._self, this._then);

  final _SessionNotesDraft _self;
  final $Res Function(_SessionNotesDraft) _then;

/// Create a copy of SessionNotesDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? consultationId = null,Object? notes = null,Object? remedies = null,}) {
  return _then(_SessionNotesDraft(
consultationId: null == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,remedies: null == remedies ? _self._remedies : remedies // ignore: cast_nullable_to_non_nullable
as List<Remedy>,
  ));
}


}

// dart format on
