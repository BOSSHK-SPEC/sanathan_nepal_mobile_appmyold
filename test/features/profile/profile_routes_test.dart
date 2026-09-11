import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/di/injection.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/permission.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_business_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/models/user_profile_model.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/business_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/session/profile_session_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_businesses.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/set_business_status.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/admin_businesses_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/business_profile_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/profile_routes.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

void main() {
  late InMemoryKeyValueStore store;
  late ProfileLocalDataSourceImpl local;

  setUp(() {
    store = InMemoryKeyValueStore();
    const resolver = FixedRegionResolver(Region.nepal);
    local = ProfileLocalDataSourceImpl(store, resolver);
    sl
      ..registerLazySingleton<ProfileLocalDataSource>(() => local)
      ..registerFactory<AdminBusinessesCubit>(() {
        final repo = BusinessRepositoryImpl(
          MockBusinessDataSource(store, resolver),
        );
        return AdminBusinessesCubit(
          getBusinesses: GetBusinesses(repo),
          setStatus: SetBusinessStatus(repo),
        );
      });
  });
  tearDown(sl.reset);

  String pathOf(RouteBase r) => (r as GoRoute).path;

  test('businessForm and myBusiness are registered before /business/:id', () {
    final paths = profileRoutes.map(pathOf).toList();
    final profileIdx = paths.indexOf(AppRoutes.businessProfile);
    expect(paths.indexOf(AppRoutes.businessForm), lessThan(profileIdx));
    expect(paths.indexOf(AppRoutes.myBusiness), lessThan(profileIdx));
    expect(paths, contains(AppRoutes.adminBusinesses));
  });

  test('BusinessProfileMode round-trips through the ?mode= query', () {
    expect(BusinessProfileMode.fromQuery(null), BusinessProfileMode.viewer);
    expect(BusinessProfileMode.fromQuery('owner'), BusinessProfileMode.owner);
    expect(BusinessProfileMode.fromQuery('admin'), BusinessProfileMode.admin);
    expect(BusinessProfileMode.admin.query, '?mode=admin');
    expect(BusinessProfileMode.viewer.query, '');
  });

  test('the stored role expands into the runtime permission set', () async {
    // Seed profile is an admin.
    var session = await ProfileSessionSource(local).load();
    expect(session.can(Permission.approveBusiness), isTrue);
    expect(session.isStaff, isTrue);

    await local.write(
      UserProfileModel.fromEntity(
        ProfileLocalDataSourceImpl.seed.copyWith(roles: {UserRole.user}),
      ),
    );
    session = await ProfileSessionSource(local).load();
    expect(session.can(Permission.approveBusiness), isFalse);
    // A plain user is still a seeker and can book.
    expect(session.can(Permission.bookConsultation), isTrue);

    // Signed out: no permissions at all.
    expect(AppSession.guest.can(Permission.bookConsultation), isFalse);
  });

  test('an astrologer holds both seeker and astrologer permissions', () async {
    await local.write(
      UserProfileModel.fromEntity(
        ProfileLocalDataSourceImpl.seed.copyWith(roles: {UserRole.astrologer}),
      ),
    );
    final session = await ProfileSessionSource(local).load();
    expect(session.can(Permission.viewAstrologerConsole), isTrue);
    expect(session.can(Permission.bookConsultation), isTrue);
    expect(session.can(Permission.approveBusiness), isFalse);
    expect(session.canSwitchRole, isTrue);
  });

  /// Wraps the router in a [SessionScope] built from the stored profile —
  /// route guards read the session, not the profile store.
  Widget routerApp(String initialLocation, {AppSession? session}) =>
      SessionScope(
        session:
            session ??
            AppSession(
              userId: 'u1',
              isAuthenticated: true,
              roles: ProfileSessionSource.rolesForAll(local.read().roles),
            ),
        child: MaterialApp.router(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: GoRouter(
            initialLocation: initialLocation,
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (_, _) => const Scaffold(body: Text('PROFILE TAB')),
              ),
              ...profileRoutes,
            ],
          ),
        ),
      );

  testWidgets('/admin/businesses opens for admins', (tester) async {
    await tester.pumpWidget(routerApp(AppRoutes.adminBusinesses));
    await tester.pumpAndSettle();
    expect(find.text('Business approvals'), findsOneWidget);
    expect(find.text('PROFILE TAB'), findsNothing);
  });

  testWidgets('/admin/businesses redirects non-admins to the profile tab', (
    tester,
  ) async {
    await local.write(
      UserProfileModel.fromEntity(
        ProfileLocalDataSourceImpl.seed.copyWith(roles: {UserRole.seller}),
      ),
    );
    await tester.pumpWidget(routerApp(AppRoutes.adminBusinesses));
    await tester.pumpAndSettle();
    expect(find.text('PROFILE TAB'), findsOneWidget);
    expect(find.text('Business approvals'), findsNothing);
  });
}
