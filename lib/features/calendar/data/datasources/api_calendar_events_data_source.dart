import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../models/calendar_event_model.dart';
import 'calendar_events_data_source.dart';

/// Calendar events served by the backend.
///
/// The server owns which festivals fall on which Gregorian date — a lunar
/// festival's date is not derivable by formula, and precomputing it there
/// means every client agrees and the response stays cacheable.
class ApiCalendarEventsDataSource implements CalendarEventsDataSource {
  const ApiCalendarEventsDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<CalendarEventModel>> fetchEvents({
    required DateTime from,
    required DateTime to,
  }) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.almanacCalendar,
      query: {'from': _day(from), 'to': _day(to)},
    );

    return asJsonList(response).map(_toModel).toList(growable: false)
      ..sort((a, b) => a.date.compareTo(b.date));
  });

  static String _day(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  CalendarEventModel _toModel(Map<String, dynamic> json) {
    final title = _localized(json['title']);
    final description = _localized(json['description']);

    return CalendarEventModel(
      id: json['id'] as String? ?? '',
      date: ApiTime.dateOr(json['date'], DateTime.now()),
      titleEn: title['en'] ?? '',
      titleNe: title['ne'] ?? '',
      titleHi: title['hi'] ?? '',
      descriptionEn: description['en'] ?? '',
      descriptionNe: description['ne'] ?? '',
      descriptionHi: description['hi'] ?? '',
      isHoliday: json['isHoliday'] as bool? ?? false,
      imageUrl: json['imageKey'] as String?,
    );
  }

  /// The server sends `{en, ne, hi}` with only `en` guaranteed.
  Map<String, String> _localized(Object? raw) {
    if (raw is! Map) return const {};
    return raw.map((key, value) => MapEntry(key.toString(), value.toString()));
  }
}
