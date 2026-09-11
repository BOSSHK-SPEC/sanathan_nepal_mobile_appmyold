import 'package:dio/dio.dart';

import 'media_bucket.dart';
import 'media_picker.dart';
import 'media_uploader.dart';
import 'picked_media.dart';

/// Pick-then-upload as one call.
///
/// Every upload point in the app wants the same sequence — choose a file,
/// validate it, send it, get an id back — so it lives here rather than being
/// reassembled in each form. Features depend on this and never on the picker
/// or the uploader directly.
class MediaService {
  const MediaService({
    required MediaPicker picker,
    required MediaUploader uploader,
  }) : _picker = picker,
       _uploader = uploader;

  final MediaPicker _picker;
  final MediaUploader _uploader;

  /// Chooses a file without uploading it.
  ///
  /// Separate from [upload] because progress must not be shown while the user
  /// is still browsing their photos — a spinner over the gallery says the app
  /// is busy when it is waiting.
  Future<PickedMedia?> pick({
    required MediaSource source,
    required MediaBucket bucket,
  }) => _picker.pick(source: source, bucket: bucket);

  /// Returns null when the user dismissed the picker; throws when the file was
  /// rejected or the upload failed, so callers can show one message.
  Future<UploadedMedia?> pickAndUpload({
    required MediaSource source,
    required MediaBucket bucket,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    final file = await _picker.pick(source: source, bucket: bucket);
    if (file == null) return null;

    return _uploader.upload(
      file: file,
      bucket: bucket,
      onProgress: onProgress,
      cancelToken: cancelToken,
    );
  }

  /// Uploads a file the caller already holds — used when several files are
  /// chosen at once, or when a retry re-sends the same bytes.
  Future<UploadedMedia> upload({
    required PickedMedia file,
    required MediaBucket bucket,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) => _uploader.upload(
    file: file,
    bucket: bucket,
    onProgress: onProgress,
    cancelToken: cancelToken,
  );
}
