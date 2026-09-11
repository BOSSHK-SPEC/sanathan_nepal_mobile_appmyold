// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatMessage {

 String get id; String get consultationId; ChatSender get sender; DateTime get sentAt; MessageKind get kind; String get text; MessageStatus get status;/// Asset path or URL for [MessageKind.image] / [MessageKind.chart].
 String? get attachment;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.text, text) || other.text == text)&&(identical(other.status, status) || other.status == status)&&(identical(other.attachment, attachment) || other.attachment == attachment));
}


@override
int get hashCode => Object.hash(runtimeType,id,consultationId,sender,sentAt,kind,text,status,attachment);

@override
String toString() {
  return 'ChatMessage(id: $id, consultationId: $consultationId, sender: $sender, sentAt: $sentAt, kind: $kind, text: $text, status: $status, attachment: $attachment)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, String consultationId, ChatSender sender, DateTime sentAt, MessageKind kind, String text, MessageStatus status, String? attachment
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? consultationId = null,Object? sender = null,Object? sentAt = null,Object? kind = null,Object? text = null,Object? status = null,Object? attachment = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,consultationId: null == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as ChatSender,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MessageKind,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,attachment: freezed == attachment ? _self.attachment : attachment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _ChatMessage extends ChatMessage {
  const _ChatMessage({required this.id, required this.consultationId, required this.sender, required this.sentAt, this.kind = MessageKind.text, this.text = '', this.status = MessageStatus.sent, this.attachment}): super._();
  

@override final  String id;
@override final  String consultationId;
@override final  ChatSender sender;
@override final  DateTime sentAt;
@override@JsonKey() final  MessageKind kind;
@override@JsonKey() final  String text;
@override@JsonKey() final  MessageStatus status;
/// Asset path or URL for [MessageKind.image] / [MessageKind.chart].
@override final  String? attachment;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.text, text) || other.text == text)&&(identical(other.status, status) || other.status == status)&&(identical(other.attachment, attachment) || other.attachment == attachment));
}


@override
int get hashCode => Object.hash(runtimeType,id,consultationId,sender,sentAt,kind,text,status,attachment);

@override
String toString() {
  return 'ChatMessage(id: $id, consultationId: $consultationId, sender: $sender, sentAt: $sentAt, kind: $kind, text: $text, status: $status, attachment: $attachment)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String consultationId, ChatSender sender, DateTime sentAt, MessageKind kind, String text, MessageStatus status, String? attachment
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? consultationId = null,Object? sender = null,Object? sentAt = null,Object? kind = null,Object? text = null,Object? status = null,Object? attachment = freezed,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,consultationId: null == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as ChatSender,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MessageKind,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,attachment: freezed == attachment ? _self.attachment : attachment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
