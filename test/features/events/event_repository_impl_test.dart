import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/datasources/events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/datasources/mock_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/models/event_model.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/repositories/event_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_category.dart';
import 'package:sanathan_nepal_mobile_app/features/events/domain/entities/event_filter.dart';

class _MockSource extends Mock implements EventsDataSource {}

/// Resolver whose region can be flipped mid-test (runtime region switch).
class _SwitchableResolver implements RegionResolver {
  _SwitchableResolver(this.region);
  @override
  Region region;
  @override
  RegionConfig get config => region.config;
}

void main() {
  final now = DateTime(2026, 8, 17);
  late EventRepositoryImpl repo;

  setUp(() {
    repo = EventRepositoryImpl(
      MockEventsDataSource(
        resolver: const FixedRegionResolver(Region.nepal),
        now: now,
      ),
      clock: () => now,
    );
  });

  group('recurring events', () {
    /// The bug this group exists for: an event created with a past date and
    /// `repeatsYearly` came back from the API, parsed correctly, and was then
    /// dropped by the upcoming filter — present in the response, absent from
    /// the screen.
    final birthday = EventModel.fromEntity(
      Event(
        id: 'bday',
        title: LocalizedText.same('My birthday'),
        date: DateTime(2000, 2, 3),
        category: EventCategory.birthday,
        repeat: EventRepeat.yearly,
      ),
    );

    late _MockSource source;
    late EventRepositoryImpl recurring;

    setUp(() {
      source = _MockSource();
      when(source.fetchAll).thenAnswer((_) async => [birthday]);
      recurring = EventRepositoryImpl(
        source,
        clock: () => now,
        resolver: const FixedRegionResolver(Region.nepal),
      );
    });

    test('a birthday from years ago is still upcoming', () async {
      final events = (await recurring.getEvents()).valueOrNull!;

      expect(events, hasLength(1));
      // February next, not the year 2000.
      expect(events.single.nextOccurrence(from: now).year, 2027);
      expect(events.single.daysLeft(now), greaterThan(0));
    });

    test('a one-off in the past stays in the past', () async {
      when(
        source.fetchAll,
      ).thenAnswer((_) async => [birthday.copyWith(repeat: EventRepeat.none)]);

      // `EventFilter()` is the upcoming one; the repository's own default is
      // `EventFilter.all`, which deliberately hides nothing. With no repeat
      // there is nothing to project — this one really has passed.
      expect(
        (await recurring.getEvents(const EventFilter())).valueOrNull,
        isEmpty,
      );
      expect(
        (await recurring.getEvents(EventFilter.all)).valueOrNull,
        hasLength(1),
      );
    });

    test('the upcoming list keeps a recurring event and drops a dead one', () async {
      when(source.fetchAll).thenAnswer(
        (_) async => [
          birthday,
          birthday.copyWith(id: 'once', repeat: EventRepeat.none),
        ],
      );

      // The pairing is the point: same date, same everything, and only the
      // repeating one belongs in a list of what is coming up.
      final upcoming = (await recurring.getEvents(
        const EventFilter(),
      )).valueOrNull!;

      expect(upcoming.map((e) => e.id), ['bday']);
    });

    test('the anniversary keeps its day of the month', () async {
      final next = (await recurring.getEvents()).valueOrNull!.single
          .nextOccurrence(from: now);

      expect(next.month, 2);
      expect(next.day, 3);
    });

    test('a 29 February birthday survives a non-leap year', () async {
      when(
        source.fetchAll,
      ).thenAnswer((_) async => [birthday.copyWith(date: DateTime(2000, 2, 29))]);

      // 2027 has no 29 February. Clamping to the 28th beats throwing, and
      // beats rolling silently into March.
      final next = (await recurring.getEvents()).valueOrNull!.single
          .nextOccurrence(from: now);
      expect(next.month, 2);
      expect(next.day, 28);
    });
  });

  group('EventRepositoryImpl (mock source)', () {
    test('EventFilter.onDay lists only that day (all groups)', () async {
      // Seed: "Medicine Time" to-do is dated today; personal events later.
      final today = (await repo.getEvents(EventFilter.onDay(now))).valueOrNull!;
      expect(today, isNotEmpty);
      expect(today.every((e) => e.date == now), isTrue);
      expect(today.any((e) => e.group == EventGroup.todo), isTrue);

      final rent = (await repo.getEvents(
        EventFilter.onDay(now.add(const Duration(days: 2))),
      )).valueOrNull!;
      expect(rent.map((e) => e.title.en), contains('House Rent'));
      expect(rent.every((e) => e.date.difference(now).inDays == 2), isTrue);

      // `to` alone caps the upcoming list.
      final capped = (await repo.getEvents(
        EventFilter(to: now.add(const Duration(days: 2))),
      )).valueOrNull!;
      expect(capped.every((e) => e.date.difference(now).inDays <= 2), isTrue);
    });

    test('lists upcoming events sorted by date', () async {
      final result = await repo.getEvents(const EventFilter());
      final events = result.valueOrNull!;
      expect(events.length, greaterThanOrEqualTo(12));
      for (var i = 1; i < events.length; i++) {
        expect(events[i].date.isBefore(events[i - 1].date), isFalse);
      }
      expect(events.every((e) => !e.date.isBefore(now)), isTrue);
    });

    test('filters by group / category / holiday flags and limit', () async {
      final festivals = (await repo.getEvents(
        const EventFilter(group: EventGroup.festival),
      )).valueOrNull!;
      expect(festivals.every((e) => e.group == EventGroup.festival), isTrue);

      final holidays = (await repo.getEvents(
        const EventFilter(category: EventCategory.publicHoliday),
      )).valueOrNull!;
      expect(holidays, isNotEmpty);
      expect(
        holidays.every((e) => e.category == EventCategory.publicHoliday),
        isTrue,
      );

      final vrat = (await repo.getEvents(
        const EventFilter(onlyVrat: true),
      )).valueOrNull!;
      expect(vrat.every((e) => e.isVrat), isTrue);

      final limited = (await repo.getEvents(
        const EventFilter(limit: 3),
      )).valueOrNull!;
      expect(limited.length, 3);
    });

    test('create → getById → update → toggleChecklist → delete', () async {
      final created = await repo.createEvent(
        Event(
          id: '',
          title: LocalizedText.same('Dentist'),
          date: now.add(const Duration(days: 3)),
          category: EventCategory.personal,
          checklist: const [ChecklistItem(id: 'a', label: 'Bring card')],
        ),
      );
      final saved = created.valueOrNull!;
      expect(saved.id, isNotEmpty);

      final fetched = await repo.getEventById(saved.id);
      expect(fetched.valueOrNull, saved);

      final updated = await repo.updateEvent(
        saved.copyWith(title: LocalizedText.same('Dentist visit')),
      );
      expect(updated.valueOrNull!.title.en, 'Dentist visit');

      final toggled = await repo.toggleChecklistItem(saved.id, 'a');
      expect(toggled.valueOrNull!.checklist.first.isDone, isTrue);

      expect((await repo.deleteEvent(saved.id)).isSuccess, isTrue);
      final gone = await repo.getEventById(saved.id);
      expect(gone.failureOrNull, isA<NotFoundFailure>());
    });
  });

  group('EventRepositoryImpl (India region)', () {
    late EventRepositoryImpl india;

    setUp(() {
      india = EventRepositoryImpl(
        MockEventsDataSource(
          resolver: const FixedRegionResolver(Region.india),
          now: now,
        ),
        clock: () => now,
      );
    });

    test('uses the India festival seed with real Gregorian dates', () async {
      final festivals = (await india.getEvents(
        const EventFilter(group: EventGroup.festival, upcomingOnly: false),
      )).valueOrNull!;
      final ids = festivals.map((e) => e.id).toSet();
      expect(ids, containsAll(['in-diwali', 'in-republic-day', 'in-holi']));
      expect(ids.any((id) => id.startsWith('fst-')), isFalse);
      final diwali = festivals.firstWhere((e) => e.id == 'in-diwali');
      // Next Diwali on/after 17 Aug 2026 is 8 Nov 2026.
      expect(diwali.date, DateTime(2026, 11, 8));
      expect(diwali.isHoliday, isTrue);
      expect(diwali.title.hi, 'दीपावली');
      expect(diwali.title.resolveFor('hi'), 'दीपावली');
      expect(diwali.title.resolveFor('en'), 'Diwali (Deepavali)');
      // Independence Day 2026 already passed → 2027.
      final independence = festivals.firstWhere(
        (e) => e.id == 'in-independence-day',
      );
      expect(independence.date, DateTime(2027, 8, 15));
      expect(independence.category, EventCategory.publicHoliday);
      // Sikh / Jain categories exist and gazetted holidays are flagged.
      expect(
        festivals.where((e) => e.category == EventCategory.sikhFestival),
        isNotEmpty,
      );
      expect(
        festivals.where((e) => e.category == EventCategory.jainFestival),
        isNotEmpty,
      );
      expect(
        festivals.where((e) => e.category == EventCategory.kiratFestival),
        isEmpty,
      );
      expect(
        festivals.firstWhere((e) => e.id == 'in-guru-nanak-jayanti').isHoliday,
        isTrue,
      );
    });

    test('personal seed uses New Delhi and keeps user rows', () async {
      final mine = (await india.getEvents(
        const EventFilter(group: EventGroup.personal),
      )).valueOrNull!;
      final anniversary = mine.firstWhere((e) => e.id == 'usr-anniversary');
      expect(anniversary.location.en, 'Home, New Delhi');
      expect(anniversary.location.hi, 'घर, नई दिल्ली');
      expect(anniversary.title.resolveFor('hi'), 'वर्षगाँठ');
    });

    test(
      'switching region at runtime swaps festivals, keeps user events',
      () async {
        final resolver = _SwitchableResolver(Region.nepal);
        final repo = EventRepositoryImpl(
          MockEventsDataSource(resolver: resolver, now: now),
          clock: () => now,
        );
        final created = (await repo.createEvent(
          Event(
            id: '',
            title: LocalizedText.same('Dentist'),
            date: now.add(const Duration(days: 3)),
            category: EventCategory.personal,
          ),
        )).valueOrNull!;
        var all = (await repo.getEvents(EventFilter.all)).valueOrNull!;
        expect(all.any((e) => e.id == 'fst-ram-nawami'), isTrue);
        expect(all.any((e) => e.id == 'in-diwali'), isFalse);

        resolver.region = Region.india;
        all = (await repo.getEvents(EventFilter.all)).valueOrNull!;
        expect(all.any((e) => e.id == 'fst-ram-nawami'), isFalse);
        expect(all.any((e) => e.id == 'in-diwali'), isTrue);
        expect(all.any((e) => e.id == created.id), isTrue);
        expect((await repo.getEventById('in-diwali')).isSuccess, isTrue);
      },
    );
  });

  test('EventModel round-trips through JSON and entities', () {
    final event = Event(
      id: 'u1',
      title: const LocalizedText(
        ne: 'वार्षिक उत्सव',
        en: 'Anniversary',
        hi: 'वर्षगाँठ',
      ),
      date: DateTime(2026, 9, 6),
      time: const EventTime(hour: 18, minute: 30),
      category: EventCategory.anniversary,
      isImportant: true,
      location: LocalizedText.same('Home'),
      checklist: const [ChecklistItem(id: 'c1', label: 'Cake', isDone: true)],
      reminder: const EventReminder(
        daysBefore: 2,
        time: EventTime(hour: 6, minute: 0),
      ),
      repeat: EventRepeat.yearly,
    );
    final model = EventModel.fromEntity(event);
    expect(model.toEntity(), event);

    final json = model.toJson();
    expect(json['is_important'], isTrue);
    expect(json['category'], 'anniversary');
    expect(json['repeat'], 'yearly');
    expect((json['title'] as Map<String, dynamic>)['hi'], 'वर्षगाँठ');
    expect((json['reminder'] as Map<String, dynamic>)['days_before'], 2);
    expect(json.containsKey('image_path'), isFalse);
    expect(EventModel.fromJson(json), model);
    expect(EventModel.fromJson(json).toEntity(), event);

    // Unknown enum names fall back like the old `fromName` helpers.
    final lenient = EventModel.fromJson({
      ...json,
      'category': 'party',
      'repeat': 'sometimes',
    });
    expect(lenient.category, EventCategory.personal);
    expect(lenient.repeat, EventRepeat.none);
  });

  test('maps data-source exceptions to failures', () async {
    final source = _MockSource();
    when(source.fetchAll).thenThrow(const ServerException('boom'));
    final r = EventRepositoryImpl(source);
    final result = await r.getEvents();
    expect(result.failureOrNull, isA<ServerFailure>());
  });
}
