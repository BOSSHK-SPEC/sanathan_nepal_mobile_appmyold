import 'package:sanathan_nepal_mobile_app/core/session/session_refresher.dart';
import 'package:sanathan_nepal_mobile_app/core/session/role_granter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/session/session_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_draft.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/delete_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/business_listings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_business_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/business_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_my_business.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/set_business_status.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/upsert_business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/business_profile_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/business_profile_page.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

const merchant = AppSession(
  userId: 'u1',
  name: 'Seller',
  roles: {AppRole.seeker, AppRole.merchant},
  isAuthenticated: true,
);

const buyer = AppSession(
  userId: 'u2',
  name: 'Buyer',
  roles: {AppRole.seeker},
  isAuthenticated: true,
);

void main() {
  const resolver = FixedRegionResolver(Region.nepal);
  late InMemoryKeyValueStore store;
  late BusinessRepositoryImpl businessRepo;
  late MockProductDataSource productSource;
  late ProductRepositoryImpl productRepo;
  late AppSettingsCubit settings;

  setUp(() {
    store = InMemoryKeyValueStore();
    businessRepo = BusinessRepositoryImpl(
      MockBusinessDataSource(store, resolver),
    );
    productSource = MockProductDataSource(resolver: resolver);
    productRepo = ProductRepositoryImpl(productSource);
    final prefsRepo = AppPreferencesRepositoryImpl(
      AppPreferencesLocalDataSourceImpl(store),
    );
    settings = AppSettingsCubit(
      getPreferences: GetAppPreferences(prefsRepo),
      savePreferences: SaveAppPreferences(prefsRepo),
    );
  });

  Widget wrap(
    String businessId, {
    BusinessProfileMode mode = BusinessProfileMode.viewer,
    AppSession session = buyer,
  }) => SessionScope(
    session: session,
    child: MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AppSettingsCubit>.value(value: settings),
          BlocProvider(
            create: (_) => BusinessProfileCubit(
              getBusiness: GetBusinessProfile(businessRepo),
              getMyBusiness: GetMyBusiness(businessRepo),
              setStatus: SetBusinessStatus(businessRepo),
              upsertBusiness: UpsertBusinessProfile(businessRepo),
              repository: businessRepo,
              roles: const NoopRoleGranter(),
              sessionRefresher: const NoopSessionRefresher(),
            )..load(businessId),
          ),
          BlocProvider(
            create: (_) => BusinessListingsCubit(
              getProducts: GetProducts(productRepo),
              deleteProduct: DeleteProduct(productRepo),
              businessId: businessId,
            )..load(),
          ),
        ],
        child: BusinessProfileView(mode: mode),
      ),
    ),
  );

  /// Fixed pumps rather than `pumpAndSettle`: the listings tab shows a
  /// progress indicator while the mock's latency elapses, and a spinner
  /// schedules frames forever — `pumpAndSettle` would never return.
  Future<void> settle(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pump();
  }

  Future<void> openProducts(WidgetTester tester) async {
    await settle(tester);
    await tester.ensureVisible(find.text('Products'));
    await tester.tap(find.text('Products'));
    await settle(tester);
  }

  testWidgets('a shop shows its marketplace listings, not a private list', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(wrap('biz-2'));
    await openProducts(tester);

    // The rows here are the same ones the marketplace serves. Before, the tab
    // read a JSON blob on the business record that the marketplace never saw.
    expect(find.text('2 BHK Flat for Rent, Baneshwor'), findsOneWidget);
  });

  testWidgets('a product published by the seller appears on their own shop', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    // The demo user has no shop until they fill the business form, so make
    // one first — the page it is testing is that shop's profile.
    await tester.runAsync(
      () => businessRepo.upsertBusiness(
        const BusinessProfile(
          id: '',
          name: 'My Puja Store',
          category: 'Puja items',
          status: BusinessStatus.approved,
        ),
      ),
    );

    // Exactly what the "+ Add Product" form does. `runAsync`, because the
    // mock's latency is a real `Future.delayed` and the widget tester's fake
    // clock would never let it complete.
    await tester.runAsync(
      () => productSource.create(
        const ProductDraft(title: 'Hand-beaten brass diyo', price: 450),
      ),
    );

    await tester.pumpWidget(
      wrap(MockBusinessDataSource.myBusinessId, session: merchant),
    );
    await openProducts(tester);

    // This is the bug that started all of this: a seller added a product and
    // could not find it anywhere.
    expect(find.text('Hand-beaten brass diyo'), findsOneWidget);
  });

  testWidgets('an owner without the merchant role is told why, not given a '
      'button that fails', (tester) async {
    tester.view.physicalSize = const Size(600, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    // biz-2 is pending in the seed, and this session is not a merchant.
    await tester.pumpWidget(
      wrap('biz-2', mode: BusinessProfileMode.owner, session: buyer),
    );
    await openProducts(tester);

    expect(find.text('Add New Product'), findsNothing);
    expect(find.textContaining('still under review'), findsOneWidget);
  });

  testWidgets('a viewer gets neither the add button nor the reason', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(wrap('biz-2'));
    await openProducts(tester);

    expect(find.text('Add New Product'), findsNothing);
    expect(find.textContaining('still under review'), findsNothing);
  });
}
