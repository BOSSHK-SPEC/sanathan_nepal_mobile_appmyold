// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_thread_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageThreadModel {

 String get id; String get businessId; DateTime get lastMessageAt; MessageSide get side; String get businessName; String get customerName; String get contactName; String get contactEmail; String get subject; String get lastMessagePreview; int get unreadCount; bool get archived; String? get businessLogoUrl;/// Only the mock keeps the owner's side of the counter — the server hands
/// each caller their own `unreadCount` and never the other side's.
 int get otherSideUnread;
/// Create a copy of MessageThreadModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageThreadModelCopyWith<MessageThreadModel> get copyWith => _$MessageThreadModelCopyWithImpl<MessageThreadModel>(this as MessageThreadModel, _$identity);

  /// Serializes this MessageThreadModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageThreadModel&&(identical(other.id, id) || other.id == id)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.side, side) || other.side == side)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.businessLogoUrl, businessLogoUrl) || other.businessLogoUrl == businessLogoUrl)&&(identical(other.otherSideUnread, otherSideUnread) || other.otherSideUnread == otherSideUnread));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessId,lastMessageAt,side,businessName,customerName,contactName,contactEmail,subject,lastMessagePreview,unreadCount,archived,businessLogoUrl,otherSideUnread);

@override
String toString() {
  return 'MessageThreadModel(id: $id, businessId: $businessId, lastMessageAt: $lastMessageAt, side: $side, businessName: $businessName, customerName: $customerName, contactName: $contactName, contactEmail: $contactEmail, subject: $subject, lastMessagePreview: $lastMessagePreview, unreadCount: $unreadCount, archived: $archived, businessLogoUrl: $businessLogoUrl, otherSideUnread: $otherSideUnread)';
}


}

/// @nodoc
abstract mixin class $MessageThreadModelCopyWith<$Res>  {
  factory $MessageThreadModelCopyWith(MessageThreadModel value, $Res Function(MessageThreadModel) _then) = _$MessageThreadModelCopyWithImpl;
@useResult
$Res call({
 String id, String businessId, DateTime lastMessageAt, MessageSide side, String businessName, String customerName, String contactName, String contactEmail, String subject, String lastMessagePreview, int unreadCount, bool archived, String? businessLogoUrl, int otherSideUnread
});




}
/// @nodoc
class _$MessageThreadModelCopyWithImpl<$Res>
    implements $MessageThreadModelCopyWith<$Res> {
  _$MessageThreadModelCopyWithImpl(this._self, this._then);

  final MessageThreadModel _self;
  final $Res Function(MessageThreadModel) _then;

/// Create a copy of MessageThreadModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? businessId = null,Object? lastMessageAt = null,Object? side = null,Object? businessName = null,Object? customerName = null,Object? contactName = null,Object? contactEmail = null,Object? subject = null,Object? lastMessagePreview = null,Object? unreadCount = null,Object? archived = null,Object? businessLogoUrl = freezed,Object? otherSideUnread = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String,lastMessageAt: null == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as MessageSide,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,lastMessagePreview: null == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,businessLogoUrl: freezed == businessLogoUrl ? _self.businessLogoUrl : businessLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,otherSideUnread: null == otherSideUnread ? _self.otherSideUnread : otherSideUnread // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _MessageThreadModel extends MessageThreadModel {
  const _MessageThreadModel({required this.id, required this.businessId, required this.lastMessageAt, this.side = MessageSide.customer, this.businessName = '', this.customerName = '', this.contactName = '', this.contactEmail = '', this.subject = '', this.lastMessagePreview = '', this.unreadCount = 0, this.archived = false, this.businessLogoUrl, this.otherSideUnread = 0}): super._();
  factory _MessageThreadModel.fromJson(Map<String, dynamic> json) => _$MessageThreadModelFromJson(json);

@override final  String id;
@override final  String businessId;
@override final  DateTime lastMessageAt;
@override@JsonKey() final  MessageSide side;
@override@JsonKey() final  String businessName;
@override@JsonKey() final  String customerName;
@override@JsonKey() final  String contactName;
@override@JsonKey() final  String contactEmail;
@override@JsonKey() final  String subject;
@override@JsonKey() final  String lastMessagePreview;
@override@JsonKey() final  int unreadCount;
@override@JsonKey() final  bool archived;
@override final  String? businessLogoUrl;
/// Only the mock keeps the owner's side of the counter — the server hands
/// each caller their own `unreadCount` and never the other side's.
@override@JsonKey() final  int otherSideUnread;

/// Create a copy of MessageThreadModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageThreadModelCopyWith<_MessageThreadModel> get copyWith => __$MessageThreadModelCopyWithImpl<_MessageThreadModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageThreadModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageThreadModel&&(identical(other.id, id) || other.id == id)&&(identical(other.businessId, businessId) || other.businessId == businessId)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.side, side) || other.side == side)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.lastMessagePreview, lastMessagePreview) || other.lastMessagePreview == lastMessagePreview)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.businessLogoUrl, businessLogoUrl) || other.businessLogoUrl == businessLogoUrl)&&(identical(other.otherSideUnread, otherSideUnread) || other.otherSideUnread == otherSideUnread));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessId,lastMessageAt,side,businessName,customerName,contactName,contactEmail,subject,lastMessagePreview,unreadCount,archived,businessLogoUrl,otherSideUnread);

@override
String toString() {
  return 'MessageThreadModel(id: $id, businessId: $businessId, lastMessageAt: $lastMessageAt, side: $side, businessName: $businessName, customerName: $customerName, contactName: $contactName, contactEmail: $contactEmail, subject: $subject, lastMessagePreview: $lastMessagePreview, unreadCount: $unreadCount, archived: $archived, businessLogoUrl: $businessLogoUrl, otherSideUnread: $otherSideUnread)';
}


}

/// @nodoc
abstract mixin class _$MessageThreadModelCopyWith<$Res> implements $MessageThreadModelCopyWith<$Res> {
  factory _$MessageThreadModelCopyWith(_MessageThreadModel value, $Res Function(_MessageThreadModel) _then) = __$MessageThreadModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String businessId, DateTime lastMessageAt, MessageSide side, String businessName, String customerName, String contactName, String contactEmail, String subject, String lastMessagePreview, int unreadCount, bool archived, String? businessLogoUrl, int otherSideUnread
});




}
/// @nodoc
class __$MessageThreadModelCopyWithImpl<$Res>
    implements _$MessageThreadModelCopyWith<$Res> {
  __$MessageThreadModelCopyWithImpl(this._self, this._then);

  final _MessageThreadModel _self;
  final $Res Function(_MessageThreadModel) _then;

/// Create a copy of MessageThreadModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? businessId = null,Object? lastMessageAt = null,Object? side = null,Object? businessName = null,Object? customerName = null,Object? contactName = null,Object? contactEmail = null,Object? subject = null,Object? lastMessagePreview = null,Object? unreadCount = null,Object? archived = null,Object? businessLogoUrl = freezed,Object? otherSideUnread = null,}) {
  return _then(_MessageThreadModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessId: null == businessId ? _self.businessId : businessId // ignore: cast_nullable_to_non_nullable
as String,lastMessageAt: null == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as MessageSide,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,lastMessagePreview: null == lastMessagePreview ? _self.lastMessagePreview : lastMessagePreview // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,businessLogoUrl: freezed == businessLogoUrl ? _self.businessLogoUrl : businessLogoUrl // ignore: cast_nullable_to_non_nullable
as String?,otherSideUnread: null == otherSideUnread ? _self.otherSideUnread : otherSideUnread // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
