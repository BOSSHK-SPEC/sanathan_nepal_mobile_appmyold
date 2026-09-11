import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/notifications_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/presentation/widgets/notification_list_view.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/presentation/widgets/notification_settings_view.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

Widget _app(
  Widget home, {
  Locale locale = const Locale('en'),
  Region region = Region.nepal,
}) => RegionScope(
  region: region,
  child: MaterialApp(
    theme: AppTheme.light(),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

/// Small-phone viewport (Figma frame is 375 wide) to catch overflows.
Future<void> pumpPhone(WidgetTester tester, Widget app) async {
  tester.view.physicalSize = const Size(375, 812);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(app);
  await tester.pumpAndSettle();
}

void main() {
  final sl = GetIt.instance;

  setUp(() async {
    await sl.reset();
    sl
      ..registerLazySingleton<KeyValueStore>(InMemoryKeyValueStore.new)
      ..registerLazySingleton<RegionResolver>(
        () => const FixedRegionResolver(Region.nepal),
      );
    registerNotificationsFeature(sl);
  });

  /// Re-registers the region resolver so the mock inbox seeds for [region].
  void useRegion(Region region) {
    sl
      ..unregister<RegionResolver>()
      ..registerLazySingleton<RegionResolver>(
        () => FixedRegionResolver(region),
      );
  }

  tearDown(sl.reset);

  testWidgets('NotificationsPage lists cards and switches to settings', (
    tester,
  ) async {
    await pumpPhone(tester, _app(const NotificationsPage()));
    await tester.pumpAndSettle();
    expect(find.text('Your daily horoscope is ready'), findsOneWidget);
    expect(find.text('My Birthday'), findsOneWidget);
    expect(find.text('Dashain reminder'), findsOneWidget);
    expect(find.text('1h ago'), findsOneWidget);
    expect(find.text('Mark all as read'), findsOneWidget);

    await tester.tap(find.text('Notification Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Horoscope Notification Setting'), findsOneWidget);
    expect(find.text('Festivals Notification Setting'), findsOneWidget);
    expect(find.text('Birthday Notification Setting'), findsOneWidget);
    expect(find.text('6:30 AM'), findsOneWidget);
    expect(find.text('12:00 AM'), findsNWidgets(2));
  });

  testWidgets(
    'NotificationSettingsPage opens on the settings tab and persists',
    (tester) async {
      await pumpPhone(tester, _app(const NotificationSettingsPage()));
      await tester.pumpAndSettle();
      expect(find.text('Important Hindu Festivals'), findsOneWidget);

      await tester.tap(find.text('Monthly'));
      await tester.pumpAndSettle();
      expect(
        sl<KeyValueStore>().getString('notifications.settings'),
        contains('"horoscope_monthly":true'),
      );
    },
  );

  testWidgets('embedded views render in Nepali with Devanagari digits', (
    tester,
  ) async {
    await pumpPhone(
      tester,
      _app(
        const Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                NotificationListView(shrinkWrap: true),
                NotificationSettingsView(shrinkWrap: true),
              ],
            ),
          ),
        ),
        locale: const Locale('ne'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('आजको राशिफल तयार छ'), findsOneWidget);
    expect(find.text('१ घण्टा अघि'), findsOneWidget);
    expect(find.text('राशिफल सूचना सेटिङ'), findsOneWidget);
    expect(find.text('७'), findsOneWidget);
  });

  testWidgets(
    'India region + Hindi: page renders Hindi strings and India seed',
    (tester) async {
      useRegion(Region.india);
      await pumpPhone(
        tester,
        _app(
          const NotificationsPage(),
          locale: const Locale('hi'),
          region: Region.india,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('सूचनाएँ'), findsWidgets);
      expect(find.text('सूचना सेटिंग'), findsOneWidget);
      expect(find.text('सभी को पढ़ा हुआ चिह्नित करें'), findsOneWidget);
      expect(find.text('आपका आज का राशिफल तैयार है'), findsOneWidget);
      expect(find.text('१ घंटा पहले'), findsOneWidget);
      expect(find.text('३ घंटे पहले'), findsOneWidget);
      expect(find.text('दिवाली अनुस्मारक'), findsOneWidget);
      expect(find.text('दशैं अनुस्मारक'), findsNothing);
      expect(find.textContaining('नेपाल'), findsNothing);

      await tester.tap(find.text('सूचना सेटिंग'));
      await tester.pumpAndSettle();
      expect(find.text('राशिफल सूचना सेटिंग'), findsOneWidget);
      expect(find.text('त्योहार सूचना सेटिंग'), findsOneWidget);
      expect(find.text('प्रमुख हिंदू त्योहार'), findsOneWidget);
      expect(find.text('सार्वजनिक अवकाश'), findsOneWidget);
      expect(find.text('जन्मदिन सूचना सेटिंग'), findsOneWidget);
      // Devanagari digits for the "remind me before 7 days" stepper.
      expect(find.text('७'), findsOneWidget);
    },
  );

  testWidgets('India region + English: welcome text does not mention Nepal', (
    tester,
  ) async {
    useRegion(Region.india);
    await pumpPhone(
      tester,
      _app(const Scaffold(body: NotificationListView()), region: Region.india),
    );
    await tester.pumpAndSettle();
    expect(find.text('Diwali reminder'), findsOneWidget);
    expect(find.text('Dashain reminder'), findsNothing);
    await tester.scrollUntilVisible(find.text('Welcome to Sanatan'), 200);
    await tester.pumpAndSettle();
    expect(find.text('Welcome to Sanatan'), findsOneWidget);
    expect(find.textContaining('Nepal'), findsNothing);
  });
}
