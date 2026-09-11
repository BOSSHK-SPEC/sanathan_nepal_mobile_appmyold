// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusinessMessage {

 String get id; String get threadId; MessageSide get sender; DateTime get sentAt; String get body; MessageDelivery get delivery;
/// Create a copy of BusinessMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessMessageCopyWith<BusinessMessage> get copyWith => _$BusinessMessageCopyWithImpl<BusinessMessage>(this as BusinessMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.body, body) || other.body == body)&&(identical(other.delivery, delivery) || other.delivery == delivery));
}


@override
int get hashCode => Object.hash(runtimeType,id,threadId,sender,sentAt,body,delivery);

@override
String toString() {
  return 'BusinessMessage(id: $id, threadId: $threadId, sender: $sender, sentAt: $sentAt, body: $body, delivery: $delivery)';
}


}

/// @nodoc
abstract mixin class $BusinessMessageCopyWith<$Res>  {
  factory $BusinessMessageCopyWith(BusinessMessage value, $Res Function(BusinessMessage) _then) = _$BusinessMessageCopyWithImpl;
@useResult
$Res call({
 String id, String threadId, MessageSide sender, DateTime sentAt, String body, MessageDelivery delivery
});




}
/// @nodoc
class _$BusinessMessageCopyWithImpl<$Res>
    implements $BusinessMessageCopyWith<$Res> {
  _$BusinessMessageCopyWithImpl(this._self, this._then);

  final BusinessMessage _self;
  final $Res Function(BusinessMessage) _then;

/// Create a copy of BusinessMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? threadId = null,Object? sender = null,Object? sentAt = null,Object? body = null,Object? delivery = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSide,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as MessageDelivery,
  ));
}

}



/// @nodoc


class _BusinessMessage extends BusinessMessage {
  const _BusinessMessage({required this.id, required this.threadId, required this.sender, required this.sentAt, this.body = '', this.delivery = MessageDelivery.sent}): super._();
  

@override final  String id;
@override final  String threadId;
@override final  MessageSide sender;
@override final  DateTime sentAt;
@override@JsonKey() final  String body;
@override@JsonKey() final  MessageDelivery delivery;

/// Create a copy of BusinessMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessMessageCopyWith<_BusinessMessage> get copyWith => __$BusinessMessageCopyWithImpl<_BusinessMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.body, body) || other.body == body)&&(identical(other.delivery, delivery) || other.delivery == delivery));
}


@override
int get hashCode => Object.hash(runtimeType,id,threadId,sender,sentAt,body,delivery);

@override
String toString() {
  return 'BusinessMessage(id: $id, threadId: $threadId, sender: $sender, sentAt: $sentAt, body: $body, delivery: $delivery)';
}


}

/// @nodoc
abstract mixin class _$BusinessMessageCopyWith<$Res> implements $BusinessMessageCopyWith<$Res> {
  factory _$BusinessMessageCopyWith(_BusinessMessage value, $Res Function(_BusinessMessage) _then) = __$BusinessMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String threadId, MessageSide sender, DateTime sentAt, String body, MessageDelivery delivery
});




}
/// @nodoc
class __$BusinessMessageCopyWithImpl<$Res>
    implements _$BusinessMessageCopyWith<$Res> {
  __$BusinessMessageCopyWithImpl(this._self, this._then);

  final _BusinessMessage _self;
  final $Res Function(_BusinessMessage) _then;

/// Create a copy of BusinessMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? threadId = null,Object? sender = null,Object? sentAt = null,Object? body = null,Object? delivery = null,}) {
  return _then(_BusinessMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSide,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,delivery: null == delivery ? _self.delivery : delivery // ignore: cast_nullable_to_non_nullable
as MessageDelivery,
  ));
}


}

// dart format on
