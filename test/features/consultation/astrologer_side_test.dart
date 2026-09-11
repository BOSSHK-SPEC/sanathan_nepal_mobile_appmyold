import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/billing/spending_account.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/localized_text.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/data/datasources/mock_astrologer_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/data/repositories/astrologer_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/data/datasources/mock_consultation_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/astrologer_session.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/chat_message.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/consult_intake.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/consultation.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/session_summary.dart';

class _Account implements SpendingAccount {
  double balance = 100000;

  @override
  Future<double> spendable() async => balance;

  @override
  Future<void> charge({
    required double amount,
    required SpendCategory category,
    required String description,
    String? referenceId,
  }) async {
    balance -= amount;
  }
}

void main() {
  late InMemoryKeyValueStore store;

  MockConsultationDataSource sourceFor() => MockConsultationDataSource(
    store: store,
    astrologers: AstrologerRepositoryImpl(
      MockAstrologerDataSource(store, const FixedRegionResolver(Region.nepal)),
    ),
    account: _Account(),
  );

  setUp(() => store = InMemoryKeyValueStore());

  const accept = QueueAcceptRequest(
    queueEntryId: 'q1',
    seekerName: 'Sabina K.',
    channel: ConsultChannel.chat,
    ratePerMinute: 25,
    question: 'Should I accept the job offer?',
  );

  group('Accepting from the queue', () {
    test(
      'opens an already-active session — no queue to wait through',
      () async {
        final session = await sourceFor().acceptFromQueue(accept);
        expect(session.status, ConsultationStatus.active);
        expect(session.startedAt, isNotNull);
        expect(session.queuePosition, 0);
        expect(session.ratePerMinute, 25);
      },
    );

    test('seeds the thread with the seeker\'s question', () async {
      final source = sourceFor();
      final session = await source.acceptFromQueue(accept);
      final messages = await source.messages(session.id);
      expect(
        messages.any(
          (m) =>
              m.sender == ChatSender.seeker &&
              m.text == 'Should I accept the job offer?',
        ),
        isTrue,
      );
    });

    test('astrologer sessions are kept apart from the seeker\'s own', () async {
      final source = sourceFor();
      await source.acceptFromQueue(accept);
      await source.start(
        const ConsultIntake(
          astrologerId: 'np-uttam',
          channel: ConsultChannel.chat,
          name: 'Me',
          birthPlace: 'Kathmandu',
        ),
      );

      final astrologerSide = await source.astrologerSessions();
      expect(astrologerSide, hasLength(1));
      expect(
        astrologerSide.single.id,
        startsWith(MockConsultationDataSource.astrologerPrefix),
      );

      // The seeker's history and active-session lookup must not see it.
      final active = await source.activeSession();
      expect(active, isNotNull);
      expect(
        active!.id,
        isNot(startsWith(MockConsultationDataSource.astrologerPrefix)),
      );
    });
  });

  group('Messaging as the astrologer', () {
    test('lands in the same thread as the seeker\'s messages', () async {
      final source = sourceFor();
      final session = await source.acceptFromQueue(accept);

      await source.sendAsAstrologer(
        consultationId: session.id,
        text: 'Namaste, let me look at your chart.',
      );
      await source.send(consultationId: session.id, text: 'Thank you');

      final messages = await source.messages(session.id);
      expect(messages.any((m) => m.sender == ChatSender.astrologer), isTrue);
      expect(messages.any((m) => m.sender == ChatSender.seeker), isTrue);
    });

    test('rejects an empty message', () async {
      final source = sourceFor();
      final session = await source.acceptFromQueue(accept);
      expect(
        () => source.sendAsAstrologer(consultationId: session.id, text: '   '),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rejects sending after the session ends', () async {
      final source = sourceFor();
      final session = await source.acceptFromQueue(accept);
      await source.end(session.id);
      expect(
        () =>
            source.sendAsAstrologer(consultationId: session.id, text: 'Hello'),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('Write-up', () {
    Future<Consultation> finished(MockConsultationDataSource source) async {
      final session = await source.acceptFromQueue(accept);
      return source.end(session.id);
    }

    test('refuses before the session is finished', () async {
      final source = sourceFor();
      final session = await source.acceptFromQueue(accept);
      expect(
        () => source.saveNotes(
          SessionNotesDraft(
            consultationId: session.id,
            notes: 'A perfectly long enough set of notes here.',
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('refuses an empty write-up', () async {
      final source = sourceFor();
      final session = await finished(source);
      expect(
        () => source.saveNotes(
          SessionNotesDraft(consultationId: session.id, notes: 'Too short'),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a remedy alone is enough, without prose', () async {
      final source = sourceFor();
      final session = await finished(source);
      final summary = await source.saveNotes(
        SessionNotesDraft(
          consultationId: session.id,
          remedies: const [
            Remedy(
              kind: RemedyKind.mantra,
              title: LocalizedText(ne: 'शनि मन्त्र', en: 'Shani mantra'),
              description: LocalizedText(ne: '१०८ पटक', en: '108 times'),
            ),
          ],
        ),
      );
      expect(summary.remedies, hasLength(1));
      expect(summary.isEmpty, isFalse);
    });

    test(
      'replaces the scripted summary the seeker would otherwise read',
      () async {
        final source = sourceFor();
        final session = await finished(source);

        final scripted = await source.summary(session.id);
        expect(scripted.notes, isNotEmpty);

        await source.saveNotes(
          SessionNotesDraft(
            consultationId: session.id,
            notes: 'Jupiter supports the move after two months.',
          ),
        );
        final written = await source.summary(session.id);
        expect(written.notes, 'Jupiter supports the move after two months.');
        expect(written.notes, isNot(scripted.notes));
      },
    );
  });

  group('Active session lookup', () {
    test('is null when nothing is running', () async {
      expect(await sourceFor().activeSession(), isNull);
    });

    test('finds a live seeker session and drops it once ended', () async {
      final source = sourceFor();
      final started = await source.start(
        const ConsultIntake(
          astrologerId: 'np-uttam',
          channel: ConsultChannel.chat,
          name: 'Me',
          birthPlace: 'Kathmandu',
        ),
      );
      expect((await source.activeSession())?.id, started.id);

      await source.cancel(started.id);
      expect(await source.activeSession(), isNull);
    });
  });

  test('both sides read one record, so the meter cannot diverge', () async {
    final source = sourceFor();
    final session = await source.acceptFromQueue(accept);

    // The astrologer's view and a fresh read are the same record.
    final reread = await source.get(session.id);
    expect(reread.startedAt, session.startedAt);
    expect(reread.ratePerMinute, session.ratePerMinute);

    final ended = await source.end(session.id);
    expect(ended.billedSeconds, greaterThanOrEqualTo(0));
    // One started minute at 25.
    expect(ended.amountCharged, 25);
  });
}
