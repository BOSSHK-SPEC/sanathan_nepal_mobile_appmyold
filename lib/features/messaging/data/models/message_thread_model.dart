import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/business_message.dart';
import '../../domain/entities/message_thread.dart';

part 'message_thread_model.freezed.dart';
part 'message_thread_model.g.dart';

/// Persistence shape of [MessageThread].
@freezed
abstract class MessageThreadModel with _$MessageThreadModel {
  const MessageThreadModel._();

  const factory MessageThreadModel({
    required String id,
    required String businessId,
    required DateTime lastMessageAt,
    @Default(MessageSide.customer) MessageSide side,
    @Default('') String businessName,
    @Default('') String customerName,
    @Default('') String contactName,
    @Default('') String contactEmail,
    @Default('') String subject,
    @Default('') String lastMessagePreview,
    @Default(0) int unreadCount,
    @Default(false) bool archived,
    String? businessLogoUrl,

    /// Only the mock keeps the owner's side of the counter — the server hands
    /// each caller their own `unreadCount` and never the other side's.
    @Default(0) int otherSideUnread,
  }) = _MessageThreadModel;

  factory MessageThreadModel.fromJson(Map<String, dynamic> json) =>
      _$MessageThreadModelFromJson(json);

  factory MessageThreadModel.fromEntity(MessageThread e) => MessageThreadModel(
    id: e.id,
    businessId: e.businessId,
    lastMessageAt: e.lastMessageAt,
    side: e.side,
    businessName: e.businessName,
    customerName: e.customerName,
    contactName: e.contactName,
    contactEmail: e.contactEmail,
    subject: e.subject,
    lastMessagePreview: e.lastMessagePreview,
    unreadCount: e.unreadCount,
    archived: e.archived,
    businessLogoUrl: e.businessLogoUrl,
  );

  MessageThread toEntity() => MessageThread(
    id: id,
    businessId: businessId,
    lastMessageAt: lastMessageAt,
    side: side,
    businessName: businessName,
    customerName: customerName,
    contactName: contactName,
    contactEmail: contactEmail,
    subject: subject,
    lastMessagePreview: lastMessagePreview,
    unreadCount: unreadCount,
    archived: archived,
    businessLogoUrl: businessLogoUrl,
  );
}
