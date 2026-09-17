import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/datasources/api_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/events/data/datasources/mock_events_seed.dart';

/// Tapping Diwali opened `/events/<festival id>`, the user-events endpoint,
/// which answered 404 — festivals are served by the almanac, by slug. These pin
/// that each kind of event is opened from the place that serves it.
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.routes);
  final Map<String, Object> routes;
  final List<String> seen = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final path = Uri.parse(options.path).path.replaceFirst('/api/v1', '');
    seen.add(path);
    final body = routes[path];
    return ResponseBody.fromString(
      jsonEncode(
        body ??
            {
              'error': {
                'kind': 'notFound',
                'code': 'NOT_FOUND',
                'message': path,
              },
            },
      ),
      body == null ? 404 : 200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _diwali = {
  'id': '01M27FV9TBHJRZJZMWNZZXN368',
  'slug': 'diwali',
  'name': {'en': 'Diwali', 'ne': 'दिवाली', 'hi': 'दीवाली'},
  'summary': {'en': 'A major festival.'},
  'date': '2026-10-06',
};

const _birthday = {
  'id': '01M2USEREVENT00000000000001',
  'kind': 'birthday',
  'title': {'en': 'Mum’s birthday', 'ne': 'आमाको जन्मदिन'},
  'date': '2026-11-02',
};

ApiEventsDataSource _source(_StubAdapter adapter) => ApiEventsDataSource(
  ApiClient(baseUrl: 'http://localhost/api/v1')
    ..dio.httpClientAdapter = adapter,
);

void main() {
  test('a festival from the list opens from the almanac, by slug', () async {
    final adapter = _StubAdapter({
      '/almanac/festivals': [_diwali],
      '/almanac/festivals/diwali': _diwali,
      '/events': <Object>[],
    });
    final source = _source(adapter);

    final listed = (await source.fetchAll()).singleWhere(
      (e) => e.title.en == 'Diwali',
    );
    expect(listed.id, ApiEventsDataSource.festivalId('diwali'));

    adapter.seen.clear();
    final opened = await source.fetchById(listed.id);

    expect(opened.title.en, 'Diwali');
    expect(opened.id, listed.id);
    expect(adapter.seen, ['/almanac/festivals/diwali']);
  });

  test('the user’s own event still opens from /events', () async {
    final adapter = _StubAdapter({'/events/${_birthday['id']}': _birthday});
    final opened = await _source(adapter).fetchById(_birthday['id']! as String);

    expect(opened.title.en, 'Mum’s birthday');
    expect(adapter.seen, ['/events/${_birthday['id']}']);
  });

  test(
    'a built-in festival, shown when the almanac has none, opens offline',
    () async {
      final adapter = _StubAdapter({});
      final seeded = MockEventsSeed.festivals(
        DateTime.now(),
        config: RegionConfig.nepal,
      ).first;

      final opened = await _source(adapter).fetchById(seeded.id);

      expect(opened.id, seeded.id);
      expect(adapter.seen, isEmpty);
    },
  );
}
