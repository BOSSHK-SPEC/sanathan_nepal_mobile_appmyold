// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppNotification {

 String get id; String get titleNe; String get titleEn; String get bodyNe; String get bodyEn; DateTime get createdAt; String get titleHi; String get bodyHi; NotificationType get type; bool get isRead;/// Optional deep-link route opened on tap.
 String? get route;
/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppNotificationCopyWith<AppNotification> get copyWith => _$AppNotificationCopyWithImpl<AppNotification>(this as AppNotification, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.bodyNe, bodyNe) || other.bodyNe == bodyNe)&&(identical(other.bodyEn, bodyEn) || other.bodyEn == bodyEn)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.bodyHi, bodyHi) || other.bodyHi == bodyHi)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleNe,titleEn,bodyNe,bodyEn,createdAt,titleHi,bodyHi,type,isRead,route);

@override
String toString() {
  return 'AppNotification(id: $id, titleNe: $titleNe, titleEn: $titleEn, bodyNe: $bodyNe, bodyEn: $bodyEn, createdAt: $createdAt, titleHi: $titleHi, bodyHi: $bodyHi, type: $type, isRead: $isRead, route: $route)';
}


}

/// @nodoc
abstract mixin class $AppNotificationCopyWith<$Res>  {
  factory $AppNotificationCopyWith(AppNotification value, $Res Function(AppNotification) _then) = _$AppNotificationCopyWithImpl;
@useResult
$Res call({
 String id, String titleNe, String titleEn, String bodyNe, String bodyEn, DateTime createdAt, String titleHi, String bodyHi, NotificationType type, bool isRead, String? route
});




}
/// @nodoc
class _$AppNotificationCopyWithImpl<$Res>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._self, this._then);

  final AppNotification _self;
  final $Res Function(AppNotification) _then;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleNe = null,Object? titleEn = null,Object? bodyNe = null,Object? bodyEn = null,Object? createdAt = null,Object? titleHi = null,Object? bodyHi = null,Object? type = null,Object? isRead = null,Object? route = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,bodyNe: null == bodyNe ? _self.bodyNe : bodyNe // ignore: cast_nullable_to_non_nullable
as String,bodyEn: null == bodyEn ? _self.bodyEn : bodyEn // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,bodyHi: null == bodyHi ? _self.bodyHi : bodyHi // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _AppNotification extends AppNotification {
  const _AppNotification({required this.id, required this.titleNe, required this.titleEn, required this.bodyNe, required this.bodyEn, required this.createdAt, this.titleHi = '', this.bodyHi = '', this.type = NotificationType.general, this.isRead = false, this.route}): super._();
  

@override final  String id;
@override final  String titleNe;
@override final  String titleEn;
@override final  String bodyNe;
@override final  String bodyEn;
@override final  DateTime createdAt;
@override@JsonKey() final  String titleHi;
@override@JsonKey() final  String bodyHi;
@override@JsonKey() final  NotificationType type;
@override@JsonKey() final  bool isRead;
/// Optional deep-link route opened on tap.
@override final  String? route;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppNotificationCopyWith<_AppNotification> get copyWith => __$AppNotificationCopyWithImpl<_AppNotification>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.bodyNe, bodyNe) || other.bodyNe == bodyNe)&&(identical(other.bodyEn, bodyEn) || other.bodyEn == bodyEn)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.bodyHi, bodyHi) || other.bodyHi == bodyHi)&&(identical(other.type, type) || other.type == type)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleNe,titleEn,bodyNe,bodyEn,createdAt,titleHi,bodyHi,type,isRead,route);

@override
String toString() {
  return 'AppNotification(id: $id, titleNe: $titleNe, titleEn: $titleEn, bodyNe: $bodyNe, bodyEn: $bodyEn, createdAt: $createdAt, titleHi: $titleHi, bodyHi: $bodyHi, type: $type, isRead: $isRead, route: $route)';
}


}

/// @nodoc
abstract mixin class _$AppNotificationCopyWith<$Res> implements $AppNotificationCopyWith<$Res> {
  factory _$AppNotificationCopyWith(_AppNotification value, $Res Function(_AppNotification) _then) = __$AppNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleNe, String titleEn, String bodyNe, String bodyEn, DateTime createdAt, String titleHi, String bodyHi, NotificationType type, bool isRead, String? route
});




}
/// @nodoc
class __$AppNotificationCopyWithImpl<$Res>
    implements _$AppNotificationCopyWith<$Res> {
  __$AppNotificationCopyWithImpl(this._self, this._then);

  final _AppNotification _self;
  final $Res Function(_AppNotification) _then;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleNe = null,Object? titleEn = null,Object? bodyNe = null,Object? bodyEn = null,Object? createdAt = null,Object? titleHi = null,Object? bodyHi = null,Object? type = null,Object? isRead = null,Object? route = freezed,}) {
  return _then(_AppNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,bodyNe: null == bodyNe ? _self.bodyNe : bodyNe // ignore: cast_nullable_to_non_nullable
as String,bodyEn: null == bodyEn ? _self.bodyEn : bodyEn // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,bodyHi: null == bodyHi ? _self.bodyHi : bodyHi // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
