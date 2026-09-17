import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

/// Kind of in-app notification (drives the icon in the list).
enum NotificationType {
  general,
  event,
  horoscope,
  festival,
  birthday,
  order,
  appointment,

  /// A chat message from a shop or an astrologer.
  message,

  /// A consultation: requested, accepted, or starting now.
  consultation,

  /// Wallet credit, a refund, or a payout.
  wallet;

  static NotificationType fromName(String? name) => values.firstWhere(
    (t) => t.name == name,
    orElse: () => NotificationType.general,
  );
}

/// A single in-app notification (Figma: "Notification Title · 1h ago · body").
///
/// Text is carried in Nepali, English and Hindi; Hindi falls back to English
/// when a translation is missing (`titleHi` / `bodyHi` empty).
@freezed
abstract class AppNotification with _$AppNotification {
  const AppNotification._();

  const factory AppNotification({
    required String id,
    required String titleNe,
    required String titleEn,
    required String bodyNe,
    required String bodyEn,
    required DateTime createdAt,
    @Default('') String titleHi,
    @Default('') String bodyHi,
    @Default(NotificationType.general) NotificationType type,
    @Default(false) bool isRead,

    /// Optional deep-link route opened on tap.
    String? route,
  }) = _AppNotification;

  String title({required bool nepali}) => nepali ? titleNe : titleEn;
  String body({required bool nepali}) => nepali ? bodyNe : bodyEn;

  /// Title for a UI language code (`ne`, `hi`, otherwise English).
  String titleFor(String languageCode) => switch (languageCode) {
    'ne' => titleNe,
    'hi' => titleHi.isNotEmpty ? titleHi : titleEn,
    _ => titleEn,
  };

  /// Body for a UI language code (`ne`, `hi`, otherwise English).
  String bodyFor(String languageCode) => switch (languageCode) {
    'ne' => bodyNe,
    'hi' => bodyHi.isNotEmpty ? bodyHi : bodyEn,
    _ => bodyEn,
  };
}
