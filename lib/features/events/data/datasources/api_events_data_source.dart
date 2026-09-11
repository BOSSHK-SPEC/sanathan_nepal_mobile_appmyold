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
class ApiEventsDataSource implements EventsDataSource {
  const ApiEventsDataSource(this._client, {this.resolver});

  final ApiClient _client;
  final RegionResolver? resolver;

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

  EventModel _festivalToModel(Map<String, dynamic> json) {
    final name = _text(json['name']);
    final summary = _text(json['summary']);
    return EventModel(
      id: json['id'] as String? ?? json['slug'] as String? ?? '',
      title: name,
      date: ApiTime.dateOr(json['date'], DateTime.now()),
      category: EventCategory.hinduFestival,
      description: summary,
      isHoliday: true,
      isImportant: true,
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
