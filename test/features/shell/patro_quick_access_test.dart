import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/ad_banner.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/shell/presentation/widgets/patro_quick_card.dart';
import 'package:sanathan_nepal_mobile_app/features/shell/presentation/widgets/quick_menu_sheet.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// Patro was a tile in the centre menu's primary row drawn with a house icon,
/// so it read as "Home" and people could not find the calendar. These pin
/// that the menu now opens on a Patro card that looks like, and opens, the
/// calendar.
void main() {
  late AppSettingsCubit settings;

  setUp(() {
    final prefsRepo = AppPreferencesRepositoryImpl(
      AppPreferencesLocalDataSourceImpl(InMemoryKeyValueStore()),
    );
    settings = AppSettingsCubit(
      getPreferences: GetAppPreferences(prefsRepo),
      savePreferences: SaveAppPreferences(prefsRepo),
    );
  });

  /// A home screen with a button that opens the real quick menu, and a stub
  /// Patro page at the real Patro route.
  Widget app({
    Locale locale = const Locale('en'),
    Region region = Region.nepal,
  }) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, _) => Scaffold(
            body: Center(
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () =>
                      QuickMenuSheet.show(context, today: DateTime(2026, 9, 14)),
                  child: const Text('open menu'),
                ),
              ),
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.patro,
          builder: (_, _) => const Scaffold(body: Text('PATRO PAGE')),
        ),
      ],
    );
    return RegionScope(
      region: region,
      child: MaterialApp.router(
        theme: AppTheme.light(),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
        // Above the navigator, so the modal menu sees them too.
        builder: (context, child) => SessionScope(
          session: const AppSession(
            userId: 'u1',
            isAuthenticated: true,
            roles: {AppRole.seeker},
          ),
          child: BlocProvider<AppSettingsCubit>.value(
            value: settings,
            child: child!,
          ),
        ),
      ),
    );
  }

  Future<void> openMenu(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    Region region = Region.nepal,
  }) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app(locale: locale, region: region));
    await tester.pumpAndSettle();
    await tester.tap(find.text('open menu'));
    await tester.pumpAndSettle();
  }

  testWidgets('the menu opens on the Patro card, above everything else', (
    tester,
  ) async {
    await openMenu(tester);

    final card = find.byType(PatroQuickCard);
    expect(card, findsOneWidget);
    expect(
      tester.getTopLeft(card).dy,
      lessThan(tester.getTopLeft(find.byType(AdBanner)).dy),
    );
    expect(
      find.descendant(of: card, matching: find.text('Patro')),
      findsOneWidget,
    );
    // 14 September 2026 is Bhadra 29, 2083 B.S.
    expect(
      find.descendant(of: card, matching: find.textContaining('2083')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: card, matching: find.textContaining('September')),
      findsOneWidget,
    );
  });

  testWidgets('tapping it closes the menu and opens the Patro page', (
    tester,
  ) async {
    await openMenu(tester);

    await tester.tap(find.byType(PatroQuickCard));
    await tester.pumpAndSettle();

    expect(find.text('PATRO PAGE'), findsOneWidget);
    expect(find.byType(QuickMenuSheet), findsNothing);
  });

  testWidgets('no menu tile wears the house icon any more', (tester) async {
    await openMenu(tester);

    expect(
      find.descendant(
        of: find.byType(QuickMenuSheet),
        matching: find.byIcon(Icons.home_outlined),
      ),
      findsNothing,
    );
  });

  testWidgets('India in Hindi: titled पंचांग with the Saka date', (tester) async {
    await openMenu(tester, locale: const Locale('hi'), region: Region.india);

    final card = find.byType(PatroQuickCard);
    expect(
      find.descendant(of: card, matching: find.text('पंचांग')),
      findsOneWidget,
    );
    // 14 September 2026 is Bhadrapada 23, 1948 Saka.
    expect(
      find.descendant(of: card, matching: find.textContaining('१९४८')),
      findsOneWidget,
    );
  });
}
