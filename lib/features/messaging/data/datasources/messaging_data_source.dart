import '../models/business_message_model.dart';
import '../models/message_thread_model.dart';

/// Source of customer ↔ business conversations.
abstract interface class MessagingDataSource {
  /// [archived] selects one list or the other, never both: the app shows them
  /// as two tabs, and an "Archived" tab that also lists the live inbox is not
  /// an archive.
  Future<List<MessageThreadModel>> threads({bool archived = false});

  /// Throws [NotFoundException] when the caller is not a participant — the
  /// server answers a stranger with "no such thread" rather than "not
  /// allowed", because a permission error would confirm the thread exists.
  Future<MessageThreadModel> thread(String threadId);

  /// `null` before the user has written to this business, which is the normal
  /// first-visit case and not an error.
  Future<MessageThreadModel?> threadWithBusiness(String businessId);

  Future<List<BusinessMessageModel>> messages(String threadId);

  /// Opens the conversation with a business, or appends to the existing one.
  Future<MessageThreadModel> messageBusiness({
    required String businessId,
    required String body,
    String subject = '',
    String contactName = '',
    String contactEmail = '',
  });

  Future<BusinessMessageModel> reply({
    required String threadId,
    required String body,
  });

  Future<MessageThreadModel> markRead(String threadId);

  Future<MessageThreadModel> setArchived(
    String threadId, {
    required bool archived,
  });

  Future<int> unreadCount();
}
