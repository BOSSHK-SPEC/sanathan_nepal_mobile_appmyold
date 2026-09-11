import 'dart:convert';

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
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/consult_intake.dart';
import 'package:sanathan_nepal_mobile_app/features/consultation/domain/entities/consultation.dart';

/// Records charges so the tests can assert on billing without a wallet.
class _RecordingAccount implements SpendingAccount {
  _RecordingAccount(this.balance);

  double balance;
  final List<double> charges = [];

  @override
  Future<double> spendable() async => balance;

  @override
  Future<void> charge({
    required double amount,
    required SpendCategory category,
    required String description,
    String? referenceId,
  }) async {
    if (amount > balance) {
      throw const ValidationException('Not enough balance');
    }
    balance -= amount;
    charges.add(amount);
  }
}

void main() {
  late InMemoryKeyValueStore store;
  late _RecordingAccount account;

  MockConsultationDataSource sourceFor({double balance = 5000}) {
    account = _RecordingAccount(balance);
    return MockConsultationDataSource(
      store: store,
      astrologers: AstrologerRepositoryImpl(
        MockAstrologerDataSource(
          store,
          const FixedRegionResolver(Region.nepal),
        ),
      ),
      account: account,
    );
  }

  setUp(() => store = InMemoryKeyValueStore());

  const intake = ConsultIntake(
    astrologerId: 'np-uttam',
    channel: ConsultChannel.chat,
    name: 'Sita',
    birthPlace: 'Kathmandu',
    question: 'Career',
  );

  group('Starting', () {
    test('creates a queued session at the astrologer rate', () async {
      final session = await sourceFor().start(intake);
      expect(session.status, ConsultationStatus.queued);
      expect(session.ratePerMinute, 25);
      expect(session.queuePosition, 3);
      expect(session.startedAt, isNull);
      expect(session.amountCharged, 0);
    });

    test('refuses when the balance will not cover one minute', () async {
      final source = sourceFor(balance: 10);
      expect(() => source.start(intake), throwsA(isA<ValidationException>()));
    });

    test('refuses a channel the astrologer does not offer', () async {
      // np-sarita offers chat and voice, not video.
      expect(
        () => sourceFor().start(
          intake.copyWith(
            astrologerId: 'np-sarita',
            channel: ConsultChannel.video,
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('refuses an unknown astrologer', () async {
      expect(
        () => sourceFor().start(intake.copyWith(astrologerId: 'nope')),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  group('Progression', () {
    test('queue drains, then the astrologer accepts', () async {
      final source = sourceFor();
      final started = await source.start(
        // No queue, so it only has to wait for the accept grace period.
        intake.copyWith(astrologerId: 'np-anjali'),
      );
      expect(started.queuePosition, 1);

      // Rewind the creation time so the elapsed-time driver has advanced.
      await _rewind(store, started.id, const Duration(seconds: 7));
      final ringing = await source.refresh(started.id);
      expect(ringing.status, ConsultationStatus.ringing);

      await _rewind(store, started.id, const Duration(seconds: 12));
      final active = await source.refresh(started.id);
      expect(active.status, ConsultationStatus.active);
      expect(active.startedAt, isNotNull);
    });

    test(
      'scripted replies arrive as time passes and never duplicate',
      () async {
        final source = sourceFor();
        final started = await source.start(
          intake.copyWith(astrologerId: 'np-anjali'),
        );
        await _rewind(store, started.id, const Duration(seconds: 40));
        await source.refresh(started.id);

        final first = await source.messages(started.id);
        final scripted = first.where((m) => m.id.startsWith('m-script-'));
        expect(scripted, isNotEmpty);

        // Polling again must not append the same lines twice.
        await source.refresh(started.id);
        final second = await source.messages(started.id);
        expect(second.length, first.length);
      },
    );
  });

  group('Messaging', () {
    test('rejects sending before the session is active', () async {
      final source = sourceFor();
      final started = await source.start(intake);
      expect(
        () => source.send(consultationId: started.id, text: 'Hello'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rejects an empty message', () async {
      final source = sourceFor();
      final started = await source.start(
        intake.copyWith(astrologerId: 'np-anjali'),
      );
      await _rewind(store, started.id, const Duration(seconds: 12));
      await source.refresh(started.id);
      expect(
        () => source.send(consultationId: started.id, text: '   '),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a sent message is stored and comes back in order', () async {
      final source = sourceFor();
      final started = await source.start(
        intake.copyWith(astrologerId: 'np-anjali'),
      );
      await _rewind(store, started.id, const Duration(seconds: 12));
      await source.refresh(started.id);

      await source.send(consultationId: started.id, text: 'Hello ji');
      final messages = await source.messages(started.id);
      expect(messages.last.text, 'Hello ji');
      for (var i = 1; i < messages.length; i++) {
        expect(messages[i - 1].sentAt.isAfter(messages[i].sentAt), isFalse);
      }
    });
  });

  group('Ending', () {
    test('charges per started minute and fixes the duration', () async {
      final source = sourceFor();
      final started = await source.start(
        intake.copyWith(astrologerId: 'np-anjali'),
      );
      // Active for a little over one minute.
      await _rewind(store, started.id, const Duration(seconds: 75));
      await source.refresh(started.id);

      final ended = await source.end(started.id);
      expect(ended.status, ConsultationStatus.completed);
      expect(ended.billedSeconds, greaterThan(60));
      // 2 started minutes at the np-anjali chat rate of 12.
      expect(ended.amountCharged, 24);
      expect(account.charges, [24]);
    });

    test('ending a queued session cancels it and charges nothing', () async {
      final source = sourceFor();
      final started = await source.start(intake);
      final ended = await source.end(started.id);
      expect(ended.status, ConsultationStatus.cancelled);
      expect(ended.amountCharged, 0);
      expect(account.charges, isEmpty);
    });

    test('is idempotent — a second end does not double-charge', () async {
      final source = sourceFor();
      final started = await source.start(
        intake.copyWith(astrologerId: 'np-anjali'),
      );
      await _rewind(store, started.id, const Duration(seconds: 70));
      await source.refresh(started.id);

      await source.end(started.id);
      await source.end(started.id);
      expect(account.charges, hasLength(1));
    });

    test('a rejected charge leaves the session uncompleted', () async {
      final source = sourceFor(balance: 12);
      final started = await source.start(
        intake.copyWith(astrologerId: 'np-anjali'),
      );
      // Long enough that the charge exceeds the remaining balance.
      await _rewind(store, started.id, const Duration(seconds: 200));
      await source.refresh(started.id);

      await expectLater(
        source.end(started.id),
        throwsA(isA<ValidationException>()),
      );
      final after = await source.get(started.id);
      expect(after.status, ConsultationStatus.active);
      expect(account.charges, isEmpty);
    });

    test('cancelling never charges', () async {
      final source = sourceFor();
      final started = await source.start(intake);
      final cancelled = await source.cancel(started.id);
      expect(cancelled.status, ConsultationStatus.cancelled);
      expect(account.charges, isEmpty);
    });
  });

  group('After the session', () {
    test('a completed chat gets notes, remedies and a transcript', () async {
      final source = sourceFor();
      final started = await source.start(
        intake.copyWith(astrologerId: 'np-anjali'),
      );
      await _rewind(store, started.id, const Duration(seconds: 70));
      await source.refresh(started.id);
      await source.end(started.id);

      final summary = await source.summary(started.id);
      expect(summary.notes, isNotEmpty);
      expect(summary.remedies, isNotEmpty);
      expect(summary.hasTranscript, isTrue);
      expect(summary.remedies.any((r) => r.isPurchasable), isTrue);
    });

    test('an unfinished session has an empty summary, not an error', () async {
      final source = sourceFor();
      final started = await source.start(intake);
      final summary = await source.summary(started.id);
      expect(summary.isEmpty, isTrue);
    });

    test('history contains only finished sessions, newest first', () async {
      final source = sourceFor();
      final a = await source.start(intake);
      await source.cancel(a.id);
      final b = await source.start(intake.copyWith(astrologerId: 'np-sarita'));

      final history = await source.history();
      expect(history.map((c) => c.id), contains(a.id));
      expect(history.map((c) => c.id), isNot(contains(b.id)));
    });
  });

  test('billing rounds up to the next started minute', () {
    final start = DateTime(2026, 9, 3, 10);
    final session = Consultation(
      id: 'c1',
      astrologerId: 'a',
      astrologerName: const LocalizedText(ne: 'क', en: 'A'),
      channel: ConsultChannel.chat,
      status: ConsultationStatus.active,
      ratePerMinute: 20,
      createdAt: start,
      startedAt: start,
    );
    // Nothing elapsed yet is genuinely zero; one second in is one minute.
    expect(session.billedMinutes(now: start), 0);
    expect(
      session.billedMinutes(now: start.add(const Duration(seconds: 1))),
      1,
    );
    expect(
      session.billedMinutes(now: start.add(const Duration(seconds: 60))),
      1,
    );
    expect(
      session.billedMinutes(now: start.add(const Duration(seconds: 61))),
      2,
    );
    expect(session.costSoFar(now: start.add(const Duration(seconds: 61))), 40);
  });
}

/// Shifts a stored session's timestamps back so elapsed-time behaviour can be
/// tested without waiting in real time.
Future<void> _rewind(
  InMemoryKeyValueStore store,
  String id,
  Duration by,
) async {
  const key = 'consultation.sessions';
  final raw = store.getString(key)!;
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  final session = decoded[id]! as Map<String, dynamic>;
  session['createdAt'] = DateTime.parse(
    session['createdAt'] as String,
  ).subtract(by).toIso8601String();
  if (session['startedAt'] != null) {
    session['startedAt'] = DateTime.parse(
      session['startedAt'] as String,
    ).subtract(by).toIso8601String();
  }
  await store.setString(key, jsonEncode(decoded));
}
