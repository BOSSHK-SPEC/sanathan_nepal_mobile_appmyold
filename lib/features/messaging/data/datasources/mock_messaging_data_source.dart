import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../../../core/utils/ulid.dart';
import '../../../profile/data/datasources/mock_business_data_source.dart';
import '../../domain/entities/business_message.dart';
import '../models/business_message_model.dart';
import '../models/message_thread_model.dart';
import 'messaging_data_source.dart';

/// Deterministic conversations, persisted in [KeyValueStore] so a message sent
/// in the demo survives a restart.
///
/// The seeded exchange is what makes the inbox demonstrable before a backend
/// exists: one conversation the user started with a shop, and one that arrived
/// at the shop they own — the two sides the screens have to render.
class MockMessagingDataSource implements MessagingDataSource {
  MockMessagingDataSource(this._store);

  final KeyValueStore _store;

  static const String _kThreads = 'messaging.threads';
  static const String _kMessages = 'messaging.messages';
  static const String _kSeeded = 'messaging.seeded';

  /// The mock's own shop. A thread against it is one the user owns, which is
  /// what puts it on the owner side of the inbox.
  static const String _myBusinessId = MockBusinessDataSource.myBusinessId;

  // --------------------------------------------------------------- storage

  List<MessageThreadModel> _readThreads() {
    _seedOnce();
    final raw = _store.getString(_kThreads);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final j in jsonDecode(raw) as List<dynamic>)
        MessageThreadModel.fromJson(j as Map<String, dynamic>),
    ];
  }

  Future<void> _writeThreads(List<MessageThreadModel> threads) =>
      _store.setString(
        _kThreads,
        jsonEncode(threads.map((t) => t.toJson()).toList()),
      );

  List<BusinessMessageModel> _readMessages() {
    _seedOnce();
    final raw = _store.getString(_kMessages);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final j in jsonDecode(raw) as List<dynamic>)
        BusinessMessageModel.fromJson(j as Map<String, dynamic>),
    ];
  }

  Future<void> _writeMessages(List<BusinessMessageModel> messages) =>
      _store.setString(
        _kMessages,
        jsonEncode(messages.map((m) => m.toJson()).toList()),
      );

  /// Seeds once and records that it did, so a user who deletes every demo
  /// conversation does not find them back after the next restart.
  void _seedOnce() {
    if (_store.getBool(_kSeeded) ?? false) return;
    _store.setBool(_kSeeded, true);

    final now = DateTime.now();
    final threads = [
      MessageThreadModel(
        id: 'thread-seed-1',
        businessId: 'biz-1',
        businessName: 'Uttam Astro & Gems',
        lastMessageAt: now.subtract(const Duration(hours: 3)),
        lastMessagePreview: 'Yes, we have 5 mukhi in stock.',
        subject: 'Rudraksha availability',
        unreadCount: 1,
      ),
      MessageThreadModel(
        id: 'thread-seed-2',
        businessId: _myBusinessId,
        businessName: 'My Business',
        side: MessageSide.owner,
        customerName: 'Anisha Shrestha',
        contactName: 'Anisha Shrestha',
        contactEmail: 'anisha@example.com',
        subject: 'Delivery to Pokhara',
        lastMessageAt: now.subtract(const Duration(minutes: 40)),
        lastMessagePreview: 'Do you deliver to Pokhara?',
        unreadCount: 1,
      ),
    ];
    final messages = [
      BusinessMessageModel(
        id: 'msg-seed-1',
        threadId: 'thread-seed-1',
        sentAt: now.subtract(const Duration(hours: 4)),
        body: 'Namaste, do you have 5 mukhi rudraksha?',
        read: true,
      ),
      BusinessMessageModel(
        id: 'msg-seed-2',
        threadId: 'thread-seed-1',
        sender: MessageSide.owner,
        sentAt: now.subtract(const Duration(hours: 3)),
        body: 'Yes, we have 5 mukhi in stock.',
      ),
      BusinessMessageModel(
        id: 'msg-seed-3',
        threadId: 'thread-seed-2',
        sentAt: now.subtract(const Duration(minutes: 40)),
        body: 'Do you deliver to Pokhara?',
      ),
    ];
    _store.setString(
      _kThreads,
      jsonEncode(threads.map((t) => t.toJson()).toList()),
    );
    _store.setString(
      _kMessages,
      jsonEncode(messages.map((m) => m.toJson()).toList()),
    );
  }

  // ------------------------------------------------------------------ reads

  @override
  Future<List<MessageThreadModel>> threads({bool archived = false}) async {
    final all = _readThreads()
      ..sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    return [
      for (final t in all)
        if (t.archived == archived) t,
    ];
  }

  @override
  Future<MessageThreadModel> thread(String threadId) async {
    for (final t in _readThreads()) {
      if (t.id == threadId) return t;
    }
    throw const NotFoundException('Conversation not found');
  }

  @override
  Future<MessageThreadModel?> threadWithBusiness(String businessId) async {
    for (final t in _readThreads()) {
      if (t.businessId == businessId && t.side == MessageSide.customer) {
        return t;
      }
    }
    return null;
  }

  @override
  Future<List<BusinessMessageModel>> messages(String threadId) async {
    final mine = [
      for (final m in _readMessages())
        if (m.threadId == threadId) m,
    ]..sort((a, b) => a.sentAt.compareTo(b.sentAt));
    return mine;
  }

  @override
  Future<int> unreadCount() async {
    var total = 0;
    for (final t in _readThreads()) {
      if (!t.archived) total += t.unreadCount;
    }
    return total;
  }

  // ----------------------------------------------------------------- writes

  @override
  Future<MessageThreadModel> messageBusiness({
    required String businessId,
    required String body,
    String subject = '',
    String contactName = '',
    String contactEmail = '',
  }) async {
    // Writing to your own shop would create a conversation that answers
    // itself; the server refuses it, so the mock has to as well or the demo
    // would show a flow that cannot exist.
    if (businessId == _myBusinessId) {
      throw const ValidationException(
        'You cannot send a message to your own business',
      );
    }

    final threads = _readThreads();
    final index = threads.indexWhere(
      (t) => t.businessId == businessId && t.side == MessageSide.customer,
    );
    final now = DateTime.now();

    final thread = index == -1
        ? MessageThreadModel(
            id: 'thread-${Ulid.generate()}',
            businessId: businessId,
            lastMessageAt: now,
            subject: subject,
            contactName: contactName,
            contactEmail: contactEmail,
          )
        : threads[index].copyWith(
            lastMessageAt: now,
            // A returning customer may have corrected how to reach them.
            subject: subject.isEmpty ? threads[index].subject : subject,
            contactName: contactName.isEmpty
                ? threads[index].contactName
                : contactName,
            contactEmail: contactEmail.isEmpty
                ? threads[index].contactEmail
                : contactEmail,
          );

    final saved = thread.copyWith(
      lastMessagePreview: body,
      archived: false,
      otherSideUnread: thread.otherSideUnread + 1,
    );
    if (index == -1) {
      threads.add(saved);
    } else {
      threads[index] = saved;
    }
    await _writeThreads(threads);
    await _append(saved.id, MessageSide.customer, body, now);
    return saved;
  }

  @override
  Future<BusinessMessageModel> reply({
    required String threadId,
    required String body,
  }) async {
    final threads = _readThreads();
    final index = threads.indexWhere((t) => t.id == threadId);
    if (index == -1) throw const NotFoundException('Conversation not found');

    final now = DateTime.now();
    final side = threads[index].side;
    threads[index] = threads[index].copyWith(
      lastMessageAt: now,
      lastMessagePreview: body,
      archived: false,
      otherSideUnread: threads[index].otherSideUnread + 1,
    );
    await _writeThreads(threads);
    return _append(threadId, side, body, now);
  }

  @override
  Future<MessageThreadModel> markRead(String threadId) async {
    final threads = _readThreads();
    final index = threads.indexWhere((t) => t.id == threadId);
    if (index == -1) throw const NotFoundException('Conversation not found');

    final side = threads[index].side;
    threads[index] = threads[index].copyWith(unreadCount: 0);
    await _writeThreads(threads);

    // Only the other side's messages can be unread to me; stamping my own
    // would make my sent ticks depend on when I opened my own thread.
    final messages = [
      for (final m in _readMessages())
        if (m.threadId == threadId && m.sender != side)
          m.copyWith(read: true)
        else
          m,
    ];
    await _writeMessages(messages);
    return threads[index];
  }

  @override
  Future<MessageThreadModel> setArchived(
    String threadId, {
    required bool archived,
  }) async {
    final threads = _readThreads();
    final index = threads.indexWhere((t) => t.id == threadId);
    if (index == -1) throw const NotFoundException('Conversation not found');
    threads[index] = threads[index].copyWith(archived: archived);
    await _writeThreads(threads);
    return threads[index];
  }

  Future<BusinessMessageModel> _append(
    String threadId,
    MessageSide sender,
    String body,
    DateTime at,
  ) async {
    final message = BusinessMessageModel(
      id: 'msg-${Ulid.generate()}',
      threadId: threadId,
      sender: sender,
      sentAt: at,
      body: body,
    );
    await _writeMessages([..._readMessages(), message]);
    return message;
  }
}
