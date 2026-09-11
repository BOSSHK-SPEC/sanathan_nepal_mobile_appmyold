import 'package:get_it/get_it.dart';

import '../../core/billing/spending_account.dart';
import '../../core/region/region.dart';
import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_wallet_data_source.dart';
import 'data/datasources/mock_wallet_data_source.dart';
import 'data/datasources/wallet_data_source.dart';
import 'data/repositories/wallet_repository_impl.dart';
import 'data/services/wallet_spending_account.dart';
import 'domain/repositories/wallet_repository.dart';
import 'domain/usecases/wallet_usecases.dart';
import 'presentation/cubit/payment_status_cubit.dart';
import 'presentation/cubit/refund_cubit.dart';
import 'presentation/cubit/topup_cubit.dart';
import 'presentation/cubit/transactions_cubit.dart';
import 'presentation/cubit/wallet_cubit.dart';

/// Registers data sources, repositories, use cases and cubits for `wallet`.
void registerWalletFeature(GetIt sl) {
  sl
    ..registerLazySingleton<WalletDataSource>(
      () => selectDataSource(
        mock: () =>
            MockWalletDataSource(sl<KeyValueStore>(), sl<RegionResolver>()),
        live: () => ApiWalletDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(sl()))
    // Lets other features charge the wallet without importing it.
    ..registerLazySingleton<SpendingAccount>(
      () => WalletSpendingAccount(sl<WalletDataSource>()),
    )
    ..registerLazySingleton(() => GetWalletBalance(sl()))
    ..registerLazySingleton(() => GetTransactions(sl()))
    ..registerLazySingleton(() => GetTopUpOptions(sl()))
    ..registerLazySingleton(() => CreateTopUp(sl()))
    ..registerLazySingleton(() => GetPaymentIntent(sl()))
    ..registerLazySingleton(() => DebitWallet(sl()))
    ..registerLazySingleton(() => RequestRefund(sl()))
    ..registerLazySingleton(() => GetRefunds(sl()))
    ..registerFactory(() => WalletCubit(getBalance: sl(), getOptions: sl()))
    ..registerFactory(() => TransactionsCubit(getTransactions: sl()))
    // The rails offered depend on the active region, so the page passes its
    // RegionConfig in rather than the cubit reaching for a BuildContext.
    ..registerFactoryParam<TopUpCubit, RegionConfig, void>(
      (config, _) => TopUpCubit(
        getOptions: sl(),
        createTopUp: sl(),
        availableRails: config.paymentRails,
      ),
    )
    ..registerFactoryParam<PaymentStatusCubit, String, void>(
      (intentId, _) => PaymentStatusCubit(intentId: intentId, getIntent: sl()),
    )
    ..registerFactoryParam<RefundCubit, String, void>(
      (transactionId, _) =>
          RefundCubit(transactionId: transactionId, requestRefund: sl()),
    );
}
