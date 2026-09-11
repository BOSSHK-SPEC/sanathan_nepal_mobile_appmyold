// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueueEntry {

 String get id; String get seekerName; ConsultChannel get channel; DateTime get joinedAt; String? get seekerAvatar;/// What they typed at intake — the astrologer's only preparation.
 String get question; bool get isRepeatClient;/// Their balance in minutes at the current rate; a one-minute wallet
/// predicts a session that ends before it starts.
 int get affordableMinutes;
/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<QueueEntry> get copyWith => _$QueueEntryCopyWithImpl<QueueEntry>(this as QueueEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.seekerName, seekerName) || other.seekerName == seekerName)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.seekerAvatar, seekerAvatar) || other.seekerAvatar == seekerAvatar)&&(identical(other.question, question) || other.question == question)&&(identical(other.isRepeatClient, isRepeatClient) || other.isRepeatClient == isRepeatClient)&&(identical(other.affordableMinutes, affordableMinutes) || other.affordableMinutes == affordableMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,id,seekerName,channel,joinedAt,seekerAvatar,question,isRepeatClient,affordableMinutes);

@override
String toString() {
  return 'QueueEntry(id: $id, seekerName: $seekerName, channel: $channel, joinedAt: $joinedAt, seekerAvatar: $seekerAvatar, question: $question, isRepeatClient: $isRepeatClient, affordableMinutes: $affordableMinutes)';
}


}

/// @nodoc
abstract mixin class $QueueEntryCopyWith<$Res>  {
  factory $QueueEntryCopyWith(QueueEntry value, $Res Function(QueueEntry) _then) = _$QueueEntryCopyWithImpl;
@useResult
$Res call({
 String id, String seekerName, ConsultChannel channel, DateTime joinedAt, String? seekerAvatar, String question, bool isRepeatClient, int affordableMinutes
});




}
/// @nodoc
class _$QueueEntryCopyWithImpl<$Res>
    implements $QueueEntryCopyWith<$Res> {
  _$QueueEntryCopyWithImpl(this._self, this._then);

  final QueueEntry _self;
  final $Res Function(QueueEntry) _then;

/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? seekerName = null,Object? channel = null,Object? joinedAt = null,Object? seekerAvatar = freezed,Object? question = null,Object? isRepeatClient = null,Object? affordableMinutes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,seekerName: null == seekerName ? _self.seekerName : seekerName // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ConsultChannel,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,seekerAvatar: freezed == seekerAvatar ? _self.seekerAvatar : seekerAvatar // ignore: cast_nullable_to_non_nullable
as String?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,isRepeatClient: null == isRepeatClient ? _self.isRepeatClient : isRepeatClient // ignore: cast_nullable_to_non_nullable
as bool,affordableMinutes: null == affordableMinutes ? _self.affordableMinutes : affordableMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _QueueEntry extends QueueEntry {
  const _QueueEntry({required this.id, required this.seekerName, required this.channel, required this.joinedAt, this.seekerAvatar, this.question = '', this.isRepeatClient = false, this.affordableMinutes = 0}): super._();
  

@override final  String id;
@override final  String seekerName;
@override final  ConsultChannel channel;
@override final  DateTime joinedAt;
@override final  String? seekerAvatar;
/// What they typed at intake — the astrologer's only preparation.
@override@JsonKey() final  String question;
@override@JsonKey() final  bool isRepeatClient;
/// Their balance in minutes at the current rate; a one-minute wallet
/// predicts a session that ends before it starts.
@override@JsonKey() final  int affordableMinutes;

/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueEntryCopyWith<_QueueEntry> get copyWith => __$QueueEntryCopyWithImpl<_QueueEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.seekerName, seekerName) || other.seekerName == seekerName)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.seekerAvatar, seekerAvatar) || other.seekerAvatar == seekerAvatar)&&(identical(other.question, question) || other.question == question)&&(identical(other.isRepeatClient, isRepeatClient) || other.isRepeatClient == isRepeatClient)&&(identical(other.affordableMinutes, affordableMinutes) || other.affordableMinutes == affordableMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,id,seekerName,channel,joinedAt,seekerAvatar,question,isRepeatClient,affordableMinutes);

@override
String toString() {
  return 'QueueEntry(id: $id, seekerName: $seekerName, channel: $channel, joinedAt: $joinedAt, seekerAvatar: $seekerAvatar, question: $question, isRepeatClient: $isRepeatClient, affordableMinutes: $affordableMinutes)';
}


}

