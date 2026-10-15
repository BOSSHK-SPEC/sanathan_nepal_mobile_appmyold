import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_colors.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/brand_mark.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/onboarding_progress_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/repositories/onboarding_progress_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/repositories/auth_presence.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

import 'helpers/test_helpers.dart';

class _SignedOut implements AuthPresence {
  @override
  bool get isSignedIn => false;
}

/// What the splash *looks* like, as opposed to where it sends people (that is
/// pages_test.dart). The launch colour and the reduced-motion path are the two
/// things a person sees break: a colour flash on every cold start, and a reveal
/// forced on someone who asked the OS for no animation.
void main() {
  setUpAll(loadAppFonts);

  Future<void> pumpSplash(
    WidgetTester tester, {
    bool disableAnimations = false,
    bool dark = false,
    Duration delay = const Duration(milliseconds: 1500),
  }) async {
    await setPhoneSurface(tester);
    final settings = buildAppSettingsCubit();
    final router = GoRouter(
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          builder: (_, _) => SplashPage(
            delay: delay,
            progress: OnboardingProgressRepositoryImpl(
              OnboardingProgressLocalDataSourceImpl(InMemoryKeyValueStore()),
            ),
            presence: _SignedOut(),
          ),
        ),
        GoRoute(
          path: AppRoutes.languageTheme,
          builder: (_, _) => const Scaffold(body: Text('LANG')),
        ),
      ],
    );
    await tester.pumpWidget(
      BlocProvider<AppSettingsCubit>.value(
        value: settings,
        child: MediaQuery(
          data: MediaQueryData(disableAnimations: disableAnimations),
          child: MaterialApp.router(
            theme: dark ? AppTheme.dark() : AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      ),
    );
  }

  BrandMark mark(WidgetTester tester) =>
      tester.widget<BrandMark>(find.byType(BrandMark));

  for (final dark in [false, true]) {
    testWidgets(
      'opens on the colour the OS launch screen is painted in'
      '${dark ? ", dark theme too" : ""}',
      (tester) async {
        await pumpSplash(tester, dark: dark);
        // android/app/src/main/res/values/colors.xml holds the same value, so
        // the handover from the system splash to Flutter has nothing to flash
        // through — including under a dark theme, which the splash blooms into
        // rather than opening in.
        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
        expect(scaffold.backgroundColor, AppColors.launchBackground);
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();
      },
    );
  }

  testWidgets('draws the mark in over the wait, then leaves', (tester) async {
    await pumpSplash(tester);
    expect(mark(tester).progress, 0);
    await tester.pump(const Duration(milliseconds: 750));
    final half = mark(tester).progress;
    expect(half, greaterThan(0.4));
    expect(half, lessThan(1));
    await tester.pump(const Duration(milliseconds: 750));
    expect(mark(tester).progress, 1);
    await tester.pumpAndSettle();
    expect(find.text('LANG'), findsOneWidget);
  });

  testWidgets('"remove animations" shows the finished mark at once', (
    tester,
  ) async {
    await pumpSplash(tester, disableAnimations: true);
    // Complete on the very first frame: nobody waits through a reveal they
    // asked the system not to play.
    expect(mark(tester).progress, 1);
    expect(mark(tester).pulse, 0);
    expect(find.text('Sanatan Nepal'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();
    expect(find.text('LANG'), findsOneWidget);
  });

  testWidgets('the mark paints at every stage of the draw', (tester) async {
    // A CustomPainter that throws part-way through takes the whole first screen
    // with it, and only for the few frames it is on.
    for (final p in [0.0, 0.05, 0.2, 0.37, 0.5, 0.66, 0.8, 1.0]) {
      await tester.pumpWidget(
        MaterialApp(
          home: ColoredBox(
            color: const Color(0xFFF37335),
            child: Center(
              child: BrandMark(
                color: const Color(0xFFFFFFFF),
                progress: p,
                pulse: p,
              ),
            ),
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    }
  });
}
