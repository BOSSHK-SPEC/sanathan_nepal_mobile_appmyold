import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/app_segmented_control.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/datasources/mock_panchanga_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/datasources/panchanga_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/models/panchanga_model.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/models/suva_sait_model.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/repositories/birth_star_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/data/repositories/panchanga_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/usecases/get_panchanga.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/cubit/day_periods_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/pages/day_periods_page.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/widgets/day_period_row.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/presentation/widgets/day_periods_link.dart';
import 'package:sanathan_nepal_mobile_app/features/panchanga/domain/repositories/birth_star_repository.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// 23 Feb 2023 was a Thursday, so the tables under test are the Thursday ones.
final _day = DateTime(2023, 2, 23);

/// A source that fails only for the day *after* the one being shown, so the
/// night half has no sunrise to measure against.
class _NoTomorrow implements PanchangaDataSource {
  _NoTomorrow(this._inner);

  final PanchangaDataSource _inner;

  @override
  Future<PanchangaModel> fetchPanchanga(DateTime date) {
    if (date.isAfter(_day)) throw Exception('offline');
    return _inner.fetchPanchanga(date);
  }

  @override
  Future<List<SuvaSaitModel>> fetchSuvaSaits() => _inner.fetchSuvaSaits();
}

void main() {
  /// The segment labels collide with period names on purpose — "Kaal" is both
  /// a Choghadiya and the name of the group — so always tap the control.
  Finder segment(String label) => find.descendant(
    of: find.byType(AppSegmentedControl),
    matching: find.text(label),
  );

  DayPeriodsCubit cubit({
    PanchangaDataSource? source,
    BirthStarRepository? stars,
  }) => DayPeriodsCubit(
    getPanchanga: GetPanchanga(
      PanchangaRepositoryImpl(
        source ??
            MockPanchangaDataSource(
              resolver: const FixedRegionResolver(Region.nepal),
              now: () => _day,
            ),
      ),
    ),
    birthStars: stars ?? BirthStarRepositoryImpl(InMemoryKeyValueStore()),
    date: _day,
    // Mid-morning, so a daytime period is always the running one.
    clock: () => DateTime(2023, 2, 23, 9, 30),
  );

  Future<void> pump(
    WidgetTester tester, {
    PanchangaDataSource? source,
    BirthStarRepository? stars,
  }) async {
    // Tall enough that every period is laid out: a ListView only builds what
    // fits, and these tests are counting rows.
    tester.view.physicalSize = const Size(420, 2600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      RegionScope(
        region: Region.nepal,
        child: MaterialApp(
          theme: AppTheme.light(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DayPeriodsPage(
            cubit: cubit(source: source, stars: stars),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('opens on the Choghadiya, day and night, sixteen in all', (
    tester,
  ) async {
    await pump(tester);
    expect(find.byType(DayPeriodRow), findsNWidgets(16));
    expect(find.text('Day'), findsOneWidget);
    expect(find.text('Night'), findsOneWidget);
  });

  testWidgets('marks exactly one period as running now', (tester) async {
    await pump(tester);
    final rows = tester
        .widgetList<DayPeriodRow>(find.byType(DayPeriodRow))
        .where((r) => r.isCurrent);
    expect(rows, hasLength(1));
    // Once as the running row's pill; the ring card says "Now · <quality>".
    expect(find.text('Now'), findsOneWidget);
    expect(find.textContaining('Now · '), findsOneWidget);
  });

  testWidgets('switches to the horas: twelve of the day, twelve of the night', (
    tester,
  ) async {
    await pump(tester);
    await tester.tap(segment('Hora'));
    await tester.pumpAndSettle();
    expect(find.byType(DayPeriodRow), findsNWidgets(24));
    // Thursday's first hora belongs to Guru — the weekday's own lord.
    expect(find.text('Guru'), findsWidgets);
  });

  testWidgets('the kaal windows are daytime only and say so by omission', (
    tester,
  ) async {
    await pump(tester);
    await tester.tap(segment('Kaal'));
    await tester.pumpAndSettle();
    expect(find.text('Rahu Kaal'), findsOneWidget);
    // Abhijit carries its own name, so it shows as "Abhijit" rather than
    // through the kind's label.
    expect(find.text('Abhijit'), findsOneWidget);
    // No night section at all: these are divisions of the daylight, so an
    // empty night here would read as missing data rather than as by design.
    expect(find.text('Night'), findsNothing);
  });

  testWidgets('without tomorrow, the night says so instead of guessing', (
    tester,
  ) async {
    await pump(
      tester,
      source: _NoTomorrow(
        MockPanchangaDataSource(
          resolver: const FixedRegionResolver(Region.nepal),
          now: () => _day,
        ),
      ),
    );
    // The day half still works…
    expect(find.byType(DayPeriodRow), findsNWidgets(8));
    // …and the night half is honest about why it is empty.
    expect(find.textContaining("tomorrow's sunrise"), findsOneWidget);
  });

  testWidgets('the panchanga screen has a way in, and it lands here', (
    tester,
  ) async {
    // The screen is only as real as its entry point: this walks the tap the
    // user makes, from the card on the panchanga page to the route behind it.
    final panchanga = await MockPanchangaDataSource(
      resolver: const FixedRegionResolver(Region.nepal),
      now: () => _day,
    ).fetchPanchanga(_day);
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => Scaffold(
            body: DayPeriodsLink(
              panchanga: panchanga.toEntity(),
              now: DateTime(2023, 2, 23, 9, 30),
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.dayPeriods,
          builder: (_, _) => const Scaffold(body: Text('PERIODS')),
        ),
      ],
    );
    await tester.pumpWidget(
      RegionScope(
        region: Region.nepal,
        child: MaterialApp.router(
          theme: AppTheme.light(),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Day periods'), findsOneWidget);
    await tester.tap(find.byType(DayPeriodsLink));
    await tester.pumpAndSettle();
    expect(find.text('PERIODS'), findsOneWidget);
  });

  group('day factors', () {
    testWidgets('season, ayana and disha shool need nothing from the user', (
      tester,
    ) async {
      await pump(tester);
      expect(find.text('Ritu'), findsOneWidget);
      expect(find.text('Ayana'), findsOneWidget);
      expect(find.text('Disha Shool'), findsOneWidget);
      // 23 Feb: the Sun is in Kumbha, so Shishira and Uttarayana.
      expect(find.text('Shishira'), findsOneWidget);
      expect(find.text('Uttarayana'), findsOneWidget);
      // Thursday's disha shool is south.
      expect(find.text('South'), findsOneWidget);
    });

    testWidgets('the personal factors wait for a birth star', (tester) async {
      await pump(tester);
      // Counting tara bala from an assumed star would answer confidently for
      // the wrong person, so it is absent until asked for.
      expect(find.text('Tara Bala'), findsNothing);
      expect(find.text('Chandra Bala'), findsNothing);
      expect(find.byType(DropdownButtonFormField<int>), findsNWidgets(2));
    });

    testWidgets('choosing a birth star brings them in', (tester) async {
      final stars = BirthStarRepositoryImpl(InMemoryKeyValueStore());
      await stars.save(0); // Ashwini pada 1
      await pump(tester, stars: stars);
      expect(find.text('Tara Bala'), findsOneWidget);
      expect(find.text('Chandra Bala'), findsOneWidget);
      expect(find.text('Chandrashtama'), findsOneWidget);
      // The boxes stay on screen so the choice can be corrected later.
      expect(find.byType(DropdownButtonFormField<int>), findsNWidgets(2));
      // The tara is named AND said plainly: "Mitra" alone means nothing to a
      // reader who is not an astrologer.
      expect(find.text('Mitra · Auspicious'), findsOneWidget);
      // Ashwini pada 1 is Mesha; the Moon is in Pisces, the 12th from it.
      // The ordinal must read "12th", never "12nd".
      expect(find.textContaining('Moon in the 12th'), findsOneWidget);
    });

    testWidgets('a corrupt stored star is treated as unset', (tester) async {
      final store = InMemoryKeyValueStore();
      await store.setInt('panchanga.birthPada.v2', 999);
      await pump(tester, stars: BirthStarRepositoryImpl(store));
      // Out of range must not index the list and crash the screen.
      expect(tester.takeException(), isNull);
      expect(find.byType(DropdownButtonFormField<int>), findsNWidgets(2));
    });

    testWidgets('picking a star and then a pada actually computes them', (
      tester,
    ) async {
      // The bug this replaces: neither box could complete the pair, because
      // the half-made choice was never held anywhere. Tapping through the two
      // dropdowns did nothing at all, for ever.
      await pump(tester);
      expect(find.text('Tara Bala'), findsNothing);

      Future<void> choose(int dropdown, String option) async {
        await tester.tap(
          find.byType(DropdownButtonFormField<int>).at(dropdown),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text(option).last);
        await tester.pumpAndSettle();
      }

      await choose(0, 'Ashwini');
      // Still nothing: a star without its pada cannot fix the birth sign.
      expect(find.text('Tara Bala'), findsNothing);

      await choose(1, '1');
      expect(find.text('Tara Bala'), findsOneWidget);
      expect(find.text('Mitra · Auspicious'), findsOneWidget);
    });

    testWidgets('the choice can be changed afterwards', (tester) async {
      final stars = BirthStarRepositoryImpl(InMemoryKeyValueStore());
      await stars.save(0); // Ashwini pada 1 → Mesha
      await pump(tester, stars: stars);
      expect(find.text('Mitra · Auspicious'), findsOneWidget);

      // Move to Bharani, whose padas all sit in Mesha too but whose tara
      // differs — the reading must follow the new star.
      await tester.tap(find.byType(DropdownButtonFormField<int>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bharani').last);
      await tester.pumpAndSettle();
      expect(find.text('Mitra · Auspicious'), findsNothing);
      expect(find.text('Tara Bala'), findsOneWidget);
    });
  });
}
