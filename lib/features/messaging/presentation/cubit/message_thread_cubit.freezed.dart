// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_thread_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageThreadState {

/// Null until the first message creates the conversation.
 String? get threadId; LoadState<MessageThread> get thread; LoadState<List<BusinessMessage>> get messages; String get draft; bool get sending; Failure? get sendFailure;
/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageThreadStateCopyWith<MessageThreadState> get copyWith => _$MessageThreadStateCopyWithImpl<MessageThreadState>(this as MessageThreadState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageThreadState&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.thread, thread) || other.thread == thread)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.sendFailure, sendFailure) || other.sendFailure == sendFailure));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,thread,messages,draft,sending,sendFailure);

@override
String toString() {
  return 'MessageThreadState(threadId: $threadId, thread: $thread, messages: $messages, draft: $draft, sending: $sending, sendFailure: $sendFailure)';
}


}

/// @nodoc
abstract mixin class $MessageThreadStateCopyWith<$Res>  {
  factory $MessageThreadStateCopyWith(MessageThreadState value, $Res Function(MessageThreadState) _then) = _$MessageThreadStateCopyWithImpl;
@useResult
$Res call({
 String? threadId, LoadState<MessageThread> thread, LoadState<List<BusinessMessage>> messages, String draft, bool sending, Failure? sendFailure
});


$LoadStateCopyWith<MessageThread, $Res> get thread;$LoadStateCopyWith<List<BusinessMessage>, $Res> get messages;$FailureCopyWith<$Res>? get sendFailure;

}
/// @nodoc
class _$MessageThreadStateCopyWithImpl<$Res>
    implements $MessageThreadStateCopyWith<$Res> {
  _$MessageThreadStateCopyWithImpl(this._self, this._then);

  final MessageThreadState _self;
  final $Res Function(MessageThreadState) _then;

/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? threadId = freezed,Object? thread = null,Object? messages = null,Object? draft = null,Object? sending = null,Object? sendFailure = freezed,}) {
  return _then(_self.copyWith(
threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,thread: null == thread ? _self.thread : thread // ignore: cast_nullable_to_non_nullable
as LoadState<MessageThread>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as LoadState<List<BusinessMessage>>,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as String,sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool,sendFailure: freezed == sendFailure ? _self.sendFailure : sendFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<MessageThread, $Res> get thread {
  
  return $LoadStateCopyWith<MessageThread, $Res>(_self.thread, (value) {
    return _then(_self.copyWith(thread: value));
  });
}/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BusinessMessage>, $Res> get messages {
  
  return $LoadStateCopyWith<List<BusinessMessage>, $Res>(_self.messages, (value) {
    return _then(_self.copyWith(messages: value));
  });
}/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get sendFailure {
    if (_self.sendFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.sendFailure!, (value) {
    return _then(_self.copyWith(sendFailure: value));
  });
}
}



/// @nodoc


class _MessageThreadState extends MessageThreadState {
  const _MessageThreadState({this.threadId, this.thread = const LoadState<MessageThread>.idle(), this.messages = const LoadState<List<BusinessMessage>>.idle(), this.draft = '', this.sending = false, this.sendFailure}): super._();
  

/// Null until the first message creates the conversation.
@override final  String? threadId;
@override@JsonKey() final  LoadState<MessageThread> thread;
@override@JsonKey() final  LoadState<List<BusinessMessage>> messages;
@override@JsonKey() final  String draft;
@override@JsonKey() final  bool sending;
@override final  Failure? sendFailure;

/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageThreadStateCopyWith<_MessageThreadState> get copyWith => __$MessageThreadStateCopyWithImpl<_MessageThreadState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageThreadState&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.thread, thread) || other.thread == thread)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.sending, sending) || other.sending == sending)&&(identical(other.sendFailure, sendFailure) || other.sendFailure == sendFailure));
}


@override
int get hashCode => Object.hash(runtimeType,threadId,thread,messages,draft,sending,sendFailure);

@override
String toString() {
  return 'MessageThreadState(threadId: $threadId, thread: $thread, messages: $messages, draft: $draft, sending: $sending, sendFailure: $sendFailure)';
}


}

/// @nodoc
abstract mixin class _$MessageThreadStateCopyWith<$Res> implements $MessageThreadStateCopyWith<$Res> {
  factory _$MessageThreadStateCopyWith(_MessageThreadState value, $Res Function(_MessageThreadState) _then) = __$MessageThreadStateCopyWithImpl;
@override @useResult
$Res call({
 String? threadId, LoadState<MessageThread> thread, LoadState<List<BusinessMessage>> messages, String draft, bool sending, Failure? sendFailure
});


@override $LoadStateCopyWith<MessageThread, $Res> get thread;@override $LoadStateCopyWith<List<BusinessMessage>, $Res> get messages;@override $FailureCopyWith<$Res>? get sendFailure;

}
/// @nodoc
class __$MessageThreadStateCopyWithImpl<$Res>
    implements _$MessageThreadStateCopyWith<$Res> {
  __$MessageThreadStateCopyWithImpl(this._self, this._then);

  final _MessageThreadState _self;
  final $Res Function(_MessageThreadState) _then;

/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? threadId = freezed,Object? thread = null,Object? messages = null,Object? draft = null,Object? sending = null,Object? sendFailure = freezed,}) {
  return _then(_MessageThreadState(
threadId: freezed == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String?,thread: null == thread ? _self.thread : thread // ignore: cast_nullable_to_non_nullable
as LoadState<MessageThread>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as LoadState<List<BusinessMessage>>,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as String,sending: null == sending ? _self.sending : sending // ignore: cast_nullable_to_non_nullable
as bool,sendFailure: freezed == sendFailure ? _self.sendFailure : sendFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<MessageThread, $Res> get thread {
  
  return $LoadStateCopyWith<MessageThread, $Res>(_self.thread, (value) {
    return _then(_self.copyWith(thread: value));
  });
}/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BusinessMessage>, $Res> get messages {
  
  return $LoadStateCopyWith<List<BusinessMessage>, $Res>(_self.messages, (value) {
    return _then(_self.copyWith(messages: value));
  });
}/// Create a copy of MessageThreadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get sendFailure {
    if (_self.sendFailure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.sendFailure!, (value) {
    return _then(_self.copyWith(sendFailure: value));
  });
}
}

// dart format on
