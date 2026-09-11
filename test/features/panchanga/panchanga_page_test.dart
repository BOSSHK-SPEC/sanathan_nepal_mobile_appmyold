import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/app/di/injection.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/calendar_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/month_calendar_view.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/datasources/mock_panchanga_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/models/suva_sait_model.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/repositories/panchanga_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/usecases/get_panchanga.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/usecases/get_suva_saits.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/cubit/panchanga_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/pages/panchanga_page.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/widgets/panchanga_section.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/widgets/suva_sait_section.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

final _today = DateTime(2023, 2, 23);

PanchangaCubit _cubit({Region region = Region.nepal}) {
  final repo = PanchangaRepositoryImpl(
    MockPanchangaDataSource(
      resolver: FixedRegionResolver(region),
      now: () => _today,
    ),
  );
  return PanchangaCubit(
    getPanchanga: GetPanchanga(repo),
    getSuvaSaits: GetSuvaSaits(repo),
    resolver: FixedRegionResolver(region),
    initialDate: _today,
  );
}

/// Registers the calendar feature (needed by the header's month grid).
Future<void> _registerCalendar(Region region) async {
  await sl.reset();
  sl.registerLazySingleton<RegionResolver>(() => FixedRegionResolver(region));
  registerCalendarFeature(sl);
}

