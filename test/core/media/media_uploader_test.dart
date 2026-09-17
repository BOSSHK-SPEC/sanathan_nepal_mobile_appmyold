import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/media/media_bucket.dart';
import 'package:sanathan_nepal_mobile_app/core/media/media_uploader.dart';
import 'package:sanathan_nepal_mobile_app/core/media/picked_media.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);
  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<RequestOptions> seen = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    seen.add(options);
    // Drain the body the way a real transport would: Dio reports send
    // progress as the stream is pulled, so an adapter that ignores it would
    // make the progress callback look broken when it is not.
    await requestStream?.drain<void>();
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(int status, Object body) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

PickedMedia _image({int bytes = 2048, String mime = 'image/jpeg'}) =>
    PickedMedia(
      bytes: Uint8List.fromList(List.filled(bytes, 7)),
      name: 'photo.jpg',
      mimeType: mime,
    );

const _slot = {
  'mediaId': '01JMEDIA0000000000000000AA',
  'objectKey': 'user/abc.jpg',
  'uploadUrl':
      'http://storage.test/public-catalog/user/abc.jpg?X-Amz-Signature=x',
  'expiresInSeconds': 600,
  'requiredHeaders': {'Content-Type': 'image/jpeg', 'Content-Length': '2048'},
};

void main() {
  late _StubAdapter api;
  late _StubAdapter storage;
  late MediaUploaderImpl uploader;

  setUp(() {
    api = _StubAdapter((options) async {
      if (options.path.endsWith('/confirm')) {
        return _json(200, {
          'id': _slot['mediaId'],
          'bucket': 'publicCatalog',
          'mimeType': 'image/jpeg',
          'status': 'ready',
          'url': 'http://storage.test/public-catalog/user/abc.jpg',
        });
      }
      return _json(201, _slot);
    });
    storage = _StubAdapter((options) async => _json(200, {}));

    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = api;
    final storageDio = Dio()..httpClientAdapter = storage;
    uploader = MediaUploaderImpl(client: client, storageClient: storageDio);
  });

  test('slot, then bytes straight to storage, then confirm', () async {
    final result = await uploader.upload(
      file: _image(),
      bucket: MediaBucket.publicCatalog,
    );

    expect(api.seen.map((r) => r.path), [
      '/media/uploads',
      '/media/uploads/${_slot['mediaId']}/confirm',
    ]);
    // The bytes must not pass through the API — that is the whole point of a
    // presigned upload.
    expect(storage.seen.single.uri.host, 'storage.test');
    expect(storage.seen.single.method, 'PUT');
    expect(result.mediaId, _slot['mediaId']);
    expect(result.url, endsWith('abc.jpg'));
  });

  test('the storage PUT carries no Authorization header', () async {
    await uploader.upload(file: _image(), bucket: MediaBucket.publicCatalog);

    // A presigned URL authenticates through its query string. Sending our
    // bearer token as well makes S3 reject the request outright — "only one
    // auth mechanism allowed" — which is why this goes out on a bare client.
    final headers = storage.seen.single.headers;
    expect(headers.containsKey('Authorization'), isFalse);
    expect(headers['Content-Type'], 'image/jpeg');
    expect(headers[Headers.contentLengthHeader], 2048);
  });

  test('an oversized file never reaches the network', () async {
    await expectLater(
      uploader.upload(
        file: _image(bytes: MediaBucket.publicCatalog.maxBytes + 1),
        bucket: MediaBucket.publicCatalog,
      ),
      throwsA(isA<ValidationException>()),
    );

    // Failing fast is the point: uploading eight megabytes to be told no is a
    // minute of someone's data allowance.
    expect(api.seen, isEmpty);
    expect(storage.seen, isEmpty);
  });

  test('a PDF is refused by an image-only bucket', () async {
    await expectLater(
      uploader.upload(
        file: _image(mime: 'application/pdf'),
        bucket: MediaBucket.publicCatalog,
      ),
      throwsA(isA<ValidationException>()),
    );
    expect(api.seen, isEmpty);
  });

  test('a PDF is accepted by the documents bucket', () async {
    final result = await uploader.upload(
      file: _image(mime: 'application/pdf'),
      bucket: MediaBucket.privateDocs,
    );
    expect(result.mediaId, isNotEmpty);
  });

  test('an expired slot says so, and is not confirmed', () async {
    storage = _StubAdapter((options) async => _json(403, {}));
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = api;
    uploader = MediaUploaderImpl(
      client: client,
      storageClient: Dio()..httpClientAdapter = storage,
    );

    await expectLater(
      uploader.upload(file: _image(), bucket: MediaBucket.publicCatalog),
      throwsA(
        isA<ServerException>().having(
          (e) => e.message,
          'message',
          contains('expired'),
        ),
      ),
    );
    // Confirming an upload that never landed would mark a missing object ready.
    expect(api.seen.where((r) => r.path.endsWith('/confirm')), isEmpty);
  });

  test('progress is reported while the bytes go out', () async {
    final seen = <double>[];
    await uploader.upload(
      file: _image(),
      bucket: MediaBucket.publicCatalog,
      onProgress: seen.add,
    );

    expect(seen, isNotEmpty);
    expect(seen.last, 1.0);
    expect(seen.every((p) => p >= 0 && p <= 1), isTrue);
  });

  group('unreachable storage host', () {
    /// Builds an uploader whose API is at [apiBaseUrl] and whose upload slot
    /// points at [uploadUrl].
    MediaUploaderImpl uploaderFor({
      required String apiBaseUrl,
      required String uploadUrl,
    }) {
      final slotApi = _StubAdapter((options) async {
        if (options.path.endsWith('/confirm')) {
          return _json(200, {'id': _slot['mediaId'], 'url': ''});
        }
        return _json(201, {..._slot, 'uploadUrl': uploadUrl});
      });
      final client = ApiClient(baseUrl: '$apiBaseUrl/api/v1')
        ..dio.httpClientAdapter = slotApi;
      return MediaUploaderImpl(
        client: client,
        // Never reached in these tests — the point is that it must not be.
        storageClient: Dio()..httpClientAdapter = storage,
        apiBaseUrl: apiBaseUrl,
      );
    }

    test('a remote API handing back a loopback URL fails immediately', () async {
      // The production bug: S3_PUBLIC_ENDPOINT was left at 127.0.0.1, so every
      // device was told to PUT to itself. With no timeout on the storage client
      // that hung forever and showed nothing — a spinner that never resolves.
      final uploader = uploaderFor(
        apiBaseUrl: 'https://api.example.com',
        uploadUrl:
            'http://127.0.0.1:9000/public-catalog/a.jpg?X-Amz-Signature=x',
      );

      await expectLater(
        uploader.upload(file: _image(), bucket: MediaBucket.publicCatalog),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            contains('not set up'),
          ),
        ),
      );
      // It must fail before any bytes are sent, not after a timeout.
      expect(storage.seen, isEmpty);
    });

    test('localhost storage is fine when the API is local too', () async {
      // The dev stack: API on localhost:3100, MinIO on localhost:9000. Blanket
      // rejection of loopback would break every developer's machine.
      final uploader = uploaderFor(
        apiBaseUrl: 'http://localhost:3100',
        uploadUrl:
            'http://localhost:9000/public-catalog/a.jpg?X-Amz-Signature=x',
      );

      await uploader.upload(file: _image(), bucket: MediaBucket.publicCatalog);

      expect(storage.seen, hasLength(1));
    });

    test('a public storage host is always allowed', () async {
      final uploader = uploaderFor(
        apiBaseUrl: 'https://api.example.com',
        uploadUrl:
            'https://files.example.com/public-catalog/a.jpg?X-Amz-Signature=x',
      );

      await uploader.upload(file: _image(), bucket: MediaBucket.publicCatalog);

      expect(storage.seen, hasLength(1));
    });

    test('a malformed slot URL is rejected rather than dialled', () async {
      final uploader = uploaderFor(
        apiBaseUrl: 'https://api.example.com',
        uploadUrl: 'not-a-url',
      );

      await expectLater(
        uploader.upload(file: _image(), bucket: MediaBucket.publicCatalog),
        throwsA(isA<ServerException>()),
      );
      expect(storage.seen, isEmpty);
    });
  });

  test(
    'the storage client has timeouts so a dead host cannot hang forever',
    () {
      // A bare Dio() has none at all, which is what turned a misconfigured
      // endpoint into an infinite spinner instead of an error.
      final dio = MediaUploaderImpl(
        client: ApiClient(baseUrl: 'http://localhost/api/v1'),
      ).debugStorageOptions;

      expect(dio.connectTimeout, isNotNull);
      expect(dio.sendTimeout, isNotNull);
      expect(dio.receiveTimeout, isNotNull);
    },
  );
}
