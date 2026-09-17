import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/calendar_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/panchanga_days_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/models/day_panchanga_model.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/pages/patro_page.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/calendar_day_cell.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/date_detail_sheet.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/vrat_day_card.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/presentation/widgets/vrat_marker.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

import 'day_panchanga_test.dart' show kathmanduSummary;

/// Server panchanga for every day asked for, with an Ekadashi on the 11th of
/// each Gregorian month — so any month the page opens on has one.
class _ServerDaysWithEkadashi implements PanchangaDaysDataSource {
  @override
  Future<List<DayPanchangaModel>> fetchRange({
    required DateTime from,
    required DateTime to,
  }) async => [
    for (
      var d = from;
      !d.isAfter(to);
      d = DateTime(d.year, d.month, d.day + 1)
    )
      DayPanchangaModel.fromWire(
        d.day == 11
            ? kathmanduSummary(
                date: _iso(d),
                vrat: const ['ekadashi'],
                tithiIndex: 10,
                tithiEn: 'Ekadashi',
                tithiNe: 'एकादशी',
              )
            : kathmanduSummary(date: _iso(d)),
      )!,
  ];

  static String _iso(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}

class _Nepal implements RegionResolver {
  const _Nepal();
  @override
  Region get region => Region.nepal;
  @override
  RegionConfig get config => Region.nepal.config;
}

Widget _app(Widget child) => RegionScope(
  region: Region.nepal,
  child: MaterialApp(
    theme: AppTheme.light(),
    locale: const Locale('ne'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: child,
  ),
);

void main() {
  setUpAll(() {
    final sl = GetIt.instance;
    sl.registerLazySingleton<RegionResolver>(_Nepal.new);
    registerCalendarFeature(sl);
    // Before anything resolves the repository, so it is built on this source.
    sl.unregister<PanchangaDaysDataSource>();
    sl.registerLazySingleton<PanchangaDaysDataSource>(
      _ServerDaysWithEkadashi.new,
    );
  });
  tearDownAll(GetIt.instance.reset);

  Future<void> open(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_app(const PatroPage()));
    await tester.pumpAndSettle();
  }

  testWidgets('marks vrat days in the grid and lists them under Vrat', (
    tester,
  ) async {
    await open(tester);

    expect(
      find.descendant(
        of: find.byType(CalendarDayCell),
        matching: find.byType(VratMarker),
      ),
      findsWidgets,
    );

    await tester.tap(find.widgetWithText(ChoiceChip, 'व्रत'));
    await tester.pumpAndSettle();
    expect(find.byType(VratDayCard), findsWidgets);

    await tester.tap(find.widgetWithText(ChoiceChip, 'बिदा'));
    await tester.pumpAndSettle();
    expect(find.byType(VratDayCard), findsNothing);
  });

  testWidgets(
    'the day popup shows when the tithi ends and invents no auspicious times',
    (tester) async {
      await open(tester);
      await tester.tap(find.widgetWithText(ChoiceChip, 'व्रत'));
      await tester.pumpAndSettle();

      final card = find.byType(VratDayCard).first;
      await tester.ensureVisible(card);
      await tester.tap(card);
      await tester.pumpAndSettle();

      expect(find.byType(DateDetailSheet), findsOneWidget);
      final sheet = find.byType(DateDetailSheet);
      expect(
        find.descendant(of: sheet, matching: find.textContaining('एकादशी')),
        findsWidgets,
      );
      expect(
        find.descendant(of: sheet, matching: find.textContaining('सम्म')),
        findsWidgets,
      );
      // The server's calculation: no "approximate" note.
      expect(find.textContaining('अनुमानित मान'), findsNothing);
      // Nothing published, and nothing made up.
      expect(
        find.text('यस दिनका लागि कुनै शुभ साइत प्रकाशित भएको छैन।'),
        findsOneWidget,
      );
      expect(find.text('पास्नी गर्ने साइत'), findsNothing);
      expect(find.text('रिमाइन्डर थप्नुहोस्'), findsOneWidget);
      expect(find.text('सेयर'), findsOneWidget);
    },
  );
}
