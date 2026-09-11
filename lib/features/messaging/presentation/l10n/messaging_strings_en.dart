part of 'messaging_strings.dart';

class _En extends MessagingStrings {
  const _En();

  @override
  String get messages => 'Messages';
  @override
  String get inbox => 'Inbox';
  @override
  String get archived => 'Archived';
  @override
  String get buying => 'My enquiries';
  @override
  String get selling => 'My business';
  @override
  String get noMessages => 'No messages yet';
  @override
  String get noMessagesBody =>
      'Conversations with businesses you contact will appear here.';
  @override
  String get noArchived => 'Nothing archived';
  @override
  String get archive => 'Archive';
  @override
  String get unarchive => 'Move to inbox';

  @override
  String get typeMessage => 'Type a message…';
  @override
  String get send => 'Send';
  @override
  String get sending => 'Sending…';
  @override
  String get failedToSend => 'Message not sent';
  @override
  String get tapToRetry => 'Tap to retry';
  @override
  String get startConversation => 'Start the conversation';
  @override
  String get startConversationBody =>
      'Ask about products, prices or delivery. The business will see your message in their inbox.';
  @override
  String get you => 'You';

  @override
  String get sendMessage => 'Send Message';
  @override
  String get messageSent => 'Message sent';
  @override
  String get messageSentBody =>
      'The business has your message and can reply here.';
  @override
  String get viewConversation => 'View conversation';
  @override
  String get yourName => 'Your name';
  @override
  String get yourEmail => 'Your email';
  @override
  String get subject => 'Subject';
  @override
  String get message => 'Message';
  @override
  String get messageRequired => 'Write a message first';
  @override
  String get notAcceptingMessages =>
      'This business is not accepting messages yet.';

  @override
  String unreadCount(int count) => count == 1 ? '1 unread' : '$count unread';
}
