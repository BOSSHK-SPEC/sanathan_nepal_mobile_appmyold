import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';
import '../config/app_environment.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../network/api_guard.dart';
import 'media_bucket.dart';
import 'picked_media.dart';

/// A file the server has accepted and is ready to be referenced.
class UploadedMedia {
  const UploadedMedia({
    required this.mediaId,
    required this.url,
    required this.mimeType,
  });

  /// What features store — an id the server can always resolve, unlike a URL
  /// that may be signed and expire.
  final String mediaId;

  /// Durable URL for public objects; empty for private ones, which are read
  /// through a short-lived signed download instead.
  final String url;
  final String mimeType;

  bool get hasPublicUrl => url.isNotEmpty;
}

/// Uploads a picked file to object storage.
///
/// Three steps, and the shape matters:
///
///  1. ask the API for a slot — it validates type and size, records a
///     `pending` row and signs a URL;
///  2. PUT the bytes **straight to storage**, so a photo-heavy marketplace
///     never pushes image traffic through the API;
///  3. confirm, which flips the row to `ready` (and in production is where
///     scanning and derivative generation are triggered).
///
/// An abandoned upload leaves a `pending` row for a sweeper rather than an
/// orphan blob nothing knows about.
abstract interface class MediaUploader {
  /// Uploads [file] and returns the stored object.
  ///
  /// [onProgress] receives 0.0–1.0 for the byte transfer, which is the only
  /// part slow enough to be worth showing.
  Future<UploadedMedia> upload({
    required PickedMedia file,
    required MediaBucket bucket,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  });
}

class MediaUploaderImpl implements MediaUploader {
  MediaUploaderImpl({
    required ApiClient client,
    Dio? storageClient,
    String? apiBaseUrl,
  }) : _client = client,
       _storage = storageClient ?? Dio(_storageOptions),
       _apiBaseUrl = apiBaseUrl ?? AppEnvironment.apiBaseUrl;

