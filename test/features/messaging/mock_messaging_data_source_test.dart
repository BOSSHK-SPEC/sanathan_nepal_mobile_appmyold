import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/data/datasources/mock_messaging_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/domain/entities/business_message.dart';

void main() {
  late InMemoryKeyValueStore store;
  late MockMessagingDataSource source;

  setUp(() {
    store = InMemoryKeyValueStore();
    source = MockMessagingDataSource(store);
  });

  test('the demo starts with both sides of the inbox represented', () async {
    final threads = await source.threads();

    expect(threads.map((t) => t.side), containsAll(MessageSide.values));
  });

  test('a first message opens a conversation with that business', () async {
    final thread = await source.messageBusiness(
      businessId: 'biz-2',
      body: 'Do you ship to Pokhara?',
      contactName: 'Kritika',
    );

    expect(thread.businessId, 'biz-2');
    expect(thread.lastMessagePreview, 'Do you ship to Pokhara?');
    expect(thread.contactName, 'Kritika');
    expect(await source.messages(thread.id), hasLength(1));
  });

  test('writing again continues the same conversation', () async {
    final first = await source.messageBusiness(
      businessId: 'biz-2',
      body: 'Do you ship to Pokhara?',
    );
    final second = await source.messageBusiness(
      businessId: 'biz-2',
      body: 'Still interested.',
    );

    // A second thread would give the shop two half-conversations to correlate.
    expect(second.id, first.id);
    expect(await source.messages(first.id), hasLength(2));
  });

  test('a sent message survives a restart', () async {
    await source.messageBusiness(businessId: 'biz-2', body: 'Namaste');

    // A new instance over the same store is what a relaunch looks like.
    final reopened = MockMessagingDataSource(store);
    final thread = await reopened.threadWithBusiness('biz-2');

    expect(thread, isNotNull);
    expect((await reopened.messages(thread!.id)).single.body, 'Namaste');
  });

  test(
    'messaging your own shop is refused, as the server refuses it',
    () async {
      expect(
        () => source.messageBusiness(businessId: 'my-business', body: 'hi'),
        throwsA(isA<ValidationException>()),
      );
    },
  );

  test('opening a conversation clears its unread badge', () async {
    final before = await source.unreadCount();
    expect(before, greaterThan(0));

    for (final thread in await source.threads()) {
      await source.markRead(thread.id);
    }

    expect(await source.unreadCount(), 0);
  });

  test('marking read does not stamp the reader\'s own messages', () async {
    final thread = await source.messageBusiness(
      businessId: 'biz-2',
      body: 'Namaste',
    );

    await source.markRead(thread.id);

    // Otherwise your own sent ticks would flip to "read" the moment you
    // opened your own conversation.
    final mine = (await source.messages(thread.id)).single;
    expect(mine.read, isFalse);
  });

  test('archiving hides a conversation until something arrives', () async {
    final thread = (await source.threads()).first;

    await source.setArchived(thread.id, archived: true);
    expect(
      (await source.threads()).map((t) => t.id),
      isNot(contains(thread.id)),
    );
    expect(
      (await source.threads(archived: true)).map((t) => t.id),
      contains(thread.id),
    );

    await source.reply(threadId: thread.id, body: 'One more thing');

    // A reply landing in a list nobody looks at is a lost customer.
    expect((await source.threads()).map((t) => t.id), contains(thread.id));
  });

  test('conversations are ordered by their latest message', () async {
    final target = (await source.threads()).last;

    await source.reply(threadId: target.id, body: 'Newest');

    expect((await source.threads()).first.id, target.id);
  });

  test('an unknown conversation is not found', () async {
    expect(() => source.thread('nope'), throwsA(isA<NotFoundException>()));
    expect(
      () => source.reply(threadId: 'nope', body: 'hi'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('deleted demo conversations do not come back after a restart', () async {
    for (final thread in await source.threads()) {
      await source.setArchived(thread.id, archived: true);
    }

    // Re-seeding on every construction would resurrect what the user cleared.
    final reopened = MockMessagingDataSource(store);
    expect(await reopened.threads(), isEmpty);
  });
}
