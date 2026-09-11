import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/domain/entities/legal_document.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/legal_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/presentation/pages/legal_document_page.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

void main() {
  /// (Re)registers the feature with a fixed region resolver – the mock data
  /// source reads the region on every call.
  Future<void> useRegion(Region region) async {
    await GetIt.I.reset(dispose: false);
    GetIt.I.registerLazySingleton<RegionResolver>(
      () => FixedRegionResolver(region),
    );
    registerLegalFeature(GetIt.I);
  }

  setUpAll(() => useRegion(Region.nepal));
  tearDownAll(() => GetIt.I.reset());

  Widget app(
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

  testWidgets('privacy policy renders headed sections', (tester) async {
    await tester.pumpWidget(
      app(const LegalDocumentPage(type: LegalDocumentType.privacyPolicy)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.textContaining('Last updated'), findsOneWidget);
    expect(find.text('1. What Information Do We Collect?'), findsOneWidget);
  });

  testWidgets('terms page renders in Nepali with Devanagari numbering', (
    tester,
  ) async {
    await tester.pumpWidget(
      app(
        const LegalDocumentPage(type: LegalDocumentType.termsConditions),
        locale: const Locale('ne'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('नियम तथा सर्तहरू'), findsOneWidget);
    expect(find.text('१. परिभाषाहरू'), findsOneWidget);
  });

  testWidgets('India region + Hindi: Hindi headings, Saka date, DPDP body', (
    tester,
  ) async {
    await useRegion(Region.india);
    addTearDown(() => useRegion(Region.nepal));

    await tester.pumpWidget(
      app(
        const LegalDocumentPage(type: LegalDocumentType.privacyPolicy),
        locale: const Locale('hi'),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('गोपनीयता नीति'), findsOneWidget);
    expect(find.text('१. हम कौन-सी जानकारी एकत्र करते हैं?'), findsOneWidget);
    // lastUpdated 10 Apr 2023 = Chaitra 20, 1945 Saka (Hindi month name).
    expect(find.textContaining('चैत्र २०, १९४५'), findsOneWidget);
    // Hindi summary precedes the (authoritative) English body.
    expect(find.textContaining('सारांश:'), findsWidgets);
    await tester.scrollUntilVisible(find.text('१०. शिकायत अधिकारी'), 400);
    expect(
      find.textContaining('Digital Personal Data Protection Act, 2023'),
      findsWidgets,
    );
    expect(
      find.textContaining('grievance.in@ourvirtualtribes.com'),
      findsOneWidget,
    );
  });

  testWidgets('India region (English): terms show New Delhi jurisdiction', (
    tester,
  ) async {
    await useRegion(Region.india);
    addTearDown(() => useRegion(Region.nepal));

    await tester.pumpWidget(
      app(
        const LegalDocumentPage(type: LegalDocumentType.termsConditions),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.textContaining('courts of New Delhi, India'),
      400,
    );
    expect(find.text('9. Governing law and jurisdiction'), findsOneWidget);
    expect(find.text('10. Contact Us'), findsOneWidget);
  });
}
