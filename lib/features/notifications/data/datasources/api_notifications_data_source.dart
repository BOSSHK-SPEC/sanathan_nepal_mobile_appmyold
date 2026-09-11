import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../domain/entities/app_notification.dart';
import '../models/app_notification_model.dart';
import 'notifications_data_source.dart';

/// The notification inbox, served by the backend.
///
/// Read state lives on the server rather than the device: a user who reads a
/// notification on their phone should not see it unread on a tablet, and the
/// unread badge has to agree with what the push worker thinks it sent.
class ApiNotificationsDataSource implements NotificationsDataSource {
  const ApiNotificationsDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<AppNotificationModel>> fetchAll() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.notifications);
    return asJsonList(response).map(_toModel).toList(growable: false);
  });

  @override
  Future<AppNotificationModel> markRead(String id) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.notificationRead(id),
    );
    return _toModel(asJsonMap(response));
  });

  @override
  Future<void> markAllRead() =>
      guardApi(() => _client.post<dynamic>(ApiEndpoints.notificationsReadAll));

  AppNotificationModel _toModel(Map<String, dynamic> json) {
    final title = _localized(json['title']);
    final body = _localized(json['body']);

    return AppNotificationModel(
      id: json['id'] as String? ?? '',
      titleEn: title['en'] ?? '',
      titleNe: title['ne'] ?? title['en'] ?? '',
      titleHi: title['hi'] ?? '',
      bodyEn: body['en'] ?? '',
      bodyNe: body['ne'] ?? body['en'] ?? '',
      bodyHi: body['hi'] ?? '',
      createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
      type: NotificationType.fromName(json['kind'] as String?),
      isRead: json['isRead'] as bool? ?? false,
      route: json['route'] as String?,
    );
  }

  static Map<String, String> _localized(Object? raw) {
    if (raw is String) return {'en': raw};
    if (raw is! Map) return const {};
    return raw.map((k, v) => MapEntry(k.toString(), v.toString()));
  }
}
