import 'package:sanathan_nepal_mobile_app/core/session/session_refresher.dart';
import 'package:sanathan_nepal_mobile_app/core/session/role_granter.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_my_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/app/di/injection.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/notifications_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_activity_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_business_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_favourites_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/activity_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/delete_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/business_listings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/business_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/delete_account.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_appointments.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_businesses.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_favourite_products.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_orders.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/logout.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/set_business_status.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/update_order.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/update_user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/upsert_business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/activity_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/admin_businesses_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/business_form_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/business_profile_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/admin_businesses_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/business_form_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/business_profile_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/my_business_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/profile_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/pages/support_page.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/widgets/delete_confirm_dialog.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/widgets/profile_links_tab.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

void main() {
  late InMemoryKeyValueStore store;
  late ProfileRepositoryImpl profileRepo;
  late BusinessRepositoryImpl businessRepo;
  late ProductRepositoryImpl productRepo;
  late ActivityRepositoryImpl activityRepo;
  late AppSettingsCubit settings;

  setUpAll(() {
    // The NOTIFICATIONS tab embeds the notifications feature's self-providing
    // views, which resolve their cubits from GetIt.
    if (!sl.isRegistered<KeyValueStore>()) {
      sl.registerLazySingleton<KeyValueStore>(InMemoryKeyValueStore.new);
    }
    if (!sl.isRegistered<RegionResolver>()) {
      sl.registerLazySingleton<RegionResolver>(
        () => const FixedRegionResolver(Region.nepal),
      );
    }
    registerNotificationsFeature(sl);
    // MyBusinessView embeds BusinessFormPage which resolves its cubit from
    // GetIt; the factory reads the per-test repository lazily.
    sl.registerFactoryParam<BusinessFormCubit, String, void>(
      (id, _) => BusinessFormCubit(
        getBusiness: GetBusinessProfile(businessRepo),
        getMyBusiness: GetMyBusiness(businessRepo),
        upsertBusiness: UpsertBusinessProfile(businessRepo),
        businessId: id,
      ),
    );
    // MyBusinessView provides this for the Products / Services tabs.
    sl.registerFactoryParam<BusinessListingsCubit, String, void>(
      (id, _) => BusinessListingsCubit(
        getProducts: GetProducts(productRepo),
        deleteProduct: DeleteProduct(productRepo),
        businessId: id,
      ),
    );
  });

  setUp(() {
    store = InMemoryKeyValueStore();
    const resolver = FixedRegionResolver(Region.nepal);
    profileRepo = ProfileRepositoryImpl(
      local: ProfileLocalDataSourceImpl(store, resolver),
      favourites: const MockFavouritesDataSource(resolver),
    );
    businessRepo = BusinessRepositoryImpl(
      MockBusinessDataSource(store, resolver),
    );
    productRepo = ProductRepositoryImpl(
      MockProductDataSource(resolver: resolver),
    );
    activityRepo = ActivityRepositoryImpl(MockActivityDataSource());
    final prefsRepo = AppPreferencesRepositoryImpl(
      AppPreferencesLocalDataSourceImpl(store),
    );
    settings = AppSettingsCubit(
      getPreferences: GetAppPreferences(prefsRepo),
      savePreferences: SaveAppPreferences(prefsRepo),
    );
  });

  Widget wrap(Widget child, {Locale locale = const Locale('en')}) =>
      MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<AppSettingsCubit>.value(
          value: settings,
          child: child,
        ),
      );

  BusinessProfileCubit businessCubit() => BusinessProfileCubit(
    getBusiness: GetBusinessProfile(businessRepo),
    getMyBusiness: GetMyBusiness(businessRepo),
    setStatus: SetBusinessStatus(businessRepo),
    upsertBusiness: UpsertBusinessProfile(businessRepo),
    repository: businessRepo,
    roles: const NoopRoleGranter(),
    sessionRefresher: const NoopSessionRefresher(),
  );

  /// The shop page needs both cubits: its identity and its listings, which
  /// are marketplace products rather than a catalogue on the business row.
  Widget businessProfile(String id, {BusinessProfileMode? mode}) =>
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => businessCubit()..load(id)),
          BlocProvider(
            create: (_) => BusinessListingsCubit(
              getProducts: GetProducts(productRepo),
              deleteProduct: DeleteProduct(productRepo),
              businessId: id,
            )..load(),
          ),
        ],
        child: mode == null
            ? const BusinessProfileView()
            : BusinessProfileView(mode: mode),
      );

  Widget profileView({int tab = 0}) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ProfileCubit(
          getProfile: GetUserProfile(profileRepo),
          getFavourites: GetFavouriteProducts(profileRepo),
          logout: Logout(profileRepo),
          deleteAccount: DeleteAccount(profileRepo),
        )..load(),
      ),
      BlocProvider(
        create: (_) => ActivityCubit(
          getAppointments: GetAppointments(activityRepo),
          getOrders: GetOrders(activityRepo),
          applyOrderAction: ApplyOrderAction(activityRepo),
          rateOrder: RateOrder(activityRepo),
        )..load(),
      ),
    ],
    child: ProfileView(initialTab: tab),
  );

  group('ProfileView', () {
    testWidgets('ACTIVITIES lists appointments without denying they exist', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(wrap(profileView(tab: 1)));
      await tester.pumpAndSettle();

      expect(find.text('CHEENA READING APPOINTMENT'), findsOneWidget);
      // The invitation card used to sit above the list unconditionally, so a
      // booked appointment was announced as "no appointments booked".
      expect(
        find.text("You don't have any appointments booked."),
        findsNothing,
      );
    });

    testWidgets('renders header + ABOUT tab (light, en)', (tester) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(wrap(profileView()));
      await tester.pumpAndSettle();
      expect(find.text('Kritika Paudel'), findsOneWidget);
      expect(find.text('kritikapaudel9@gmail.com'), findsOneWidget);
      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.text('ABOUT'), findsOneWidget);
      expect(find.text('Preferences'), findsOneWidget);
      expect(find.text('Blue Sapphire'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('ACTIVITIES tab shows appointments and orders', (tester) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(wrap(profileView(tab: 1)));
      await tester.pumpAndSettle();
      expect(find.text('CHEENA READING APPOINTMENT'), findsOneWidget);
      await tester.ensureVisible(find.text('My Orders'));
      await tester.tap(find.text('My Orders'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Order Placed !', findRichText: true),
        findsOneWidget,
      );
      await tester.ensureVisible(find.text('Seller: My Sales'));
      await tester.tap(find.text('Seller: My Sales'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('New Order Received !', findRichText: true),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('NOTIFICATIONS and LINKS tabs render (Nepali, dark)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await settings.setThemeMode(ThemeMode.dark);
      await tester.pumpWidget(
        wrap(profileView(tab: 2), locale: const Locale('ne')),
      );
      await tester.pumpAndSettle();
      expect(find.text('सूचना सेटिङ'), findsOneWidget);
      await tester.tap(find.text('सूचना सेटिङ'));
      await tester.pumpAndSettle();
      expect(find.text('राशिफल सूचना सेटिङ'), findsOneWidget);
      await tester.ensureVisible(find.text('लिङ्कहरू'));
      await tester.tap(find.text('लिङ्कहरू'));
      await tester.pumpAndSettle();
      expect(find.text('उपयोगी लिङ्कहरू'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('language radio switches AppSettingsCubit', (tester) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(wrap(profileView()));
      await tester.pumpAndSettle();
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();
      expect(settings.state.language.code, 'en');
    });
  });

  testWidgets('EditProfileView shows seeded values and saves', (tester) async {
    tester.view.physicalSize = const Size(600, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => EditProfileCubit(
            getProfile: GetUserProfile(profileRepo),
            updateProfile: UpdateUserProfile(profileRepo),
          )..load(),
          child: const EditProfileView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Kritika Paudel'), findsOneWidget);
    expect(
      find.textContaining('Full Name', findRichText: true),
      findsOneWidget,
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Kritika Paudel'),
      'Sita',
    );
    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();
    expect(store.getString(ProfileStorageKeys.profile), contains('Sita'));
    expect(tester.takeException(), isNull);
  });

  testWidgets('BusinessProfileView (admin) approves via Seller Approval '
      'dialog', (tester) async {
    tester.view.physicalSize = const Size(600, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrap(businessProfile('biz-2', mode: BusinessProfileMode.admin)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Shree Gems & Jewels'), findsOneWidget);
    expect(find.text('Admin actions'), findsOneWidget);
    expect(find.text('Approve'), findsOneWidget);
    await tester.tap(find.text('Approve'));
    await tester.pumpAndSettle();
    expect(find.text('Seller Approval'), findsOneWidget);
    await tester.tap(find.text('Approve').last);
    await tester.pumpAndSettle();
    expect(find.text('Approved'), findsWidgets);
    expect(find.text('Approve'), findsNothing);
    await tester.ensureVisible(find.text('Products'));
    await tester.tap(find.text('Products'));
    await tester.pumpAndSettle();
    // The shop's tab is its marketplace listings, not a private catalogue on
    // the business row — the two used to be different lists with one name.
    expect(find.text('2 BHK Flat for Rent, Baneshwor'), findsOneWidget);
    await tester.ensureVisible(find.text('Reviews'));
    await tester.tap(find.text('Reviews'));
    await tester.pumpAndSettle();
    expect(find.text('Customer reviews'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('BusinessFormView validates and moves to step 2', (tester) async {
    tester.view.physicalSize = const Size(600, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => BusinessFormCubit(
            getBusiness: GetBusinessProfile(businessRepo),
            getMyBusiness: GetMyBusiness(businessRepo),
            upsertBusiness: UpsertBusinessProfile(businessRepo),
            businessId: 'my-business',
          )..load(),
          child: const BusinessFormView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Business Details'), findsOneWidget);
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('This field is required'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('BusinessProfileView (admin) rejects with a reason', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrap(businessProfile('biz-2', mode: BusinessProfileMode.admin)),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reject'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).last, 'Missing PAN');
    await tester.tap(find.text('Reject').last);
    await tester.pumpAndSettle();
    expect(find.text('Rejected'), findsWidgets);
    expect(find.textContaining('Missing PAN'), findsOneWidget);
    expect(
      (await businessRepo.getBusiness('biz-2')).valueOrNull?.moderationNote,
      'Missing PAN',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('BusinessProfileView (viewer) hides moderation and edit', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(wrap(businessProfile('biz-2')));
    await tester.pumpAndSettle();
    expect(find.text('Shree Gems & Jewels'), findsOneWidget);
    expect(find.text('Approve'), findsNothing);
    expect(find.text('Status'), findsNothing);
    await tester.tap(find.text('Products'));
    await tester.pumpAndSettle();
    expect(find.text('Add New Product'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'BusinessProfileView (owner) shows the status card and why a pending '
    'shop cannot publish',
    (tester) async {
      tester.view.physicalSize = const Size(600, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        wrap(businessProfile('biz-2', mode: BusinessProfileMode.owner)),
      );
      await tester.pumpAndSettle();
      expect(find.text('Status'), findsOneWidget);
      expect(find.text('Pending approval'), findsWidgets);
      expect(find.text('Approve'), findsNothing);
      await tester.tap(find.text('Services'));
      await tester.pumpAndSettle();
      // A pending shop cannot publish: the button is replaced by the reason,
      // rather than offering an action that can only fail at submit.
      expect(find.text('Add Other Services'), findsNothing);
      expect(find.textContaining('still under review'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'MyBusinessView opens Products and Services without a provider error',
    (tester) async {
      // The regression this guards: MyBusinessView provided only the profile
      // cubit, so BusinessProfileView threw ProviderNotFoundException the
      // moment an owner tapped Products. The About tab needs no listings
      // cubit, so nothing failed until then — which is why this test opens the
      // tabs rather than just rendering the page.
      tester.view.physicalSize = const Size(600, 2200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        wrap(
          BlocProvider(
            // A seeded business rather than loadMine(): the mock has none for
            // the user until one is created, and that path renders the create
            // form, which has no tabs to open.
            create: (_) => businessCubit()..load('biz-2'),
            child: const MyBusinessView(),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pump();

      for (final tab in ['Products', 'Services']) {
        await tester.tap(find.text(tab).last);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 700));
        await tester.pump();

        expect(
          tester.takeException(),
          isNull,
          reason: 'the $tab tab must find its BusinessListingsCubit',
        );
      }
    },
  );

  testWidgets('MyBusinessView shows the form when the user has no business '
      'and the owner view once submitted', (tester) async {
    tester.view.physicalSize = const Size(600, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) =>
              businessCubit()..load(MockBusinessDataSource.myBusinessId),
          child: const MyBusinessView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Business Details'), findsOneWidget);
    // Fill the required fields and submit.
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Official Business name'),
      'Kritika Crafts',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'eg: Digital Marketing Agency'),
      'Handicraft',
    );
    // Phone (3rd field: name, type, website, phone).
    await tester.enterText(find.byType(TextFormField).at(3), '9800000000');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'name@gmail.com'),
      'k@x.com',
    );
    await tester.enterText(
      find.widgetWithText(
        TextFormField,
        'Short description about business (20 words)',
      ),
      'Handmade goods.',
    );
    await tester.ensureVisible(find.text('Next'));
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Submit'));
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    expect(find.text('Submitted for approval'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    // Owner view of the freshly created (pending) business.
    expect(find.text('Kritika Crafts'), findsOneWidget);
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('Pending approval'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('AdminBusinessesView filters and moderates listings', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(600, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => AdminBusinessesCubit(
            getBusinesses: GetBusinesses(businessRepo),
            setStatus: SetBusinessStatus(businessRepo),
          )..load(),
          child: const AdminBusinessesView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Business approvals'), findsOneWidget);
    // Default filter = pending → only Shree Gems.
    expect(find.text('Shree Gems & Jewels'), findsOneWidget);
    expect(find.text('Uttam Astro & Gems'), findsNothing);
    await tester.ensureVisible(find.textContaining('All ('));
    await tester.tap(find.textContaining('All ('));
    await tester.pumpAndSettle();
    expect(find.text('Uttam Astro & Gems'), findsOneWidget);
    // Quick approve from the list.
    await tester.tap(find.text('Approve'));
    await tester.pumpAndSettle();
    expect(find.text('Seller Approval'), findsOneWidget);
    await tester.tap(find.text('Approve').last);
    await tester.pumpAndSettle();
    expect(find.text('Approve'), findsNothing);
    await tester.ensureVisible(find.textContaining('Pending ('));
    await tester.tap(find.textContaining('Pending ('));
    await tester.pumpAndSettle();
    expect(find.text('No businesses in this list.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ProfileLinksTab shows seller row and admin row only for '
      'admins', (tester) async {
    await tester.pumpWidget(
      wrap(
        Scaffold(
          body: SingleChildScrollView(
            child: ProfileLinksTab(onDeleteAccount: () {}),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('My Business / Become a Seller'), findsOneWidget);
    expect(find.text('Admin: Business approvals'), findsNothing);
    await tester.pumpWidget(
      wrap(
        Scaffold(
          body: SingleChildScrollView(
            child: ProfileLinksTab(isAdmin: true, onDeleteAccount: () {}),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Admin: Business approvals'), findsOneWidget);
  });

  testWidgets('SupportPage shows contact options and FAQ', (tester) async {
    await tester.pumpWidget(wrap(const SupportPage()));
    await tester.pumpAndSettle();
    expect(find.text('Help & Support'), findsOneWidget);
    expect(find.text('Call Us'), findsOneWidget);
    expect(find.text('Frequently Asked Questions'), findsOneWidget);
    await tester.tap(find.textContaining('language or theme'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Preferences'), findsWidgets);
  });

  testWidgets('DeleteConfirmDialog resolves true on confirm', (tester) async {
    bool? result;
    await tester.pumpWidget(
      wrap(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              result = await DeleteConfirmDialog.show(
                context,
                title: 'Sure?',
                message: 'Really',
              );
            },
            child: const Text('open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('Sure?'), findsOneWidget);
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(result, isTrue);
  });
}
