import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/push/push_device_registrar.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter({this.status = 204});
  final int status;
  final List<Map<String, dynamic>> bodies = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    bodies.add(Map<String, dynamic>.from(options.data as Map));
    if (status >= 400) {
      throw DioException.badResponse(
        statusCode: status,
        requestOptions: options,
        response: Response<dynamic>(
          requestOptions: options,
          statusCode: status,
        ),
      );
    }
    return ResponseBody.fromString(
      jsonEncode({}),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late InMemoryKeyValueStore store;
  late _StubAdapter adapter;
  String language = 'ne';

  PushDeviceRegistrar registrarWith({int status = 204}) {
    adapter = _StubAdapter(status: status);
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = adapter;
    return PushDeviceRegistrar(
      client: client,
      store: store,
      languageCode: () => language,
      appVersion: '2.0.0',
      platformName: 'android',
    );
  }

  setUp(() {
    store = InMemoryKeyValueStore();
    language = 'ne';
  });

  test('sends the token, platform and language', () async {
    final registrar = registrarWith();

    expect(await registrar.register('tok-1'), isTrue);

    expect(adapter.bodies.single, {
      'platform': 'android',
      'pushToken': 'tok-1',
      'locale': 'ne',
      'appVersion': '2.0.0',
    });
  });

  test('does not repeat an identical registration', () async {
    final registrar = registrarWith();

    await registrar.register('tok-1');
    await registrar.register('tok-1');

    // The token rarely changes; re-posting it on every launch is a request
    // per app open for nothing.
    expect(adapter.bodies, hasLength(1));
  });

  test('re-registers when the token changes', () async {
    final registrar = registrarWith();

    await registrar.register('tok-1');
    await registrar.register('tok-2');

    expect(adapter.bodies.map((b) => b['pushToken']), ['tok-1', 'tok-2']);
  });

  test('re-registers when the app language changes', () async {
    final registrar = registrarWith();
    await registrar.register('tok-1');

    language = 'en';
    await registrar.register('tok-1');

    // The server picks the notification's language from the device row, so a
    // phone switched to English must say so or keep getting Nepali.
    expect(adapter.bodies.map((b) => b['locale']), ['ne', 'en']);
  });

  test('an unsupported language falls back to English', () async {
    language = 'fr';
    final registrar = registrarWith();

    await registrar.register('tok-1');

    expect(adapter.bodies.single['locale'], 'en');
  });

  test('a failed registration is not remembered, and never throws', () async {
    final registrar = registrarWith(status: 500);

    expect(await registrar.register('tok-1'), isFalse);
    // Nothing stored, so the next launch tries again rather than believing
    // this device is registered.
    expect(store.getString(PushDeviceRegistrar.storageKey), isNull);
  });

  test('forgetting clears the marker so the next token is sent', () async {
    final registrar = registrarWith();
    await registrar.register('tok-1');

    await registrar.forget();
    await registrar.register('tok-1');

    expect(adapter.bodies, hasLength(2));
  });

  test('ignores an empty token', () async {
    final registrar = registrarWith();
    expect(await registrar.register(''), isFalse);
    expect(adapter.bodies, isEmpty);
  });
}
