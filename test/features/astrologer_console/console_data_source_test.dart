import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/role_granter.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/data/datasources/mock_console_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/application.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/availability.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/console_pricing.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/earnings.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/payout.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/queue_entry.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/specialty.dart';

/// Records grants so approval can be asserted without a profile store.
class _RecordingGranter implements RoleGranter {
  final List<AppRole> granted = [];

  @override
  Future<void> grant(AppRole role) async => granted.add(role);

  @override
  Future<void> revoke(AppRole role) async {}
}

void main() {
  late InMemoryKeyValueStore store;
  late _RecordingGranter granter;

  MockConsoleDataSource sourceFor([Region region = Region.nepal]) =>
      MockConsoleDataSource(store, FixedRegionResolver(region), granter);

  setUp(() {
    store = InMemoryKeyValueStore();
    granter = _RecordingGranter();
  });

  /// An application with every step satisfied except the documents.
  AstrologerApplication completeForm() => const AstrologerApplication(
    fullName: 'Uttam Upadhyaya',
    phone: '9841000000',
    experienceYears: 12,
    bio:
        'Twenty years of chart reading in Kathmandu, focused on career and '
        'marriage questions.',
    specialties: [Specialty.vedic],
    languageCodes: ['ne'],
    ratePerMinute: {ConsultChannel.chat: 25},
  );

  Future<void> uploadRequired(MockConsoleDataSource source) async {
    for (final kind in KycDocumentKind.values.where((k) => k.isRequired)) {
      await source.uploadDocument(kind: kind, fileRef: 'file://${kind.name}');
    }
  }

  group('KYC document requirements', () {
    test('every required document is collected by some step', () {
      // The bug this guards: `addressProof` was required but no step showed
      // a field for it, so the wizard reported every step complete and
      // submission then failed with "upload every required document" —
      // an instruction the user could not act on.
      for (final kind in KycDocumentKind.values) {
        expect(
          KycDocumentKind.forStep(kind.step),
          contains(kind),
          reason: '$kind must belong to the step that collects it',
        );
      }
    });

    test(
      'a missing required document blocks its own step, not just submit',
      () async {
        final source = sourceFor();
        await source.saveApplication(completeForm());
        await source.acceptTerms('v1');

        // Nothing uploaded: the identity step itself must report incomplete.
        var application = await source.application();
        expect(application.identityComplete, isFalse);
        expect(application.isStepComplete(KycStep.identity), isFalse);
        expect(application.canSubmit, isFalse);

        await uploadRequired(source);
        application = await source.application();
        expect(application.isStepComplete(KycStep.identity), isTrue);
      },
    );

    test('completing every step is enough to submit', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm());
      await uploadRequired(source);
      await source.acceptTerms('v1');

      final application = await source.application();
      // No requirement lives outside a step, so these two must agree.
      expect(
        KycStep.values.every(application.isStepComplete),
        application.canSubmit,
      );
      expect(application.canSubmit, isTrue);
      await expectLater(source.submitApplication(), completes);
    });

    test('optional documents never block anything', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm());
      await uploadRequired(source);
      await source.acceptTerms('v1');

      final application = await source.application();
      // Certificate and address proof are deliberately not uploaded.
      expect(
        application.documentFor(KycDocumentKind.certificate).isSatisfied,
        isFalse,
      );
      expect(
        application.documentFor(KycDocumentKind.addressProof).isSatisfied,
        isFalse,
      );
      expect(application.canSubmit, isTrue);
    });
  });

  group('Application', () {
    test('starts empty and not started', () async {
      final application = await sourceFor().application();
      expect(application.status, ApplicationStatus.notStarted);
      expect(application.canSubmit, isFalse);
      expect(application.completedSteps, 0);
    });

    test('saving promotes it to a draft and persists', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm());
      final reloaded = await sourceFor().application();
      expect(reloaded.status, ApplicationStatus.draft);
      expect(reloaded.fullName, 'Uttam Upadhyaya');
    });

    test('step completion follows the fields', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm());
      await uploadRequired(source);
      final application = await source.application();

      expect(application.isStepComplete(KycStep.identity), isTrue);
      expect(application.isStepComplete(KycStep.credentials), isTrue);
      expect(application.isStepComplete(KycStep.expertise), isTrue);
      expect(application.isStepComplete(KycStep.pricing), isTrue);
      // Terms not yet accepted.
      expect(application.isStepComplete(KycStep.introduction), isFalse);
      expect(application.canSubmit, isFalse);
    });

    test('a short bio blocks the credentials step', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm().copyWith(bio: 'Too short'));
      final application = await source.application();
      expect(application.credentialsComplete, isFalse);
    });

    test('certificates are optional, identity documents are not', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm());
      var application = await source.application();
      expect(
        application.missingRequired.map((d) => d.kind),
        isNot(contains(KycDocumentKind.certificate)),
      );
      expect(
        application.missingRequired.map((d) => d.kind),
        contains(KycDocumentKind.identityFront),
      );

      await uploadRequired(source);
      application = await source.application();
      expect(application.missingRequired, isEmpty);
    });

    test('submitting without documents is rejected', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm());
      await source.acceptTerms('v1');
      expect(source.submitApplication, throwsA(isA<ValidationException>()));
    });

    test('review advances on the clock and grants the role', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm());
      await uploadRequired(source);
      await source.acceptTerms('v1');
      await source.submitApplication();

      // Nothing has been granted while the decision is outstanding.
      expect(granter.granted, isEmpty);
      expect((await source.application()).status, ApplicationStatus.submitted);

      // Rewind past the review window: the decision lands and the role is
      // granted, which is what actually unlocks the console.
      await _rewindSubmission(store, MockConsoleDataSource.reviewAfter * 2);
      final reviewed = await source.application();
      expect(reviewed.status, ApplicationStatus.approved);
      expect(reviewed.reviewedAt, isNotNull);
      expect(granter.granted, [AppRole.astrologer]);
    });

    test('an approved application is not re-granted on every read', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm());
      await uploadRequired(source);
      await source.acceptTerms('v1');
      await source.submitApplication();
      await _rewindSubmission(store, MockConsoleDataSource.reviewAfter * 2);

      await source.application();
      await source.application();
      expect(granter.granted, hasLength(1));
    });

    test('a complete application submits and locks', () async {
      final source = sourceFor();
      await source.saveApplication(completeForm());
      await uploadRequired(source);
      await source.acceptTerms('v1');

      final submitted = await source.submitApplication();
      expect(submitted.status, ApplicationStatus.submitted);
      expect(submitted.submittedAt, isNotNull);
      expect(submitted.status.isEditable, isFalse);

      // Editing after submission is refused.
      expect(
        () => source.saveApplication(completeForm()),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('Availability', () {
    test('rejects a window that ends before it starts', () async {
      expect(
        () => sourceFor().saveAvailability(
          const Availability(
            windows: [
              AvailabilityWindow(weekday: 1, startMinute: 600, endMinute: 540),
            ],
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rejects two overlapping windows on the same day', () async {
      expect(
        () => sourceFor().saveAvailability(
          const Availability(
            windows: [
              AvailabilityWindow(weekday: 1, startMinute: 540, endMinute: 720),
              AvailabilityWindow(weekday: 1, startMinute: 660, endMinute: 840),
            ],
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('accepts the same hours on different days', () async {
      final saved = await sourceFor().saveAvailability(
        const Availability(
          windows: [
            AvailabilityWindow(weekday: 1, startMinute: 540, endMinute: 720),
            AvailabilityWindow(weekday: 2, startMinute: 540, endMinute: 720),
          ],
        ),
      );
      expect(saved.windows, hasLength(2));
      expect(saved.weeklyHours, 6);
    });

    test('going online requires a schedule', () async {
      final source = sourceFor();
      await source.saveAvailability(const Availability());
      expect(
        () => source.setOnline(online: true),
        throwsA(isA<ValidationException>()),
      );
    });

    test('the queue is empty while offline', () async {
      final source = sourceFor();
      await source.setOnline(online: false);
      expect(await source.queue(), isEmpty);
      expect(await source.pendingRequest(), isNull);
    });

    test('the queue fills once online', () async {
      final source = sourceFor();
      await source.setOnline(online: true);
      expect(await source.queue(), isNotEmpty);
      expect(await source.pendingRequest(), isNotNull);
    });
  });

  group('Requests', () {
    test('declining removes the person from the queue', () async {
      final source = sourceFor();
      await source.setOnline(online: true);
      final before = await source.queue();

      await source.respondToRequest(requestId: before.first.id, accept: false);
      final after = await source.queue();
      expect(after.length, before.length - 1);
      expect(after.map((e) => e.id), isNot(contains(before.first.id)));
    });

    test('accepting leaves the queue intact', () async {
      final source = sourceFor();
      await source.setOnline(online: true);
      final before = await source.queue();
      await source.respondToRequest(requestId: before.first.id, accept: true);
      expect((await source.queue()).length, before.length);
    });

    test('the longest waiter is offered first', () async {
      final source = sourceFor();
      await source.setOnline(online: true);
      final queue = await source.queue();
      final request = await source.pendingRequest();
      final oldest = queue.reduce(
        (a, b) => a.joinedAt.isBefore(b.joinedAt) ? a : b,
      );
      expect(request!.entry.id, oldest.id);
    });

    test('a request counts down and expires', () {
      final request = IncomingRequestFixture.offeredSecondsAgo(10);
      expect(request.secondsRemaining(), 20);
      expect(request.progress(), closeTo(20 / 30, 0.01));
      expect(request.isExpired, isFalse);

      final expired = IncomingRequestFixture.offeredSecondsAgo(40);
      expect(expired.secondsRemaining(), 0);
      expect(expired.isExpired, isTrue);
    });
  });

  group('Earnings', () {
    test('net is gross minus commission across the range', () async {
      final summary = await sourceFor().earnings(EarningsRange.month);
      expect(summary.entries, isNotEmpty);
      expect(summary.net, closeTo(summary.gross - summary.commission, 0.01));
      expect(summary.effectiveCommissionRate, closeTo(0.2, 0.001));
    });

    test('a wider range includes at least as much', () async {
      final source = sourceFor();
      final week = await source.earnings(EarningsRange.week);
      final month = await source.earnings(EarningsRange.month);
      expect(month.entries.length, greaterThanOrEqualTo(week.entries.length));
    });

    test('India amounts are scaled, not reused verbatim', () async {
      final np = await sourceFor().earnings(EarningsRange.year);
      final ind = await sourceFor(Region.india).earnings(EarningsRange.year);
      expect(ind.gross, lessThan(np.gross));
    });

    test('performance metrics derive from the same entries', () async {
      final source = sourceFor();
      final summary = await source.earnings(EarningsRange.month);
      final metrics = await source.performance(EarningsRange.month);
      expect(metrics.totalSessions, summary.sessions);
      expect(metrics.totalMinutes, summary.minutes);
      expect(
        metrics.averageSessionMinutes,
        closeTo(summary.minutes / summary.sessions, 0.01),
      );
    });
  });

  group('Payouts', () {
    Future<PayoutAccount> addAccount(MockConsoleDataSource source) =>
        source.savePayoutAccount(
          const PayoutAccount(
            destination: PayoutDestination.esewa,
            identifier: '9841000000',
            holderName: 'Uttam Upadhyaya',
          ),
        );

    test(
      'a saved account starts pending verification, never verified',
      () async {
        final source = sourceFor();
        final saved = await addAccount(source);
        expect(saved.verification, VerificationState.pending);
        expect(saved.isUsable, isFalse);
        expect(saved.maskedIdentifier, '••••0000');
      },
    );

    test('rejects a destination the region does not offer', () async {
      // UPI is India-only.
      expect(
        () => sourceFor().savePayoutAccount(
          const PayoutAccount(
            destination: PayoutDestination.upi,
            identifier: 'a@upi',
            holderName: 'A',
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rejects blank details', () async {
      expect(
        () => sourceFor().savePayoutAccount(
          const PayoutAccount(
            destination: PayoutDestination.esewa,
            identifier: '  ',
            holderName: 'A',
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('withdrawing without an account is rejected', () async {
      expect(
        () => sourceFor().requestPayout(1000),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rejects an amount below the minimum', () async {
      final source = sourceFor();
      await addAccount(source);
      expect(
        () => source.requestPayout(MockConsoleDataSource.minimumPayout - 1),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rejects more than the available balance', () async {
      final source = sourceFor();
      await addAccount(source);
      final summary = await source.earnings(EarningsRange.year);
      expect(
        () => source.requestPayout(summary.availableBalance + 1000),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a valid request is recorded and reduces what is available', () async {
      final source = sourceFor();
      await addAccount(source);
      final before = await source.earnings(EarningsRange.year);
      final request = await source.requestPayout(1000);

      expect(request.status, PayoutStatus.requested);
      expect(request.netAmount, 1000 - request.fee);
      expect(request.isOpen, isTrue);

      final after = await source.earnings(EarningsRange.year);
      expect(after.availableBalance, lessThan(before.availableBalance));
    });
  });

  group('Pricing', () {
    test('rejects an empty rate card', () async {
      expect(
        () => sourceFor().savePricing(const ConsolePricing()),
        throwsA(isA<ValidationException>()),
      );
    });

    test('round-trips and computes the net after commission', () async {
      final source = sourceFor();
      final saved = await source.savePricing(
        const ConsolePricing(
          ratePerMinute: {ConsultChannel.chat: 30},
          freeFirstMinutes: 2,
        ),
      );
      expect(saved.rateFor(ConsultChannel.chat), 30);
      expect(saved.netPerMinute(ConsultChannel.chat), closeTo(24, 0.001));
      expect(saved.offers(ConsultChannel.video), isFalse);

      final reloaded = await sourceFor().pricing();
      expect(reloaded.rateFor(ConsultChannel.chat), 30);
      expect(reloaded.freeFirstMinutes, 2);
    });
  });

  group('Reviews', () {
    test('replying stores the reply and blocks a second one', () async {
      final source = sourceFor();
      final unanswered = (await source.reviews()).firstWhere(
        (r) => !r.hasReply,
      );

      final replied = await source.replyToReview(
        reviewId: unanswered.id,
        reply: 'Thank you for the feedback.',
      );
      expect(replied.hasReply, isTrue);

      expect(
        () => source.replyToReview(reviewId: unanswered.id, reply: 'Again'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rejects an empty reply', () async {
      final source = sourceFor();
      final unanswered = (await source.reviews()).firstWhere(
        (r) => !r.hasReply,
      );
      expect(
        () => source.replyToReview(reviewId: unanswered.id, reply: '   '),
        throwsA(isA<ValidationException>()),
      );
    });

    test('an unknown review is a not-found error', () async {
      expect(
        () => sourceFor().replyToReview(reviewId: 'nope', reply: 'Hi'),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  group('Clients', () {
    test('notes persist and survive a reload', () async {
      final source = sourceFor();
      await source.saveClientNotes(clientId: 'c1', notes: 'Prefers evenings');
      final client = await sourceFor().client('c1');
      expect(client.notes, 'Prefers evenings');
    });

    test('an unknown client is a not-found error', () async {
      expect(
        () => sourceFor().client('nope'),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('repeat clients are identified by session count', () async {
      final clients = await sourceFor().clients();
      expect(clients.where((c) => c.isRepeat), isNotEmpty);
      for (final client in clients) {
        expect(client.isRepeat, client.sessionCount > 1);
        expect(
          client.averageSessionValue,
          closeTo(client.lifetimeValue / client.sessionCount, 0.01),
        );
      }
    });
  });
}

/// Builds an [IncomingRequest] offered a chosen number of seconds ago.
abstract final class IncomingRequestFixture {
  static IncomingRequest offeredSecondsAgo(int seconds) => IncomingRequest(
    entry: QueueEntryFixture.any,
    offeredAt: DateTime.now().subtract(Duration(seconds: seconds)),
  );
}

abstract final class QueueEntryFixture {
  static QueueEntry get any => QueueEntry(
    id: 'q1',
    seekerName: 'Test',
    channel: ConsultChannel.chat,
    joinedAt: DateTime.now(),
  );
}

/// Shifts a submitted application's timestamp back so the review window can
/// be crossed without waiting in real time.
Future<void> _rewindSubmission(InMemoryKeyValueStore store, Duration by) async {
  const key = 'console.application';
  final decoded = jsonDecode(store.getString(key)!) as Map<String, dynamic>;
  decoded['submittedAt'] = DateTime.parse(
    decoded['submittedAt'] as String,
  ).subtract(by).toIso8601String();
  await store.setString(key, jsonEncode(decoded));
}
