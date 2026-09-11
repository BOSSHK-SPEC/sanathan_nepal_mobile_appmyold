import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_category.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/create_event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/usecases/update_event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/presentation/cubit/event_form_cubit.dart';

class _MockCreate extends Mock implements CreateEvent {}

class _MockUpdate extends Mock implements UpdateEvent {}

void main() {
  late _MockCreate create;
  late _MockUpdate update;
  final now = DateTime(2026, 8, 17, 10);

  setUpAll(
    () => registerFallbackValue(
      Event(
        id: '',
        title: LocalizedText.empty,
        date: DateTime(2026),
        category: EventCategory.personal,
      ),
    ),
  );

  setUp(() {
    create = _MockCreate();
    update = _MockUpdate();
  });

  EventFormCubit build() =>
      EventFormCubit(createEvent: create, updateEvent: update, now: now);

  test('initial state defaults to today / personal / reminder on', () {
    final s = build().state;
    expect(s.date, DateTime(2026, 8, 17));
    expect(s.group, EventGroup.personal);
    expect(s.reminderEnabled, isTrue);
    expect(s.isValid, isFalse);
  });

  blocTest<EventFormCubit, EventFormState>(
    'submit without title emits validation error and does not save',
    build: build,
    act: (c) => c.submit(),
    expect: () => [
      EventFormState(date: DateTime(2026, 8, 17), titleMissing: true),
    ],
    verify: (_) => verifyNever(() => create(any())),
  );

  blocTest<EventFormCubit, EventFormState>(
    'valid submit creates the event with checklist / reminder / repeat',
    build: build,
    setUp: () => when(() => create(any())).thenAnswer(
      (i) async => Result.success(
        (i.positionalArguments.single as Event).copyWith(id: 'new-1'),
      ),
    ),
    act: (c) async {
      c
        ..setTitle('Trip')
        ..setCategory(EventCategory.travel)
        ..setDate(DateTime(2026, 10, 1))
        ..setTime(const EventTime(hour: 7, minute: 30))
        ..addChecklistItem('Pack bags')
        ..setRepeats(true)
        ..setRepeat(EventRepeat.monthly)
        ..setReminderDays(3);
      await c.submit();
    },
    verify: (c) {
      expect(c.state.saved.isLoaded, isTrue);
      expect(c.state.titleMissing, isFalse);
      final saved = c.state.saved.dataOrNull!;
      expect(saved.id, 'new-1');
      expect(saved.title.en, 'Trip');
      expect(saved.category, EventCategory.travel);
      expect(saved.date, DateTime(2026, 10, 1));
      expect(saved.time, const EventTime(hour: 7, minute: 30));
      expect(saved.checklist.single.label, 'Pack bags');
      expect(saved.repeat, EventRepeat.monthly);
      expect(saved.reminder?.daysBefore, 3);
    },
  );

  blocTest<EventFormCubit, EventFormState>(
    'initWith existing event → submit calls update',
    build: build,
    setUp: () => when(() => update(any())).thenAnswer(
      (i) async => Result.success(i.positionalArguments.single as Event),
    ),
    act: (c) async {
      c.initWith(
        Event(
          id: 'u9',
          title: LocalizedText.same('Old'),
          date: DateTime(2026, 9, 9),
          category: EventCategory.official,
          repeat: EventRepeat.yearly,
        ),
      );
      c.setTitle('New title');
      await c.submit();
    },
    verify: (c) {
      expect(c.state.isEditing, isTrue);
      expect(c.state.saved.dataOrNull!.id, 'u9');
      expect(c.state.saved.dataOrNull!.title.en, 'New title');
      verify(() => update(any())).called(1);
      verifyNever(() => create(any()));
    },
  );

  blocTest<EventFormCubit, EventFormState>(
    'setGroup(todo) switches category to todo; failure surfaces message',
    build: build,
    setUp: () => when(
      () => create(any()),
    ).thenAnswer((_) async => const Result.failure(ServerFailure('nope'))),
    act: (c) async {
      c
        ..setGroup(EventGroup.todo)
        ..setTitle('Pay rent');
      await c.submit();
    },
    verify: (c) {
      expect(c.state.category, EventCategory.todo);
      expect(
        c.state.saved,
        const LoadState<Event>.failed(ServerFailure('nope')),
      );
      expect(c.state.saved.errorMessage, 'nope');
    },
  );
}
