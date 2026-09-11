import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/data/datasources/api_console_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/console_pricing.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);
  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    requests.add(options);
    return handler(options);
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

/// `GET /console/pricing` as the server now answers it: every channel present,
/// unpriced ones flagged off.
Map<String, dynamic> _pricing({
  String chat = '2000',
  String voice = '3500',
  String video = '0',
  bool videoEnabled = false,
}) => {
  'channels': {
    'chat': {'ratePerMinuteMinor': chat, 'enabled': true},
    'voice': {'ratePerMinuteMinor': voice, 'enabled': true},
    'video': {'ratePerMinuteMinor': video, 'enabled': videoEnabled},
  },
  'commissionPercent': 20,
  'firstSessionRateMinor': null,
  'freeFirstMinutes': 0,
};

/// The console lets an astrologer set what they charge, so the two things
/// worth pinning are that the rates arrive and that switching a channel off
/// actually reaches the server — the second used to silently fail, leaving
/// them offering a channel they had turned off.
void main() {
  late _StubAdapter adapter;
  late ApiConsoleDataSource source;

  ApiConsoleDataSource build(Map<String, dynamic> response) {
    adapter = _StubAdapter((_) async => _json(response));
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = adapter;
    return ApiConsoleDataSource(client, () => 'en');
  }

  test('rates are read back for every enabled channel', () async {
    source = build(_pricing());

    final pricing = await source.pricing();

    expect(pricing.rateFor(ConsultChannel.chat), 20);
    expect(pricing.rateFor(ConsultChannel.voice), 35);
    // Present in the response but switched off, so it is not on offer.
    expect(pricing.rateFor(ConsultChannel.video), isNull);
    expect(pricing.commissionRate, 0.2);
  });

  test('an astrologer who has priced nothing gets no rates, not an error', () async {
    source = build({
      'channels': {
        'chat': {'ratePerMinuteMinor': '0', 'enabled': false},
        'voice': {'ratePerMinuteMinor': '0', 'enabled': false},
        'video': {'ratePerMinuteMinor': '0', 'enabled': false},
      },
      'commissionPercent': 20,
      'firstSessionRateMinor': null,
      'freeFirstMinutes': 0,
    });

    final pricing = await source.pricing();

    expect(pricing.ratePerMinute, isEmpty);
    expect(pricing.commissionRate, 0.2);
  });

  test('saving sends every channel, so switching one off takes effect', () async {
    source = build(_pricing(video: '0'));

    // Video omitted from the map — that is how the cubit represents "not
    // offered" after the field is cleared.
    await source.savePricing(
      const ConsolePricing(
        ratePerMinute: {
          ConsultChannel.chat: 20,
          ConsultChannel.voice: 35,
        },
      ),
    );

    final body = adapter.requests.single.data! as Map<String, dynamic>;
    // All three, not just the two that have a price. The server upserts what it
    // receives and leaves the rest untouched, so an omitted channel kept its
    // old row enabled and stayed on offer.
    expect(body.keys, containsAll(['chat', 'voice', 'video']));
    expect(body['video'], {'ratePerMinuteMinor': '0', 'enabled': false});
    expect(body['chat'], {'ratePerMinuteMinor': '2000', 'enabled': true});
  });

  test('net per minute accounts for commission', () async {
    source = build(_pricing());

    final pricing = await source.pricing();

    // ₹20 at 20% commission leaves ₹16.
    expect(pricing.netPerMinute(ConsultChannel.chat), 16);
  });
}
