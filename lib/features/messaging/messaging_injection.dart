import 'package:get_it/get_it.dart';

import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/api_messaging_data_source.dart';
import 'data/datasources/messaging_data_source.dart';
import 'data/datasources/mock_messaging_data_source.dart';
import 'data/repositories/messaging_repository_impl.dart';
import 'domain/repositories/messaging_repository.dart';
import 'domain/usecases/messaging_usecases.dart';
import 'presentation/cubit/business_contact_cubit.dart';
import 'presentation/cubit/message_thread_cubit.dart';
import 'presentation/cubit/message_threads_cubit.dart';

/// Registers data sources, repositories, use cases and cubits for `messaging`.
void registerMessagingFeature(GetIt sl) {
  sl
    ..registerLazySingleton<MessagingDataSource>(
      () => selectDataSource(
        mock: () => MockMessagingDataSource(sl<KeyValueStore>()),
        live: () => ApiMessagingDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<MessagingRepository>(
      () => MessagingRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetMessageThreads(sl()))
    ..registerLazySingleton(() => GetMessageThread(sl()))
    ..registerLazySingleton(() => GetThreadWithBusiness(sl()))
    ..registerLazySingleton(() => GetThreadMessages(sl()))
    ..registerLazySingleton(() => MessageBusiness(sl()))
    ..registerLazySingleton(() => ReplyToThread(sl()))
    ..registerLazySingleton(() => MarkThreadRead(sl()))
    ..registerLazySingleton(() => SetThreadArchived(sl()))
    ..registerLazySingleton(() => GetUnreadMessageCount(sl()))
    ..registerFactory(
      () => MessageThreadsCubit(getThreads: sl(), setArchived: sl()),
    )
    // Two runtime arguments because a conversation is opened either by thread
    // id (from the inbox) or by business id (from a shop page, before any
    // thread exists). Exactly one is non-null.
    ..registerFactoryParam<MessageThreadCubit, String?, String?>(
      (threadId, businessId) => MessageThreadCubit(
        getThread: sl(),
        getThreadWithBusiness: sl(),
        getMessages: sl(),
        messageBusiness: sl(),
        reply: sl(),
        markRead: sl(),
        threadId: threadId,
        businessId: businessId,
      ),
    )
    ..registerFactoryParam<BusinessContactCubit, String, void>(
      (businessId, _) =>
          BusinessContactCubit(messageBusiness: sl(), businessId: businessId),
    );
}
