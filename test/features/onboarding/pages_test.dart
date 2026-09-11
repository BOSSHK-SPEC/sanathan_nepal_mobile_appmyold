import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/entities/app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/notification_prefs_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/onboarding_progress_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/repositories/onboarding_progress_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/onboarding_step.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/repositories/auth_presence.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/repositories/notification_prefs_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/otp_challenge.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/user_profile_draft.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/get_notification_prefs.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/save_notification_prefs.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/verify_otp.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/cubit/auth_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/cubit/notification_prefs_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/cubit/profile_details_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/pages/details_input_page.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/pages/language_theme_page.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/pages/login_page.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/pages/notification_settings_onboarding_page.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/pages/otp_page.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/widgets/bs_date_picker_dialog.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/widgets/date_of_birth_field.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/widgets/post_sign_in_scope.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

import 'helpers/test_helpers.dart';

void main() {
  late MockSignInWithGoogle google;
  late MockSignInWithApple apple;
  late MockSignInWithPhone phone;
  late MockVerifyOtp verifyUc;

  AuthCubit authCubit() => AuthCubit(
    signInWithGoogle: google,
    signInWithApple: apple,
    signInWithPhone: phone,
    verifyOtp: verifyUc,
  );

  setUpAll(() async {
    await loadAppFonts();
    registerFallbackValue(const VerifyOtpParams(phoneNumber: '', code: ''));
    registerFallbackValue(const UserProfileDraft());
  });

  setUp(() {
    google = MockSignInWithGoogle();
    apple = MockSignInWithApple();
    phone = MockSignInWithPhone();
    verifyUc = MockVerifyOtp();
  });

  group('SplashPage', () {
    OnboardingProgressRepositoryImpl progressWith([OnboardingStep? step]) {
      final repo = OnboardingProgressRepositoryImpl(
        OnboardingProgressLocalDataSourceImpl(InMemoryKeyValueStore()),
      );
      if (step != null) repo.saveStep(step);
      return repo;
    }

    /// Pumps the splash over a router with a placeholder for every step, and
    /// returns the router so a test can inspect the stack it built.
    Future<GoRouter> launch(
      WidgetTester tester, {
      OnboardingStep? saved,
      bool signedIn = false,
      bool onboarded = false,
    }) async {
      await setPhoneSurface(tester);
      final settings = buildAppSettingsCubit();
      if (onboarded) await settings.completeOnboarding();
      final progress = progressWith(saved);
      Widget page(String label) => Scaffold(body: Text(label));
      final router = GoRouter(
        routes: [
          GoRoute(
            path: AppRoutes.splash,
            builder: (_, _) => SplashPage(
              delay: const Duration(milliseconds: 100),
              progress: progress,
              presence: _Presence(signedIn),
            ),
          ),
          GoRoute(path: AppRoutes.languageTheme, builder: (_, _) => page('LANG')),
          GoRoute(path: AppRoutes.login, builder: (_, _) => page('LOGIN')),
          GoRoute(path: AppRoutes.detailsInput, builder: (_, _) => page('DETAILS')),
          GoRoute(
            path: AppRoutes.notificationSettingsOnboarding,
            builder: (_, _) => page('NOTIFS'),
          ),
          GoRoute(path: AppRoutes.home, builder: (_, _) => page('HOME')),
        ],
      );
      await tester.pumpWidget(
        BlocProvider<AppSettingsCubit>.value(
          value: settings,
          child: MaterialApp.router(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );
      expect(find.text('Sanatan Nepal'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 150));
      await tester.pumpAndSettle();
      return router;
    }

    testWidgets('a first run starts at language and theme', (tester) async {
      await launch(tester);
      expect(find.text('LANG'), findsOneWidget);
    });

    testWidgets('closed on the details form → reopens on the details form', (
      tester,
    ) async {
      // The bug this replaces: reopening started over, the second sign-in no
      // longer counted as "new", and the details form was skipped for good.
      await launch(tester, saved: OnboardingStep.profileDetails, signedIn: true);
      expect(find.text('DETAILS'), findsOneWidget);
    });

    testWidgets('closed on notifications → reopens on notifications', (
      tester,
    ) async {
      await launch(tester, saved: OnboardingStep.notifications, signedIn: true);
      expect(find.text('NOTIFS'), findsOneWidget);
    });

    testWidgets('a signed-in step whose login is gone asks to sign in again, '
        'with language underneath so Back behaves as on a first run', (
      tester,
    ) async {
      final router = await launch(
        tester,
        saved: OnboardingStep.profileDetails,
        signedIn: false,
      );
      expect(find.text('LOGIN'), findsOneWidget);
      expect(router.canPop(), isTrue);
      router.pop();
      await tester.pumpAndSettle();
      expect(find.text('LANG'), findsOneWidget);
    });

    testWidgets('closed on the login screen → reopens on login', (tester) async {
      await launch(tester, saved: OnboardingStep.signIn);
      expect(find.text('LOGIN'), findsOneWidget);
    });

    testWidgets('a finished onboarding always opens home', (tester) async {
      await launch(
        tester,
        saved: OnboardingStep.profileDetails,
        signedIn: true,
        onboarded: true,
      );
      expect(find.text('HOME'), findsOneWidget);
    });
  });

  group('LanguageThemePage', () {
    testWidgets('shows radios and updates AppSettingsCubit', (tester) async {
      await setPhoneSurface(tester);
      final settings = buildAppSettingsCubit();
      await tester.pumpWidget(
        wrapApp(const LanguageThemePage(), settings: settings),
      );
      expect(find.text('Select Language'), findsOneWidget);
      expect(find.text('Select Theme'), findsOneWidget);
      expect(find.text('SKIP'), findsOneWidget);

      await tester.tap(find.text('English'));
      await tester.pump();
      expect(settings.state.language, AppLanguage.english);

      await tester.tap(find.text('Dark'));
      await tester.pump();
      expect(settings.state.themeMode, ThemeMode.dark);
    });

    testWidgets('renders Nepali strings', (tester) async {
      await setPhoneSurface(tester);
      await tester.pumpWidget(
        wrapApp(const LanguageThemePage(), locale: const Locale('ne')),
      );
      expect(find.text('भाषा चयन गर्नुहोस'), findsOneWidget);
      expect(find.text('जारी राख्नुहोस्'), findsOneWidget);
    });

    testWidgets('renders Hindi strings in the India region', (tester) async {
      await setPhoneSurface(tester);
      final settings = buildAppSettingsCubit();
      await settings.setRegion(Region.india);
      await tester.pumpWidget(
        wrapApp(
          const LanguageThemePage(),
          settings: settings,
          region: Region.india,
          locale: const Locale('hi'),
        ),
      );
      expect(find.text('भाषा चुनें'), findsOneWidget);
      expect(find.text('थीम चुनें'), findsOneWidget);
      expect(find.text('लाइट थीम'), findsOneWidget);
      expect(find.text('डार्क थीम'), findsOneWidget);
    });
  });

  group('LoginPage', () {
    testWidgets('renders social buttons and opens the phone sheet', (
      tester,
    ) async {
      await setPhoneSurface(tester);
      await tester.pumpWidget(wrapApp(LoginPage(cubit: authCubit())));
      expect(find.text('Welcome to Sanatan Nepal Family!'), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);
      expect(find.text('Continue with Apple'), findsOneWidget);
      expect(find.text('Continue with Number'), findsOneWidget);

      await tester.tap(find.text('Continue with Number'));
      await tester.pumpAndSettle();
      expect(find.text('SIGNUP WITH NUMBER'), findsOneWidget);
      expect(find.text('Enter your Mobile Number'), findsOneWidget);
      // Nepal region → +977 prefix chip.
      expect(find.text('+977'), findsOneWidget);
      expect(find.text('+91'), findsNothing);

      // Invalid number → validation message, no use-case call.
      await tester.enterText(find.byType(TextFormField), '123');
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
      expect(find.text('Enter a valid 10-digit mobile number'), findsOneWidget);
      verifyNever(() => phone(any()));
    });

    testWidgets('India region: phone sheet shows +91 and validates Indian '
        'mobiles', (tester) async {
      await setPhoneSurface(tester);
      // A failure keeps the sheet open (no GoRouter in this test) while
      // still proving the use case was invoked with the raw input.
      when(() => phone(any())).thenAnswer(
        (_) async => const Result.failure(ServerFailure('SMS quota')),
      );
      await tester.pumpWidget(
        wrapApp(LoginPage(cubit: authCubit()), region: Region.india),
      );
      await tester.tap(find.text('Continue with Number'));
      await tester.pumpAndSettle();
      expect(find.text('+91'), findsOneWidget);
      expect(find.text('+977'), findsNothing);

      // 5… is not an Indian mobile prefix → rejected locally.
      await tester.enterText(find.byType(TextFormField), '5123456789');
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
      expect(find.text('Enter a valid 10-digit mobile number'), findsOneWidget);
      verifyNever(() => phone(any()));

      // Valid Indian number (with +91) → use case called with the raw input.
      await tester.enterText(find.byType(TextFormField), '+91 9876543210');
      await tester.tap(find.text('NEXT'));
      await tester.pumpAndSettle();
      verify(() => phone('+91 9876543210')).called(1);
      expect(find.text('SMS quota'), findsOneWidget);
    });

    testWidgets('renders Hindi strings', (tester) async {
      await setPhoneSurface(tester);
      await tester.pumpWidget(
        wrapApp(
          LoginPage(cubit: authCubit()),
          region: Region.india,
          locale: const Locale('hi'),
        ),
      );
      expect(
        find.text('सनातन नेपाल परिवार में आपका स्वागत है!'),
        findsOneWidget,
      );
      expect(find.text('मोबाइल नंबर से जारी रखें'), findsOneWidget);
      await tester.tap(find.text('मोबाइल नंबर से जारी रखें'));
      await tester.pumpAndSettle();
      expect(find.text('अपना मोबाइल नंबर दर्ज करें'), findsOneWidget);
      expect(find.text('+91'), findsOneWidget);
    });

    testWidgets('renders dark variant', (tester) async {
      await setPhoneSurface(tester);
      await tester.pumpWidget(
        wrapApp(LoginPage(cubit: authCubit()), dark: true),
      );
      expect(find.text('Log In'), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);
    });
  });

  group('OtpPage', () {
    testWidgets('registered user sees name and Log In', (tester) async {
      await setPhoneSurface(tester);
      const challenge = OtpChallenge(
        phoneNumber: '9841000002',
        isRegistered: true,
        displayName: 'Sita Sharma',
      );
      await tester.pumpWidget(
        wrapApp(
          Scaffold(
            body: OtpPage(challenge: challenge, cubit: authCubit()),
          ),
        ),
      );
      expect(find.text('Existing User'), findsOneWidget);
      expect(find.text('Sita Sharma'), findsOneWidget);
      expect(find.text('Log In'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(6));

      // Pressing Log In with an incomplete code shows a validation hint.
      await tester.tap(find.text('Log In'));
      await tester.pump();
      expect(find.text('Enter the 6-digit code'), findsOneWidget);
      verifyNever(() => verifyUc(any()));
    });

    testWidgets('new user sees Verify and calls VerifyOtp', (tester) async {
      await setPhoneSurface(tester);
      when(() => verifyUc(any())).thenAnswer(
        (_) async => const Result.failure(ServerFailure('Wrong code')),
      );
      const challenge = OtpChallenge(
        phoneNumber: '9841000001',
        isRegistered: false,
      );
      await tester.pumpWidget(
        wrapApp(
          Scaffold(
            body: OtpPage(challenge: challenge, cubit: authCubit()),
          ),
        ),
      );
      expect(find.text('New User'), findsOneWidget);
      expect(find.text('Verify'), findsOneWidget);
      final fields = find.byType(TextField);
      for (var i = 0; i < 6; i++) {
        await tester.enterText(fields.at(i), '${i + 1}');
      }
      await tester.pumpAndSettle();
      verify(() => verifyUc(any())).called(1);
      expect(find.text('Wrong code'), findsOneWidget);
    });
  });

  group('OtpPage · regions', () {
    testWidgets('shows the phone with the region prefix', (tester) async {
      await setPhoneSurface(tester);
      const challenge = OtpChallenge(
        phoneNumber: '9876543211',
        isRegistered: false,
      );
      await tester.pumpWidget(
        wrapApp(
          Scaffold(
            body: OtpPage(challenge: challenge, cubit: authCubit()),
          ),
          region: Region.india,
        ),
      );
      expect(find.text('Code sent to +91 9876543211'), findsOneWidget);
    });

    testWidgets('Hindi locale renders Devanagari digits', (tester) async {
      await setPhoneSurface(tester);
      const challenge = OtpChallenge(
        phoneNumber: '9876543211',
        isRegistered: false,
      );
      await tester.pumpWidget(
        wrapApp(
          Scaffold(
            body: OtpPage(challenge: challenge, cubit: authCubit()),
          ),
          region: Region.india,
          locale: const Locale('hi'),
        ),
      );
      expect(find.text('नया उपयोगकर्ता'), findsOneWidget);
      expect(find.text('+९१ ९८७६५४३२११ पर कोड भेजा गया'), findsOneWidget);
    });
  });

  group('DetailsInputPage', () {
    testWidgets('validates required fields', (tester) async {
      await setPhoneSurface(tester);
      final submit = MockSubmitProfile();
      await tester.pumpWidget(
        wrapApp(
          DetailsInputPage(cubit: ProfileDetailsCubit(submitProfile: submit)),
        ),
      );
      expect(find.text('Enter Your Details'), findsOneWidget);
      expect(
        find.textContaining('Full Name', findRichText: true),
        findsOneWidget,
      );
      expect(
        find.textContaining('Date of Birth', findRichText: true),
        findsOneWidget,
      );
      expect(find.textContaining('Gender', findRichText: true), findsOneWidget);
      expect(find.text('Horoscope Sign'), findsOneWidget);
      // Nepal → Bikram Sambat toggle + Kathmandu hint.
      expect(find.text('BS'), findsOneWidget);
      expect(find.text('AD'), findsOneWidget);
      expect(find.text('e.g. Kathmandu'), findsOneWidget);

      await tester.drag(find.byType(ListView), const Offset(0, -800));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('This field is required'), findsWidgets);
      verifyNever(() => submit(any()));
    });

    testWidgets('shows no errors until Continue is pressed', (tester) async {
      await setPhoneSurface(tester);
      final submit = MockSubmitProfile();
      await tester.pumpWidget(
        wrapApp(
          DetailsInputPage(cubit: ProfileDetailsCubit(submitProfile: submit)),
        ),
      );
      // Typing a name used to flag every other field — Form-level
      // onUserInteraction re-validates the whole form on any change.
      await tester.enterText(find.byType(TextFormField).at(0), 'Sita');
      await tester.pump();
      expect(find.text('This field is required'), findsNothing);
      // A half-typed email is not judged mid-word either.
      await tester.enterText(find.byType(TextFormField).at(1), 'sita@');
      await tester.pump();
      expect(find.text('Enter a valid email'), findsNothing);

      await tester.drag(find.byType(ListView), const Offset(0, -800));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      // Now everything is judged at once: date and gender are missing, and
      // the email that was typed is malformed.
      expect(find.text('This field is required'), findsWidgets);
      expect(find.text('Enter a valid email'), findsOneWidget);
      verifyNever(() => submit(any()));
    });

    testWidgets('email is optional: blank or only spaces is not an error', (
      tester,
    ) async {
      await setPhoneSurface(tester);
      final submit = MockSubmitProfile();
      when(() => submit(any())).thenAnswer(
        (_) async => const Result.failure(ServerFailure('offline')),
      );
      final cubit = ProfileDetailsCubit(
        submitProfile: submit,
        initial: UserProfileDraft(
          fullName: 'Sita Sharma',
          dateOfBirth: DateTime(1998, 4, 2),
          gender: Gender.female,
        ),
      );
      await tester.pumpWidget(wrapApp(DetailsInputPage(cubit: cubit)));
      await tester.enterText(find.byType(TextFormField).at(1), '   ');
      await tester.pump();

      await tester.drag(find.byType(ListView), const Offset(0, -800));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Enter a valid email'), findsNothing);
      final sent =
          verify(() => submit(captureAny())).captured.single as UserProfileDraft;
      expect(sent.email, isEmpty);
    });

    testWidgets('has no way back into sign-in', (tester) async {
      await setPhoneSurface(tester);
      await tester.pumpWidget(
        wrapApp(
          DetailsInputPage(
            cubit: ProfileDetailsCubit(submitProfile: MockSubmitProfile()),
          ),
        ),
      );
      // No arrow in the top bar, and the system Back gesture is intercepted.
      expect(find.byIcon(Icons.arrow_back), findsNothing);
      expect(find.byType(PostSignInScope), findsOneWidget);
    });

    testWidgets('reopens with what was typed before the app closed', (
      tester,
    ) async {
      await setPhoneSurface(tester);
      final progress = OnboardingProgressRepositoryImpl(
        OnboardingProgressLocalDataSourceImpl(InMemoryKeyValueStore()),
      );
      await progress.saveDetailsDraft(
        const UserProfileDraft(
          fullName: 'Sita Sharma',
          email: 'sita@example.com',
          birthPlace: 'Hetauda',
        ),
      );
      await tester.pumpWidget(
        wrapApp(
          DetailsInputPage(
            cubit: ProfileDetailsCubit(
              submitProfile: MockSubmitProfile(),
              progress: progress,
            ),
          ),
        ),
      );
      expect(find.widgetWithText(TextFormField, 'Sita Sharma'), findsOneWidget);
      expect(
        find.widgetWithText(TextFormField, 'sita@example.com'),
        findsOneWidget,
      );
      expect(find.widgetWithText(TextFormField, 'Hetauda'), findsOneWidget);
    });

    testWidgets('India region: Saka/A.D. toggle, New Delhi hint and Saka '
        'picker', (tester) async {
      await setPhoneSurface(tester);
      final submit = MockSubmitProfile();
      final cubit = ProfileDetailsCubit(submitProfile: submit);
      await tester.pumpWidget(
        wrapApp(DetailsInputPage(cubit: cubit), region: Region.india),
      );
      expect(find.text('Saka'), findsOneWidget);
      expect(find.text('A.D.'), findsOneWidget);
      expect(find.text('BS'), findsNothing);
      expect(find.text('e.g. New Delhi'), findsOneWidget);

      // Open the traditional picker → Saka title, then confirm.
      await tester.tap(
        find.ancestor(
          of: find.text('Select date'),
          matching: find.byType(TextField),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(TraditionalDatePickerDialog), findsOneWidget);
      expect(find.text('Date of Birth (Saka)'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(cubit.state.draft.dateOfBirth, isNotNull);
      final saka = RegionConfig.india.calendar;
      final expected = DateOfBirthField.format(
        cubit.state.draft.dateOfBirth,
        system: DateSystem.bs,
        calendar: saka,
        languageCode: 'en',
      );
      expect(find.text(expected), findsOneWidget);
      expect(
        saka.monthNames(languageCode: 'en').any(expected.startsWith),
        isTrue,
      );
    });

    testWidgets('renders Hindi strings with New Delhi hint', (tester) async {
      await setPhoneSurface(tester);
      final submit = MockSubmitProfile();
      await tester.pumpWidget(
        wrapApp(
          DetailsInputPage(cubit: ProfileDetailsCubit(submitProfile: submit)),
          region: Region.india,
          locale: const Locale('hi'),
        ),
      );
      expect(find.text('अपना विवरण भरें'), findsOneWidget);
      expect(find.text('जैसे: नई दिल्ली'), findsOneWidget);
      expect(find.text('शक'), findsOneWidget);
      expect(find.text('ईस्वी'), findsOneWidget);
      expect(find.text('राशि'), findsOneWidget);
    });
  });

  group('DateOfBirthField.format', () {
    test('formats traditional and Gregorian dates per calendar/language', () {
      final date = DateTime(1998, 5, 12);
      expect(
        DateOfBirthField.format(
          date,
          system: DateSystem.ad,
          calendar: RegionConfig.nepal.calendar,
          languageCode: 'en',
        ),
        '1998-05-12',
      );
      expect(
        DateOfBirthField.format(
          date,
          system: DateSystem.bs,
          calendar: RegionConfig.nepal.calendar,
          languageCode: 'ne',
        ),
        'बैशाख २९, २०५५',
      );
      // 12 May 1998 = Vaishakha 22, 1920 Saka.
      expect(
        DateOfBirthField.format(
          date,
          system: DateSystem.bs,
          calendar: RegionConfig.india.calendar,
          languageCode: 'en',
        ),
        'Vaishakha 22, 1920',
      );
      expect(
        DateOfBirthField.format(
          date,
          system: DateSystem.bs,
          calendar: RegionConfig.india.calendar,
          languageCode: 'hi',
        ),
        'वैशाख २२, १९२०',
      );
    });
  });

  group('NotificationSettingsOnboardingPage', () {
    testWidgets('loads defaults and toggles', (tester) async {
      await setPhoneSurface(tester);
      final repo = NotificationPrefsRepositoryImpl(
        NotificationPrefsLocalDataSourceImpl(InMemoryKeyValueStore()),
      );
      final cubit = NotificationPrefsCubit(
        getPrefs: GetNotificationPrefs(repo),
        savePrefs: SaveNotificationPrefs(repo),
      );
      await tester.pumpWidget(
        wrapApp(NotificationSettingsOnboardingPage(cubit: cubit)),
      );
      await tester.pumpAndSettle();
      expect(find.text('Horoscope Notification Setting'), findsOneWidget);
      expect(find.text('Festivals Notification Setting'), findsOneWidget);
      expect(cubit.state.current.horoscopeDaily, isTrue);

      await tester.tap(find.byType(Switch).first);
      await tester.pump();
      expect(cubit.state.current.horoscopeDaily, isFalse);

      await tester.drag(find.byType(ListView), const Offset(0, -1200));
      await tester.pumpAndSettle();
      expect(find.text('Finish'), findsOneWidget);
    });
  });
}

class _Presence implements AuthPresence {
  _Presence(this.isSignedIn);

  @override
  final bool isSignedIn;
}
