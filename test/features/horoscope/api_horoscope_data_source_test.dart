import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/data/datasources/api_horoscope_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/entities/horoscope_period.dart';
import 'package:sanathan_nepal_mobile_app/features/horoscope/domain/entities/zodiac_sign.dart';

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

ResponseBody _json(Object? body) => ResponseBody.fromString(
  jsonEncode(body),
  200,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

/// The shape the server sends: localized text objects, not flat strings.
Map<String, dynamic> _entry({String sign = 'leo', String period = 'weekly'}) =>
    {
      'sign': sign,
      'period': period,
      'periodStart': '2026-09-06',
      'prediction': {
        'en': 'Confidence runs high this week.',
        'ne': 'यो साता आत्मविश्वास उच्च रहनेछ।',
        'hi': 'इस सप्ताह आत्मविश्वास ऊँचा रहेगा।',
      },
      'lucky': {
        'numbers': [1, 4],
        'colour': {'en': 'Gold', 'ne': 'सुनौलो', 'hi': 'सुनहरा'},
        'colourValue': 4294947584,
        'days': {
          'en': ['Sundays'],
          'ne': ['आइतबार'],
          'hi': ['रविवार'],
        },
        'rulingPlanet': {'en': 'Sun', 'ne': 'सूर्य', 'hi': 'सूर्य'},
        'symbol': {'en': 'The Lion', 'ne': 'सिंह', 'hi': 'सिंह'},
        'element': {'en': 'Fire', 'ne': 'अग्नि', 'hi': 'अग्नि'},
        'luckyStone': {'en': 'Ruby', 'ne': 'माणिक', 'hi': 'माणिक'},
        'unluckyStone': {'en': 'Diamond', 'ne': 'हीरा', 'hi': 'हीरा'},
        'alphabet': 'M, T',
        'eventfulYears': [1, 10, 19],
      },
      'scores': {'love': 75, 'career': 88},
    };

({ApiHoroscopeDataSource source, _StubAdapter adapter}) _build(
  Future<ResponseBody> Function(RequestOptions) handler,
) {
  final adapter = _StubAdapter(handler);
  final client = ApiClient(baseUrl: 'http://localhost/api/v1')
    ..dio.httpClientAdapter = adapter;
  return (source: ApiHoroscopeDataSource(client), adapter: adapter);
}

void main() {
  test('asks for the period the user picked', () async {
    final built = _build((_) async => _json([_entry()]));

    for (final period in HoroscopePeriod.values) {
      await built.source.fetchAll(period);
      expect(
        built.adapter.requests.last.uri.queryParameters['period'],
        period.name,
      );
    }
  });

  test('a weekly reading comes back whole, in three languages', () async {
    final built = _build((_) async => _json(_entry()));

    final p = await built.source.fetchPrediction(
      ZodiacSign.leo,
      HoroscopePeriod.weekly,
    );

    expect(p.period, HoroscopePeriod.weekly);
    expect(p.sign, ZodiacSign.leo);
    expect(p.textEn, 'Confidence runs high this week.');
    expect(p.textNe, 'यो साता आत्मविश्वास उच्च रहनेछ।');
    expect(p.textHi, 'इस सप्ताह आत्मविश्वास ऊँचा रहेगा।');
  });

  test('the lucky table is mapped, not just a number and a colour', () async {
    final built = _build((_) async => _json(_entry()));

    final lucky = (await built.source.fetchPrediction(
      ZodiacSign.leo,
      HoroscopePeriod.weekly,
    )).lucky;

    // It used to read only `colour` and `number`, so the Lucky Details table
    // rendered a row of blanks against a server that sends the whole thing.
    expect(lucky.numbers, [1, 4]);
    expect(lucky.colorEn, 'Gold');
    expect(lucky.colorHi, 'सुनहरा');
    expect(lucky.colorValue, 4294947584);
    expect(lucky.daysNe, ['आइतबार']);
    expect(lucky.rulingPlanetEn, 'Sun');
    expect(lucky.symbolNe, 'सिंह');
    expect(lucky.elementEn, 'Fire');
    expect(lucky.luckyStoneEn, 'Ruby');
    expect(lucky.unluckyStoneEn, 'Diamond');
    expect(lucky.luckyAlphabet, 'M, T');
    expect(lucky.eventfulYears, [1, 10, 19]);
  });

  test('an older flat lucky payload still yields a number', () async {
    // The first version of this endpoint sent `{colour: 'Saffron', number: 7}`.
    final built = _build(
      (_) async => _json({
        ..._entry(),
        'lucky': {'colour': 'Saffron', 'number': 7},
      }),
    );

    final lucky = (await built.source.fetchPrediction(
      ZodiacSign.leo,
      HoroscopePeriod.daily,
    )).lucky;

    expect(lucky.numbers, [7]);
    expect(lucky.colorEn, 'Saffron');
  });

  test('a missing lucky table costs the table, not the reading', () async {
    final built = _build((_) async => _json({..._entry(), 'lucky': null}));

    final p = await built.source.fetchPrediction(
      ZodiacSign.leo,
      HoroscopePeriod.monthly,
    );

    expect(p.textEn, isNotEmpty);
    expect(p.lucky.numbers, isEmpty);
  });

  test('every sign in the list is mapped to itself', () async {
    final built = _build(
      (_) async => _json([
        for (final s in ZodiacSign.values)
          _entry(sign: s.name, period: 'yearly'),
      ]),
    );

    final all = await built.source.fetchAll(HoroscopePeriod.yearly);

    expect(all, hasLength(12));
    expect(all.map((p) => p.sign), ZodiacSign.values);
    expect(all.every((p) => p.period == HoroscopePeriod.yearly), isTrue);
  });
}