/// @nodoc
abstract mixin class _$QueueEntryCopyWith<$Res> implements $QueueEntryCopyWith<$Res> {
  factory _$QueueEntryCopyWith(_QueueEntry value, $Res Function(_QueueEntry) _then) = __$QueueEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String seekerName, ConsultChannel channel, DateTime joinedAt, String? seekerAvatar, String question, bool isRepeatClient, int affordableMinutes
});




}
/// @nodoc
class __$QueueEntryCopyWithImpl<$Res>
    implements _$QueueEntryCopyWith<$Res> {
  __$QueueEntryCopyWithImpl(this._self, this._then);

  final _QueueEntry _self;
  final $Res Function(_QueueEntry) _then;

/// Create a copy of QueueEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? seekerName = null,Object? channel = null,Object? joinedAt = null,Object? seekerAvatar = freezed,Object? question = null,Object? isRepeatClient = null,Object? affordableMinutes = null,}) {
  return _then(_QueueEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,seekerName: null == seekerName ? _self.seekerName : seekerName // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ConsultChannel,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,seekerAvatar: freezed == seekerAvatar ? _self.seekerAvatar : seekerAvatar // ignore: cast_nullable_to_non_nullable
as String?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,isRepeatClient: null == isRepeatClient ? _self.isRepeatClient : isRepeatClient // ignore: cast_nullable_to_non_nullable
as bool,affordableMinutes: null == affordableMinutes ? _self.affordableMinutes : affordableMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$IncomingRequest {

 QueueEntry get entry; DateTime get offeredAt;/// Seconds to respond before it rolls to the next astrologer.
 int get timeoutSeconds;
/// Create a copy of IncomingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomingRequestCopyWith<IncomingRequest> get copyWith => _$IncomingRequestCopyWithImpl<IncomingRequest>(this as IncomingRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomingRequest&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.offeredAt, offeredAt) || other.offeredAt == offeredAt)&&(identical(other.timeoutSeconds, timeoutSeconds) || other.timeoutSeconds == timeoutSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,entry,offeredAt,timeoutSeconds);

@override
String toString() {
  return 'IncomingRequest(entry: $entry, offeredAt: $offeredAt, timeoutSeconds: $timeoutSeconds)';
}


}

/// @nodoc
abstract mixin class $IncomingRequestCopyWith<$Res>  {
  factory $IncomingRequestCopyWith(IncomingRequest value, $Res Function(IncomingRequest) _then) = _$IncomingRequestCopyWithImpl;
@useResult
$Res call({
 QueueEntry entry, DateTime offeredAt, int timeoutSeconds
});


$QueueEntryCopyWith<$Res> get entry;

}
/// @nodoc
class _$IncomingRequestCopyWithImpl<$Res>
    implements $IncomingRequestCopyWith<$Res> {
  _$IncomingRequestCopyWithImpl(this._self, this._then);

  final IncomingRequest _self;
  final $Res Function(IncomingRequest) _then;

/// Create a copy of IncomingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entry = null,Object? offeredAt = null,Object? timeoutSeconds = null,}) {
  return _then(_self.copyWith(
entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as QueueEntry,offeredAt: null == offeredAt ? _self.offeredAt : offeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeoutSeconds: null == timeoutSeconds ? _self.timeoutSeconds : timeoutSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of IncomingRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<$Res> get entry {
  
  return $QueueEntryCopyWith<$Res>(_self.entry, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}



/// @nodoc


class _IncomingRequest extends IncomingRequest {
  const _IncomingRequest({required this.entry, required this.offeredAt, this.timeoutSeconds = 30}): super._();
  

@override final  QueueEntry entry;
@override final  DateTime offeredAt;
/// Seconds to respond before it rolls to the next astrologer.
@override@JsonKey() final  int timeoutSeconds;

/// Create a copy of IncomingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomingRequestCopyWith<_IncomingRequest> get copyWith => __$IncomingRequestCopyWithImpl<_IncomingRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomingRequest&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.offeredAt, offeredAt) || other.offeredAt == offeredAt)&&(identical(other.timeoutSeconds, timeoutSeconds) || other.timeoutSeconds == timeoutSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,entry,offeredAt,timeoutSeconds);

@override
String toString() {
  return 'IncomingRequest(entry: $entry, offeredAt: $offeredAt, timeoutSeconds: $timeoutSeconds)';
}


}

/// @nodoc
abstract mixin class _$IncomingRequestCopyWith<$Res> implements $IncomingRequestCopyWith<$Res> {
  factory _$IncomingRequestCopyWith(_IncomingRequest value, $Res Function(_IncomingRequest) _then) = __$IncomingRequestCopyWithImpl;
@override @useResult
$Res call({
 QueueEntry entry, DateTime offeredAt, int timeoutSeconds
});


@override $QueueEntryCopyWith<$Res> get entry;

}
/// @nodoc
class __$IncomingRequestCopyWithImpl<$Res>
    implements _$IncomingRequestCopyWith<$Res> {
  __$IncomingRequestCopyWithImpl(this._self, this._then);

  final _IncomingRequest _self;
  final $Res Function(_IncomingRequest) _then;

/// Create a copy of IncomingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entry = null,Object? offeredAt = null,Object? timeoutSeconds = null,}) {
  return _then(_IncomingRequest(
entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as QueueEntry,offeredAt: null == offeredAt ? _self.offeredAt : offeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeoutSeconds: null == timeoutSeconds ? _self.timeoutSeconds : timeoutSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of IncomingRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueEntryCopyWith<$Res> get entry {
  
  return $QueueEntryCopyWith<$Res>(_self.entry, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}

// dart format on
