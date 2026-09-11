import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/business_message.dart';

part 'business_message_model.freezed.dart';
part 'business_message_model.g.dart';

/// Persistence shape of [BusinessMessage].
@freezed
abstract class BusinessMessageModel with _$BusinessMessageModel {
  const BusinessMessageModel._();

  const factory BusinessMessageModel({
    required String id,
    required String threadId,
    required DateTime sentAt,
    @Default(MessageSide.customer) MessageSide sender,
    @Default('') String body,
    @Default(false) bool read,
  }) = _BusinessMessageModel;

  factory BusinessMessageModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessMessageModelFromJson(json);

  factory BusinessMessageModel.fromEntity(BusinessMessage e) =>
      BusinessMessageModel(
        id: e.id,
        threadId: e.threadId,
        sentAt: e.sentAt,
        sender: e.sender,
        body: e.body,
        read: e.delivery == MessageDelivery.read,
      );

  BusinessMessage toEntity() => BusinessMessage(
    id: id,
    threadId: threadId,
    sender: sender,
    sentAt: sentAt,
    body: body,
    // A message the server has stored is at least sent; `read` moves it on.
    delivery: read ? MessageDelivery.read : MessageDelivery.sent,
  );
}
