import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_order_tracking_data_source.dart';
import 'data/datasources/mock_order_tracking_data_source.dart';
import 'data/datasources/order_tracking_data_source.dart';
import 'data/repositories/order_tracking_repository_impl.dart';
import 'domain/repositories/order_tracking_repository.dart';
import 'domain/usecases/order_usecases.dart';
import 'presentation/cubit/order_tracking_cubit.dart';
import 'presentation/cubit/orders_list_cubit.dart';

/// Registers order tracking and fulfilment.
void registerOrdersFeature(GetIt sl) {
  sl
    ..registerLazySingleton<OrderTrackingDataSource>(
      () => selectDataSource(
        mock: () => MockOrderTrackingDataSource(
          sl<KeyValueStore>(),
          sl<RegionResolver>(),
        ),
        live: () => ApiOrderTrackingDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<OrderTrackingRepository>(
      () => OrderTrackingRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetMyOrders(sl()))
    ..registerLazySingleton(() => GetTrackedOrder(sl()))
    ..registerLazySingleton(() => RequestReturn(sl()))
    ..registerLazySingleton(() => GetSellerOrders(sl()))
    ..registerLazySingleton(() => AdvanceOrder(sl()))
    ..registerFactoryParam<OrdersListCubit, OrdersScope, void>(
      (scope, _) => OrdersListCubit(
        scope: scope,
        getMyOrders: sl(),
        getSellerOrders: sl(),
        advanceOrder: sl(),
      ),
    )
    ..registerFactoryParam<OrderTrackingCubit, String, void>(
      (orderId, _) => OrderTrackingCubit(
        orderId: orderId,
        getOrder: sl(),
        requestReturn: sl(),
      ),
    );
}
