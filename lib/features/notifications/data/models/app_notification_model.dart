import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/app_notification.dart';

part 'app_notification_model.freezed.dart';
part 'app_notification_model.g.dart';

/// Serializable [AppNotification].
@freezed
abstract class AppNotificationModel with _$AppNotificationModel {
  const AppNotificationModel._();

  const factory AppNotificationModel({
    required String id,
    @Default('') String titleNe,
    @Default('') String titleEn,
    @Default('') String titleHi,
    @Default('') String bodyNe,
    @Default('') String bodyEn,
    @Default('') String bodyHi,
    required DateTime createdAt,
    @JsonKey(unknownEnumValue: NotificationType.general)
    @Default(NotificationType.general)
    NotificationType type,
    @Default(false) bool isRead,
    String? route,
  }) = _AppNotificationModel;

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationModelFromJson(json);

  factory AppNotificationModel.fromEntity(AppNotification n) =>
      AppNotificationModel(
        id: n.id,
        titleNe: n.titleNe,
        titleEn: n.titleEn,
        titleHi: n.titleHi,
        bodyNe: n.bodyNe,
        bodyEn: n.bodyEn,
        bodyHi: n.bodyHi,
        createdAt: n.createdAt,
        type: n.type,
        isRead: n.isRead,
        route: n.route,
      );

  AppNotification toEntity() => AppNotification(
    id: id,
    titleNe: titleNe,
    titleEn: titleEn,
    titleHi: titleHi,
    bodyNe: bodyNe,
    bodyEn: bodyEn,
    bodyHi: bodyHi,
    createdAt: createdAt,
    type: type,
    isRead: isRead,
    route: route,
  );
}
