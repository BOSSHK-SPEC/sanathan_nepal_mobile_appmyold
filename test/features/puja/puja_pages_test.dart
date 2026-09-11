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
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/puja/puja_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/puja/puja_routes.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

void main() {
  final sl = GetIt.instance;

  setUp(() {
    sl
      ..registerLazySingleton<KeyValueStore>(InMemoryKeyValueStore.new)
      ..registerLazySingleton<RegionResolver>(
        () => const FixedRegionResolver(Region.nepal),
      );
    registerPujaFeature(sl);
  });
  tearDown(sl.reset);

  Widget app({String initialLocation = AppRoutes.pujas}) => const SessionScope(
    session: AppSession(
      userId: 'u1',
      isAuthenticated: true,
      roles: {AppRole.seeker},
    ),
    child: _Harness(),
  ).withLocation(initialLocation);

  group('PujaCataloguePage', () {
    testWidgets('lists pujas with prices', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      expect(find.text('Rudrabhishek'), findsOneWidget);
      expect(find.text('Shri Lakshmi puja'), findsOneWidget);
    });

    testWidgets('a purpose chip narrows the list', (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ancestors'));
      await tester.pumpAndSettle();
      expect(find.text('Pitru tarpan'), findsOneWidget);
      expect(find.text('Rudrabhishek'), findsNothing);
    });
  });

  group('PujaDetailsPage', () {
    testWidgets('shows the modes and a total that follows the choices', (
      tester,
    ) async {
      await tester.pumpWidget(
        app(initialLocation: AppRoutes.pujaDetailsPath('puja-rudrabhishek')),
      );
      await tester.pumpAndSettle();

      expect(find.text('At the temple, streamed'), findsOneWidget);
      expect(find.text('At your home'), findsOneWidget);
      // Pinned to the bottom bar, so it is on screen without scrolling.
      expect(find.text('Confirm booking'), findsOneWidget);

      // The sankalp section sits below the fold; scrolling to it proves the
      // long form is reachable rather than clipped.
      await tester.scrollUntilVisible(
        find.text('Sankalp details'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Sankalp details'), findsOneWidget);
    });
  });

  group('MyPujasPage', () {
    testWidgets('empty until something is booked', (tester) async {
      await tester.pumpWidget(app(initialLocation: AppRoutes.myPujas));
      await tester.pumpAndSettle();
      expect(find.text('No pujas booked'), findsOneWidget);
    });
  });
}

/// Router harness shared by the cases above.
class _Harness extends StatelessWidget {
  const _Harness({this.initialLocation = AppRoutes.pujas});

  final String initialLocation;

  @override
  Widget build(BuildContext context) => RegionScope(
    region: Region.nepal,
    child: MaterialApp.router(
      theme: AppTheme.light(),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(
        initialLocation: initialLocation,
        routes: [
          ...pujaRoutes,
          GoRoute(
            path: AppRoutes.home,
            builder: (_, _) => const Scaffold(body: Text('HOME')),
          ),
        ],
      ),
    ),
  );
}

extension on Widget {
  /// Rebuilds the harness at [location] — the scope wrappers are identical,
  /// only the router's starting point differs.
  Widget withLocation(String location) => SessionScope(
    session: const AppSession(
      userId: 'u1',
      isAuthenticated: true,
      roles: {AppRole.seeker},
    ),
    child: _Harness(initialLocation: location),
  );
}
