import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/role_granter.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/astrologer_console_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/presentation/pages/astrologer_profile_page.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/presentation/pages/compliance_page.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/presentation/pages/work_settings_page.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

class _NoopGranter implements RoleGranter {
  @override
  Future<void> grant(AppRole role) async {}

  @override
  Future<void> revoke(AppRole role) async {}
}

void main() {
  final sl = GetIt.instance;

  setUp(() {
    sl
      ..registerLazySingleton<KeyValueStore>(InMemoryKeyValueStore.new)
      ..registerLazySingleton<RegionResolver>(
        () => const FixedRegionResolver(Region.nepal),
      )
      ..registerLazySingleton<RoleGranter>(_NoopGranter.new);
    registerAstrologerConsoleFeature(sl);
  });
  tearDown(sl.reset);

  /// The pages are mounted directly rather than through the console routes:
  /// the guards are covered elsewhere, and this keeps the harness to the
  /// screen under test.
  Widget app(Widget page) => SessionScope(
    session: const AppSession(
      userId: 'a1',
      isAuthenticated: true,
      roles: {AppRole.astrologer},
    ),
    child: RegionScope(
      region: Region.nepal,
      child: MaterialApp.router(
        theme: AppTheme.light(),
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: GoRouter(
          initialLocation: AppRoutes.home,
          routes: [GoRoute(path: AppRoutes.home, builder: (_, _) => page)],
        ),
      ),
    ),
  );

  group('AstrologerProfilePage', () {
    testWidgets('offers the fields and refuses to publish an empty profile', (
      tester,
    ) async {
      await tester.pumpWidget(app(const AstrologerProfilePage()));
      await tester.pumpAndSettle();

      expect(find.text('Edit public profile'), findsOneWidget);
      expect(find.text('Profile strength'), findsOneWidget);
      expect(find.text('0%'), findsOneWidget);

      // Nothing has been filled in, so publishing is not offered.
      expect(find.text('Publish changes'), findsOneWidget);
      await tester.tap(find.text('Publish changes'));
      await tester.pumpAndSettle();
      expect(find.text('Profile updated.'), findsNothing);
    });
  });

  group('WorkSettingsPage', () {
    testWidgets('shows the alert and routing sections', (tester) async {
      await tester.pumpWidget(app(const WorkSettingsPage()));
      await tester.pumpAndSettle();

      expect(find.text('New request alerts'), findsOneWidget);
      expect(find.text('Quiet hours'), findsWidgets);
    });

    testWidgets('turning off request alerts disables the sound switch', (
      tester,
    ) async {
      await tester.pumpWidget(app(const WorkSettingsPage()));
      await tester.pumpAndSettle();

      final soundSwitch = find.ancestor(
        of: find.text('Play a sound'),
        matching: find.byType(Row),
      );
      expect(soundSwitch, findsWidgets);

      await tester.tap(
        find
            .descendant(
              of: find.ancestor(
                of: find.text('New request alerts'),
                matching: find.byType(Row),
              ),
              matching: find.byType(Switch),
            )
            .first,
      );
      await tester.pumpAndSettle();

      final sound = tester
          .widgetList<Switch>(
            find.descendant(
              of: find
                  .ancestor(
                    of: find.text('Play a sound'),
                    matching: find.byType(Row),
                  )
                  .first,
              matching: find.byType(Switch),
            ),
          )
          .first;
      expect(sound.onChanged, isNull);
    });
  });

  group('CompliancePage', () {
    testWidgets('lists open notices with their actions', (tester) async {
      await tester.pumpWidget(app(const CompliancePage()));
      await tester.pumpAndSettle();

      expect(find.text('Needs your attention'), findsOneWidget);
      expect(find.text('I understand'), findsWidgets);
      expect(find.text('Appeal this'), findsWidgets);
    });

    testWidgets('acknowledging moves a notice into the settled list', (
      tester,
    ) async {
      await tester.pumpWidget(app(const CompliancePage()));
      await tester.pumpAndSettle();

      // Nothing is settled yet, so there is no "earlier" section at all.
      expect(find.text('Earlier notices'), findsNothing);

      await tester.tap(find.text('I understand').first);
      await tester.pumpAndSettle();

      // The settled section appears only once something has left the open
      // list, so its presence is the assertion.
      expect(find.text('Earlier notices'), findsOneWidget);
    });
  });
}
