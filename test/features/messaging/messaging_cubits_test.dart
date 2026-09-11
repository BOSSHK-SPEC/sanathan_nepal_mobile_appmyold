import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/domain/entities/business_message.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/domain/entities/message_thread.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/domain/usecases/messaging_usecases.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/cubit/business_contact_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/cubit/message_thread_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/cubit/message_threads_cubit.dart';

class MockGetThreads extends Mock implements GetMessageThreads {}

class MockGetThread extends Mock implements GetMessageThread {}

class MockGetThreadWithBusiness extends Mock implements GetThreadWithBusiness {}

class MockGetMessages extends Mock implements GetThreadMessages {}

class MockMessageBusiness extends Mock implements MessageBusiness {}

class MockReply extends Mock implements ReplyToThread {}

class MockMarkRead extends Mock implements MarkThreadRead {}

class MockSetArchived extends Mock implements SetThreadArchived {}

final threadAt = DateTime(2026, 9, 1, 10);

MessageThread thread({
  String id = 't1',
  MessageSide side = MessageSide.customer,
  int unread = 0,
}) => MessageThread(
  id: id,
  businessId: 'b1',
  businessName: 'Bhaktapur Bhandar',
  lastMessageAt: threadAt,
  side: side,
  unreadCount: unread,
);

BusinessMessage message(
  String id, {
  MessageSide sender = MessageSide.customer,
}) => BusinessMessage(
  id: id,
  threadId: 't1',
  sender: sender,
  sentAt: threadAt,
  body: 'body-$id',
);

const failure = Failure.network('No connection');

