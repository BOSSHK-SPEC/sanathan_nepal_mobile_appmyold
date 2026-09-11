import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';

/// Home-feature strings (feature-scoped, ne / en / hi).
abstract class HomeStrings {
  const HomeStrings();
  static HomeStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get title;
  String get defaultCalendarView;
  String get goldSilverToday;
  String get gold;
  String get silver;

  /// "/tola", "/10 g" – [unit] is `RegionConfig.metalUnitEn/Local`.
  String perUnit(String unit);
}

class _En extends HomeStrings {
  const _En();
  @override
  String get title => 'Home';
  @override
  String get defaultCalendarView => 'Default calendar view';
  @override
  String get goldSilverToday => "Today's gold & silver rate";
  @override
  String get gold => 'Gold';
  @override
  String get silver => 'Silver';
  @override
  String perUnit(String unit) => '/$unit';
}

class _Ne extends HomeStrings {
  const _Ne();
  @override
  String get title => 'गृहपृष्ठ';
  @override
  String get defaultCalendarView => 'पूर्वनिर्धारित क्यालेन्डर दृश्य';
  @override
  String get goldSilverToday => 'आजको सुन, चाँदीको दर';
  @override
  String get gold => 'सुन';
  @override
  String get silver => 'चाँदी';
  @override
  String perUnit(String unit) => '/$unit';
}

class _Hi extends HomeStrings {
  const _Hi();
  @override
  String get title => 'होम';
  @override
  String get defaultCalendarView => 'डिफ़ॉल्ट कैलेंडर दृश्य';
  @override
  String get goldSilverToday => 'आज का सोना-चाँदी भाव';
  @override
  String get gold => 'सोना';
  @override
  String get silver => 'चाँदी';
  @override
  String perUnit(String unit) => '/$unit';
}
