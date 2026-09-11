import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/business_message.dart';
import '../entities/message_thread.dart';
import '../repositories/messaging_repository.dart';

class GetMessageThreads implements UseCase<List<MessageThread>, bool> {
  const GetMessageThreads(this._repository);
  final MessagingRepository _repository;

  /// The archived flag is the only parameter, so the archive is served by the
  /// same use case rather than a second one that could drift from it.
  @override
  Future<Result<List<MessageThread>>> call(bool archived) =>
      _repository.getThreads(archived: archived);
}

class GetMessageThread implements UseCase<MessageThread, String> {
  const GetMessageThread(this._repository);
  final MessagingRepository _repository;

  @override
  Future<Result<MessageThread>> call(String threadId) =>
      _repository.getThread(threadId);
}

class GetThreadWithBusiness implements UseCase<MessageThread?, String> {
  const GetThreadWithBusiness(this._repository);
  final MessagingRepository _repository;

  @override
  Future<Result<MessageThread?>> call(String businessId) =>
      _repository.getThreadWithBusiness(businessId);
}

class GetThreadMessages implements UseCase<List<BusinessMessage>, String> {
  const GetThreadMessages(this._repository);
  final MessagingRepository _repository;

  @override
  Future<Result<List<BusinessMessage>>> call(String threadId) =>
      _repository.getMessages(threadId);
}

/// What the business page's contact form and the "Message" button both send.
class MessageBusinessParams {
  const MessageBusinessParams({
    required this.businessId,
    required this.body,
    this.subject = '',
    this.contactName = '',
    this.contactEmail = '',
  });

  final String businessId;
  final String body;
  final String subject;
  final String contactName;
  final String contactEmail;
}

class MessageBusiness implements UseCase<MessageThread, MessageBusinessParams> {
  const MessageBusiness(this._repository);
  final MessagingRepository _repository;

  @override
  Future<Result<MessageThread>> call(MessageBusinessParams params) =>
      _repository.messageBusiness(
        businessId: params.businessId,
        body: params.body,
        subject: params.subject,
        contactName: params.contactName,
        contactEmail: params.contactEmail,
      );
}

class ReplyParams {
  const ReplyParams({required this.threadId, required this.body});
  final String threadId;
  final String body;
}

class ReplyToThread implements UseCase<BusinessMessage, ReplyParams> {
  const ReplyToThread(this._repository);
  final MessagingRepository _repository;

  @override
  Future<Result<BusinessMessage>> call(ReplyParams params) =>
      _repository.reply(threadId: params.threadId, body: params.body);
}

class MarkThreadRead implements UseCase<MessageThread, String> {
  const MarkThreadRead(this._repository);
  final MessagingRepository _repository;

  @override
  Future<Result<MessageThread>> call(String threadId) =>
      _repository.markRead(threadId);
}

class ArchiveParams {
  const ArchiveParams({required this.threadId, required this.archived});
  final String threadId;
  final bool archived;
}

class SetThreadArchived implements UseCase<MessageThread, ArchiveParams> {
  const SetThreadArchived(this._repository);
  final MessagingRepository _repository;

  @override
  Future<Result<MessageThread>> call(ArchiveParams params) =>
      _repository.setArchived(params.threadId, archived: params.archived);
}

class GetUnreadMessageCount implements NoParamsUseCase<int> {
  const GetUnreadMessageCount(this._repository);
  final MessagingRepository _repository;

  @override
  Future<Result<int>> call() => _repository.unreadCount();
}
