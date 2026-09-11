import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/data/datasources/api_messaging_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/domain/entities/business_message.dart';

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

ResponseBody _json(Object? body, {int status = 200}) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

Map<String, dynamic> _thread({String side = 'customer', int unread = 2}) => {
  'id': '01JTHREAD00000000000000001',
  'businessId': '01JBIZ0000000000000000000A',
  'businessName': 'Bhaktapur Bhandar',
  'businessLogoKey': 'http://cdn.test/logo.png',
  'customerId': '01JUSER000000000000000000A',
  'customerName': 'Kritika',
  'contactName': 'Kritika S.',
  'contactEmail': 'k@example.com',
  'subject': 'Stock',
  'lastMessageAt': '2026-09-01T10:00:00.000Z',
  'lastMessagePreview': 'Do you have brass diyo?',
  'unreadCount': unread,
  'archived': false,
  'side': side,
  'createdAt': '2026-09-01T09:00:00.000Z',
};

Map<String, dynamic> _message(String id, String sender, String at) => {
  'id': id,
  'threadId': '01JTHREAD00000000000000001',
  'sender': sender,
  'body': 'body-$id',
  'readAt': null,
  'createdAt': at,
};

({ApiMessagingDataSource source, _StubAdapter adapter}) _build(
  Future<ResponseBody> Function(RequestOptions) handler,
) {
  final adapter = _StubAdapter(handler);
  final client = ApiClient(baseUrl: 'http://localhost/api/v1')
    ..dio.httpClientAdapter = adapter;
  return (source: ApiMessagingDataSource(client), adapter: adapter);
}

void main() {
  test('a thread maps every field the inbox renders', () async {
    final built = _build((_) async => _json(_thread(side: 'owner')));

    final thread = await built.source.thread('01JTHREAD00000000000000001');

    expect(thread.businessName, 'Bhaktapur Bhandar');
    expect(thread.side, MessageSide.owner);
    expect(thread.contactEmail, 'k@example.com');
    expect(thread.subject, 'Stock');
    expect(thread.unreadCount, 2);
    expect(thread.businessLogoUrl, 'http://cdn.test/logo.png');
  });

  test('a business nobody has written to yet is null, not an error', () async {
    final built = _build((_) async => _json(null));

    final thread = await built.source.threadWithBusiness(
      '01JBIZ0000000000000000000A',
    );

    expect(thread, isNull);
  });

  test('messages come back oldest-first for reading', () async {
    // The server pages newest-first so the first page is the bottom of the
    // conversation; a transcript that rendered it in that order would read
    // backwards.
    final built = _build(
      (_) async => _json({
        'items': [
          _message('c', 'owner', '2026-09-01T12:00:00.000Z'),
          _message('b', 'customer', '2026-09-01T11:00:00.000Z'),
          _message('a', 'customer', '2026-09-01T10:00:00.000Z'),
        ],
        'nextCursor': null,
      }),
    );

    final messages = await built.source.messages('01JTHREAD00000000000000001');

    expect(messages.map((m) => m.id), ['a', 'b', 'c']);
    expect(messages.last.sender, MessageSide.owner);
  });

  test('a sent enquiry carries a client-generated ULID', () async {
    final built = _build((_) async => _json(_thread()));

    await built.source.messageBusiness(
      businessId: '01JBIZ0000000000000000000A',
      body: 'Do you have brass diyo?',
      subject: 'Stock',
      contactName: 'Kritika',
      contactEmail: 'k@example.com',
    );

    final body = built.adapter.requests.last.data! as Map<String, dynamic>;
    // Client-supplied so a retry after a dropped connection collapses onto one
    // row instead of posting the enquiry twice.
    expect(
      body['messageId'],
      matches(RegExp(r'^[0-7][0-9A-HJKMNP-TV-Z]{25}$')),
    );
    expect(body['body'], 'Do you have brass diyo?');
    expect(body['subject'], 'Stock');
    expect(body['contactEmail'], 'k@example.com');
  });

  test('two sends never reuse an id', () async {
    final built = _build((_) async => _json(_thread()));

    await built.source.reply(threadId: 't', body: 'one');
    await built.source.reply(threadId: 't', body: 'two');

    final ids = built.adapter.requests
        .map((r) => (r.data! as Map<String, dynamic>)['messageId'])
        .toSet();
    expect(ids, hasLength(2));
  });

  test('empty contact details are left out rather than sent blank', () async {
    final built = _build((_) async => _json(_thread()));

    await built.source.messageBusiness(
      businessId: '01JBIZ0000000000000000000A',
      body: 'hello',
    );

    final body = built.adapter.requests.last.data! as Map<String, dynamic>;
    expect(body.containsKey('subject'), isFalse);
    expect(body.containsKey('contactName'), isFalse);
    expect(body.containsKey('contactEmail'), isFalse);
  });

  test('the archived list is asked for explicitly', () async {
    final built = _build((_) async => _json([_thread()]));

    await built.source.threads(archived: true);
    expect(built.adapter.requests.last.uri.queryParameters['archived'], 'true');

    await built.source.threads();
    expect(built.adapter.requests.last.uri.queryParameters, isEmpty);
  });

  test('the unread badge survives a body without a count', () async {
    final built = _build((_) async => _json(const <String, dynamic>{}));

    expect(await built.source.unreadCount(), 0);
  });

  test('a thread the caller is not part of is reported as not found', () async {
    // The server answers a stranger with 404 rather than 403, so the app must
    // surface "no such conversation" and not a permission error.
    final built = _build(
      (_) async => _json({
        'error': {'kind': 'notFound', 'message': 'Thread not found'},
      }, status: 404),
    );

    expect(
      () => built.source.thread('01JTHREAD00000000000000001'),
      throwsA(isA<NotFoundException>()),
    );
  });
}
