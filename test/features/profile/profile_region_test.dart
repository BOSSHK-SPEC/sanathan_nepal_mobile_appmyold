import 'package:sanathan_nepal_mobile_app/core/session/session_refresher.dart';
import 'package:sanathan_nepal_mobile_app/core/session/role_granter.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_my_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/traditional_date.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_activity_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_business_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_favourites_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/models/business_profile_model.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/delete_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/business_listings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/business_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/order_summary.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_businesses.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/set_business_status.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/update_user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/upsert_business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/business_form_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/admin_businesses_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/business_profile_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/business_form_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/admin_businesses_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/business_profile_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/support_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/region/business_region_fields.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/region/support_contacts.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/widgets/appointment_card.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/widgets/order_card.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

const india = FixedRegionResolver(Region.india);
const nepal = FixedRegionResolver(Region.nepal);

void main() {
  group('ProfileLocalDataSourceImpl seed', () {
    test('India region seeds Priya Sharma with +91 phone and Saka DOB', () {
      final ds = ProfileLocalDataSourceImpl(InMemoryKeyValueStore(), india);
      final p = ds.read();
      expect(p.name, 'Priya Sharma');
      expect(p.phone, startsWith('+91'));
      expect(p.birthPlace, 'Jaipur');
      expect(p.address, contains('New Delhi'));
      // 1998-04-02 AD = Chaitra 12, Saka 1920.
      expect(p.dobBs, '1920/01/12');
      expect(p.dobAd, '1998/04/02');
      expect(
        RegionConfig.india.calendar.fromGregorian(DateTime(1998, 4, 2)),
        const TraditionalDate(1920, 1, 12),
      );
    });

    test('Nepal region keeps Kritika Paudel / +977', () {
      final ds = ProfileLocalDataSourceImpl(InMemoryKeyValueStore(), nepal);
      final p = ds.read();
      expect(p.name, 'Kritika Paudel');
      expect(p.phone, startsWith('+977'));
      expect(p.dobBs, '2054/12/20');
    });

    test('resolver is read at call time (region switch changes seed)', () {
      final store = InMemoryKeyValueStore();
      final resolver = _MutableResolver(Region.nepal);
      final ds = ProfileLocalDataSourceImpl(store, resolver);
      expect(ds.read().name, 'Kritika Paudel');
      resolver.region = Region.india;
      expect(ds.read().name, 'Priya Sharma');
    });
  });

  group('MockBusinessDataSource', () {
    test(
      'India seeds Delhi / Mumbai businesses with ₹ prices and GSTIN',
      () async {
        final ds = MockBusinessDataSource(InMemoryKeyValueStore(), india);
        final b1 = await ds.getBusiness('biz-1');
        final b2 = await ds.getBusiness('biz-2');
        expect(b1.address, contains('Delhi'));
        expect(b1.phone, startsWith('+91'));
        expect(b1.taxId, startsWith('GSTIN'));
        expect(b1.items.first.priceLabel, '₹8,000 - ₹16,000');
        expect(b2.address, contains('Mumbai'));
        expect(b2.items.first.priceLabel, '₹2,400');
      },
    );

    test('Nepal seeds Kathmandu businesses with रु. prices and PAN', () async {
      final ds = MockBusinessDataSource(InMemoryKeyValueStore(), nepal);
      final b1 = await ds.getBusiness('biz-1');
      expect(b1.name, 'Uttam Astro & Gems');
      expect(b1.address, contains('Kathmandu'));
      expect(b1.phone, startsWith('+977'));
      expect(b1.taxId, startsWith('PAN'));
      expect(b1.items.first.priceLabel, 'Rs. 10,000 - Rs. 20,000');
    });

    test('taxId survives JSON round-trip and upsert', () async {
      final store = InMemoryKeyValueStore();
      final ds = MockBusinessDataSource(store, india);
      const model = BusinessProfileModel(
        id: 'my-business',
        name: 'Test',
        category: 'Cat',
        taxId: 'GSTIN 27AAAAA0000A1Z5',
      );
      await ds.upsert(model);
      final again = MockBusinessDataSource(store, nepal);
      final loaded = await again.getBusiness('my-business');
      expect(loaded.taxId, 'GSTIN 27AAAAA0000A1Z5');
      expect(BusinessProfileModel.fromJson(model.toJson()).taxId, model.taxId);
      expect(
        const BusinessProfile(id: 'x', name: 'n', category: 'c').taxId,
        '',
      );
    });
  });

  test('MockFavouritesDataSource formats prices in region currency', () async {
    final inr = await const MockFavouritesDataSource(india).getFavourites();
    expect(inr.first.priceLabel, startsWith('₹'));
    expect(inr.first.location, contains('Delhi'));
    final npr = await const MockFavouritesDataSource(nepal).getFavourites();
    expect(npr.first.priceLabel, startsWith('Rs.'));
    expect(npr.first.location, contains('Kathmandu'));
  });

  test('BusinessRegionFields / SupportContacts are keyed by region', () {
    final inFields = BusinessRegionFields.of(RegionConfig.india);
    expect(inFields.taxIdLabel('en'), contains('GSTIN'));
    expect(inFields.taxIdLabel('hi'), contains('GSTIN'));
    expect(inFields.addressHint, contains('PIN'));
    expect(inFields.phoneHint, startsWith('+91'));
    final npFields = BusinessRegionFields.of(RegionConfig.nepal);
    expect(npFields.taxIdLabel('en'), contains('PAN'));
    expect(npFields.phoneHint, startsWith('+977'));

    expect(SupportContacts.of(RegionConfig.india).phone, startsWith('+91'));
    expect(
      SupportContacts.of(RegionConfig.india).email,
      'support.in@sanatannepal.com',
    );
    expect(SupportContacts.of(RegionConfig.nepal).phone, startsWith('+977'));
  });

  group('widgets (India region)', () {
    late InMemoryKeyValueStore store;
    late AppSettingsCubit settings;

    setUp(() {
      store = InMemoryKeyValueStore();
      final prefsRepo = AppPreferencesRepositoryImpl(
        AppPreferencesLocalDataSourceImpl(store),
      );
      settings = AppSettingsCubit(
        getPreferences: GetAppPreferences(prefsRepo),
        savePreferences: SaveAppPreferences(prefsRepo),
      );
    });

    Widget wrap(
      Widget child, {
      Region region = Region.india,
      Locale locale = const Locale('en'),
    }) => MaterialApp(
      theme: AppTheme.light(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: RegionScope(
        region: region,
        child: BlocProvider<AppSettingsCubit>.value(
          value: settings,
          child: Scaffold(body: child),
        ),
      ),
    );

    testWidgets('OrderCard formats amounts with ₹ (India) and रु. (Nepal)', (
      tester,
    ) async {
      final order = OrderSummary(
        id: 'o',
        productName: 'Iphone',
        price: 8000,
        sellingPrice: 10000,
        counterpartyName: 'Ram Bahadur',
        counterpartyId: 'u',
        role: OrderRole.seller,
        status: OrderStatus.placed,
        updatedAt: DateTime.now(),
      );
      await tester.pumpWidget(wrap(OrderCard(order: order)));
      await tester.pumpAndSettle();
      expect(find.text('₹8,000'), findsOneWidget);
      expect(find.textContaining('₹10,000'), findsOneWidget);

      await tester.pumpWidget(
        wrap(OrderCard(order: order), region: Region.nepal),
      );
      await tester.pumpAndSettle();
      expect(find.text('Rs. 8,000'), findsOneWidget);
    });

    testWidgets('ProfileInfoCard shows Saka + A.D. DOB in India', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          const ProfileInfoCard(profile: ProfileLocalDataSourceImpl.seedIndia),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.textContaining(
          '1920/01/12 Saka · 1998/04/02 A.D.',
          findRichText: true,
        ),
        findsOneWidget,
      );
      // A Nepal-stored profile viewed in India is re-derived to Saka.
      await tester.pumpWidget(
        wrap(const ProfileInfoCard(profile: ProfileLocalDataSourceImpl.seed)),
      );
      await tester.pumpAndSettle();
      expect(
        find.textContaining('1920/01/12 Saka', findRichText: true),
        findsOneWidget,
      );
      // Nepal keeps B.S.
      await tester.pumpWidget(
        wrap(
          const ProfileInfoCard(profile: ProfileLocalDataSourceImpl.seed),
          region: Region.nepal,
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.textContaining(
          '2054/12/20 B.S. · 1998/04/02 A.D.',
          findRichText: true,
        ),
        findsOneWidget,
      );
    });

    testWidgets('AppointmentCard shows Saka month in India', (tester) async {
      final apt = MockActivityDataSource();
      final list = await apt.getAppointments();
      await tester.pumpWidget(wrap(AppointmentCard(appointment: list.first)));
      await tester.pumpAndSettle();
      // 30 Mar 2023 = Chaitra 9, Saka 1945.
      expect(find.textContaining('Chaitra 9, 1945'), findsOneWidget);
    });

    testWidgets('EditProfileView uses Saka DOB label and +91 hint (India)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final repo = ProfileRepositoryImpl(
        local: ProfileLocalDataSourceImpl(store, india),
        favourites: const MockFavouritesDataSource(india),
      );
      await tester.pumpWidget(
        wrap(
          BlocProvider(
            create: (_) => EditProfileCubit(
              getProfile: GetUserProfile(repo),
              updateProfile: UpdateUserProfile(repo),
            )..load(),
            child: const EditProfileView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Priya Sharma'), findsOneWidget);
      expect(find.text('Date of Birth (Saka)'), findsOneWidget);
      expect(find.text('1920/01/12'), findsOneWidget);
      // Traditional picker opens on the Saka calendar.
      await tester.tap(find.text('1920/01/12'));
      await tester.pumpAndSettle();
      expect(find.text('Chaitra'), findsWidgets);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('1920/01/12'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('SupportPage shows India contacts', (tester) async {
      await tester.pumpWidget(wrap(const SupportPage()));
      await tester.pumpAndSettle();
      expect(find.text('+91-11-40000000'), findsOneWidget);
      expect(find.text('support.in@sanatannepal.com'), findsOneWidget);
      expect(find.text('+977-01-4444444'), findsNothing);
    });

    testWidgets('BusinessFormView shows GSTIN field and +91 hint (India)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(600, 2000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final repo = BusinessRepositoryImpl(MockBusinessDataSource(store, india));
      await tester.pumpWidget(
        wrap(
          BlocProvider(
            create: (_) => BusinessFormCubit(
              getBusiness: GetBusinessProfile(repo),
              getMyBusiness: GetMyBusiness(repo),
              upsertBusiness: UpsertBusinessProfile(repo),
              businessId: 'biz-1',
            )..load(),
            child: const BusinessFormView(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Sharma Jyotish & Ratna Kendra'), findsOneWidget);
      expect(
        find.textContaining('GSTIN (optional)', findRichText: true),
        findsOneWidget,
      );
      expect(find.text('GSTIN 07AAACS1234A1Z5'), findsOneWidget);
      expect(find.text('+91-9810123456'), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('BusinessProfileView renders in Hindi (India)', (tester) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final repo = BusinessRepositoryImpl(MockBusinessDataSource(store, india));
      final products = ProductRepositoryImpl(
        MockProductDataSource(resolver: india),
      );
      await tester.pumpWidget(
        wrap(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => BusinessProfileCubit(
                  getBusiness: GetBusinessProfile(repo),
                  getMyBusiness: GetMyBusiness(repo),
                  setStatus: SetBusinessStatus(repo),
                  upsertBusiness: UpsertBusinessProfile(repo),
                  repository: repo,
                  roles: const NoopRoleGranter(),
                  sessionRefresher: const NoopSessionRefresher(),
                )..load('biz-2'),
              ),
              BlocProvider(
                create: (_) => BusinessListingsCubit(
                  getProducts: GetProducts(products),
                  deleteProduct: DeleteProduct(products),
                  businessId: 'biz-2',
                )..load(),
              ),
            ],
            child: const BusinessProfileView(mode: BusinessProfileMode.admin),
          ),
          locale: const Locale('hi'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Shree Gems & Jewels'), findsOneWidget);
      expect(find.text('स्वीकृत करें'), findsOneWidget);
      await tester.ensureVisible(find.text('उत्पाद'));
      await tester.tap(find.text('उत्पाद'));
      await tester.pumpAndSettle();
      // The shop's tab is its marketplace listings, priced in ₹ with
      // Devanagari digits in Hindi.
      expect(
        find.text('किराए पर २ बीएचके फ़्लैट, अंधेरी वेस्ट'),
        findsOneWidget,
      );
      expect(find.textContaining('₹'), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('AdminBusinessesView renders in Hindi (India) with ₹ seeds', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final repo = BusinessRepositoryImpl(MockBusinessDataSource(store, india));
      await tester.pumpWidget(
        wrap(
          BlocProvider(
            create: (_) => AdminBusinessesCubit(
              getBusinesses: GetBusinesses(repo),
              setStatus: SetBusinessStatus(repo),
            )..load(),
            child: const AdminBusinessesView(),
          ),
          locale: const Locale('hi'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('व्यवसाय स्वीकृतियाँ'), findsOneWidget);
      // Pending filter → the Mumbai jeweller with a Devanagari review count.
      expect(find.text('Shree Gems & Jewels'), findsOneWidget);
      expect(find.text('(२४)'), findsOneWidget);
      expect(find.text('स्वीकृत करें'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('SupportPage renders in Hindi', (tester) async {
      await tester.pumpWidget(
        wrap(const SupportPage(), locale: const Locale('hi')),
      );
      await tester.pumpAndSettle();
      expect(find.text('सहायता और समर्थन'), findsOneWidget);
      expect(find.text('हमें कॉल करें'), findsOneWidget);
      expect(find.text('अक्सर पूछे जाने वाले प्रश्न'), findsOneWidget);
      // Devanagari digits for the Indian support number.
      expect(find.text('+९१-११-४०००००००'), findsOneWidget);
    });
  });
}

class _MutableResolver implements RegionResolver {
  _MutableResolver(this.region);
  @override
  Region region;
  @override
  RegionConfig get config => region.config;
}
