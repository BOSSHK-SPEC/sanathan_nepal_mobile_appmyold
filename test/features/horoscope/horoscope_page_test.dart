import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/data/datasources/mock_horoscope_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/data/repositories/horoscope_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/entities/zodiac_sign.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/usecases/get_all_predictions.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/presentation/cubit/horoscope_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/presentation/pages/horoscope_page.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/presentation/widgets/horoscope_section.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

HoroscopeCubit _cubit({Region region = Region.nepal}) => HoroscopeCubit(
  getAllPredictions: GetAllPredictions(
    HoroscopeRepositoryImpl(
      MockHoroscopeDataSource(
        resolver: FixedRegionResolver(region),
        now: () => region == Region.india
            ? DateTime(2026, 8, 18)
            : DateTime(2023, 2, 23),
      ),
    ),
  ),
);

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

void main() {
  testWidgets('HoroscopePage renders 12 sign cards in Nepali', (tester) async {
    tester.view.physicalSize = const Size(400, 6000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const HoroscopeView()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('दैनिक राशिफल'), findsOneWidget);
    expect(find.textContaining('मेष', findRichText: true), findsWidgets);
    expect(
      find.textContaining('चु, चे, चो', findRichText: true),
      findsOneWidget,
    );
    expect(find.text('दैनिक'), findsOneWidget);
    // Cards carry the lucky strip + like/share rail.
    expect(find.text('भाग्यशाली विवरण'), findsWidgets);
    expect(find.text('थप विवरण'), findsWidgets);
    expect(find.byIcon(Icons.favorite_border), findsWidgets);
    expect(find.byIcon(Icons.share_outlined), findsWidgets);
    // Scroll to the end: 12th card, ads after the 4th/8th/12th card,
    // closing blessing and stay-informed card.
    await tester.scrollUntilVisible(
      find.text('सूचित हुनुहोस्'),
      600,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('मीन', findRichText: true), findsWidgets);
    expect(find.text('HOROSCOPE PAGE ADS'), findsWidgets);
    expect(find.textContaining('डा. उत्तम उपाध्याय न्यौपाने'), findsOneWidget);
    expect(find.text('सूचित हुनुहोस्'), findsOneWidget);
    // Nothing expanded yet.
    expect(find.text('मेष राशि को बारेमा'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('More Details opens table, lucky clip, about card and tabs; '
      'like toggles; share copies', (tester) async {
    tester.view.physicalSize = const Size(400, 6000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final copied = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied.add((call.arguments as Map)['text'] as String);
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    final cubit = _cubit();
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const HoroscopeView()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('थप विवरण').first);
    await tester.pumpAndSettle();
    expect(cubit.state.isExpanded(ZodiacSign.aries), isTrue);
    expect(find.text('कम विवरण'), findsOneWidget);
    // Lucky table rows + Shop Now.
    expect(find.text('भाग्यशाली अंक'), findsOneWidget);
    expect(find.text('स्वामी ग्रह'), findsOneWidget);
    expect(find.text('अशुभ रत्न'), findsOneWidget);
    expect(find.text('महत्वपूर्ण वर्ष'), findsOneWidget);
    expect(find.text('किन्नुहोस्'), findsOneWidget);
    // The second clip's card is there, in its "coming soon" state.
    expect(find.text('मेष राशिको शुभ रङ, अंक र रत्न'), findsOneWidget);
    // About card + tabs + points.
    expect(find.text('मेष राशि को बारेमा'), findsOneWidget);
    expect(find.textContaining('मेष राशि राशिचक्रको पहिलो'), findsOneWidget);
    expect(find.text('मेष राशि को पुरुष'), findsOneWidget);
    expect(find.text('मेष राशि को व्यक्तित्व'), findsOneWidget);
    expect(find.textContaining('पैसा : ', findRichText: true), findsOneWidget);
    expect(
      find.textContaining('सम्बन्ध : ', findRichText: true),
      findsOneWidget,
    );
    await tester.tap(find.text('मेष राशि को व्यक्तित्व'));
    await tester.pumpAndSettle();
    expect(find.textContaining('पैसा : ', findRichText: true), findsNothing);
    expect(find.textContaining('अग्रगामी', findRichText: true), findsOneWidget);
    // Nothing is published, so every card sits in its "coming soon" state:
    // the slot is visible so the reader knows the feature is coming, but no
    // control is offered. A play button used to render regardless, over a
    // progress bar driven by a timer with no audio behind it.
    expect(find.text('छिट्टै आउँदैछ'), findsWidgets);
    expect(find.byIcon(Icons.hourglass_empty_rounded), findsWidgets);
    expect(find.byIcon(Icons.play_arrow_rounded), findsNothing);
    expect(find.byIcon(Icons.open_in_new_rounded), findsNothing);
    // Like + share.
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();
    expect(cubit.state.isLiked(ZodiacSign.aries), isTrue);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.byIcon(Icons.share_outlined).first);
    await tester.pumpAndSettle();
    expect(copied.single, startsWith('मेष राशिफल (दैनिक): '));
    expect(find.text('राशिफल कपी गरियो'), findsOneWidget);
    // Collapse again.
    await tester.tap(find.text('कम विवरण'));
    await tester.pumpAndSettle();
    expect(find.text('मेष राशि को बारेमा'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('sign card at 320 px width does not overflow (English, dark)', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 6000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit();
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const HoroscopeView()),
        locale: const Locale('en'),
        dark: true,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('More Details').first);
    await tester.pumpAndSettle();
    expect(find.text('About Aries'), findsOneWidget);
    expect(find.text('Aries Man'), findsOneWidget);
    expect(find.text('Shop Now'), findsOneWidget);
    expect(
      find.text('Lucky Color, Number and Stone for Aries Sign'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('HoroscopePage switches period in English', (tester) async {
    final cubit = _cubit();
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const HoroscopeView()),
        locale: const Locale('en'),
        dark: true,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Daily Horoscope'), findsOneWidget);
    expect(find.textContaining('Aries', findRichText: true), findsWidgets);
    await tester.tap(find.text('Weekly'));
    await tester.pumpAndSettle();
    expect(cubit.state.period.name, 'weekly');
    expect(find.text('Weekly Horoscope'), findsOneWidget);
    expect(find.textContaining('this week'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('HoroscopeSection shows selected sign and media card', (
    tester,
  ) async {
    final cubit = _cubit();
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: SingleChildScrollView(
            child: HoroscopeSection(cubit: cubit..load()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('सूचित हुनुहोस्'), findsOneWidget);
    // The card holds its place and says the clip is on its way.
    expect(find.text('अडियो राशिफल'), findsWidgets);
    expect(find.text('छिट्टै आउँदैछ'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_rounded), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a published clip brings the player back', (tester) async {
    tester.view.physicalSize = const Size(400, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final cubit = _cubit();
    addTearDown(cubit.close);
    await cubit.load();
    final all = cubit.state.predictions.dataOrNull!;
    cubit.emit(
      cubit.state.copyWith(
        predictions: LoadState.loaded([
          all.first.copyWith(
            media: all.first.media.copyWith(
              url: 'https://www.youtube.com/watch?v=abc123',
            ),
          ),
          ...all.skip(1),
        ]),
      ),
    );

    await tester.pumpWidget(_app(Scaffold(body: HoroscopeSection(cubit: cubit))));
    await tester.pumpAndSettle();

    // Aries is selected by default and now has a clip: the chip and the card
    // both appear, and the card says the tap leaves the app.
    expect(find.text('अडियो राशिफल'), findsWidgets);
    // One in the chip, one in the card — and the waiting state is gone.
    expect(find.byIcon(Icons.play_arrow_rounded), findsNWidgets(2));
    expect(find.byIcon(Icons.open_in_new_rounded), findsOneWidget);
    expect(find.text('छिट्टै आउँदैछ'), findsNothing);
    expect(find.byIcon(Icons.hourglass_empty_rounded), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('HoroscopePage in India + Hindi shows Hindi strings, sign names '
      'and Saka month with Devanagari digits', (tester) async {
    tester.view.physicalSize = const Size(400, 6000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final cubit = _cubit(region: Region.india);
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        BlocProvider.value(value: cubit..load(), child: const HoroscopeView()),
        locale: const Locale('hi'),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();
    // Hindi UI strings.
    expect(find.text('दैनिक राशिफल'), findsOneWidget);
    expect(find.text('भाग्यशाली विवरण'), findsWidgets);
    expect(find.text('अधिक विवरण'), findsWidgets);
    expect(find.text('सूचित रहें'), findsOneWidget);
    expect(find.text('दैनिक'), findsOneWidget);
    // Hindi sign names (Hindi-specific spellings).
    expect(find.textContaining('वृषभ', findRichText: true), findsWidgets);
    expect(find.textContaining('कर्क', findRichText: true), findsWidgets);
    expect(find.textContaining('मेष', findRichText: true), findsWidgets);
    // Hindi "More Details" content.
    await tester.tap(find.text('अधिक विवरण').first);
    await tester.pumpAndSettle();
    expect(find.text('मेष राशि के बारे में'), findsOneWidget);
    expect(find.text('मेष राशि का पुरुष'), findsOneWidget);
    expect(find.textContaining('धन : ', findRichText: true), findsOneWidget);
    expect(find.text('अभी खरीदें'), findsOneWidget);
    // Hindi prediction text, and the clip card in Hindi.
    expect(find.textContaining('आज का दिन मनोरंजन'), findsOneWidget);
    expect(find.text('मेष राशिफल – श्रावण, १९४८'), findsOneWidget);
    expect(find.text('जल्द आ रहा है'), findsWidgets);
    // Hindi lucky days from the strip.
    expect(find.textContaining('मंगलवार'), findsWidgets);
    // Nepali-only strings must not appear.
    expect(find.text('सूचित हुनुहोस्'), findsNothing);
    expect(find.text('अडियो राशिफल'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('HoroscopeSection in India + English shows Saka media title', (
    tester,
  ) async {
    final cubit = _cubit(region: Region.india);
    addTearDown(cubit.close);
    await tester.pumpWidget(
      _app(
        Scaffold(
          body: SingleChildScrollView(
            child: HoroscopeSection(cubit: cubit..load()),
          ),
        ),
        locale: const Locale('en'),
        region: Region.india,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Aries Rashifal - Shravana, 1948'), findsOneWidget);
    expect(find.text('Audio Rashifal'), findsWidgets);
    // English "coming soon", not a Nepali or Hindi string.
    expect(find.text('Coming soon'), findsOneWidget);
    expect(find.text('छिट्टै आउँदैछ'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
