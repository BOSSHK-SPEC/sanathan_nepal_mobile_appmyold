/// A web address as a person types it.
///
/// Mirrors `webUrlSchema` on the server, deliberately: the seller should be
/// told "that is not a web address" while the field is in front of them, not
/// after a round trip that fails the whole listing. The server still applies
/// the same rule — this is a courtesy, never the enforcement.
abstract final class WebUrl {
  const WebUrl._();

  static final RegExp _hasScheme = RegExp(r'^[a-zA-Z][a-zA-Z0-9+.\-]*://');
  static final RegExp _whitespace = RegExp(r'\s');

  /// The longest address the server will store.
  static const int maxLength = 500;

  /// A complete, openable URL — or null when [raw] cannot be one.
  ///
  /// `shop.com` becomes `https://shop.com`, because that is what someone means
  /// when they type it. A scheme that is not http(s) is refused rather than
  /// repaired: the app makes this tappable, and `javascript:` there would run
  /// a stranger's code on a buyer's phone.
  static String? normalize(String? raw) {
    final value = raw?.trim() ?? '';
    if (value.isEmpty || _whitespace.hasMatch(value)) return null;

    final withScheme = _hasScheme.hasMatch(value) ? value : 'https://$value';
    if (withScheme.length > maxLength) return null;

    final uri = Uri.tryParse(withScheme);
    if (uri == null) return null;
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;
    // A host with no dot is a LAN name or a typo, not a shop's website.
    if (!uri.host.contains('.')) return null;
    return withScheme;
  }

  /// Whether the field may be submitted. Empty is fine — the website is
  /// optional, and an empty optional field is not an error.
  static bool isAcceptable(String? raw) =>
      (raw?.trim().isEmpty ?? true) || normalize(raw) != null;
}
