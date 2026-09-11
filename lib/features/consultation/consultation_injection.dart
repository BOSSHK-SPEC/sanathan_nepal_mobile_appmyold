import 'package:get_it/get_it.dart';

import '../../core/billing/spending_account.dart';
import '../../core/storage/key_value_store.dart';
import '../astrologers/domain/entities/consult_channel.dart';
import '../astrologers/domain/repositories/astrologer_repository.dart';
import 'data/datasources/consultation_data_source.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_consultation_data_source.dart';
import 'data/datasources/mock_consultation_data_source.dart';
import 'data/repositories/consultation_repository_impl.dart';
import 'domain/repositories/consultation_repository.dart';
import 'domain/usecases/consultation_usecases.dart';
import 'presentation/cubit/active_session_cubit.dart';
import 'presentation/cubit/astrologer_session_cubit.dart';
import 'presentation/cubit/consult_intake_cubit.dart';
import 'presentation/cubit/consultation_history_cubit.dart';
import 'presentation/cubit/live_session_cubit.dart';
import 'presentation/cubit/session_summary_cubit.dart';

/// Registers data sources, repositories, use cases and cubits for
/// `consultation`.
///
/// Must be registered after `astrologers` (for the catalogue) and `wallet`
/// (which provides [SpendingAccount]).
void registerConsultationFeature(GetIt sl) {
  sl
    ..registerLazySingleton<ConsultationDataSource>(
      () => selectDataSource(
        mock: () => MockConsultationDataSource(
          store: sl<KeyValueStore>(),
          astrologers: sl<AstrologerRepository>(),
          account: sl<SpendingAccount>(),
        ),
        live: () => ApiConsultationDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<ConsultationRepository>(
      () => ConsultationRepositoryImpl(
        source: sl(),
        account: sl<SpendingAccount>(),
      ),
    )
    ..registerLazySingleton(() => StartConsultation(sl()))
    ..registerLazySingleton(() => GetConsultation(sl()))
    ..registerLazySingleton(() => RefreshConsultation(sl()))
    ..registerLazySingleton(() => GetMessages(sl()))
    ..registerLazySingleton(() => SendMessage(sl()))
    ..registerLazySingleton(() => EndConsultation(sl()))
    ..registerLazySingleton(() => CancelConsultation(sl()))
    ..registerLazySingleton(() => GetSessionSummary(sl()))
    ..registerLazySingleton(() => GetConsultationHistory(sl()))
    ..registerLazySingleton(() => GetSpendableBalance(sl()))
    ..registerLazySingleton(() => GetActiveSession(sl()))
    ..registerLazySingleton(() => AcceptFromQueue(sl()))
    ..registerLazySingleton(() => GetAstrologerSessions(sl()))
    ..registerLazySingleton(() => SendAsAstrologer(sl()))
    ..registerLazySingleton(() => SaveSessionNotes(sl()))
    ..registerFactory(() => ConsultationHistoryCubit(getHistory: sl()))
    // App-global: the call bar must survive navigation, so this is a
    // singleton rather than a per-screen factory.
    ..registerLazySingleton(() => ActiveSessionCubit(getActiveSession: sl()))
    ..registerFactoryParam<ConsultIntakeCubit, String, ConsultChannel?>(
      (astrologerId, channel) => ConsultIntakeCubit(
        astrologerId: astrologerId,
        initialChannel: channel,
        getAstrologer: sl(),
        getBalance: sl(),
        startConsultation: sl(),
      ),
    )
    ..registerFactoryParam<LiveSessionCubit, String, void>(
      (consultationId, _) => LiveSessionCubit(
        consultationId: consultationId,
        getConsultation: sl(),
        refreshConsultation: sl(),
        getMessages: sl(),
        sendMessage: sl(),
        endConsultation: sl(),
        cancelConsultation: sl(),
        getBalance: sl(),
      ),
    )
    ..registerFactoryParam<AstrologerSessionCubit, String, void>(
      (consultationId, _) => AstrologerSessionCubit(
        consultationId: consultationId,
        getConsultation: sl(),
        getMessages: sl(),
        send: sl(),
        endConsultation: sl(),
        saveNotes: sl(),
      ),
    )
    ..registerFactoryParam<SessionSummaryCubit, String, void>(
      (consultationId, _) => SessionSummaryCubit(
        consultationId: consultationId,
        getConsultation: sl(),
        getSummary: sl(),
      ),
    );
}
