import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/utils/ulid.dart';
import '../../domain/entities/business_message.dart';
import '../models/business_message_model.dart';
import '../models/message_thread_model.dart';
import 'messaging_data_source.dart';

/// Live customer ↔ business messaging.
///
/// The sender's side is never sent: the server infers it from the token, so a
/// customer cannot post a message that renders as the shop's own answer.
class ApiMessagingDataSource implements MessagingDataSource {
  const ApiMessagingDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<MessageThreadModel>> threads({bool archived = false}) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.messageThreads,
          query: archived ? const {'archived': 'true'} : null,
        );
        return asJsonList(response).map(_toThread).toList(growable: false);
      });

  @override
  Future<MessageThreadModel> thread(String threadId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.messageThread(threadId),
    );
    return _toThread(asJsonMap(response));
  });

  @override
  Future<MessageThreadModel?> threadWithBusiness(String businessId) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.businessThread(businessId),
        );
        // A shop nobody has written to answers with a bare `null` body, which
        // is the normal first visit — not an empty object and not an error.
        if (response.data == null) return null;
        return _toThread(asJsonMap(response));
      });

  @override
  Future<List<BusinessMessageModel>> messages(String threadId) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.messageThreadMessages(threadId),
          query: const {'limit': 100},
        );
        // The server pages newest-first so the first page is the bottom of the
        // conversation; a transcript reads oldest-first.
        return asPageItems(response)
            .map(_toMessage)
            .toList(growable: false)
            .reversed
            .toList(growable: false);
      });

  @override
  Future<MessageThreadModel> messageBusiness({
    required String businessId,
    required String body,
    String subject = '',
    String contactName = '',
    String contactEmail = '',
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.businessMessages(businessId),
      data: {
        // Client-supplied so a retry after a dropped connection collapses onto
        // one row instead of posting the enquiry twice.
        'messageId': Ulid.generate(),
        'body': body,
        if (subject.isNotEmpty) 'subject': subject,
        if (contactName.isNotEmpty) 'contactName': contactName,
        if (contactEmail.isNotEmpty) 'contactEmail': contactEmail,
      },
    );
    return _toThread(asJsonMap(response));
  });

  @override
  Future<BusinessMessageModel> reply({
    required String threadId,
    required String body,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.messageThreadMessages(threadId),
      data: {'messageId': Ulid.generate(), 'body': body},
    );
    return _toMessage(asJsonMap(response));
  });

  @override
  Future<MessageThreadModel> markRead(String threadId) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.messageThreadRead(threadId),
    );
    return _toThread(asJsonMap(response));
  });

  @override
  Future<MessageThreadModel> setArchived(
    String threadId, {
    required bool archived,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.messageThreadArchive(threadId),
      data: {'archived': archived},
    );
    return _toThread(asJsonMap(response));
  });

  @override
  Future<int> unreadCount() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.messagingUnread);
    final count = asJsonMap(response)['count'];
    return count is num ? count.toInt() : 0;
  });

  MessageThreadModel _toThread(Map<String, dynamic> json) => MessageThreadModel(
    id: json['id'] as String? ?? '',
    businessId: json['businessId'] as String? ?? '',
    lastMessageAt: ApiTime.instantOr(json['lastMessageAt'], DateTime.now()),
    side: _side(json['side']),
    businessName: json['businessName'] as String? ?? '',
    customerName: json['customerName'] as String? ?? '',
    contactName: json['contactName'] as String? ?? '',
    contactEmail: json['contactEmail'] as String? ?? '',
    subject: json['subject'] as String? ?? '',
    lastMessagePreview: json['lastMessagePreview'] as String? ?? '',
    unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
    archived: json['archived'] == true,
    businessLogoUrl: json['businessLogoKey'] as String?,
  );

  BusinessMessageModel _toMessage(Map<String, dynamic> json) =>
      BusinessMessageModel(
        id: json['id'] as String? ?? '',
        threadId: json['threadId'] as String? ?? '',
        sentAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
        sender: _side(json['sender']),
        body: json['body'] as String? ?? '',
        read: json['readAt'] != null,
      );

  static MessageSide _side(Object? raw) =>
      raw == 'owner' ? MessageSide.owner : MessageSide.customer;
}
