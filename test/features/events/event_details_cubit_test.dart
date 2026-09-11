import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_category.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/delete_event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/get_event_by_id.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/toggle_checklist_item.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/cubit/event_details_cubit.dart';

class _MockGet extends Mock implements GetEventById {}

class _MockToggle extends Mock implements ToggleChecklistItem {}

class _MockDelete extends Mock implements DeleteEvent {}

void main() {
  late _MockGet get;
  late _MockToggle toggle;
  late _MockDelete delete;

  final event = Event(
    id: 'u1',
    title: LocalizedText.same('Anniversary'),
    date: DateTime(2026, 9, 6),
    category: EventCategory.anniversary,
    checklist: const [ChecklistItem(id: 'c1', label: 'Cake')],
  );

  setUpAll(
    () => registerFallbackValue(
      const ToggleChecklistParams(eventId: '', itemId: ''),
    ),
  );

  setUp(() {
    get = _MockGet();
    toggle = _MockToggle();
    delete = _MockDelete();
  });

  EventDetailsCubit build() => EventDetailsCubit(
    getEventById: get,
    toggleChecklistItem: toggle,
    deleteEvent: delete,
  );

  blocTest<EventDetailsCubit, EventDetailsState>(
    'load emits loading → success',
    build: build,
    setUp: () =>
        when(() => get('u1')).thenAnswer((_) async => Result.success(event)),
    act: (c) => c.load('u1'),
    expect: () => [
      const EventDetailsState(event: LoadState.loading()),
      EventDetailsState(event: LoadState.loaded(event)),
    ],
  );

  blocTest<EventDetailsCubit, EventDetailsState>(
    'load failure emits failure',
    build: build,
    setUp: () => when(
      () => get('x'),
    ).thenAnswer((_) async => const Result.failure(NotFoundFailure('missing'))),
    act: (c) => c.load('x'),
    expect: () => [
      const EventDetailsState(event: LoadState.loading()),
      const EventDetailsState(
        event: LoadState.failed(NotFoundFailure('missing')),
      ),
    ],
    verify: (c) => expect(c.state.event.errorMessage, 'missing'),
  );

  blocTest<EventDetailsCubit, EventDetailsState>(
    'toggleChecklist updates the event, delete emits deleted',
    build: build,
    seed: () => EventDetailsState(event: LoadState.loaded(event)),
    setUp: () {
      when(() => toggle(any())).thenAnswer(
        (_) async => Result.success(
          event.copyWith(
            checklist: const [
              ChecklistItem(id: 'c1', label: 'Cake', isDone: true),
            ],
          ),
        ),
      );
      when(
        () => delete('u1'),
      ).thenAnswer((_) async => const Result.success(null));
    },
    act: (c) async {
      await c.toggleChecklist('c1');
      await c.delete();
    },
    verify: (c) {
      expect(c.state.isDeleted, isTrue);
      expect(c.state.deletion, const LoadState<void>.loaded(null));
      expect(c.state.event.dataOrNull!.checklist.single.isDone, isTrue);
      expect(c.state.actionFailure, isNull);
      verify(
        () => toggle(const ToggleChecklistParams(eventId: 'u1', itemId: 'c1')),
      ).called(1);
    },
  );

  blocTest<EventDetailsCubit, EventDetailsState>(
    'toggleChecklist failure keeps the event and sets actionFailure',
    build: build,
    seed: () => EventDetailsState(event: LoadState.loaded(event)),
    setUp: () => when(
      () => toggle(any()),
    ).thenAnswer((_) async => const Result.failure(ServerFailure('offline'))),
    act: (c) => c.toggleChecklist('c1'),
    expect: () => [
      EventDetailsState(
        event: LoadState.loaded(event),
        actionFailure: const ServerFailure('offline'),
      ),
    ],
  );
}
