import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';

part 'system_strings_en.dart';
part 'system_strings_hi.dart';
part 'system_strings_ne.dart';

/// Feature-local strings for offline, upgrade, maintenance and sign-in
/// gating — the screens every app needs and no design remembers.
abstract class SystemStrings {
  const SystemStrings();

  static SystemStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  String get offlineTitle;
  String get offlineBody;
  String get offlineStillWorks;
  String get retry;
  String get youAreOffline;
  String get backOnline;

  String get updateRequiredTitle;
  String get updateRequiredBody;
  String get updateAvailableTitle;
  String get updateAvailableBody;
  String get updateNow;
  String get notNow;

  String get maintenanceTitle;
  String get maintenanceBody;
  String get expectedBack;

  String get signInRequiredTitle;
  String get signInRequiredBody;
  String get signIn;
  String get maybeLater;
  String get freeToBrowse;

  /// "Version 1.4.2 → 1.5.0"
  String versionLine(String current, String latest);
}
