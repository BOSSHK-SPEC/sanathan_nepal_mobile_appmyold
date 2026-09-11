import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/business_message.dart';
import '../../domain/entities/message_thread.dart';
import '../../domain/repositories/messaging_repository.dart';
import '../datasources/messaging_data_source.dart';

class MessagingRepositoryImpl implements MessagingRepository {
  const MessagingRepositoryImpl(this._source);
  final MessagingDataSource _source;

  @override
  Future<Result<List<MessageThread>>> getThreads({bool archived = false}) =>
      guard(() async {
        final threads = await _source.threads(archived: archived);
        return [for (final t in threads) t.toEntity()];
      });

  @override
  Future<Result<MessageThread>> getThread(String threadId) =>
      guard(() async => (await _source.thread(threadId)).toEntity());

  @override
  Future<Result<MessageThread?>> getThreadWithBusiness(String businessId) =>
      guard(
        () async => (await _source.threadWithBusiness(businessId))?.toEntity(),
      );

  @override
  Future<Result<List<BusinessMessage>>> getMessages(String threadId) =>
      guard(() async {
        final messages = await _source.messages(threadId);
        return [for (final m in messages) m.toEntity()];
      });

  @override
  Future<Result<MessageThread>> messageBusiness({
    required String businessId,
    required String body,
    String subject = '',
    String contactName = '',
    String contactEmail = '',
  }) => guard(
    () async => (await _source.messageBusiness(
      businessId: businessId,
      body: body,
      subject: subject,
      contactName: contactName,
      contactEmail: contactEmail,
    )).toEntity(),
  );

  @override
  Future<Result<BusinessMessage>> reply({
    required String threadId,
    required String body,
  }) => guard(
    () async =>
        (await _source.reply(threadId: threadId, body: body)).toEntity(),
  );

  @override
  Future<Result<MessageThread>> markRead(String threadId) =>
      guard(() async => (await _source.markRead(threadId)).toEntity());

  @override
  Future<Result<MessageThread>> setArchived(
    String threadId, {
    required bool archived,
  }) => guard(
    () async =>
        (await _source.setArchived(threadId, archived: archived)).toEntity(),
  );

  @override
  Future<Result<int>> unreadCount() => guard(_source.unreadCount);
}
