import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_notifications_data_source.dart';
import 'data/datasources/mock_notifications_data_source.dart';
import 'data/datasources/notification_settings_local_data_source.dart';
import 'data/datasources/notifications_data_source.dart';
import 'data/repositories/notification_repository_impl.dart';
import 'domain/repositories/notification_repository.dart';
import 'domain/usecases/get_notification_settings.dart';
import 'domain/usecases/get_notifications.dart';
import 'domain/usecases/mark_all_notifications_read.dart';
import 'domain/usecases/mark_notification_read.dart';
import 'domain/usecases/save_notification_settings.dart';
import 'presentation/cubit/notification_settings_cubit.dart';
import 'presentation/cubit/notifications_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `notifications`.
void registerNotificationsFeature(GetIt sl) {
  sl
    ..registerLazySingleton<NotificationsDataSource>(
      () => selectDataSource(
        mock: () => MockNotificationsDataSource(resolver: sl<RegionResolver>()),
        live: () => ApiNotificationsDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<NotificationSettingsLocalDataSource>(
      () => NotificationSettingsLocalDataSourceImpl(sl<KeyValueStore>()),
    )
    ..registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(inbox: sl(), settings: sl()),
    )
    ..registerLazySingleton(() => GetNotifications(sl()))
    ..registerLazySingleton(() => MarkNotificationRead(sl()))
    ..registerLazySingleton(() => MarkAllNotificationsRead(sl()))
    ..registerLazySingleton(() => GetNotificationSettings(sl()))
    ..registerLazySingleton(() => SaveNotificationSettings(sl()))
    ..registerFactory(
      () => NotificationsCubit(
        getNotifications: sl(),
        markRead: sl(),
        markAllRead: sl(),
      ),
    )
    ..registerFactory(
      () => NotificationSettingsCubit(getSettings: sl(), saveSettings: sl()),
    );
}
