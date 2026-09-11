import 'package:url_launcher/url_launcher.dart';

/// Hand-offs to the phone: dialler, WhatsApp, mail client, browser.
///
/// One place rather than a `launchUrl` at each call site, because the part
/// that is easy to get wrong is the same everywhere: a number typed by a shop
/// owner arrives with spaces, dashes and brackets in it, and `tel:+977 98-41`
/// silently fails to open the dialler on Android.
abstract final class ExternalLinks {
  const ExternalLinks._();

  /// Strips everything a dialler cannot use, keeping a leading `+`.
  static String normalisePhone(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.isEmpty) return '';
    // A `+` is only meaningful in front; one in the middle is a typo.
    final plus = digits.startsWith('+');
    final bare = digits.replaceAll('+', '');
    if (bare.isEmpty) return '';
    return plus ? '+$bare' : bare;
  }

  /// Opens the dialler. Returns false when there is no number or no app for it.
  static Future<bool> call(String phone) {
    final number = normalisePhone(phone);
    if (number.isEmpty) return Future.value(false);
    return _open(Uri(scheme: 'tel', path: number));
  }

  /// Opens a WhatsApp chat. `wa.me` needs the number without a `+`.
  static Future<bool> whatsapp(String phone, {String message = ''}) {
    final number = normalisePhone(phone).replaceAll('+', '');
    if (number.isEmpty) return Future.value(false);
    return _open(
      Uri.https(
        'wa.me',
        '/$number',
        message.isEmpty ? null : {'text': message},
      ),
    );
  }

  static Future<bool> email(String address, {String subject = ''}) {
    if (address.isEmpty) return Future.value(false);
    return _open(
      Uri(
        scheme: 'mailto',
        path: address,
        query: subject.isEmpty
            ? null
            : 'subject=${Uri.encodeComponent(subject)}',
      ),
    );
  }

  /// Opens a website, tolerating an address a shop owner typed without a
  /// scheme (`www.example.com`), which `Uri.parse` would otherwise treat as a
  /// relative path and fail to launch.
  static Future<bool> website(String url) {
    if (url.trim().isEmpty) return Future.value(false);
    final trimmed = url.trim();
    final uri = Uri.tryParse(
      trimmed.contains('://') ? trimmed : 'https://$trimmed',
    );
    if (uri == null) return Future.value(false);
    return _open(uri);
  }

  static Future<bool> _open(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Object {
      // A missing handler (no dialler on a tablet, no WhatsApp installed)
      // throws. The caller shows a message; it is not a crash.
      return false;
    }
  }
}
