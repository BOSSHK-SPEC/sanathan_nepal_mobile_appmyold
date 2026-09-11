import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_category.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/get_events.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/toggle_checklist_item.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/cubit/day_events_cubit.dart';

class _MockGetEvents extends Mock implements GetEvents {}

class _MockToggle extends Mock implements ToggleChecklistItem {}

void main() {
  late _MockGetEvents getEvents;
  late _MockToggle toggle;
  final day = DateTime(2026, 8, 20);
  final festival = Event(
    id: 'f1',
    title: LocalizedText.same('Holi'),
    date: day,
    category: EventCategory.hinduFestival,
  );
  final todo = Event(
    id: 't1',
    title: LocalizedText.same('Rent'),
    date: day,
    category: EventCategory.todo,
    checklist: const [ChecklistItem(id: 'c1', label: 'Pay')],
  );

  setUpAll(() {
    registerFallbackValue(const EventFilter());
    registerFallbackValue(const ToggleChecklistParams(eventId: '', itemId: ''));
  });
  setUp(() {
    getEvents = _MockGetEvents();
    toggle = _MockToggle();
  });

  blocTest<DayEventsCubit, DayEventsState>(
    'load requests the single-day filter and splits groups',
    build: () =>
        DayEventsCubit(getEvents: getEvents, toggleChecklistItem: toggle),
    setUp: () => when(
      () => getEvents(any()),
    ).thenAnswer((_) async => Result.success([festival, todo])),
    act: (c) => c.load(DateTime(2026, 8, 20, 15, 30)),
    expect: () => [
      DayEventsState(date: day, events: const LoadState.loading()),
      DayEventsState(date: day, events: LoadState.loaded([festival, todo])),
    ],
    verify: (c) {
      expect(c.state.festivals, [festival]);
      expect(c.state.todos, [todo]);
      expect(c.state.personal, isEmpty);
      final f =
          verify(() => getEvents(captureAny())).captured.single as EventFilter;
      expect(f.from, day);
      expect(f.to, day);
    },
  );

  blocTest<DayEventsCubit, DayEventsState>(
    'load failure keeps a Failed state',
    build: () =>
        DayEventsCubit(getEvents: getEvents, toggleChecklistItem: toggle),
    setUp: () => when(
      () => getEvents(any()),
    ).thenAnswer((_) async => const Result.failure(Failure.server('boom'))),
    act: (c) => c.load(day),
    verify: (c) {
      expect(c.state.events.isFailed, isTrue);
      expect(c.state.eventList, isEmpty);
    },
  );

  blocTest<DayEventsCubit, DayEventsState>(
    'toggleChecklist replaces the updated event in place',
    build: () =>
        DayEventsCubit(getEvents: getEvents, toggleChecklistItem: toggle),
    seed: () => DayEventsState(date: day, events: LoadState.loaded([todo])),
    setUp: () => when(() => toggle(any())).thenAnswer(
      (_) async => Result.success(
        todo.copyWith(
          checklist: const [
            ChecklistItem(id: 'c1', label: 'Pay', isDone: true),
          ],
        ),
      ),
    ),
    act: (c) => c.toggleChecklist('t1', 'c1'),
    verify: (c) {
      expect(c.state.todos.single.checklist.single.isDone, isTrue);
      expect(c.state.actionFailure, isNull);
    },
  );
}
