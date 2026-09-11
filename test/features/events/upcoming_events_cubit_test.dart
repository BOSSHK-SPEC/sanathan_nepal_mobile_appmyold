import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_category.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/get_events.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/cubit/upcoming_events_cubit.dart';

class _MockGetEvents extends Mock implements GetEvents {}

void main() {
  late _MockGetEvents getEvents;
  final e = Event(
    id: 'f1',
    title: LocalizedText.same('Holi'),
    date: DateTime(2027, 3, 1),
    category: EventCategory.hinduFestival,
  );

  setUpAll(() => registerFallbackValue(const EventFilter()));
  setUp(() => getEvents = _MockGetEvents());

  blocTest<UpcomingEventsCubit, UpcomingEventsState>(
    'load requests limited upcoming events and exposes featured',
    build: () => UpcomingEventsCubit(getEvents: getEvents, limit: 3),
    setUp: () => when(
      () => getEvents(any()),
    ).thenAnswer((_) async => Result.success([e])),
    act: (c) => c.load(),
    expect: () => [
      const UpcomingEventsState(events: LoadState.loading()),
      UpcomingEventsState(events: LoadState.loaded([e])),
    ],
    verify: (c) {
      expect(c.state.featured, e);
      final f =
          verify(() => getEvents(captureAny())).captured.single as EventFilter;
      expect(f.limit, 3);
      expect(f.group, isNull);
    },
  );

  blocTest<UpcomingEventsCubit, UpcomingEventsState>(
    'scope + holiday chips are translated into the filter',
    build: () => UpcomingEventsCubit(getEvents: getEvents),
    setUp: () => when(
      () => getEvents(any()),
    ).thenAnswer((_) async => const Result.success([])),
    act: (c) async {
      await c.selectScope(UpcomingScope.governmentHolidays);
      await c.toggleHolidays();
      await c.selectScope(UpcomingScope.mine);
    },
    verify: (c) {
      final filters = verify(
        () => getEvents(captureAny()),
      ).captured.cast<EventFilter>();
      expect(filters[0].category, EventCategory.publicHoliday);
      expect(filters[1].onlyHolidays, isTrue);
      expect(filters[2].group, EventGroup.personal);
      expect(c.state.onlyHolidays, isTrue);
    },
  );
}
