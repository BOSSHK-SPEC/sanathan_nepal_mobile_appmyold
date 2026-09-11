import 'package:image_picker/image_picker.dart';

import '../error/exceptions.dart';
import 'media_bucket.dart';
import 'picked_media.dart';

/// Where the user takes a file from.
enum MediaSource { camera, gallery }

/// Chooses a file from the camera, the gallery or the file browser.
///
/// An interface rather than a direct call to the plugins so the pages above it
/// can be widget-tested without a platform channel: a picker that needs a real
/// camera makes "the form saves what was picked" untestable.
abstract interface class MediaPicker {
  /// Returns the chosen file, or null when the user backed out.
  ///
  /// Throws [ValidationException] when the file breaks [bucket]'s rules, and
  /// [PermissionException] when the OS denied access.
  Future<PickedMedia?> pick({
    required MediaSource source,
    required MediaBucket bucket,
  });
}

class MediaPickerImpl implements MediaPicker {
  MediaPickerImpl({ImagePicker? images}) : _images = images ?? ImagePicker();

  final ImagePicker _images;

  /// Long edge cap for camera and gallery images.
  ///
  /// A modern phone camera produces 12 MP files of 5–8 MB; nothing in this app
  /// displays an image wider than a phone screen, so uploading the original
  /// would spend a rural user's data on pixels that are then thrown away. 1600
  /// px still looks sharp on a 3x display and lands well inside the 8 MB cap.
  static const double _maxDimension = 1600;
  static const int _quality = 85;

  @override
  Future<PickedMedia?> pick({
    required MediaSource source,
    required MediaBucket bucket,
  }) async {
    final picked = switch (source) {
      MediaSource.camera => await _fromCamera(),
      MediaSource.gallery => await _fromGallery(),
    };
    if (picked == null) return null;

    if (!bucket.accepts(picked.mimeType)) {
      throw ValidationException(
        'That file type is not supported here. '
            'Choose ${_readableTypes(bucket)}.',
        'file',
      );
    }
    if (picked.sizeBytes > bucket.maxBytes) {
      throw ValidationException(
        'That file is ${picked.sizeLabel}. The limit is ${bucket.maxSizeLabel}.',
        'file',
      );
    }
    if (picked.sizeBytes == 0) {
      throw const ValidationException('That file is empty.', 'file');
    }
    return picked;
  }

  Future<PickedMedia?> _fromCamera() => _image(ImageSource.camera);

  Future<PickedMedia?> _fromGallery() => _image(ImageSource.gallery);

  Future<PickedMedia?> _image(ImageSource source) async {
    final XFile? file;
    try {
      file = await _images.pickImage(
        source: source,
        maxWidth: _maxDimension,
        maxHeight: _maxDimension,
        imageQuality: _quality,
      );
    } on Exception catch (error) {
      throw _asDomainException(error);
    }
    if (file == null) return null;

    return PickedMedia(
      bytes: await file.readAsBytes(),
      name: file.name,
      // The plugin re-encodes when it resizes, so the extension is the honest
      // signal; `file.mimeType` is often null on Android.
      mimeType: file.mimeType ?? _mimeFromName(file.name),
    );
  }

  /// Type from the file name. The OS is not consistent about reporting one,
  /// and the server signs the upload against whatever we declare — so an
  /// honest guess from the extension beats a confident wrong header.
  static String _mimeFromName(String name) {
    final extension = name.split('.').last.toLowerCase();
    return switch (extension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      'pdf' => 'application/pdf',
      'heic' || 'heif' => 'image/heic',
      _ => 'application/octet-stream',
    };
  }

  static String _readableTypes(MediaBucket bucket) {
    final names =
        bucket.mimeTypes
            .map(
              (m) => m == 'application/pdf'
                  ? 'PDF'
                  : m.split('/').last.toUpperCase(),
            )
            .toList()
          ..sort();
    if (names.length == 1) return names.single;
    return '${names.take(names.length - 1).join(', ')} or ${names.last}';
  }

  /// Plugin errors are platform strings; the app only cares about the one the
  /// user can act on — a permission they declined.
  static Exception _asDomainException(Exception error) {
    final message = error.toString().toLowerCase();
    if (message.contains('permission') || message.contains('denied')) {
      return const PermissionException(
        'Allow access to your camera and photos in Settings to add a file.',
      );
    }
    return CacheException('Could not read that file: $error');
  }
}
