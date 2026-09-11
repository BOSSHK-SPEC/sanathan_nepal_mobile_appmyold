import '../../../../core/utils/result.dart';
import '../entities/business_message.dart';
import '../entities/message_thread.dart';

/// Customer ↔ business conversations.
abstract interface class MessagingRepository {
  /// Every thread the signed-in user takes part in, as customer or as owner,
  /// newest activity first. [archived] selects the archive instead of the
  /// live inbox — the two are separate lists, not nested ones.
  Future<Result<List<MessageThread>>> getThreads({bool archived = false});

  Future<Result<MessageThread>> getThread(String threadId);

  /// The user's existing conversation with a business, or `null` before they
  /// have written to it. Not a failure — a shop nobody has messaged yet is the
  /// normal case, and reporting it as an error would make the contact screen
  /// open on a red banner.
  Future<Result<MessageThread?>> getThreadWithBusiness(String businessId);

  Future<Result<List<BusinessMessage>>> getMessages(String threadId);

  /// Writes to a business, opening the conversation on the first message.
  Future<Result<MessageThread>> messageBusiness({
    required String businessId,
    required String body,
    String subject = '',
    String contactName = '',
    String contactEmail = '',
  });

  /// Replies into an existing thread.
  Future<Result<BusinessMessage>> reply({
    required String threadId,
    required String body,
  });

  Future<Result<MessageThread>> markRead(String threadId);

  Future<Result<MessageThread>> setArchived(
    String threadId, {
    required bool archived,
  });

  /// Badge count across every thread the user takes part in.
  Future<Result<int>> unreadCount();
}
