import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/data/datasources/api_console_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/application.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/specialty.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);
  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<Object?> bodies = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    bodies.add(options.data);
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

Map<String, dynamic> _application() => {
  'id': '01JAPP00000000000000000000',
  'status': 'draft',
  'fullName': 'Ram Joshi',
  'phone': '+9779812345678',
  'ratePerMinute': {'chat': '2000', 'voice': '3500'},
  'headline': {'en': 'Vedic astrologer'},
  'about': {'en': 'A biography long enough to satisfy the credentials step.'},
  'languageCodes': ['ne', 'en'],
  'specialties': ['vedic'],
  'experienceYears': 12,
  // All three identity documents: the wizard requires front, back and a
  // selfie, and a step is only complete when none of its required files are
  // missing.
  // The server's own names for the slots — not the app's enum names.
  'documents': {
    'idFront': '01JMEDIA000000000000000001',
    'idBack': '01JMEDIA000000000000000002',
    'selfie': '01JMEDIA000000000000000003',
  },
  'termsVersion': '2026-09-01',
  'termsAcceptedAt': '2026-09-01T00:00:00.000Z',
  'submittedAt': null,
  'decisionNote': '',
};

void main() {
  late _StubAdapter adapter;
  late ApiConsoleDataSource source;

  setUp(() {
    adapter = _StubAdapter((_) async => _json(_application()));
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = adapter;
    source = ApiConsoleDataSource(client, () => 'en');
  });

  test('the wizard can be completed after a round trip', () async {
    final application = await source.application();

    // These two are what the identity and pricing steps gate on. Dropping
    // either in the mapping left every step but one incomplete, so "Submit"
    // stayed disabled with nothing on screen explaining why.
    expect(application.phone, '+9779812345678');
    expect(application.ratePerMinute, {
      ConsultChannel.chat: 20.0,
      ConsultChannel.voice: 35.0,
    });

    expect(application.identityComplete, isTrue);
    expect(application.credentialsComplete, isTrue);
    expect(application.expertiseComplete, isTrue);
    expect(application.pricingComplete, isTrue);
    expect(application.introductionComplete, isTrue);
    expect(application.canSubmit, isTrue);
  });

  test('a draft sends the contact number and the quoted rates', () async {
    await source.saveApplication(
      const AstrologerApplication(
        fullName: 'Ram Joshi',
        phone: '+9779812345678',
        bio: 'A biography long enough to satisfy the credentials step here.',
        experienceYears: 12,
        specialties: [Specialty.vedic],
        languageCodes: ['ne'],
        ratePerMinute: {ConsultChannel.chat: 20, ConsultChannel.video: 50},
      ),
    );

    final body = adapter.bodies.last! as Map<String, dynamic>;
    expect(body['phone'], '+9779812345678');
    // Minor units as integer strings, like every other money field.
    expect(body['ratePerMinute'], {'chat': '2000', 'video': '5000'});
  });

  test('an applicant who prices only one channel is still valid', () async {
    adapter = _StubAdapter(
      (_) async => _json({
        ..._application(),
        'ratePerMinute': {'chat': '1500'},
      }),
    );
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = adapter;
    source = ApiConsoleDataSource(client, () => 'en');

    final application = await source.application();

    // Not every astrologer offers video; requiring all three would block them.
    expect(application.ratePerMinute, {ConsultChannel.chat: 15.0});
    expect(application.pricingComplete, isTrue);
  });

  test('a zero rate is not treated as a price', () async {
    adapter = _StubAdapter(
      (_) async => _json({
        ..._application(),
        'ratePerMinute': {'chat': '0'},
      }),
    );
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = adapter;
    source = ApiConsoleDataSource(client, () => 'en');

    final application = await source.application();

    expect(application.ratePerMinute, isEmpty);
    expect(application.pricingComplete, isFalse);
    expect(application.canSubmit, isFalse);
  });

  group('KYC documents', () {
    test('a document is attached under the name the server accepts', () async {
      await source.uploadDocument(
        kind: KycDocumentKind.identityFront,
        fileRef: '01JMEDIA000000000000000009',
      );

      final body = adapter.bodies.last! as Map<String, dynamic>;
      // The app calls it identityFront; the server only knows idFront, and
      // rejected anything else — silently, as far as the wizard could tell.
      expect(body['kind'], 'idFront');
      expect(body['mediaId'], '01JMEDIA000000000000000009');
    });

    test('every slot the wizard offers has a name the server knows', () async {
      const accepted = {
        'idFront',
        'idBack',
        'selfie',
        'certificate',
        'addressProof',
      };

      for (final kind in KycDocumentKind.values) {
        await source.uploadDocument(kind: kind, fileRef: 'm');
        final body = adapter.bodies.last! as Map<String, dynamic>;
        expect(
          accepted,
          contains(body['kind']),
          reason: '${kind.name} sends "${body['kind']}"',
        );
      }
    });

    test('uploaded documents are read back onto their slots', () async {
      final application = await source.application();

      expect(
        application.documentFor(KycDocumentKind.identityFront).isSatisfied,
        isTrue,
      );
      expect(
        application.documentFor(KycDocumentKind.identityBack).isSatisfied,
        isTrue,
      );
      expect(application.missingForStep(KycStep.identity), isEmpty);
    });
  });

  group('draft saves', () {
    test('an untouched bio is not sent as an empty localized string', () async {
      await source.saveApplication(
        const AstrologerApplication(fullName: 'Ram', phone: '+9779812345678'),
      );

      final body = adapter.bodies.last! as Map<String, dynamic>;
      // The server rejects `{en: ''}` inside a localized field, so sending it
      // made every save on the first step fail — silently, at the time.
      expect(body.containsKey('headline'), isFalse);
      expect(body.containsKey('about'), isFalse);
      expect(body['fullName'], 'Ram');
    });

    test('a written bio is sent as headline and about', () async {
      await source.saveApplication(
        const AstrologerApplication(
          fullName: 'Ram',
          bio: 'Vedic astrologer. Fifteen years of practice in Kathmandu.',
        ),
      );

      final body = adapter.bodies.last! as Map<String, dynamic>;
      expect(body['headline'], {'en': 'Vedic astrologer'});
      expect(
        (body['about']! as Map)['en'],
        'Vedic astrologer. Fifteen years of practice in Kathmandu.',
      );
    });
  });
}
