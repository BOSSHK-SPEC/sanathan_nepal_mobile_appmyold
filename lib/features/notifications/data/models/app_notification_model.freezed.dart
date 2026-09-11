// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppNotificationModel {

 String get id; String get titleNe; String get titleEn; String get titleHi; String get bodyNe; String get bodyEn; String get bodyHi; DateTime get createdAt;@JsonKey(unknownEnumValue: NotificationType.general) NotificationType get type; bool get isRead; String? get route;
/// Create a copy of AppNotificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppNotificationModelCopyWith<AppNotificationModel> get copyWith => _$AppNotificationModelCopyWithImpl<AppNotificationModel>(this as AppNotificationModel, _$identity);

  /// Serializes this AppNotificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppNotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.bodyNe, bodyNe) || other.bodyNe == bodyNe)&&(identical(other.bodyEn, bodyEn) || other.bodyEn == bodyEn)&&(identical(other.bodyHi, bodyHi) || other.bodyHi == bodyHi)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.route, route) || other.route == route));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titleNe,titleEn,titleHi,bodyNe,bodyEn,bodyHi,createdAt,type,isRead,route);

@override
String toString() {
  return 'AppNotificationModel(id: $id, titleNe: $titleNe, titleEn: $titleEn, titleHi: $titleHi, bodyNe: $bodyNe, bodyEn: $bodyEn, bodyHi: $bodyHi, createdAt: $createdAt, type: $type, isRead: $isRead, route: $route)';
}


}

/// @nodoc
abstract mixin class $AppNotificationModelCopyWith<$Res>  {
  factory $AppNotificationModelCopyWith(AppNotificationModel value, $Res Function(AppNotificationModel) _then) = _$AppNotificationModelCopyWithImpl;
@useResult
$Res call({
 String id, String titleNe, String titleEn, String titleHi, String bodyNe, String bodyEn, String bodyHi, DateTime createdAt,@JsonKey(unknownEnumValue: NotificationType.general) NotificationType type, bool isRead, String? route
});




}
/// @nodoc
class _$AppNotificationModelCopyWithImpl<$Res>
    implements $AppNotificationModelCopyWith<$Res> {
  _$AppNotificationModelCopyWithImpl(this._self, this._then);

  final AppNotificationModel _self;
  final $Res Function(AppNotificationModel) _then;

/// Create a copy of AppNotificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleNe = null,Object? titleEn = null,Object? titleHi = null,Object? bodyNe = null,Object? bodyEn = null,Object? bodyHi = null,Object? createdAt = null,Object? type = null,Object? isRead = null,Object? route = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,bodyNe: null == bodyNe ? _self.bodyNe : bodyNe // ignore: cast_nullable_to_non_nullable
as String,bodyEn: null == bodyEn ? _self.bodyEn : bodyEn // ignore: cast_nullable_to_non_nullable
as String,bodyHi: null == bodyHi ? _self.bodyHi : bodyHi // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _AppNotificationModel extends AppNotificationModel {
  const _AppNotificationModel({required this.id, this.titleNe = '', this.titleEn = '', this.titleHi = '', this.bodyNe = '', this.bodyEn = '', this.bodyHi = '', required this.createdAt, @JsonKey(unknownEnumValue: NotificationType.general) this.type = NotificationType.general, this.isRead = false, this.route}): super._();
  factory _AppNotificationModel.fromJson(Map<String, dynamic> json) => _$AppNotificationModelFromJson(json);

@override final  String id;
@override@JsonKey() final  String titleNe;
@override@JsonKey() final  String titleEn;
@override@JsonKey() final  String titleHi;
@override@JsonKey() final  String bodyNe;
@override@JsonKey() final  String bodyEn;
@override@JsonKey() final  String bodyHi;
@override final  DateTime createdAt;
@override@JsonKey(unknownEnumValue: NotificationType.general) final  NotificationType type;
@override@JsonKey() final  bool isRead;
@override final  String? route;

/// Create a copy of AppNotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppNotificationModelCopyWith<_AppNotificationModel> get copyWith => __$AppNotificationModelCopyWithImpl<_AppNotificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppNotificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppNotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.bodyNe, bodyNe) || other.bodyNe == bodyNe)&&(identical(other.bodyEn, bodyEn) || other.bodyEn == bodyEn)&&(identical(other.bodyHi, bodyHi) || other.bodyHi == bodyHi)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.route, route) || other.route == route));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,titleNe,titleEn,titleHi,bodyNe,bodyEn,bodyHi,createdAt,type,isRead,route);

@override
String toString() {
  return 'AppNotificationModel(id: $id, titleNe: $titleNe, titleEn: $titleEn, titleHi: $titleHi, bodyNe: $bodyNe, bodyEn: $bodyEn, bodyHi: $bodyHi, createdAt: $createdAt, type: $type, isRead: $isRead, route: $route)';
}


}

/// @nodoc
abstract mixin class _$AppNotificationModelCopyWith<$Res> implements $AppNotificationModelCopyWith<$Res> {
  factory _$AppNotificationModelCopyWith(_AppNotificationModel value, $Res Function(_AppNotificationModel) _then) = __$AppNotificationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleNe, String titleEn, String titleHi, String bodyNe, String bodyEn, String bodyHi, DateTime createdAt,@JsonKey(unknownEnumValue: NotificationType.general) NotificationType type, bool isRead, String? route
});




}
/// @nodoc
class __$AppNotificationModelCopyWithImpl<$Res>
    implements _$AppNotificationModelCopyWith<$Res> {
  __$AppNotificationModelCopyWithImpl(this._self, this._then);

  final _AppNotificationModel _self;
  final $Res Function(_AppNotificationModel) _then;

/// Create a copy of AppNotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleNe = null,Object? titleEn = null,Object? titleHi = null,Object? bodyNe = null,Object? bodyEn = null,Object? bodyHi = null,Object? createdAt = null,Object? type = null,Object? isRead = null,Object? route = freezed,}) {
  return _then(_AppNotificationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,bodyNe: null == bodyNe ? _self.bodyNe : bodyNe // ignore: cast_nullable_to_non_nullable
as String,bodyEn: null == bodyEn ? _self.bodyEn : bodyEn // ignore: cast_nullable_to_non_nullable
as String,bodyHi: null == bodyHi ? _self.bodyHi : bodyHi // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