void main() {
  setUpAll(() {
    registerFallbackValue(
      const MessageBusinessParams(businessId: 'b1', body: 'x'),
    );
    registerFallbackValue(const ReplyParams(threadId: 't1', body: 'x'));
    registerFallbackValue(const ArchiveParams(threadId: 't1', archived: true));
  });

  group('MessageThreadsCubit', () {
    late MockGetThreads getThreads;
    late MockSetArchived setArchived;

    setUp(() {
      getThreads = MockGetThreads();
      setArchived = MockSetArchived();
    });

    MessageThreadsCubit build() =>
        MessageThreadsCubit(getThreads: getThreads, setArchived: setArchived);

    blocTest<MessageThreadsCubit, MessageThreadsState>(
      'loads the inbox',
      build: () {
        when(
          () => getThreads(any()),
        ).thenAnswer((_) async => Result.success([thread(), thread(id: 't2')]));
        return build();
      },
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<MessageThreadsState>().having(
          (s) => s.threads.isLoading,
          'loading',
          true,
        ),
        isA<MessageThreadsState>().having(
          (s) => s.items,
          'items',
          hasLength(2),
        ),
      ],
    );

    blocTest<MessageThreadsCubit, MessageThreadsState>(
      'splits the two sides so each can be labelled',
      build: () {
        when(() => getThreads(any())).thenAnswer(
          (_) async => Result.success([
            thread(),
            thread(id: 't2', side: MessageSide.owner),
          ]),
        );
        return build();
      },
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        expect(cubit.state.selling.single.id, 't2');
        expect(cubit.state.buying.single.id, 't1');
      },
    );

    blocTest<MessageThreadsCubit, MessageThreadsState>(
      'switching to archived reloads with the flag set',
      build: () {
        when(
          () => getThreads(any()),
        ).thenAnswer((_) async => const Result.success([]));
        return build();
      },
      act: (cubit) => cubit.showArchived(archived: true),
      verify: (_) => verify(() => getThreads(true)).called(1),
    );

    blocTest<MessageThreadsCubit, MessageThreadsState>(
      'a failed load surfaces the failure',
      build: () {
        when(
          () => getThreads(any()),
        ).thenAnswer((_) async => const Result.failure(failure));
        return build();
      },
      act: (cubit) => cubit.load(),
      verify: (cubit) =>
          expect(cubit.state.threads.errorMessage, 'No connection'),
    );

    blocTest<MessageThreadsCubit, MessageThreadsState>(
      'archiving reloads, because the thread moves between the two lists',
      build: () {
        when(
          () => getThreads(any()),
        ).thenAnswer((_) async => const Result.success([]));
        when(
          () => setArchived(any()),
        ).thenAnswer((_) async => Result.success(thread()));
        return build();
      },
      act: (cubit) => cubit.archive('t1', archived: true),
      verify: (_) => verify(() => getThreads(any())).called(1),
    );
  });

  group('MessageThreadCubit', () {
    late MockGetThread getThread;
    late MockGetThreadWithBusiness getWithBusiness;
    late MockGetMessages getMessages;
    late MockMessageBusiness messageBusiness;
    late MockReply reply;
    late MockMarkRead markRead;

    setUp(() {
      getThread = MockGetThread();
      getWithBusiness = MockGetThreadWithBusiness();
      getMessages = MockGetMessages();
      messageBusiness = MockMessageBusiness();
      reply = MockReply();
      markRead = MockMarkRead();
      when(
        () => markRead(any()),
      ).thenAnswer((_) async => Result.success(thread()));
    });

    MessageThreadCubit build({String? threadId, String? businessId}) =>
        MessageThreadCubit(
          getThread: getThread,
          getThreadWithBusiness: getWithBusiness,
          getMessages: getMessages,
          messageBusiness: messageBusiness,
          reply: reply,
          markRead: markRead,
          threadId: threadId,
          businessId: businessId,
        );

    blocTest<MessageThreadCubit, MessageThreadState>(
      'opening an existing conversation loads it and marks it read',
      build: () {
        when(
          () => getThread(any()),
        ).thenAnswer((_) async => Result.success(thread(unread: 2)));
        when(
          () => getMessages(any()),
        ).thenAnswer((_) async => Result.success([message('a')]));
        return build(threadId: 't1');
      },
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        expect(cubit.state.chat, hasLength(1));
        verify(() => markRead('t1')).called(1);
      },
    );

    blocTest<MessageThreadCubit, MessageThreadState>(
      'a shop nobody has written to opens empty, not on an error',
      build: () {
        when(
          () => getWithBusiness(any()),
        ).thenAnswer((_) async => const Result.success(null));
        return build(businessId: 'b1');
      },
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        expect(cubit.state.threadId, isNull);
        expect(cubit.state.thread.isFailed, isFalse);
        expect(cubit.state.isEmpty, isTrue);
        // Nothing is created by looking, so an abandoned screen leaves no
        // empty conversation in the shop's inbox.
        verifyNever(() => markRead(any()));
      },
    );

    blocTest<MessageThreadCubit, MessageThreadState>(
      'the first message creates the conversation',
      build: () {
        when(
          () => getWithBusiness(any()),
        ).thenAnswer((_) async => const Result.success(null));
        when(
          () => messageBusiness(any()),
        ).thenAnswer((_) async => Result.success(thread()));
        when(
          () => getMessages(any()),
        ).thenAnswer((_) async => Result.success([message('a')]));
        return build(businessId: 'b1');
      },
      act: (cubit) async {
        await cubit.load();
        cubit.setDraft('Namaste');
        await cubit.send();
      },
      verify: (cubit) {
        expect(cubit.state.threadId, 't1');
        expect(cubit.state.chat.single.id, 'a');
        verify(() => messageBusiness(any())).called(1);
        verifyNever(() => reply(any()));
      },
    );

    blocTest<MessageThreadCubit, MessageThreadState>(
      'a reply into an open conversation replaces the optimistic bubble',
      build: () {
        when(
          () => getThread(any()),
        ).thenAnswer((_) async => Result.success(thread()));
        when(
          () => getMessages(any()),
        ).thenAnswer((_) async => Result.success([message('a')]));
        when(
          () => reply(any()),
        ).thenAnswer((_) async => Result.success(message('b')));
        return build(threadId: 't1');
      },
      act: (cubit) async {
        await cubit.load();
        cubit.setDraft('Thanks');
        await cubit.send();
      },
      verify: (cubit) {
        expect(cubit.state.chat.every((m) => !m.isPending), isTrue);
        expect(cubit.state.draft, isEmpty);
      },
    );

    blocTest<MessageThreadCubit, MessageThreadState>(
      'a rejected message is marked failed and the text is given back',
      build: () {
        when(
          () => getThread(any()),
        ).thenAnswer((_) async => Result.success(thread()));
        when(
          () => getMessages(any()),
        ).thenAnswer((_) async => const Result.success([]));
        when(
          () => reply(any()),
        ).thenAnswer((_) async => const Result.failure(failure));
        return build(threadId: 't1');
      },
      act: (cubit) async {
        await cubit.load();
        cubit.setDraft('Namaste');
        await cubit.send();
      },
      verify: (cubit) {
        expect(cubit.state.chat.single.hasFailed, isTrue);
        // Nothing the user typed is thrown away by a failure.
        expect(cubit.state.draft, 'Namaste');
        expect(cubit.state.sendFailure, failure);
        expect(cubit.state.isSending, isFalse);
      },
    );

    blocTest<MessageThreadCubit, MessageThreadState>(
      'retrying a failed message re-sends it exactly once',
      build: () {
        when(
          () => getThread(any()),
        ).thenAnswer((_) async => Result.success(thread()));
        when(
          () => getMessages(any()),
        ).thenAnswer((_) async => const Result.success([]));
        var attempts = 0;
        when(() => reply(any())).thenAnswer((_) async {
          attempts += 1;
          return attempts == 1
              ? const Result.failure(failure)
              : Result.success(message('b'));
        });
        return build(threadId: 't1');
      },
      act: (cubit) async {
        await cubit.load();
        cubit.setDraft('Namaste');
        await cubit.send();
        await cubit.retry();
      },
      verify: (cubit) {
        verify(() => reply(any())).called(2);
        expect(cubit.state.chat.any((m) => m.hasFailed), isFalse);
      },
    );

    blocTest<MessageThreadCubit, MessageThreadState>(
      'an empty draft sends nothing',
      build: () {
        when(
          () => getThread(any()),
        ).thenAnswer((_) async => Result.success(thread()));
        when(
          () => getMessages(any()),
        ).thenAnswer((_) async => const Result.success([]));
        return build(threadId: 't1');
      },
      act: (cubit) async {
        await cubit.load();
        cubit.setDraft('   ');
        await cubit.send();
      },
      verify: (_) => verifyNever(() => reply(any())),
    );

    blocTest<MessageThreadCubit, MessageThreadState>(
      'the owner writes as the owner',
      build: () {
        when(() => getThread(any())).thenAnswer(
          (_) async => Result.success(thread(side: MessageSide.owner)),
        );
        // The server computes `side` per caller and returns it on every
        // thread it hands back, this one included.
        when(() => markRead(any())).thenAnswer(
          (_) async => Result.success(thread(side: MessageSide.owner)),
        );
        when(
          () => getMessages(any()),
        ).thenAnswer((_) async => const Result.success([]));
        when(() => reply(any())).thenAnswer(
          (_) async => Result.success(message('b', sender: MessageSide.owner)),
        );
        return build(threadId: 't1');
      },
      act: (cubit) async {
        await cubit.load();
        cubit.setDraft('Yes, three sizes.');
        await cubit.send();
      },
      // Alignment is a property of the viewer; getting this wrong renders the
      // shop's own replies on the customer's side of the screen.
      verify: (cubit) => expect(cubit.state.mySide, MessageSide.owner),
    );
  });

  group('BusinessContactCubit', () {
    late MockMessageBusiness messageBusiness;

    setUp(() => messageBusiness = MockMessageBusiness());

    BusinessContactCubit build() => BusinessContactCubit(
      messageBusiness: messageBusiness,
      businessId: 'b1',
    );

    blocTest<BusinessContactCubit, BusinessContactState>(
      'a sent enquiry reports the conversation it opened',
      build: () {
        when(
          () => messageBusiness(any()),
        ).thenAnswer((_) async => Result.success(thread()));
        return build();
      },
      act: (cubit) => cubit.send(
        body: 'Do you have brass diyo?',
        name: 'Kritika',
        email: 'k@example.com',
      ),
      verify: (cubit) {
        expect(cubit.state.sentThread?.id, 't1');
        final params =
            verify(() => messageBusiness(captureAny())).captured.single
                as MessageBusinessParams;
        expect(params.contactName, 'Kritika');
        expect(params.contactEmail, 'k@example.com');
      },
    );

    blocTest<BusinessContactCubit, BusinessContactState>(
      'a blank message is not sent at all',
      build: build,
      act: (cubit) => cubit.send(body: '   '),
      expect: () => <BusinessContactState>[],
      verify: (_) => verifyNever(() => messageBusiness(any())),
    );

    blocTest<BusinessContactCubit, BusinessContactState>(
      'a refusal is reported instead of a success message',
      build: () {
        when(() => messageBusiness(any())).thenAnswer(
          (_) async => const Result.failure(
            Failure.validation('This business is not accepting messages yet'),
          ),
        );
        return build();
      },
      act: (cubit) => cubit.send(body: 'hello'),
      verify: (cubit) {
        // The old form showed a success snackbar for a message that went
        // nowhere; the failure has to reach the user.
        expect(
          cubit.state.errorMessage,
          'This business is not accepting messages yet',
        );
        expect(cubit.state.sentThread, isNull);
      },
    );

    blocTest<BusinessContactCubit, BusinessContactState>(
      'editing the form clears a stale error',
      build: () {
        when(
          () => messageBusiness(any()),
        ).thenAnswer((_) async => const Result.failure(failure));
        return build();
      },
      act: (cubit) async {
        await cubit.send(body: 'hello');
        cubit.dismissError();
      },
      verify: (cubit) => expect(cubit.state.errorMessage, isNull),
    );
  });
}
