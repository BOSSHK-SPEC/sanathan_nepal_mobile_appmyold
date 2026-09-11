part of 'system_strings.dart';

class _En extends SystemStrings {
  const _En();
  @override
  String get offlineTitle => 'No internet connection';
  @override
  String get offlineBody =>
      'Check your connection and try again. Anything already downloaded still works.';
  @override
  String get offlineStillWorks =>
      'Patro, panchanga and saved charts work offline.';
  @override
  String get retry => 'Try again';
  @override
  String get youAreOffline => 'You are offline';
  @override
  String get backOnline => 'Back online';
  @override
  String get updateRequiredTitle => 'Update to continue';
  @override
  String get updateRequiredBody =>
      'This version is no longer supported. Update to keep using the app.';
  @override
  String get updateAvailableTitle => 'A new version is available';
  @override
  String get updateAvailableBody =>
      'Update when you have a moment for the latest fixes.';
  @override
  String get updateNow => 'Update now';
  @override
  String get notNow => 'Not now';
  @override
  String get maintenanceTitle => 'Back shortly';
  @override
  String get maintenanceBody =>
      'We are carrying out planned maintenance. Nothing you have done is lost.';
  @override
  String get expectedBack => 'Expected back';
  @override
  String get signInRequiredTitle => 'Sign in to continue';
  @override
  String get signInRequiredBody =>
      'Consultations, your wallet and orders need an account.';
  @override
  String get signIn => 'Sign in';
  @override
  String get maybeLater => 'Keep browsing';
  @override
  String get freeToBrowse =>
      'Patro, panchanga, horoscope and festivals stay free.';
  @override
  String versionLine(String current, String latest) =>
      'Version $current → $latest';
}
