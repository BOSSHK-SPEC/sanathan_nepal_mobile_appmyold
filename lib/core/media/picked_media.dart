import 'dart:typed_data';

/// A file the user chose, in memory and ready to upload.
///
/// Bytes rather than a path: on Android a gallery pick is a content URI that
/// may not have a readable path at all, and the upload needs the exact length
/// up front because the server signs `Content-Length` into the URL.
class PickedMedia {
  const PickedMedia({
    required this.bytes,
    required this.name,
    required this.mimeType,
  });

  final Uint8List bytes;

  /// Original file name, kept for display only — the server assigns the key.
  final String name;
  final String mimeType;

  int get sizeBytes => bytes.length;

  /// "2.4 MB" / "812 KB", for size errors and upload rows.
  String get sizeLabel {
    const kb = 1024;
    if (sizeBytes < kb) return '$sizeBytes B';
    if (sizeBytes < kb * kb) return '${(sizeBytes / kb).toStringAsFixed(0)} KB';
    return '${(sizeBytes / (kb * kb)).toStringAsFixed(1)} MB';
  }

  bool get isImage => mimeType.startsWith('image/');
}
