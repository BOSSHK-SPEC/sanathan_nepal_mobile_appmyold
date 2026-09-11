import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';

/// Feature-local strings for the legal pages.
abstract class LegalStrings {
  const LegalStrings();

  static LegalStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get privacyPolicy;
  String get termsConditions;
  String get lastUpdated;
  String get documentLastUpdated;
}

class _En extends LegalStrings {
  const _En();
  @override
  String get privacyPolicy => 'Privacy Policy';
  @override
  String get termsConditions => 'Terms And Conditions';
  @override
  String get lastUpdated => 'Last updated';
  @override
  String get documentLastUpdated => 'This document was last updated on';
}

class _Ne extends LegalStrings {
  const _Ne();
  @override
  String get privacyPolicy => 'गोपनीयता नीति';
  @override
  String get termsConditions => 'नियम तथा सर्तहरू';
  @override
  String get lastUpdated => 'अन्तिम अद्यावधिक';
  @override
  String get documentLastUpdated =>
      'यो कागजात अन्तिम पटक अद्यावधिक गरिएको मिति';
}

class _Hi extends LegalStrings {
  const _Hi();
  @override
  String get privacyPolicy => 'गोपनीयता नीति';
  @override
  String get termsConditions => 'नियम और शर्तें';
  @override
  String get lastUpdated => 'अंतिम अद्यतन';
  @override
  String get documentLastUpdated => 'यह दस्तावेज़ अंतिम बार अद्यतन किया गया';
}