Widget _app(
  Widget home, {
  Locale locale = const Locale('ne'),
  bool dark = false,
  Region region = Region.nepal,
}) => RegionScope(
  region: region,
  child: MaterialApp(
    theme: dark ? AppTheme.dark() : AppTheme.light(),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

Future<void> _scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

void main() {
  tearDown(sl.reset);

  testWidgets('PanchangaPage renders header, sait panel and table (Nepali)', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await _registerCalendar(Region.nepal);
    final cubit = _cubit();
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const PanchangaView()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('पञ्चाङ्ग तथा शुभ साइत'), findsOneWidget);
    // Header: month grid + day summary of 23 Feb 2023 = फागुन ११, २०७९.
    expect(find.byType(MonthCalendarView), findsOneWidget);
    expect(find.text('फागुन,२०७९'), findsOneWidget);
    expect(find.text('११'), findsWidgets);
    // Suva sait panel.
    expect(find.text('शुभ साइत तथा मुहूर्तहरू'), findsOneWidget);
    expect(find.text('मासिक शुभ साइत'), findsOneWidget);
    expect(find.text('वार्षिक शुभ साइत'), findsOneWidget);
    expect(find.text('फागुन महिनाको शुभ साइत'), findsOneWidget);
    expect(find.text('अघिल्लो महिना'), findsOneWidget);
    expect(find.text('आगामी महिना'), findsOneWidget);
    // Today's saits as bullets (hom + bibaha) – table rows carry the labels too.
    expect(find.text('होम गर्ने साइत'), findsNWidgets(2));
    expect(find.text('पास्नी गर्ने साइत'), findsOneWidget);
    expect(find.text('ब्रतबन्ध गर्ने साइत'), findsOneWidget);
    // Panchanga table.
    await _scrollTo(tester, find.text('वि.सं.'));
    expect(find.text('वि.सं.'), findsOneWidget);
    expect(find.text('नेपाल संवत्'), findsOneWidget);
    expect(find.text('फागुन ११, २०७९'), findsWidgets);
    expect(find.text('तिथि'), findsOneWidget);
    expect(find.text('सूर्योदय'), findsOneWidget);
    expect(find.text('चन्द्रास्त'), findsOneWidget);
    expect(find.text('घ: प: वि: प्र'), findsNothing);
    await tester.tap(find.text('थप जानकारी').at(1));
    await tester.pumpAndSettle();
    expect(find.text('घ: प: वि: प्र'), findsOneWidget);
    expect(find.text('भुक्त घडी'), findsOneWidget);
    // Day details block.
    await tester.tap(find.text('थप जानकारी').first);
    await tester.pumpAndSettle();
    expect(find.text('दिनमान (घडीमा)'), findsOneWidget);
    expect(find.text('कल्पगत अहर्गण'), findsOneWidget);
    expect(find.text('गति अन्तर'), findsOneWidget);
    await _scrollTo(tester, find.text('चन्द्रराशि'));
    expect(find.text('आनन्दादि योग'), findsOneWidget);
    expect(find.text('मंगल'), findsOneWidget);
    expect(find.text('राहु'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sait panel navigates months / years and picks a day', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await _registerCalendar(Region.nepal);
    final cubit = _cubit();
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const PanchangaView()),
        locale: const Locale('en'),
        dark: true,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Panchanga & Suva Sait'), findsOneWidget);
    expect(find.text('Suva Sait And Muhurat'), findsOneWidget);
    expect(find.text('Suva Sait of Falgun'), findsOneWidget);
    await tester.tap(find.text('Next Month'));
    await tester.pumpAndSettle();
    expect(cubit.state.saitMonth, 12);
    expect(find.text('Suva Sait of Chaitra'), findsOneWidget);
    await tester.tap(find.text('Yearly Suva Sait'));
    await tester.pumpAndSettle();
    expect(find.text('Suva Sait of 2079'), findsOneWidget);
    expect(find.text('Previous Year'), findsOneWidget);
    await tester.tap(find.text('Next Year'));
    await tester.pumpAndSettle();
    expect(cubit.state.saitYear, 2080);
    // Month strip inside the yearly table.
    await tester.tap(find.text('Baishakh').last);
    await tester.pumpAndSettle();
    expect(cubit.state.saitMonth, 1);
    // Tapping a day in the header grid selects it in the cubit.
    await tester.tap(find.text('24').first);
    await tester.pumpAndSettle();
    expect(cubit.state.date, DateTime(2023, 2, 24));
    // …and the sait table follows the new date's month.
    expect(cubit.state.saitMonth, 11);
    expect(cubit.state.saitYear, 2079);
    // Nepal design has no Rahu Kaal row.
    await _scrollTo(tester, find.text('Shaka Samvat'));
    expect(find.text('1944'), findsOneWidget);
    expect(find.textContaining('Rahu Kaal'), findsNothing);
    expect(find.text('Vikram Samvat'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('PanchangaSection and SuvaSaitSection share a cubit', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                PanchangaSection(cubit: cubit..load()),
                SuvaSaitSection(cubit: cubit, maxItems: 3),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('पञ्चाङ्ग'), findsOneWidget);
    expect(find.text('शुभ साइत'), findsOneWidget);
    expect(find.text('विवाह गर्ने साइत'), findsOneWidget);
    expect(find.text('घर सर्ने साइत'), findsNothing);
    expect(find.text('थप शुभ साइत तथा मुहूर्तहरू हेर्नुहोस्'), findsOneWidget);
    // Date chips follow the cubit's date (B.S. dates, Devanagari digits).
    expect(find.textContaining('२०७९'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sections at 320 px width do not overflow', (tester) async {
    tester.view.physicalSize = const Size(320, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                PanchangaSection(cubit: cubit..load()),
                SuvaSaitSection(cubit: cubit, full: true),
              ],
            ),
          ),
        ),
        locale: const Locale('en'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Monthly Suva Sait'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'PanchangaPage in India (English): Vikram/Saka header + Rahu Kaal',
    (tester) async {
      tester.view.physicalSize = const Size(400, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await _registerCalendar(Region.india);
      final cubit = _cubit(region: Region.india);
      addTearDown(cubit.close);
      await tester.pumpWidget(
        _app(
          BlocProvider.value(
            value: cubit..load(),
            child: const PanchangaView(),
          ),
          locale: const Locale('en'),
          region: Region.india,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Panchanga & Shubh Muhurat'), findsOneWidget);
      // Header: Gregorian primary, Saka secondary.
      expect(find.text('February, 2023'), findsWidgets);
      expect(find.text('Phalguna 4, 1944'), findsWidgets);
      // Muhurat wording in the sait panel.
      expect(find.text('Shubh Muhurat'), findsOneWidget);
      expect(find.text('Monthly Shubh Muhurat'), findsOneWidget);
      expect(find.text('Shubh Muhurat of Phalguna'), findsOneWidget);
      expect(find.text('Havan muhurat'), findsWidgets);
      await _scrollTo(tester, find.text('Vikram Samvat'));
      expect(find.text('Vikram Samvat'), findsOneWidget);
      expect(find.text('2079'), findsOneWidget); // Vikram year for Feb 2023.
      expect(find.text('Shaka Samvat'), findsOneWidget);
      expect(find.text('Nepal Samvat'), findsNothing);
      expect(find.text('B.S.'), findsNothing);
      // India-only muhurta row.
      await _scrollTo(tester, find.textContaining('Rahu Kaal'));
      expect(find.textContaining('Rahu Kaal'), findsOneWidget);
      expect(find.textContaining('Abhijit Muhurat'), findsOneWidget);
      expect(find.text('Choghadiya'), findsNothing);
      await tester.tap(find.text('More Info').last);
      await tester.pumpAndSettle();
      expect(find.text('Choghadiya'), findsOneWidget);
      expect(find.textContaining('Shubh · Auspicious'), findsWidgets);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('PanchangaPage in India (Hindi) shows Hindi strings', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await _registerCalendar(Region.india);
    final cubit = _cubit(region: Region.india);
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const PanchangaView()),
        locale: const Locale('hi'),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('पंचांग एवं शुभ मुहूर्त'), findsOneWidget);
    expect(find.text('मासिक शुभ मुहूर्त'), findsOneWidget);
    expect(find.text('हवन मुहूर्त'), findsWidgets);
    expect(find.text('पिछला महीना'), findsWidgets);
    await _scrollTo(tester, find.text('विक्रम संवत्'));
    expect(find.text('विक्रम संवत्'), findsOneWidget);
    expect(find.text('२०७९'), findsOneWidget);
    expect(find.text('तिथि'), findsOneWidget);
    expect(find.text('अधिक जानकारी'), findsWidgets);
    expect(find.textContaining('बजे तक उसके बाद'), findsWidgets);
    await _scrollTo(tester, find.textContaining('राहु काल'));
    expect(find.textContaining('राहु काल'), findsOneWidget);
    // Hindi weekday name (not Nepali बिहीबार).
    expect(find.textContaining('गुरुवार'), findsWidgets);
    expect(find.textContaining('बिहीबार'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  group('with nothing published', () {
    // Suva saits are editorial: an almanac publishes them and nothing computes
    // them, so a live server with an empty `suva_saits` table hands the app an
    // empty list. That is the state this covers.
    PanchangaCubit emptyCubit() {
      final repo = PanchangaRepositoryImpl(_EmptySaitSource(now: () => _today));
      return PanchangaCubit(
        getPanchanga: GetPanchanga(repo),
        getSuvaSaits: GetSuvaSaits(repo),
        resolver: const FixedRegionResolver(Region.nepal),
        initialDate: _today,
      );
    }

    testWidgets('says nothing is published, not "none today"', (tester) async {
      tester.view.physicalSize = const Size(400, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        _app(
          Scaffold(
            body: SingleChildScrollView(
              child: SuvaSaitSection(cubit: emptyCubit()..load()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // "आज कुनै शुभ साइत … फेला परेन" reads as an answer — as though the
      // panel looked and today happens to be inauspicious. With an empty table
      // nobody has looked at all, and saying so is the honest state.
      expect(find.textContaining('प्रकाशित भएको छैन'), findsOneWidget);
      expect(find.textContaining('फेला परेन'), findsNothing);
    });

    testWidgets('drops the "more saits" link when there is no more', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(400, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        _app(
          Scaffold(
            body: SingleChildScrollView(
              child: SuvaSaitSection(cubit: emptyCubit()..load()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // A link into an equally empty panel is a dead end.
      expect(find.textContaining('थप शुभ साइत'), findsNothing);
    });

    testWidgets('still shows the link once something is published', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(400, 1800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        _app(
          Scaffold(
            body: SingleChildScrollView(
              child: SuvaSaitSection(cubit: _cubit()..load()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('थप शुभ साइत'), findsOneWidget);
      expect(find.textContaining('प्रकाशित भएको छैन'), findsNothing);
    });
  });
}

/// A panchanga source that computes the day as usual but publishes no saits —
/// what a live server with an empty `suva_saits` table returns.
class _EmptySaitSource extends MockPanchangaDataSource {
  _EmptySaitSource({required DateTime Function() now})
    : super(resolver: const FixedRegionResolver(Region.nepal), now: now);

  @override
  Future<List<SuvaSaitModel>> fetchSuvaSaits() async => const [];
}
