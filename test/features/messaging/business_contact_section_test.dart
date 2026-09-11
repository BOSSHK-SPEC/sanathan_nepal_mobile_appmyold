import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/di/injection.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/data/datasources/mock_messaging_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/data/repositories/messaging_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/domain/usecases/messaging_usecases.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/cubit/business_contact_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/business_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/presentation/widgets/business_contact_section.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

const business = BusinessProfile(
  id: 'biz-2',
  name: 'Kathmandu Puja Bhandar',
  category: 'Puja items',
  email: 'shop@example.com',
  phone: '+977-9841234567',
  whatsapp: '+977-9841234567',
  address: 'Baneshwor, Kathmandu',
);

void main() {
  late InMemoryKeyValueStore store;
  late MockMessagingDataSource source;
  late MessagingRepositoryImpl repo;
  late AppSettingsCubit settings;

  setUpAll(() {
    // The section resolves its cubit from GetIt, as the page does at runtime.
    sl.registerFactoryParam<BusinessContactCubit, String, void>(
      (businessId, _) => BusinessContactCubit(
        messageBusiness: MessageBusiness(repo),
        businessId: businessId,
      ),
    );
  });

  setUp(() {
    store = InMemoryKeyValueStore();
    source = MockMessagingDataSource(store);
    repo = MessagingRepositoryImpl(source);
    final prefsRepo = AppPreferencesRepositoryImpl(
      AppPreferencesLocalDataSourceImpl(store),
    );
    settings = AppSettingsCubit(
      getPreferences: GetAppPreferences(prefsRepo),
      savePreferences: SaveAppPreferences(prefsRepo),
    );
  });

  Widget wrap(Widget child) => MaterialApp.router(
    theme: AppTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider<AppSettingsCubit>.value(
            value: settings,
            child: Scaffold(body: SingleChildScrollView(child: child)),
          ),
        ),
        GoRoute(
          path: '/messages/:id',
          builder: (context, state) => const Scaffold(body: Text('thread')),
        ),
      ],
    ),
  );

  testWidgets('the enquiry form actually delivers the message', (tester) async {
    await tester.pumpWidget(
      wrap(const BusinessContactSection(business: business)),
    );
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Kritika');
    await tester.enterText(fields.at(1), 'k@example.com');
    await tester.enterText(fields.at(2), 'Do you have brass diyo?');
    await tester.tap(find.text('Send Message').last);
    await tester.pumpAndSettle();

    // The form used to show a success snackbar and clear the box without
    // sending anything at all. It has to reach the shop.
    final thread = await source.threadWithBusiness('biz-2');
    expect(thread, isNotNull);
    expect(thread!.lastMessagePreview, 'Do you have brass diyo?');
    expect(thread.contactName, 'Kritika');
    expect(thread.contactEmail, 'k@example.com');
    expect(
      (await source.messages(thread.id)).single.body,
      'Do you have brass diyo?',
    );
  });

  testWidgets('an empty message is refused instead of silently swallowed', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(const BusinessContactSection(business: business)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Send Message').last);
    await tester.pumpAndSettle();

    expect(find.text('Write a message first'), findsOneWidget);
    expect(await source.threadWithBusiness('biz-2'), isNull);
  });

  testWidgets('a refusal is shown, not reported as success', (tester) async {
    // The mock refuses a shop messaging itself, exactly as the server does.
    await tester.pumpWidget(
      wrap(
        const BusinessContactSection(
          business: BusinessProfile(
            id: 'my-business',
            name: 'My Business',
            category: 'Puja items',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(2), 'Hello');
    await tester.tap(find.text('Send Message').last);
    await tester.pumpAndSettle();

    expect(
      find.text('You cannot send a message to your own business'),
      findsWidgets,
    );
    expect(find.text('View conversation'), findsNothing);
  });

  testWidgets('a successful send offers the conversation', (tester) async {
    await tester.pumpWidget(
      wrap(const BusinessContactSection(business: business)),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(2), 'Namaste');
    await tester.tap(find.text('Send Message').last);
    await tester.pumpAndSettle();

    expect(find.text('View conversation'), findsWidgets);
  });
}
