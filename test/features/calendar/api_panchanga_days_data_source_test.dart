import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/bounded_json_cache.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/api_panchanga_days_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/approximate_panchanga_days_data_source.dart';

import 'day_panchanga_test.dart' show kathmanduSummary;

/// Answers every request from [respond]; throwing simulates being offline.
class _Adapter implements HttpClientAdapter {
  _Adapter(this.respond);
  ResponseBody Function(RequestOptions options) respond;
  final List<Uri> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options.uri);
    return respond(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(Object body) => ResponseBody.fromString(
  jsonEncode(body),
  200,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

Never _offline(RequestOptions options) => throw DioException(
  requestOptions: options,
  type: DioExceptionType.connectionError,
);

void main() {
  const resolver = FixedRegionResolver(Region.nepal);
  final from = DateTime(2026, 9, 14);
  final to = DateTime(2026, 9, 15);

  late _Adapter adapter;
  late ApiPanchangaDaysDataSource source;

  setUp(() {
    adapter = _Adapter(
      (_) => _json([
        kathmanduSummary(date: '2026-09-14'),
        kathmanduSummary(date: '2026-09-15'),
      ]),
    );
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://api.test',
        validateStatus: (status) => status != null && status < 400,
      ),
    )..httpClientAdapter = adapter;
    source = ApiPanchangaDaysDataSource(
      client: ApiClient(dio: dio),
      cache: BoundedJsonCache(InMemoryKeyValueStore(), namespace: 'test'),
      resolver: resolver,
      fallback: const ApproximatePanchangaDaysDataSource(resolver),
    );
  });

  test('asks the range endpoint and returns the server days', () async {
    final days = await source.fetchRange(from: from, to: to);
    expect(days, hasLength(2));
    expect(days.every((d) => !d.isApproximate), isTrue);
    expect(adapter.requests.single.path, '/almanac/panchanga/range');
    expect(adapter.requests.single.queryParameters, {
      'from': '2026-09-14',
      'to': '2026-09-15',
    });
  });

  test('shows a month fetched earlier exactly while offline', () async {
    await source.fetchRange(from: from, to: to);
    adapter.respond = _offline;
    final days = await source.fetchRange(from: from, to: to);
    expect(days, hasLength(2));
    expect(days.every((d) => !d.isApproximate), isTrue);
  });

  test('falls back to the labelled estimate for a month never fetched', () async {
    adapter.respond = _offline;
    final days = await source.fetchRange(from: from, to: to);
    expect(days, hasLength(2));
    expect(days.every((d) => d.isApproximate), isTrue);
  });

  test('drops malformed rows but keeps the good ones', () async {
    adapter.respond = (_) => _json([
      kathmanduSummary(date: '2026-09-14'),
      {'date': '2026-09-15'},
    ]);
    final days = await source.fetchRange(from: from, to: to);
    expect(days, hasLength(1));
  });
}
