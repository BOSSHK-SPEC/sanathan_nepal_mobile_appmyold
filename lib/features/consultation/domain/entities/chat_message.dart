import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

enum ChatSender { seeker, astrologer, system }

/// Delivery state, shown as ticks on the seeker's own messages.
enum MessageStatus { sending, sent, delivered, read, failed }

enum MessageKind { text, image, chart, remedy }

@freezed
abstract class ChatMessage with _$ChatMessage {
  const ChatMessage._();

  const factory ChatMessage({
    required String id,
    required String consultationId,
    required ChatSender sender,
    required DateTime sentAt,
    @Default(MessageKind.text) MessageKind kind,
    @Default('') String text,
    @Default(MessageStatus.sent) MessageStatus status,

    /// Asset path or URL for [MessageKind.image] / [MessageKind.chart].
    String? attachment,
  }) = _ChatMessage;

  bool get isMine => sender == ChatSender.seeker;

  /// System notices ("Session started") render centred, without a bubble.
  bool get isSystem => sender == ChatSender.system;
}
