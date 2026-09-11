import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../models/event_model.dart';
import 'events_data_source.dart';
import 'mock_events_seed.dart';

/// In-memory events store seeded with realistic multilingual data.
///
/// Personal events / to-dos live in one session store; the festival rows are
/// selected per call from the active region (`resolver.config`) so switching
/// Nepal ↔ India at runtime swaps the festival list while keeping the user's
/// own events. Create / update / delete mutate the session copy so the UI
/// behaves like a real backend until one exists. Deterministic for [now].
class MockEventsDataSource implements EventsDataSource {
  MockEventsDataSource({
    required RegionResolver resolver,
    DateTime? now,
    List<EventModel>? seed,
  }) : _resolver = resolver,
       _today = _midnight(now ?? DateTime.now()),
       _seedOverride = seed != null,
       _events = List.of(
         seed ??
             MockEventsSeed.userRows(
               _midnight(now ?? DateTime.now()),
               config: resolver.config,
             ),
       );

  final RegionResolver _resolver;
  final DateTime _today;

  /// `true` when an explicit [seed] replaces both festivals and user rows.
  final bool _seedOverride;

  /// Personal / to-do rows (or the full explicit seed).
  final List<EventModel> _events;

  /// Festival rows per region, built lazily on first use.
  final Map<Region, List<EventModel>> _festivals = {};
  int _counter = 0;

  static DateTime _midnight(DateTime d) => DateTime(d.year, d.month, d.day);

  List<EventModel> get _regionFestivals => _seedOverride
      ? const []
      : _festivals.putIfAbsent(
          _resolver.region,
          () => List.of(
            MockEventsSeed.festivals(_today, config: _resolver.config),
          ),
        );

  List<EventModel> get _all => [..._regionFestivals, ..._events];

  @override
  Future<List<EventModel>> fetchAll() async => List.unmodifiable(_all);

  @override
  Future<EventModel> fetchById(String id) async {
    final match = _all.where((e) => e.id == id);
    if (match.isEmpty) throw NotFoundException('Event $id not found');
    return match.first;
  }

  @override
  Future<EventModel> insert(EventModel event) async {
    final id = event.id.isEmpty
        ? 'usr-${++_counter}-${_events.length}'
        : event.id;
    final saved = event.copyWith(id: id);
    _events.add(saved);
    return saved;
  }

  @override
  Future<EventModel> update(EventModel event) async {
    final list = _listContaining(event.id);
    final index = list.indexWhere((e) => e.id == event.id);
    if (index < 0) throw NotFoundException('Event ${event.id} not found');
    list[index] = event;
    return event;
  }

  @override
  Future<void> delete(String id) async {
    final list = _listContaining(id);
    final index = list.indexWhere((e) => e.id == id);
    if (index < 0) throw NotFoundException('Event $id not found');
    list.removeAt(index);
  }

  List<EventModel> _listContaining(String id) =>
      _regionFestivals.any((e) => e.id == id) ? _regionFestivals : _events;
}
