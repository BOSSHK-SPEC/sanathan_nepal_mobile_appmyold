import 'package:freezed_annotation/freezed_annotation.dart';

import 'business_message.dart';

part 'message_thread.freezed.dart';

/// One conversation between a customer and a business.
///
/// A thread is keyed on `(business, customer)` on the server, so writing to
/// the same shop twice continues one conversation rather than opening a second
/// one the owner would have to correlate by hand.
@freezed
abstract class MessageThread with _$MessageThread {
  const MessageThread._();

  const factory MessageThread({
    required String id,
    required String businessId,
    required DateTime lastMessageAt,

    /// Which side the viewer is on. Everything in the UI that says "mine"
    /// resolves through this, never through a stored sender.
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
  }) = _MessageThread;

  bool get isOwnerSide => side == MessageSide.owner;

  bool get hasUnread => unreadCount > 0;

  /// Who the viewer is talking to — the shop, or the customer who wrote in.
  String get counterpartName {
    if (!isOwnerSide) return businessName;
    final named = contactName.isNotEmpty ? contactName : customerName;
    return named;
  }
}
