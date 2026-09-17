import 'landing_site_stub.dart'
    if (dart.library.js_interop) 'landing_site_web.dart'
    as impl;

/// The public static site (`landing/`: the 3D landing page, the Privacy Policy
/// and Delete account), built into `web/welcome/` so it ships inside every
/// console build and is served by `flutter run` too.
///
/// Deliberately not `/landing/`: `flutter run`'s dev server also serves the
/// project root, so a URL matching a source folder returns the *unbuilt*
/// `landing/index.html`. `test/admin/landing_site_test.dart` keeps it that way.
const String landingSitePath = '/welcome/index.html';

/// Public paths that belong to the static site rather than the console, and
/// the page each one is.
const Map<String, String> _publicPages = {
  '': landingSitePath,
  '/': landingSitePath,
  '/privacy': '/welcome/privacy/index.html',
  '/privacy/': '/welcome/privacy/index.html',
  '/delete-account': '/welcome/delete-account/index.html',
  '/delete-account/': '/welcome/delete-account/index.html',
};

/// Where the static site's file for [location] lives, if [location] is a page
/// of the static site rather than a console route; null otherwise.
///
/// In production nginx serves these paths before Flutter is ever fetched; this
/// covers every other way the app can be opened at one of them — `flutter run`,
/// `flutter build web` served by anything else, or a server whose nginx config
/// has not been updated yet. It also turns folder URLs such as `/welcome/kn/`
/// (which the language menu produces) into their `index.html`, for servers
/// that do not resolve folder indexes.
String? landingTargetFor(Uri location) {
  final path = location.path;
  final page = _publicPages[path];
  if (page != null) return page;
  if (path.startsWith('/welcome/') && !path.endsWith('.html')) {
    final lastSegment = path.split('/').last;
    if (lastSegment.contains('.')) return null; // a real asset, not a page
    return path.endsWith('/') ? '${path}index.html' : '$path/index.html';
  }
  return null;
}

/// Replaces the current page with [target] (from [landingTargetFor]),
/// keeping the query and fragment. `replace`, not a navigation, so Back does
/// not return to the console URL and bounce straight here again. Returns false
/// where there is no browser page to replace (tests, mobile).
bool openLandingSite(String target) => impl.replaceLocation(target);
