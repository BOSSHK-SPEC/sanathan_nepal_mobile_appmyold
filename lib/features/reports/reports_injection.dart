import '../../app/di/injection.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_report_data_source.dart';
import 'package:get_it/get_it.dart';

import '../../core/billing/spending_account.dart';
import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/mock_report_data_source.dart';
import 'data/datasources/report_data_source.dart';
import 'data/repositories/report_repository_impl.dart';
import 'domain/repositories/report_repository.dart';
import 'domain/usecases/report_usecases.dart';
import 'presentation/cubit/my_reports_cubit.dart';
import 'presentation/cubit/report_catalogue_cubit.dart';
import 'presentation/cubit/report_delivery_cubit.dart';
import 'presentation/cubit/report_purchase_cubit.dart';

/// Registers paid PDF reports.
///
/// The wallet is injected as [SpendingAccount], so this feature charges
/// money without importing the wallet feature.
void registerReportsFeature(GetIt sl) {
  sl
    ..registerLazySingleton<ReportDataSource>(
      () => selectDataSource(
        mock: () => MockReportDataSource(
          sl<KeyValueStore>(),
          sl<RegionResolver>(),
          sl<SpendingAccount>(),
        ),
        live: () =>
            ApiReportDataSource(sl<ApiClient>(), () => activeLanguageCode(sl)),
      ),
    )
    ..registerLazySingleton<ReportRepository>(() => ReportRepositoryImpl(sl()))
    ..registerLazySingleton(() => GetReportCatalogue(sl()))
    ..registerLazySingleton(() => GetReportProduct(sl()))
    ..registerLazySingleton(() => PurchaseReport(sl()))
    ..registerLazySingleton(() => GetMyReports(sl()))
    ..registerLazySingleton(() => GetPurchasedReport(sl()))
    ..registerFactory(() => ReportCatalogueCubit(getCatalogue: sl()))
    ..registerFactory(() => MyReportsCubit(getMyReports: sl()))
    ..registerFactoryParam<ReportPurchaseCubit, String, void>(
      (productId, _) => ReportPurchaseCubit(
        productId: productId,
        getProduct: sl(),
        getProfiles: sl(),
        purchaseReport: sl(),
        wallet: sl(),
      ),
    )
    ..registerFactoryParam<ReportDeliveryCubit, String, void>(
      (reportId, _) => ReportDeliveryCubit(reportId: reportId, getReport: sl()),
    );
}
