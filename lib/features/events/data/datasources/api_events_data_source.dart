import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/event_category.dart';
import '../models/event_model.dart';
import 'events_data_source.dart';
import 'mock_events_seed.dart';

/// Personal events, to-dos, and system festivals served by the backend.
///
/// Festivals and the user's own events share one list and one details page,
/// but not one endpoint: festivals come from the almanac, by slug. A festival's
/// id says so ([festivalId]), and [fetchById] reads it to ask the right place —
/// asking `/events/:id` answered every festival with 404.
class ApiEventsDataSource implements EventsDataSource {
  const ApiEventsDataSource(this._client, {this.resolver});

  final ApiClient _client;
  final RegionResolver? resolver;

  static const String festivalIdPrefix = 'festival:';

  /// The event id of the almanac festival with [slug].
  static String festivalId(String slug) => '$festivalIdPrefix$slug';

  @override
  Future<List<EventModel>> fetchAll() => guardApi(() async {
    final List<EventModel> results = [];
    final config = resolver?.config ?? RegionConfig.nepal;

    // 1. Fetch backend system festivals
    try {
      final festivalResponse = await _client.get<dynamic>(
        ApiEndpoints.almanacFestivals,
      );
      final festivalList = asJsonList(
        festivalResponse,
      ).map(_festivalToModel).toList(growable: false);
      if (festivalList.isNotEmpty) {
        results.addAll(festivalList);
      } else {
        // Fallback to rich regional festival seed if DB has no festival records
        results.addAll(
          MockEventsSeed.festivals(DateTime.now(), config: config),
        );
      }
    } catch (_) {
      results.addAll(MockEventsSeed.festivals(DateTime.now(), config: config));
    }

    // 2. Fetch user-created personal events & to-dos
    try {
      final userEventsResponse = await _client.get<dynamic>(
        ApiEndpoints.events,
      );
      final userEvents = asJsonList(
        userEventsResponse,
      ).map(_toModel).toList(growable: false);
      results.addAll(userEvents);
    } catch (_) {
      // Keep festival results if user events request fails
    }

    return List.unmodifiable(results);
  });

  @override
  Future<EventModel> fetchById(String id) => guardApi(() async {
    if (id.startsWith(festivalIdPrefix)) {
      final slug = id.substring(festivalIdPrefix.length);
      final response = await _client.get<dynamic>(
        ApiEndpoints.almanacFestival(slug),
      );
      return _festivalToModel(asJsonMap(response));
    }
    // The built-in festival list [fetchAll] falls back to when the almanac
    // has none: those exist only on the device, so they are answered here.
    final seeded = MockEventsSeed.festivals(
      DateTime.now(),
      config: resolver?.config ?? RegionConfig.nepal,
    ).where((e) => e.id == id);
    if (seeded.isNotEmpty) return seeded.first;

    final response = await _client.get<dynamic>(ApiEndpoints.event(id));
    return _toModel(asJsonMap(response));
  });

