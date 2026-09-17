import '../../app/di/injection.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_console_data_source.dart';
import 'package:get_it/get_it.dart';

import '../../core/region/region.dart';
import '../../core/session/role_granter.dart';
import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/console_data_source.dart';
import 'data/datasources/mock_console_data_source.dart';
import 'data/repositories/console_repositories_impl.dart';
import 'domain/repositories/console_repositories.dart';
import 'domain/usecases/console_usecases.dart';
import 'presentation/cubit/application_cubit.dart';
import 'presentation/cubit/astrologer_profile_cubit.dart';
import 'presentation/cubit/boost_cubit.dart';
import 'presentation/cubit/clients_cubit.dart';
import 'presentation/cubit/compliance_cubit.dart';
import 'presentation/cubit/console_appointment_cubit.dart';
import 'presentation/cubit/console_appointments_cubit.dart';
import 'presentation/cubit/console_dashboard_cubit.dart';
import 'presentation/cubit/earnings_cubit.dart';
import 'presentation/cubit/payout_cubit.dart';
import 'presentation/cubit/pricing_cubit.dart';
import 'presentation/cubit/reviews_inbox_cubit.dart';
import 'presentation/cubit/schedule_cubit.dart';
import 'presentation/cubit/work_preferences_cubit.dart';

