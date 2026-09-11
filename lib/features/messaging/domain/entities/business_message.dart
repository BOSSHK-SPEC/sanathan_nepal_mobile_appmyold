import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_message.freezed.dart';

/// Which side of a business conversation wrote a message.
///
/// Stored with the message rather than derived from the current owner, so a
/// transcript keeps its attribution if a shop changes hands.
enum MessageSide { customer, owner }

/// Delivery state, shown as ticks on the reader's own messages.
enum MessageDelivery { sending, sent, read, failed }

@freezed
abstract class BusinessMessage with _$BusinessMessage {
  const BusinessMessage._();

  const factory BusinessMessage({
    required String id,
    required String threadId,
    required MessageSide sender,
    required DateTime sentAt,
    @Default('') String body,
    @Default(MessageDelivery.sent) MessageDelivery delivery,
  }) = _BusinessMessage;

  /// A message still on its way out, so the composer can show it optimistically.
  bool get isPending => delivery == MessageDelivery.sending;

  bool get hasFailed => delivery == MessageDelivery.failed;
}