  @override
  Future<EventModel> insert(EventModel event) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.events,
      data: _body(event),
    );
    return _toModel(asJsonMap(response));
  });

  @override
  Future<EventModel> update(EventModel event) => guardApi(() async {
    final response = await _client.patch<dynamic>(
      ApiEndpoints.event(event.id),
      data: _body(event),
    );
    return _toModel(asJsonMap(response));
  });

  @override
  Future<void> delete(String id) =>
      guardApi(() => _client.delete<dynamic>(ApiEndpoints.event(id)));

  /// Toggles one checklist item.
  Future<EventModel> toggleChecklistItem(String eventId, String itemId) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.eventChecklistItem(eventId, itemId),
        );
        return _toModel(asJsonMap(response));
      });

  Map<String, dynamic> _body(EventModel event) {
    final reminder = event.reminder;
    return {
      'kind': _kindFor(event.category),
      'title': {
        'en': event.title.en,
        'ne': event.title.ne,
        if (event.title.hi.isNotEmpty) 'hi': event.title.hi,
      },
      'note': event.description.en,
      'date': event.date.toIso8601String().substring(0, 10),
      'repeatsYearly': event.repeat == EventRepeat.yearly,
      'useTraditionalDate':
          event.repeat == EventRepeat.yearly &&
          (event.category == EventCategory.personal ||
              event.category == EventCategory.todo),
      'reminders': reminder == null
          ? const []
          : [
              {
                'daysBefore': reminder.daysBefore,
                'hour': reminder.time.hour,
                'minute': reminder.time.minute,
              },
            ],
      'checklist': event.checklist
          .map((item) => {'label': item.label, 'isDone': item.isDone})
          .toList(),
    };
  }

  static String _kindFor(EventCategory category) => switch (category.name) {
    'birthday' => 'birthday',
    'anniversary' => 'anniversary',
    'shraddha' => 'shraddha',
    'todo' => 'todo',
    _ => 'custom',
  };

  static EventCategory _categoryFor(String? kind) {
    if (kind == 'todo') return EventCategory.todo;
    return EventCategory.values.firstWhere(
      (c) => c.name == kind,
      orElse: () => EventCategory.personal,
    );
  }

  /// Maps the almanac's festival category onto the app's chips.
  ///
  /// The server had no category column, so every festival arrived here as a
  /// Hindu one — which filed Christmas under the Hindu chip and left the
  /// Christian, Sikh and Jain chips permanently empty.
  static const Map<String, EventCategory> _festivalCategories = {
    'hindu': EventCategory.hinduFestival,
    'buddhist': EventCategory.buddhistFestival,
    'islamic': EventCategory.islamicFestival,
    'kirat': EventCategory.kiratFestival,
    'christian': EventCategory.christianFestival,
    'sikh': EventCategory.sikhFestival,
    'jain': EventCategory.jainFestival,
    'publicHoliday': EventCategory.publicHoliday,
  };

  EventModel _festivalToModel(Map<String, dynamic> json) {
    final slug = json['slug'] as String? ?? '';
    return EventModel(
      // By slug, which is what the almanac serves a single festival by.
      id: slug.isNotEmpty ? festivalId(slug) : json['id'] as String? ?? '',
      title: _text(json['name']),
      date: ApiTime.dateOr(json['date'], DateTime.now()),
      category:
          _festivalCategories[json['category'] as String?] ??
          EventCategory.hinduFestival,
      description: _text(json['summary']),
      // Carried now that the almanac stores them: the details page rendered
      // three empty sections because these never left the server.
      tithi: _text(json['tithi']),
      howToCelebrate: _text(json['howToCelebrate']),
      attractionPlaces: _text(json['attractions']),
      // Read rather than assumed — hard-coding these made every festival a
      // holiday and every one important, so both sub-filters matched all rows.
      isHoliday: json['isHoliday'] as bool? ?? true,
      isVrat: json['isVrat'] as bool? ?? false,
      isImportant: json['isImportant'] as bool? ?? false,
    );
  }

  EventModel _toModel(Map<String, dynamic> json) {
    final reminders = json['reminders'];
    final firstReminder =
        reminders is List && reminders.isNotEmpty && reminders.first is Map
        ? Map<String, dynamic>.from(reminders.first as Map)
        : null;

    return EventModel(
      id: json['id'] as String? ?? '',
      title: _text(json['title']),
      date: ApiTime.dateOr(json['date'], DateTime.now()),
      category: _categoryFor(json['kind'] as String?),
      description: LocalizedTextModel(en: json['note'] as String? ?? ''),
      repeat: json['repeatsYearly'] == true
          ? EventRepeat.yearly
          : EventRepeat.none,
      // Sent on the way out and dropped on the way back in, so a birthday
      // recorded in Bikram Sambat came home recurring on the Gregorian date.
      useTraditionalDate: json['useTraditionalDate'] == true,
      reminder: firstReminder == null
          ? null
          : EventReminderModel(
              daysBefore: (firstReminder['daysBefore'] as num?)?.toInt() ?? 1,
              time: EventTimeModel(
                hour: (firstReminder['hour'] as num?)?.toInt() ?? 0,
                minute: (firstReminder['minute'] as num?)?.toInt() ?? 0,
              ),
            ),
      checklist: json['checklist'] is List
          ? (json['checklist'] as List)
                .whereType<Map>()
                .map(
                  (item) => ChecklistItemModel(
                    id: item['id'] as String? ?? '',
                    label: item['label'] as String? ?? '',
                    isDone: item['isDone'] as bool? ?? false,
                  ),
                )
                .toList(growable: false)
          : const [],
    );
  }

  static LocalizedTextModel _text(Object? raw) {
    if (raw is String) return LocalizedTextModel(en: raw, ne: raw);
    if (raw is! Map) return const LocalizedTextModel();
    final en = raw['en'] as String? ?? '';
    return LocalizedTextModel(
      en: en,
      ne: raw['ne'] as String? ?? en,
      hi: raw['hi'] as String? ?? '',
    );
  }
}
