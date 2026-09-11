// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessMessageModel {

 String get id; String get threadId; DateTime get sentAt; MessageSide get sender; String get body; bool get read;
/// Create a copy of BusinessMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessMessageModelCopyWith<BusinessMessageModel> get copyWith => _$BusinessMessageModelCopyWithImpl<BusinessMessageModel>(this as BusinessMessageModel, _$identity);

  /// Serializes this BusinessMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.body, body) || other.body == body)&&(identical(other.read, read) || other.read == read));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,threadId,sentAt,sender,body,read);

@override
String toString() {
  return 'BusinessMessageModel(id: $id, threadId: $threadId, sentAt: $sentAt, sender: $sender, body: $body, read: $read)';
}


}

/// @nodoc
abstract mixin class $BusinessMessageModelCopyWith<$Res>  {
  factory $BusinessMessageModelCopyWith(BusinessMessageModel value, $Res Function(BusinessMessageModel) _then) = _$BusinessMessageModelCopyWithImpl;
@useResult
$Res call({
 String id, String threadId, DateTime sentAt, MessageSide sender, String body, bool read
});




}
/// @nodoc
class _$BusinessMessageModelCopyWithImpl<$Res>
    implements $BusinessMessageModelCopyWith<$Res> {
  _$BusinessMessageModelCopyWithImpl(this._self, this._then);

  final BusinessMessageModel _self;
  final $Res Function(BusinessMessageModel) _then;

/// Create a copy of BusinessMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? threadId = null,Object? sentAt = null,Object? sender = null,Object? body = null,Object? read = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSide,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _BusinessMessageModel extends BusinessMessageModel {
  const _BusinessMessageModel({required this.id, required this.threadId, required this.sentAt, this.sender = MessageSide.customer, this.body = '', this.read = false}): super._();
  factory _BusinessMessageModel.fromJson(Map<String, dynamic> json) => _$BusinessMessageModelFromJson(json);

@override final  String id;
@override final  String threadId;
@override final  DateTime sentAt;
@override@JsonKey() final  MessageSide sender;
@override@JsonKey() final  String body;
@override@JsonKey() final  bool read;

/// Create a copy of BusinessMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessMessageModelCopyWith<_BusinessMessageModel> get copyWith => __$BusinessMessageModelCopyWithImpl<_BusinessMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.body, body) || other.body == body)&&(identical(other.read, read) || other.read == read));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,threadId,sentAt,sender,body,read);

@override
String toString() {
  return 'BusinessMessageModel(id: $id, threadId: $threadId, sentAt: $sentAt, sender: $sender, body: $body, read: $read)';
}


}

/// @nodoc
abstract mixin class _$BusinessMessageModelCopyWith<$Res> implements $BusinessMessageModelCopyWith<$Res> {
  factory _$BusinessMessageModelCopyWith(_BusinessMessageModel value, $Res Function(_BusinessMessageModel) _then) = __$BusinessMessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String threadId, DateTime sentAt, MessageSide sender, String body, bool read
});




}
/// @nodoc
class __$BusinessMessageModelCopyWithImpl<$Res>
    implements _$BusinessMessageModelCopyWith<$Res> {
  __$BusinessMessageModelCopyWithImpl(this._self, this._then);

  final _BusinessMessageModel _self;
  final $Res Function(_BusinessMessageModel) _then;

/// Create a copy of BusinessMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? threadId = null,Object? sentAt = null,Object? sender = null,Object? body = null,Object? read = null,}) {
  return _then(_BusinessMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSide,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
