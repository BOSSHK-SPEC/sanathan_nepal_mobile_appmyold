import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/localized_text.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/app_skeleton.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/astrologer.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/astrologer_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/specialty.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/usecases/get_astrologers.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/usecases/get_consult_languages.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/usecases/manage_recent_searches.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/usecases/toggle_follow_astrologer.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/presentation/cubit/astrologer_list_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/presentation/widgets/talk_to_astrologer_section.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

class _MockGetAstrologers extends Mock implements GetAstrologers {}

class _MockGetLanguages extends Mock implements GetConsultLanguages {}

class _MockToggleFollow extends Mock implements ToggleFollowAstrologer {}

class _MockGetRecent extends Mock implements GetRecentSearches {}

class _MockSaveRecent extends Mock implements SaveRecentSearch {}

class _MockClearRecent extends Mock implements ClearRecentSearches {}

const _astrologer = Astrologer(
  id: 'a1',
  name: LocalizedText(ne: 'राम', en: 'Ram'),
  headline: LocalizedText(ne: 'वैदिक', en: 'Vedic'),
  about: LocalizedText(ne: 'बारे', en: 'About'),
  specialties: [Specialty.vedic],
  languageCodes: ['en'],
  experienceYears: 10,
  rating: 4.5,
  reviewCount: 12,
  ratePerMinute: {ConsultChannel.chat: 20},
);

void main() {
  late _MockGetAstrologers getAstrologers;

  setUpAll(() => registerFallbackValue(const AstrologerFilter()));

  AstrologerListCubit buildCubit() {
    final languages = _MockGetLanguages();
    final recent = _MockGetRecent();
    when(languages.call).thenAnswer((_) async => const Result.success(['en']));
    when(recent.call).thenAnswer((_) async => const Result.success(<String>[]));

    return AstrologerListCubit(
      getAstrologers: getAstrologers,
      getLanguages: languages,
      toggleFollow: _MockToggleFollow(),
      getRecentSearches: recent,
      saveRecentSearch: _MockSaveRecent(),
      clearRecentSearches: _MockClearRecent(),
    );
  }

  Widget wrap(AstrologerListCubit cubit) => RegionScope(
    region: Region.nepal,
    child: MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<AstrologerListCubit>.value(
          value: cubit,
          child: const TalkToAstrologerRail(maxItems: 8),
        ),
      ),
    ),
  );

  setUp(() => getAstrologers = _MockGetAstrologers());

  testWidgets('shimmers while the catalogue is still loading', (tester) async {
    final blocked = Completer<Result<List<Astrologer>>>();
    when(() => getAstrologers(any())).thenAnswer((_) => blocked.future);

    final cubit = buildCubit()..load();
    await tester.pumpWidget(wrap(cubit));
    await tester.pump();

    expect(find.byType(AppShimmer), findsOneWidget);

    blocked.complete(const Result.success([_astrologer]));
    await tester.pumpAndSettle();
    expect(find.byType(AppShimmer), findsNothing);
    expect(find.text('Ram'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('a region with no astrologers shows nothing, not a shimmer', (
    tester,
  ) async {
    when(
      () => getAstrologers(any()),
    ).thenAnswer((_) async => const Result.success(<Astrologer>[]));

    final cubit = buildCubit();
    await cubit.load();
    await tester.pumpWidget(wrap(cubit));
    await tester.pumpAndSettle();

    // The reported bug: an empty *result* rendered the loading skeleton, so a
    // region with no astrologers looked like an app stuck loading forever.
    expect(find.byType(AppShimmer), findsNothing);
    expect(find.byType(TalkToAstrologerRail), findsOneWidget);

    await cubit.close();
  });
}
