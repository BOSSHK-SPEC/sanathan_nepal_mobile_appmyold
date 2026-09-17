import 'package:web/web.dart' as web;

bool replaceLocation(String path) {
  final location = web.window.location;
  // Keep the query and the fragment: the landing page handles both (an old
  // `/#/console/payouts` bookmark is forwarded from there, `#yantra` scrolls).
  location.replace('$path${location.search}${location.hash}');
  return true;
}
