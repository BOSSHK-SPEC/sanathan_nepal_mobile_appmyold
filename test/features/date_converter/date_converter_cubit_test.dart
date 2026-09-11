import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/calendar.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/regional_calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/data/repositories/date_conversion_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/domain/entities/conversion_direction.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/domain/entities/converted_date.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/domain/entities/date_parts.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/domain/usecases/convert_gregorian_to_traditional.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/domain/usecases/convert_traditional_to_gregorian.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/presentation/cubit/date_converter_cubit.dart';

class _MockToGregorian extends Mock implements ConvertTraditionalToGregorian {}

void main() {
  setUpAll(
    () => registerFallbackValue(const DateParts(year: 2080, month: 1, day: 1)),
  );

  DateTime now() => DateTime(2023, 3, 6); // 2079-11-22
  const nepal = FixedRegionResolver(Region.nepal);
  final repo = DateConversionRepositoryImpl(
    nepal,
    RegionalCalendarEventsDataSource(nepal),
    now: now,
  );
  DateConverterCubit build() => DateConverterCubit(
    convertToGregorian: ConvertTraditionalToGregorian(repo),
    convertToTraditional: ConvertGregorianToTraditional(repo),
    resolver: nepal,
    now: now,
  );

  test('initial input is today in BS', () {
    final c = build();
    expect(c.state.direction, ConversionDirection.traditionalToGregorian);
    expect(c.state.input, const DateParts(year: 2079, month: 11, day: 22));
    expect(c.minYear, 1970);
    expect(c.maxYear, 2100);
  });

  test('India: initial input is today in Saka, picker ranges follow Saka', () {
    const india = FixedRegionResolver(Region.india);
    DateTime indiaNow() => DateTime(2026, 8, 18);
    final indiaRepo = DateConversionRepositoryImpl(
      india,
      RegionalCalendarEventsDataSource(india),
      now: indiaNow,
    );
    final c = DateConverterCubit(
      convertToGregorian: ConvertTraditionalToGregorian(indiaRepo),
      convertToTraditional: ConvertGregorianToTraditional(indiaRepo),
      resolver: india,
      now: indiaNow,
    );
    expect(c.state.input, const DateParts(year: 1948, month: 5, day: 27));
    expect(c.minYear, 1800);
    expect(c.maxYear, 2100);
    expect(c.daysInMonth(c.state.input), 31); // Shravana
    c.setMonth(7); // Ashwin → 30 days
    expect(c.daysInMonth(c.state.input), 30);
    c.setDirection(ConversionDirection.gregorianToTraditional);
    expect(c.state.input, const DateParts(year: 2026, month: 8, day: 18));
    expect(c.minYear, 1879);
  });

  blocTest<DateConverterCubit, DateConverterState>(
    'convert BS→AD emits converting then success',
    build: build,
    act: (c) => c.convert(),
    expect: () => [
      const DateConverterState(
        input: DateParts(year: 2079, month: 11, day: 22),
        result: LoadState.loading(),
      ),
      isA<DateConverterState>()
          .having((s) => s.result.isLoaded, 'loaded', isTrue)
          .having((s) => s.result.dataOrNull!.ad, 'ad', DateTime(2023, 3, 6)),
    ],
  );

  blocTest<DateConverterCubit, DateConverterState>(
    'setDirection resets input to today in AD and converts it',
    build: build,
    act: (c) => c.setDirection(ConversionDirection.gregorianToTraditional),
    expect: () => [
      const DateConverterState(
        direction: ConversionDirection.gregorianToTraditional,
        input: DateParts(year: 2023, month: 3, day: 6),
      ),
      isA<DateConverterState>().having(
        (s) => s.result.isLoading,
        'loading',
        isTrue,
      ),
      isA<DateConverterState>()
          .having((s) => s.result.isLoaded, 'loaded', isTrue)
          .having((s) => s.result.dataOrNull!.ad, 'ad', DateTime(2023, 3, 6)),
    ],
  );

  test('switching direction never leaves the screen without a result', () async {
    // Everything below the picker — the result card, the difference card, the
    // converted day's events / suva sait / panchanga and the ads slot — is
    // rendered only when a result exists. So the property that matters is not
    // "the end state is right" but "no state in between is empty": a single
    // one blanks the bottom half of the screen. The old `setDirection` emitted
    // exactly that, and it is invisible to an assertion on the final state.
    final cubit = build();
    await cubit.convert();

    final seen = <DateConverterState>[];
    final subscription = cubit.stream.listen(seen.add);
    addTearDown(subscription.cancel);

    await cubit.setDirection(ConversionDirection.gregorianToTraditional);
    await cubit.setDirection(ConversionDirection.traditionalToGregorian);

    expect(seen, isNotEmpty);
    expect(
      seen.where((s) => s.result.dataOrNull == null),
      isEmpty,
      reason: 'a state with no result collapses the lower half of the screen',
    );
    await cubit.close();
  });

  blocTest<DateConverterCubit, DateConverterState>(
    'Cancel still clears the result — that one is deliberate',
    build: build,
    act: (c) async {
      await c.convert();
      c.reset();
    },
    verify: (c) => expect(c.state.result.dataOrNull, isNull),
  );

  blocTest<DateConverterCubit, DateConverterState>(
    'setMonth clamps the day to the month length',
    build: build,
    seed: () => const DateConverterState(
      input: DateParts(year: 2080, month: 1, day: 31),
    ),
    act: (c) => c.setMonth(2), // Jestha 2080 has 32 days → keep 31; then Poush
    expect: () => [
      isA<DateConverterState>().having((s) => s.input.day, 'day', 31),
    ],
  );

  blocTest<DateConverterCubit, DateConverterState>(
    'setMonth to a shorter month clamps day',
    build: build,
    seed: () => const DateConverterState(
      input: DateParts(year: 2080, month: 1, day: 31),
    ),
    act: (c) => c.setMonth(9),
    expect: () => [
      isA<DateConverterState>().having(
        (s) => s.input.day,
        'day',
        const BikramSambatCalendar().daysInMonth(2080, 9),
      ),
    ],
  );

  blocTest<DateConverterCubit, DateConverterState>(
    'failure surfaces message',
    build: () {
      final m = _MockToGregorian();
      when(
        () => m(any()),
      ).thenAnswer((_) async => const Result.failure(ValidationFailure('bad')));
      return DateConverterCubit(
        convertToGregorian: m,
        convertToTraditional: ConvertGregorianToTraditional(repo),
        resolver: nepal,
        now: now,
      );
    },
    act: (c) => c.convert(),
    skip: 1,
    expect: () => [
      const DateConverterState(
        input: DateParts(year: 2079, month: 11, day: 22),
        result: LoadState.failed(ValidationFailure('bad')),
      ),
    ],
  );

  blocTest<DateConverterCubit, DateConverterState>(
    'reset returns to today and clears the result',
    build: build,
    act: (c) async {
      await c.convert();
      c.setDay(1);
      c.reset();
    },
    verify: (c) {
      expect(c.state.result, const LoadState<ConvertedDate>.idle());
      expect(c.state.input.day, 22);
    },
  );
}
