import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_category.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/delete_event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/get_events.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/toggle_checklist_item.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/cubit/events_list_cubit.dart';

class _MockGetEvents extends Mock implements GetEvents {}

class _MockDelete extends Mock implements DeleteEvent {}

class _MockToggle extends Mock implements ToggleChecklistItem {}

void main() {
  late _MockGetEvents getEvents;
  late _MockDelete deleteEvent;
  late _MockToggle toggle;

  final festival = Event(
    id: 'f1',
    title: const LocalizedText(ne: 'होली', en: 'Holi'),
    date: DateTime(2027, 3, 1),
    category: EventCategory.hinduFestival,
    isHoliday: true,
  );
  final mine = Event(
    id: 'u1',
    title: LocalizedText.same('Birthday'),
    date: DateTime(2026, 9, 1),
    category: EventCategory.birthday,
    checklist: const [ChecklistItem(id: 'c', label: 'Cake')],
  );

  setUpAll(() {
    registerFallbackValue(const EventFilter());
    registerFallbackValue(const ToggleChecklistParams(eventId: '', itemId: ''));
  });

  setUp(() {
    getEvents = _MockGetEvents();
    deleteEvent = _MockDelete();
    toggle = _MockToggle();
  });

  EventsListCubit build() => EventsListCubit(
    getEvents: getEvents,
    deleteEvent: deleteEvent,
    toggleChecklistItem: toggle,
  );

  blocTest<EventsListCubit, EventsListState>(
    'load emits loading then success with festivals filter',
    build: build,
    setUp: () => when(
      () => getEvents(any()),
    ).thenAnswer((_) async => Result.success([festival])),
    act: (c) => c.load(),
    expect: () => [
      const EventsListState(events: LoadState.loading()),
      EventsListState(events: LoadState.loaded([festival])),
    ],
    verify: (_) {
      final filter =
          verify(() => getEvents(captureAny())).captured.single as EventFilter;
      expect(filter.group, EventGroup.festival);
    },
  );

  blocTest<EventsListCubit, EventsListState>(
    'selectGroup(personal) resets chip and reloads',
    build: build,
    seed: () => EventsListState(
      events: LoadState.loaded([festival]),
      category: EventCategory.hinduFestival,
    ),
    setUp: () => when(
      () => getEvents(any()),
    ).thenAnswer((_) async => Result.success([mine])),
    act: (c) => c.selectGroup(EventGroup.personal),
    expect: () => [
      EventsListState(
        events: LoadState.loading(previous: [festival]),
        group: EventGroup.personal,
      ),
      EventsListState(
        events: LoadState.loaded([mine]),
        group: EventGroup.personal,
      ),
    ],
  );

  blocTest<EventsListCubit, EventsListState>(
    'selectImportant sets onlyImportant and clears category',
    build: build,
    seed: () => const EventsListState(
      events: LoadState.loaded([]),
      category: EventCategory.hinduFestival,
    ),
    setUp: () => when(
      () => getEvents(any()),
    ).thenAnswer((_) async => const Result.success([])),
    act: (c) => c.selectImportant(),
    expect: () => [
      const EventsListState(
        events: LoadState.loading(previous: []),
        onlyImportant: true,
      ),
      const EventsListState(events: LoadState.loaded([]), onlyImportant: true),
    ],
  );

  blocTest<EventsListCubit, EventsListState>(
    'load failure emits failure with message',
    build: build,
    setUp: () => when(
      () => getEvents(any()),
    ).thenAnswer((_) async => const Result.failure(ServerFailure('down'))),
    act: (c) => c.load(),
    expect: () => [
      const EventsListState(events: LoadState.loading()),
      const EventsListState(events: LoadState.failed(ServerFailure('down'))),
    ],
    verify: (c) => expect(c.state.events.errorMessage, 'down'),
  );

  blocTest<EventsListCubit, EventsListState>(
    'delete removes the event from the list',
    build: build,
    seed: () => EventsListState(
      events: LoadState.loaded([mine]),
      group: EventGroup.personal,
    ),
    setUp: () => when(
      () => deleteEvent('u1'),
    ).thenAnswer((_) async => const Result.success(null)),
    act: (c) => c.delete('u1'),
    expect: () => [
      const EventsListState(
        events: LoadState.loaded([]),
        group: EventGroup.personal,
      ),
    ],
  );

  blocTest<EventsListCubit, EventsListState>(
    'delete failure keeps the list and exposes actionFailure',
    build: build,
    seed: () => EventsListState(
      events: LoadState.loaded([mine]),
      group: EventGroup.personal,
    ),
    setUp: () => when(
      () => deleteEvent('u1'),
    ).thenAnswer((_) async => const Result.failure(ServerFailure('nope'))),
    act: (c) => c.delete('u1'),
    expect: () => [
      EventsListState(
        events: LoadState.loaded([mine]),
        group: EventGroup.personal,
        actionFailure: const ServerFailure('nope'),
      ),
    ],
  );

  blocTest<EventsListCubit, EventsListState>(
    'toggleChecklist replaces the updated event',
    build: build,
    seed: () => EventsListState(
      events: LoadState.loaded([mine]),
      group: EventGroup.personal,
    ),
    setUp: () => when(() => toggle(any())).thenAnswer(
      (_) async => Result.success(
        mine.copyWith(
          checklist: const [
            ChecklistItem(id: 'c', label: 'Cake', isDone: true),
          ],
        ),
      ),
    ),
    act: (c) => c.toggleChecklist('u1', 'c'),
    verify: (c) =>
        expect(c.state.eventList.single.checklist.single.isDone, isTrue),
  );
}
