import '../../core/media/media_picker.dart';
import '../../core/media/media_service.dart';
import '../../core/media/media_uploader.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/auth/auth_session_manager.dart';
import '../../core/auth/token_store.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_resolver.dart';
import '../../features/appointment/domain/repositories/booking_contact_source.dart';
import '../../features/profile/domain/usecases/get_user_profile.dart';
import 'profile_booking_contact_source.dart';
import '../../core/storage/key_value_store.dart';
import '../../features/account/account_injection.dart';
import '../../features/app_settings/app_settings_injection.dart';
import '../../features/appointment/appointment_injection.dart';
import '../../features/astrologer_console/astrologer_console_injection.dart';
import '../../features/astrologers/astrologers_injection.dart';
import '../../features/calendar/calendar_injection.dart';
import '../../features/consultation/consultation_injection.dart';
import '../../features/content/content_injection.dart';
import '../../features/date_converter/date_converter_injection.dart';
import '../../features/events/events_injection.dart';
import '../../features/forex/forex_injection.dart';
import '../../features/home/home_injection.dart';
import '../../features/horoscope/horoscope_injection.dart';
import '../../features/kundli/kundli_injection.dart';
import '../../features/legal/legal_injection.dart';
import '../../features/marketplace/marketplace_injection.dart';
import '../../features/notifications/notifications_injection.dart';
import '../../features/onboarding/onboarding_injection.dart';
import '../../features/orders/orders_injection.dart';
import '../../features/puja/puja_injection.dart';
import '../../features/reports/reports_injection.dart';
import '../../features/panchanga/panchanga_injection.dart';
import '../../features/messaging/messaging_injection.dart';
import '../../features/profile/profile_injection.dart';
import '../../features/session/session_injection.dart';
import '../../features/wallet/wallet_injection.dart';
import '../../features/system/system_injection.dart';
import '../../features/weather/weather_injection.dart';

/// Global service locator.
final GetIt sl = GetIt.instance;

/// Named instances for the external APIs used by the app.
///
/// The unnamed [ApiClient] is the app's own backend — it carries the auth,
/// tracing, idempotency and retry chain. The named ones are bare clients for
/// third-party APIs the app still calls directly.
abstract final class ApiClients {
  static const String nrbForex = 'nrbForexApi';
  static const String openMeteo = 'openMeteoApi';
}

/// The language the app is currently showing, for code that has to pick one
/// translation out of a `{en, ne, hi}` payload.
///
/// Lives here rather than in each feature so the preference key is written
/// once; falls back to the region default before the user has chosen.
String activeLanguageCode(GetIt sl) =>
    sl<KeyValueStore>().getString('prefs.language') ??
    sl<RegionResolver>().config.defaultLanguageCode;

/// Registers core singletons then delegates to every feature's own
/// registration function (each feature owns its wiring – SRP).
/// [tokenStore] lets tests substitute an in-memory store; production uses the
/// keychain-backed one.
Future<void> configureDependencies({TokenStore? tokenStore}) async {
  if (sl.isRegistered<KeyValueStore>()) return;

  final prefs = await SharedPreferences.getInstance();

  // The refresh token is restored before anything can make a request, so a
  // returning user is signed in on the first frame rather than flickering
  // through onboarding.
  final session = AuthSessionManager(tokenStore ?? SecureTokenStore());
  await session.restore();

  sl
    ..registerLazySingleton<KeyValueStore>(
      () => SharedPrefsKeyValueStore(prefs),
    )
    ..registerSingleton<AuthSessionManager>(session)
    ..registerLazySingleton<ApiClient>(
      () => ApiClient.forBackend(
        session: sl<AuthSessionManager>(),
        regions: sl<RegionResolver>(),
        // Read lazily on every request: the user can change language at any
        // point, and the header must follow rather than being frozen at the
        // moment the client was constructed. Falls back to the region default
        // before the user has chosen.
        languageCode: () => activeLanguageCode(sl),
      ),
    )
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(baseUrl: AppConstants.nrbForexBaseUrl),
      instanceName: ApiClients.nrbForex,
    )
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(baseUrl: AppConstants.openMeteoBaseUrl),
      instanceName: ApiClients.openMeteo,
    );

  // Uploads: one picker and one uploader for every form in the app.
  sl
    ..registerLazySingleton<MediaPicker>(MediaPickerImpl.new)
    ..registerLazySingleton<MediaUploader>(
      () => MediaUploaderImpl(client: sl<ApiClient>()),
    )
    ..registerLazySingleton<MediaService>(
      () => MediaService(
        picker: sl<MediaPicker>(),
        uploader: sl<MediaUploader>(),
      ),
    );

  registerAppSettingsFeature(sl);
  registerOnboardingFeature(sl);
  registerHomeFeature(sl);
  registerCalendarFeature(sl);
  registerHoroscopeFeature(sl);
  registerWeatherFeature(sl);
  registerDateConverterFeature(sl);
  registerForexFeature(sl);
  registerPanchangaFeature(sl);
  registerEventsFeature(sl);
  registerMarketplaceFeature(sl);
  registerAppointmentFeature(sl);
  registerAstrologersFeature(sl);
  registerWalletFeature(sl);
  // After astrologers and wallet: it needs both.
  registerConsultationFeature(sl);
  registerKundliFeature(sl);
  registerAstrologerConsoleFeature(sl);
  registerOrdersFeature(sl);
  registerPujaFeature(sl);
  registerReportsFeature(sl);
  registerAccountFeature(sl);
  registerSystemFeature(sl);
  registerProfileFeature(sl);
  registerMessagingFeature(sl);
  // After profile: the booking form starts from the signed-in user's own
  // details, so nobody retypes their name and number for every appointment.
  sl.registerLazySingleton<BookingContactSource>(
    () => ProfileBookingContactSource(sl<GetUserProfile>()),
  );
  // After profile: the session cubit resolves SessionSource from it.
  registerSessionFeature(sl);
  registerNotificationsFeature(sl);
  registerLegalFeature(sl);
  registerContentFeature(sl);
}
