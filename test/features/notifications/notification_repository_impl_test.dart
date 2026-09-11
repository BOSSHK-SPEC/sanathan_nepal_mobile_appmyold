import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/data/datasources/mock_notifications_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/data/datasources/notification_settings_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/data/datasources/notifications_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/data/models/app_notification_model.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/data/models/notification_settings_model.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/domain/entities/notification_settings.dart';

class _MockInbox extends Mock implements NotificationsDataSource {}

/// Region can be flipped mid-test to prove the seed is read at call time.
class _SwitchableResolver implements RegionResolver {
  _SwitchableResolver(this.region);
  @override
  Region region;
  @override
  RegionConfig get config => region.config;
}

void main() {
  late InMemoryKeyValueStore store;
  late NotificationRepositoryImpl repo;
  final now = DateTime(2026, 8, 17, 12);

  NotificationRepositoryImpl buildRepo(RegionResolver resolver) =>
      NotificationRepositoryImpl(
        inbox: MockNotificationsDataSource(resolver: resolver, now: now),
        settings: NotificationSettingsLocalDataSourceImpl(store),
      );

  setUp(() {
    store = InMemoryKeyValueStore();
    repo = buildRepo(const FixedRegionResolver(Region.nepal));
  });

  test(
    'getNotifications returns newest first; markAsRead / markAllAsRead',
    () async {
      final list = (await repo.getNotifications()).valueOrNull!;
      expect(list.length, 7);
      for (var i = 1; i < list.length; i++) {
        expect(list[i].createdAt.isAfter(list[i - 1].createdAt), isFalse);
      }
      expect(list.first.isRead, isFalse);

      final read = (await repo.markAsRead(list.first.id)).valueOrNull!;
      expect(read.isRead, isTrue);

      await repo.markAllAsRead();
      final all = (await repo.getNotifications()).valueOrNull!;
      expect(all.every((n) => n.isRead), isTrue);
    },
  );

  test('Nepal seed keeps Nepal-specific festival and welcome text', () async {
    final list = (await repo.getNotifications()).valueOrNull!;
    final titles = list.map((n) => n.titleEn).toList();
    expect(titles, contains('Dashain reminder'));
    expect(titles, contains('Welcome to Sanatan Nepal'));
    expect(titles, isNot(contains('Diwali reminder')));
  });

  test(
    'India seed swaps festival reminder and welcome text (region-neutral)',
    () async {
      final india = buildRepo(const FixedRegionResolver(Region.india));
      final list = (await india.getNotifications()).valueOrNull!;
      expect(list.length, 7);
      final titles = list.map((n) => n.titleEn).toList();
      expect(titles, contains('Diwali reminder'));
      expect(titles, isNot(contains('Dashain reminder')));
      final welcome = list.firstWhere((n) => n.id == 'n6');
      expect(welcome.titleEn, 'Welcome to Sanatan');
      expect(welcome.titleEn, isNot(contains('Nepal')));
      expect(welcome.titleHi, isNot(contains('नेपाल')));
      expect(welcome.titleNe, isNot(contains('नेपाल')));
      expect(welcome.bodyEn, isNot(contains('Nepal')));
      // Public holiday body stays neutral in both regions.
      final holiday = list.firstWhere((n) => n.id == 'n3');
      expect(holiday.titleEn, 'Public holiday tomorrow');
      expect(holiday.bodyEn, isNot(contains('Nepal')));
      // Every seed item carries Hindi text.
      expect(
        list.every((n) => n.titleHi.isNotEmpty && n.bodyHi.isNotEmpty),
        isTrue,
      );
      expect(
        list.firstWhere((n) => n.id == 'n7').titleFor('hi'),
        'दिवाली अनुस्मारक',
      );
    },
  );

  test(
    'seed follows a runtime region switch; read state survives it',
    () async {
      final resolver = _SwitchableResolver(Region.nepal);
      final source = MockNotificationsDataSource(resolver: resolver, now: now);
      expect(
        (await source.fetchAll()).firstWhere((n) => n.id == 'n7').titleEn,
        'Dashain reminder',
      );
      await source.markRead('n7');
      resolver.region = Region.india;
      final afterSwitch = (await source.fetchAll()).firstWhere(
        (n) => n.id == 'n7',
      );
      expect(afterSwitch.titleEn, 'Diwali reminder');
      expect(afterSwitch.isRead, isTrue);
      expect(
        (await source.fetchAll()).firstWhere((n) => n.id == 'n1').isRead,
        isFalse,
      );
    },
  );

  test(
    'AppNotificationModel round-trips Hindi text; hi falls back to en',
    () async {
      final model = AppNotificationModel(
        id: 'x',
        titleNe: 'ने',
        titleEn: 'En',
        titleHi: 'हि',
        bodyNe: 'ब',
        bodyEn: 'Body',
        createdAt: now,
      );
      final decoded = AppNotificationModel.fromJson(model.toJson());
      expect(decoded, model);
      final entity = decoded.toEntity();
      expect(entity.titleFor('hi'), 'हि');
      expect(entity.bodyFor('hi'), 'Body');
      expect(entity.titleFor('ne'), 'ने');
      expect(entity.title(nepali: false), 'En');
      expect(
        AppNotificationModel.fromJson({
          'id': 'y',
          'created_at': now.toIso8601String(),
        }).titleHi,
        '',
      );
    },
  );

  test(
    'settings default when nothing stored and round-trip through JSON',
    () async {
      expect(
        (await repo.getSettings()).valueOrNull,
        const NotificationSettings(),
      );

      const custom = NotificationSettings(
        horoscopeEnabled: false,
        horoscopeMonthly: true,
        horoscopeTime: NotificationTime(hour: 7, minute: 15),
        commonFestivals: true,
        festivalRemindDays: 3,
        birthdayRemindDays: 2,
        birthdayRemindTime: NotificationTime(hour: 18, minute: 0),
      );
      expect((await repo.saveSettings(custom)).isSuccess, isTrue);
      expect(
        store.getString('notifications.settings'),
        contains('"festival_remind_days":3'),
      );
      expect((await repo.getSettings()).valueOrNull, custom);
    },
  );

  test('corrupt stored JSON falls back to defaults', () async {
    await store.setString('notifications.settings', '{not json');
    expect(
      (await repo.getSettings()).valueOrNull,
      const NotificationSettings(),
    );
    expect(
      NotificationSettingsModel.decode('[]'),
      const NotificationSettingsModel(),
    );
  });

  test('inbox exceptions become failures', () async {
    final inbox = _MockInbox();
    when(inbox.fetchAll).thenThrow(const NetworkException());
    final r = NotificationRepositoryImpl(
      inbox: inbox,
      settings: NotificationSettingsLocalDataSourceImpl(store),
    );
    expect((await r.getNotifications()).failureOrNull, isA<NetworkFailure>());
  });
}
