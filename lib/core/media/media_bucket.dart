/// Where an upload lands, and what the server will accept into it.
///
/// The limits mirror the server's `BUCKET_RULES` exactly. Duplicating them
/// here is deliberate: checking before the upload starts turns "your 40 MB
/// photo was rejected after a two-minute upload" into an instant, specific
/// message, and it is the difference between a picker that feels considered
/// and one that feels broken. The server still enforces its own copy — this is
/// courtesy, not security.
enum MediaBucket {
  /// Product photos and anything else shown to every user.
  publicCatalog(
    wire: 'publicCatalog',
    maxBytes: 8 * 1024 * 1024,
    mimeTypes: {'image/jpeg', 'image/png', 'image/webp'},
  ),

  /// Avatars, chat attachments, review photos — owner-readable.
  userMedia(
    wire: 'userMedia',
    maxBytes: 8 * 1024 * 1024,
    mimeTypes: {'image/jpeg', 'image/png', 'image/webp'},
  ),

  /// KYC documents and business papers. Never public.
  ///
  /// The server also accepts PDFs here — the app photographs documents rather
  /// than attaching them, but the bucket does not need to know that.
  privateDocs(
    wire: 'privateDocs',
    maxBytes: 16 * 1024 * 1024,
    mimeTypes: {'image/jpeg', 'image/png', 'application/pdf'},
  );

  const MediaBucket({
    required this.wire,
    required this.maxBytes,
    required this.mimeTypes,
  });

  /// The value the API expects.
  final String wire;
  final int maxBytes;
  final Set<String> mimeTypes;

  bool accepts(String mimeType) => mimeTypes.contains(mimeType);

  /// "8 MB" — for the message shown when a file is too big.
  String get maxSizeLabel => '${maxBytes ~/ (1024 * 1024)} MB';
}