  /// Timeouts for the storage PUT.
  ///
  /// A bare `Dio()` has **no** timeouts at all, so a presigned URL pointing
  /// somewhere unreachable left the spinner turning forever with nothing
  /// logged and nothing shown — the failure mode that looks like "upload is
  /// broken" and cannot be diagnosed from the app.
  ///
  /// `sendTimeout` is per-chunk rather than total, so it can be generous
  /// enough for a large photo on a slow connection while still catching a
  /// connection that has silently died.
  static final BaseOptions _storageOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(minutes: 2),
    receiveTimeout: const Duration(seconds: 30),
    validateStatus: (status) => status != null && status < 400,
  );

  final ApiClient _client;

  /// Where this build's API lives. Injected rather than read from
  /// [AppEnvironment] at the point of use, so the loopback rule below can
  /// be tested for both a local and a remote deployment.
  final String _apiBaseUrl;

  /// A bare Dio for the storage PUT.
  ///
  /// It must not carry our interceptors: a presigned URL already authenticates
  /// the request through its query string, and S3 rejects a request that also
  /// carries an `Authorization` header with "only one auth mechanism allowed".
  /// The retry interceptor would be wrong here too — replaying a PUT against a
  /// URL whose signature may have expired just turns one failure into three.
  final Dio _storage;

  @override
  Future<UploadedMedia> upload({
    required PickedMedia file,
    required MediaBucket bucket,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    // Checked here as well as in the picker: features can construct a
    // PickedMedia directly, and the wasted round trip is worth avoiding.
    if (!bucket.accepts(file.mimeType)) {
      throw const ValidationException(
        'That file type cannot be uploaded here.',
        'file',
      );
    }
    if (file.sizeBytes > bucket.maxBytes) {
      throw ValidationException(
        'That file is ${file.sizeLabel}. The limit is ${bucket.maxSizeLabel}.',
        'file',
      );
    }

    final slot = await _createSlot(file, bucket);
    await _putBytes(
      slot,
      file,
      onProgress: onProgress,
      cancelToken: cancelToken,
    );
    return _confirm(slot.mediaId);
  }

  Future<_UploadSlot> _createSlot(PickedMedia file, MediaBucket bucket) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.mediaUploads,
          data: {
            'bucket': bucket.wire,
            'mimeType': file.mimeType,
            'sizeBytes': file.sizeBytes,
          },
        );
        final json = asJsonMap(response);

        final mediaId = json['mediaId'] as String?;
        final uploadUrl = json['uploadUrl'] as String?;
        if (mediaId == null || uploadUrl == null) {
          throw const ServerException('Upload slot was missing its URL');
        }

        _assertReachable(uploadUrl);

        return _UploadSlot(
          mediaId: mediaId,
          uploadUrl: uploadUrl,
          headers: {
            for (final entry in (json['requiredHeaders'] as Map? ?? {}).entries)
              entry.key.toString(): entry.value.toString(),
          },
        );
      });

  /// Refuses a presigned URL this device could never reach.
  ///
  /// Object storage signs its URLs against a host, and that host has to be one
  /// the *client* can dial. A server whose `S3_PUBLIC_ENDPOINT` still points at
  /// its own loopback address hands every phone a URL for the phone itself —
  /// which is not a request that fails, it is a request that hangs until the
  /// timeout, on every upload, with nothing to go on.
  ///
  /// Loopback is only rejected when the API itself is remote. Against a local
  /// dev stack, storage on `localhost` is exactly right.
  void _assertReachable(String uploadUrl) {
    final storage = Uri.tryParse(uploadUrl);
    if (storage == null || storage.host.isEmpty) {
      throw const ServerException('Upload slot returned a malformed URL');
    }
    if (!_isLoopback(storage.host)) return;

    final api = Uri.tryParse(_apiBaseUrl);
    if (api != null && _isLoopback(api.host)) return;

    throw const ServerException(
      'Photo uploads are not set up on this server yet. '
      'Storage returned a local address that this device cannot reach.',
    );
  }

  static bool _isLoopback(String host) =>
      host == 'localhost' ||
      host == '127.0.0.1' ||
      host == '0.0.0.0' ||
      host == '::1' ||
      host == '[::1]';

  /// The storage client's options, so a test can assert the timeouts exist.
  @visibleForTesting
  BaseOptions get debugStorageOptions => _storage.options;

  Future<void> _putBytes(
    _UploadSlot slot,
    PickedMedia file, {
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      await _storage.putUri<void>(
        Uri.parse(slot.uploadUrl),
        data: Stream<List<int>>.value(file.bytes),
        cancelToken: cancelToken,
        options: Options(
          // Exactly what the server signed. Sending anything else — a
          // different content type, a missing length — invalidates the
          // signature and storage answers 403.
          headers: {
            ...slot.headers,
            Headers.contentLengthHeader: file.sizeBytes,
          },
          contentType: file.mimeType,
        ),
        onSendProgress: onProgress == null
            ? null
            : (sent, total) => onProgress(total <= 0 ? 0 : sent / total),
      );
    } on DioException catch (error) {
      throw _storageFailure(error);
    }
  }

  Future<UploadedMedia> _confirm(String mediaId) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.mediaConfirm(mediaId),
    );
    final json = asJsonMap(response);
    return UploadedMedia(
      mediaId: json['id'] as String? ?? mediaId,
      url: json['url'] as String? ?? '',
      mimeType: json['mimeType'] as String? ?? '',
    );
  });

  /// Storage speaks S3, not our error envelope, so its failures are mapped by
  /// hand into something a user can act on.
  static Exception _storageFailure(DioException error) {
    if (CancelToken.isCancel(error)) {
      return const CacheException('Upload cancelled');
    }
    final status = error.response?.statusCode;
    if (status == 403) {
      // Almost always an expired slot: the user sat on the picker for longer
      // than the ten minutes the URL is good for.
      return const ServerException(
        'That upload link expired. Please try again.',
        403,
      );
    }
    if (status != null && status >= 400) {
      return ServerException('Storage rejected the file', status);
    }
    return NetworkException(
      error.message ?? 'The upload could not reach storage',
    );
  }
}

class _UploadSlot {
  const _UploadSlot({
    required this.mediaId,
    required this.uploadUrl,
    required this.headers,
  });

  final String mediaId;
  final String uploadUrl;
  final Map<String, String> headers;
}
