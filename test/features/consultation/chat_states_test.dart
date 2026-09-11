import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/chat_message.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/presentation/cubit/astrologer_session_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/presentation/cubit/live_session_cubit.dart';

/// A live chat has three states, and conflating two of them is what left an
/// accepted consultation spinning forever: an empty message list was rendered
/// as "still loading", so a session that had just started — which correctly
/// has no messages — never finished loading.
void main() {
  final message = ChatMessage(
    id: '01M25WCBDN68ERQ2TG5QMFXZZZ',
    consultationId: '01M25WCBDN68ERQ2TG5QMFXZH8',
    sender: ChatSender.astrologer,
    text: 'namaste',
    sentAt: DateTime(2026, 9, 10),
  );

  group('seeker chat', () {
    test('is loading only before the first fetch returns', () {
      const state = LiveSessionState(messages: LoadState.loading());

      expect(state.isLoadingChat, isTrue);
      expect(state.hasNoMessagesYet, isFalse);
    });

    test('an accepted session with no messages is empty, not loading', () {
      // The exact case that hung: accepted, active, zero messages.
      const state = LiveSessionState(
        messages: LoadState.loaded(<ChatMessage>[]),
      );

      expect(state.isLoadingChat, isFalse);
      expect(state.hasNoMessagesYet, isTrue);
      expect(state.chatError, isNull);
    });

    test('a failed fetch reports itself instead of spinning', () {
      const state = LiveSessionState(
        messages: LoadState.failed(ServerFailure('down')),
      );

      expect(state.isLoadingChat, isFalse);
      expect(state.chatError, 'down');
    });

    test('messages present means neither loading nor empty', () {
      final state = LiveSessionState(messages: LoadState.loaded([message]));

      expect(state.isLoadingChat, isFalse);
      expect(state.hasNoMessagesYet, isFalse);
      expect(state.chat, hasLength(1));
    });

    test('a refresh failure keeps the messages already on screen', () {
      final state = LiveSessionState(
        messages: LoadState.failed(
          const ServerFailure('flaky'),
          previous: [message],
        ),
      );

      // Still readable, and not mistaken for an error page.
      expect(state.chat, hasLength(1));
      expect(state.chatError, isNull);
      expect(state.isLoadingChat, isFalse);
    });
  });

  group('astrologer console chat', () {
    test('an accepted session with no messages is empty, not loading', () {
      const state = AstrologerSessionState(
        messages: LoadState.loaded(<ChatMessage>[]),
      );

      expect(state.isLoadingChat, isFalse);
      expect(state.hasNoMessagesYet, isTrue);
    });

    test('is loading before the first fetch', () {
      const state = AstrologerSessionState();

      expect(state.isLoadingChat, isTrue);
    });
  });
}
