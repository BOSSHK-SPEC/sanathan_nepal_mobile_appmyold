import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';

part 'messaging_strings_en.dart';
part 'messaging_strings_hi.dart';
part 'messaging_strings_ne.dart';

/// Feature-local strings (English / Nepali / Hindi) for messaging.
abstract class MessagingStrings {
  const MessagingStrings();

  static MessagingStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  // Inbox
  String get messages;
  String get inbox;
  String get archived;
  String get buying;
  String get selling;
  String get noMessages;
  String get noMessagesBody;
  String get noArchived;
  String get archive;
  String get unarchive;

  // Conversation
  String get typeMessage;
  String get send;
  String get sending;
  String get failedToSend;
  String get tapToRetry;
  String get startConversation;
  String get startConversationBody;
  String get you;

  // Contact form
  String get sendMessage;
  String get messageSent;
  String get messageSentBody;
  String get viewConversation;
  String get yourName;
  String get yourEmail;
  String get subject;
  String get message;
  String get messageRequired;

  /// Shown when a business has not been approved yet, so it cannot receive
  /// enquiries.
  String get notAcceptingMessages;

  String unreadCount(int count);
}
