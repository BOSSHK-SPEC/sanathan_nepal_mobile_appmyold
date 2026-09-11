import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/role_granter.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/data/datasources/mock_console_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/astrologer_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/compliance_notice.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/work_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/specialty.dart';

class _NoopGranter implements RoleGranter {
  @override
  Future<void> grant(AppRole role) async {}

  @override
  Future<void> revoke(AppRole role) async {}
}

void main() {
  late InMemoryKeyValueStore store;

  MockConsoleDataSource sourceFor([Region region = Region.nepal]) =>
      MockConsoleDataSource(store, FixedRegionResolver(region), _NoopGranter());

  const publishable = AstrologerProfileDraft(
    displayName: 'Uttam Upadhyaya',
    headline: '12+ years · Vedic',
    about:
        'I read charts in the parashari tradition and have practised for '
        'over a decade in Kathmandu.',
    specialties: [Specialty.vedic],
    languageCodes: ['ne', 'en'],
    experienceYears: 12,
  );

  setUp(() => store = InMemoryKeyValueStore());

  group('Public profile', () {
    test('seeds from the application on first read', () async {
      final source = sourceFor();
      final profile = await source.profile();
      // The seeded application is empty in a fresh store, so the seeded
      // profile is empty too — but it must not throw or invent content.
      expect(profile.displayName, isEmpty);
      expect(profile.isPublishable, isFalse);
    });

    test('an incomplete profile cannot be published', () async {
      await expectLater(
        sourceFor().saveProfile(publishable.copyWith(about: 'Too short.')),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a published profile round-trips', () async {
      final source = sourceFor();
      await source.saveProfile(publishable.copyWith(hiddenFromSearch: true));

      final read = await source.profile();
      expect(read.displayName, publishable.displayName);
      expect(read.specialties, publishable.specialties);
      expect(read.languageCodes, publishable.languageCodes);
      expect(read.hiddenFromSearch, isTrue);
    });

    test('completeness rises as the profile fills out', () async {
      final thin = publishable.completeness;
      final full = publishable
          .copyWith(avatarRef: 'a.jpg', introVideoRef: 'v.mp4')
          .completeness;
      expect(full, greaterThan(thin));
      expect(full, 1);
    });
  });

  group('Work preferences', () {
    test('defaults accept every channel', () async {
      final prefs = await sourceFor().workPreferences();
      for (final channel in ConsultChannel.values) {
        expect(prefs.acceptsChannel(channel), isTrue);
      }
      expect(prefs.maxQueueLength, 0);
    });

    test('an out-of-range auto-decline is refused', () async {
      await expectLater(
        sourceFor().saveWorkPreferences(
          const WorkPreferences(autoDeclineAfterSeconds: 5),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('preferences round-trip', () async {
      final source = sourceFor();
      await source.saveWorkPreferences(
        const WorkPreferences(
          quietHoursEnabled: true,
          quietStartMinute: 23 * 60,
          quietEndMinute: 6 * 60,
          acceptedChannels: {ConsultChannel.chat},
          maxQueueLength: 4,
          autoDeclineAfterSeconds: 45,
        ),
      );

      final read = await source.workPreferences();
      expect(read.quietHoursEnabled, isTrue);
      expect(read.acceptedChannels, {ConsultChannel.chat});
      expect(read.acceptsChannel(ConsultChannel.voice), isFalse);
      expect(read.maxQueueLength, 4);
      expect(read.autoDeclineAfterSeconds, 45);
    });

    test('a quiet window wrapping midnight covers both sides', () {
      const prefs = WorkPreferences(
        quietHoursEnabled: true,
        quietStartMinute: 22 * 60,
        quietEndMinute: 7 * 60,
      );
      expect(prefs.isQuietAt(23 * 60), isTrue);
      expect(prefs.isQuietAt(2 * 60), isTrue);
      expect(prefs.isQuietAt(12 * 60), isFalse);
    });

    test('a quiet window inside one day does not wrap', () {
      const prefs = WorkPreferences(
        quietHoursEnabled: true,
        quietStartMinute: 13 * 60,
        quietEndMinute: 15 * 60,
      );
      expect(prefs.isQuietAt(14 * 60), isTrue);
      expect(prefs.isQuietAt(23 * 60), isFalse);
    });
  });

  group('Compliance notices', () {
    test('seeded newest first, with at least one open', () async {
      final notices = await sourceFor().complianceNotices();
      expect(notices, isNotEmpty);
      expect(notices.any((n) => n.isOpen), isTrue);
      for (var i = 1; i < notices.length; i++) {
        expect(notices[i - 1].issuedAt.isBefore(notices[i].issuedAt), isFalse);
      }
    });

    test('acknowledging is recorded and persists', () async {
      final source = sourceFor();
      final open = (await source.complianceNotices()).firstWhere(
        (n) => n.isOpen,
      );

      final acked = await source.acknowledgeNotice(open.id);
      expect(acked.status, ComplianceStatus.acknowledged);
      expect(acked.acknowledgedAt, isNotNull);

      final reread = (await source.complianceNotices()).firstWhere(
        (n) => n.id == open.id,
      );
      expect(reread.status, ComplianceStatus.acknowledged);
    });

    test('an appeal needs a real explanation', () async {
      final source = sourceFor();
      final open = (await source.complianceNotices()).firstWhere(
        (n) => n.canAppeal,
      );

      await expectLater(
        source.appealNotice(open.id, 'nope'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a notice that is not appealable cannot be appealed', () async {
      final source = sourceFor();
      final fixed = (await source.complianceNotices()).firstWhere(
        (n) => !n.appealable,
      );

      await expectLater(
        source.appealNotice(
          fixed.id,
          'I believe this policy does not apply to my practice.',
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('an appeal is recorded with its reason', () async {
      final source = sourceFor();
      final open = (await source.complianceNotices()).firstWhere(
        (n) => n.canAppeal,
      );

      const reason = 'The call dropped because of a network outage at my end.';
      final appealed = await source.appealNotice(open.id, reason);
      expect(appealed.status, ComplianceStatus.appealed);
      expect(appealed.appealReason, reason);
      expect(appealed.appealedAt, isNotNull);
    });

    test('an unknown notice is not found', () async {
      await expectLater(
        sourceFor().acknowledgeNotice('notice-nope'),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('the policy notice names the region currency', () async {
      final india = await sourceFor(Region.india).complianceNotices();
      final policy = india.firstWhere(
        (n) => n.kind == ComplianceKind.policyUpdate,
      );
      expect(policy.body, contains('INR'));
    });
  });
}