/// Registers the astrologer console.
///
/// One data source behind three narrow repositories, so screens depend only
/// on the slice they use.
void registerAstrologerConsoleFeature(GetIt sl) {
  sl
    ..registerLazySingleton<ConsoleDataSource>(
      () => selectDataSource(
        mock: () => MockConsoleDataSource(
          sl<KeyValueStore>(),
          sl<RegionResolver>(),
          sl<RoleGranter>(),
        ),
        live: () =>
            ApiConsoleDataSource(sl<ApiClient>(), () => activeLanguageCode(sl)),
      ),
    )
    ..registerLazySingleton<AstrologerApplicationRepository>(
      () => AstrologerApplicationRepositoryImpl(sl()),
    )
    ..registerLazySingleton<AstrologerOpsRepository>(
      () => AstrologerOpsRepositoryImpl(sl()),
    )
    ..registerLazySingleton<AstrologerEarningsRepository>(
      () => AstrologerEarningsRepositoryImpl(sl()),
    )
    ..registerLazySingleton<AstrologerProfileRepository>(
      () => AstrologerProfileRepositoryImpl(sl()),
    )
    // Application
    ..registerLazySingleton(() => GetApplication(sl()))
    ..registerLazySingleton(() => SaveApplicationDraft(sl()))
    ..registerLazySingleton(() => UploadKycDocument(sl()))
    ..registerLazySingleton(() => RemoveKycDocument(sl()))
    ..registerLazySingleton(() => AcceptAstrologerTerms(sl()))
    ..registerLazySingleton(() => SubmitApplication(sl()))
    ..registerLazySingleton(() => GetAstrologerProfile(sl()))
    ..registerLazySingleton(() => SaveAstrologerProfile(sl()))
    ..registerLazySingleton(() => GetComplianceNotices(sl()))
    ..registerLazySingleton(() => AcknowledgeNotice(sl()))
    ..registerLazySingleton(() => AppealNotice(sl()))
    ..registerLazySingleton(() => GetWorkPreferences(sl()))
    ..registerLazySingleton(() => SaveWorkPreferences(sl()))
    // Operations
    ..registerLazySingleton(() => GetDashboard(sl()))
    ..registerLazySingleton(() => GetAvailability(sl()))
    ..registerLazySingleton(() => SaveAvailability(sl()))
    ..registerLazySingleton(() => SetOnline(sl()))
    ..registerLazySingleton(() => GetQueue(sl()))
    ..registerLazySingleton(() => GetPendingRequest(sl()))
    ..registerLazySingleton(() => RespondToRequest(sl()))
    ..registerLazySingleton(() => GetClients(sl()))
    ..registerLazySingleton(() => GetClient(sl()))
    ..registerLazySingleton(() => SaveClientNotes(sl()))
    // Money & reputation
    ..registerLazySingleton(() => GetEarnings(sl()))
    ..registerLazySingleton(() => GetPerformance(sl()))
    ..registerLazySingleton(() => GetPayoutAccount(sl()))
    ..registerLazySingleton(() => SavePayoutAccount(sl()))
    ..registerLazySingleton(() => GetPayouts(sl()))
    ..registerLazySingleton(() => RequestPayout(sl()))
    ..registerLazySingleton(() => GetTaxDocuments(sl()))
    ..registerLazySingleton(() => GetPricing(sl()))
    ..registerLazySingleton(() => SavePricing(sl()))
    ..registerLazySingleton(() => GetMyReviews(sl()))
    ..registerLazySingleton(() => ReplyToReview(sl()))
    ..registerLazySingleton(() => GetBoostPlans(sl()))
    ..registerLazySingleton(() => GetBoostCampaigns(sl()))
    ..registerLazySingleton(() => BuyBoost(sl()))
    // Appointments
    ..registerLazySingleton(() => GetConsoleAppointments(sl()))
    ..registerLazySingleton(() => GetConsoleAppointment(sl()))
    ..registerLazySingleton(() => RecordAppointmentOutcome(sl()))
    ..registerLazySingleton(() => CancelConsoleAppointment(sl()))
    // Cubits
    ..registerFactory(
      () => AstrologerProfileCubit(getProfile: sl(), saveProfile: sl()),
    )
    ..registerFactory(
      () => WorkPreferencesCubit(getPreferences: sl(), savePreferences: sl()),
    )
    ..registerFactory(
      () => ComplianceCubit(getNotices: sl(), acknowledge: sl(), appeal: sl()),
    )
    ..registerFactory(
      () => ApplicationCubit(
        getApplication: sl(),
        saveDraft: sl(),
        uploadDocument: sl(),
        removeDocument: sl(),
        acceptTerms: sl(),
        submit: sl(),
        roles: sl<RoleGranter>(),
      ),
    )
    ..registerFactory(
      () => ConsoleDashboardCubit(
        getDashboard: sl(),
        getAvailability: sl(),
        setOnline: sl(),
        getQueue: sl(),
        getPendingRequest: sl(),
        respondToRequest: sl(),
        acceptFromQueue: sl(),
        // Registered by the consultation feature, which owns sessions.
        getSessions: sl(),
      ),
    )
    ..registerFactory(
      () => ScheduleCubit(getAvailability: sl(), saveAvailability: sl()),
    )
    ..registerFactory(() => ClientsCubit(getClients: sl(), saveNotes: sl()))
    ..registerFactory(() => ConsoleAppointmentsCubit(getAppointments: sl()))
    // param1 = appointment id.
    ..registerFactoryParam<ConsoleAppointmentCubit, String, void>(
      (id, _) => ConsoleAppointmentCubit(
        id: id,
        getAppointment: sl(),
        recordOutcome: sl(),
        cancelAppointment: sl(),
      ),
    )
    ..registerFactory(
      () => EarningsCubit(
        getEarnings: sl(),
        getPerformance: sl(),
        getAccount: sl(),
      ),
    )
    ..registerFactory(
      () => ReviewsInboxCubit(getReviews: sl(), replyToReview: sl()),
    )
    ..registerFactory(() => PricingCubit(getPricing: sl(), savePricing: sl()))
    ..registerFactory(
      () => ConsoleBoostCubit(
        getPlans: sl(),
        getCampaigns: sl(),
        buyBoost: sl(),
        getEarnings: sl(),
      ),
    )
    // The payout destinations depend on the active region, so the page
    // passes it in rather than the cubit reaching for a BuildContext.
    ..registerFactoryParam<PayoutCubit, Region, void>(
      (region, _) => PayoutCubit(
        region: region,
        getAccount: sl(),
        saveAccount: sl(),
        getPayouts: sl(),
        requestPayout: sl(),
        getEarnings: sl(),
        getTaxDocuments: sl(),
      ),
    );
}
