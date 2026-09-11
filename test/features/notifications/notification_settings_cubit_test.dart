import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/data/datasources/mock_notifications_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/data/datasources/notification_settings_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/domain/entities/notification_settings.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/domain/usecases/get_notification_settings.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/domain/usecases/save_notification_settings.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/presentation/cubit/notification_settings_cubit.dart';

void main() {
  late InMemoryKeyValueStore store;
  late NotificationRepositoryImpl repo;

  setUp(() {
    store = InMemoryKeyValueStore();
    repo = NotificationRepositoryImpl(
      inbox: MockNotificationsDataSource(
        resolver: const FixedRegionResolver(Region.nepal),
      ),
      settings: NotificationSettingsLocalDataSourceImpl(store),
    );
  });

  NotificationSettingsCubit build() => NotificationSettingsCubit(
    getSettings: GetNotificationSettings(repo),
    saveSettings: SaveNotificationSettings(repo),
  );

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'load emits loading → ready with defaults',
    build: build,
    act: (c) => c.load(),
    expect: () => const [
      NotificationSettingsState(settings: LoadState.loading()),
      NotificationSettingsState(
        settings: LoadState.loaded(NotificationSettings()),
      ),
    ],
  );

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'setters emit saving → ready and persist to the store',
    build: build,
    seed: () => const NotificationSettingsState(
      settings: LoadState.loaded(NotificationSettings()),
    ),
    act: (c) async {
      await c.setHoroscopeEnabled(false);
      await c.setFestivalRemindDays(5);
      await c.setBirthdayRemindTime(const NotificationTime(hour: 8, minute: 0));
      await c.setFestivalsEnabled(false);
    },
    verify: (c) {
      final s = c.state.current;
      expect(c.state.save.isLoaded, isTrue);
      expect(c.state.settings.isLoaded, isTrue);
      expect(s.horoscopeEnabled, isFalse);
      expect(s.festivalRemindDays, 5);
      expect(s.birthdayRemindTime, const NotificationTime(hour: 8, minute: 0));
      expect(s.festivalsEnabled, isFalse);
      expect(
        store.getString('notifications.settings'),
        contains('"festival_remind_days":5'),
      );
    },
  );

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'load restores persisted settings',
    build: build,
    setUp: () async => repo.saveSettings(
      const NotificationSettings(horoscopeDaily: false, birthdayRemindDays: 3),
    ),
    act: (c) => c.load(),
    verify: (c) {
      expect(c.state.current.horoscopeDaily, isFalse);
      expect(c.state.current.birthdayRemindDays, 3);
    },
  );
}
