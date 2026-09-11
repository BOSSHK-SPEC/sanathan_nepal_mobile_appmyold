import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';

/// Feature-local strings for the date converter screen.
abstract class DateConverterStrings {
  const DateConverterStrings();

  static DateConverterStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get title;

  /// "B.S. to A.D." – [era] is the traditional calendar's era label
  /// (`TraditionalCalendar.eraLabel`: वि.सं. / B.S. / Saka / शक).
  String toGregorian(String era);

  /// "A.D. to B.S."
  String toTraditional(String era);
  String get cancel;
  String get convert;
  String get addEventReminder;
  String get sunrise;
  String get sunset;
  String get holiday;
  String get panchanga;
  String get vikramSamvat;
  String get difference;
  String get daysFromToday;
  String get daysAgo;
  String get daysAhead;
  String get isToday;
  String get age;
  String get years;
  String get months;
  String get days;
  String get ads;
  String get conversionFailed;
}

class _Ne extends DateConverterStrings {
  const _Ne();
  @override
  String get title => 'मिति परिवर्तन';
  @override
  String toGregorian(String era) => '$era बाट ई.सं.';
  @override
  String toTraditional(String era) => 'ई.सं. बाट $era';
  @override
  String get cancel => 'रद्द गर्नुहोस्';
  @override
  String get convert => 'परिवर्तन गर्नुहोस्';
  @override
  String get addEventReminder => 'कार्यक्रम रिमाइन्डर थप्नुहोस्';
  @override
  String get sunrise => 'सूर्योदय';
  @override
  String get sunset => 'सूर्यास्त';
  @override
  String get holiday => 'बिदा';
  @override
  String get panchanga => 'पञ्चाङ्ग';
  @override
  String get vikramSamvat => 'विक्रम संवत्';
  @override
  String get difference => 'आजसँगको अन्तर';
  @override
  String get daysFromToday => 'दिन';
  @override
  String get daysAgo => 'दिन अघि';
  @override
  String get daysAhead => 'दिन पछि';
  @override
  String get isToday => 'आजकै मिति';
  @override
  String get age => 'उमेर / अवधि';
  @override
  String get years => 'वर्ष';
  @override
  String get months => 'महिना';
  @override
  String get days => 'दिन';
  @override
  String get ads => 'HOME BELOW EVENT ADS';
  @override
  String get conversionFailed => 'मिति परिवर्तन गर्न सकिएन';
}

class _En extends DateConverterStrings {
  const _En();
  @override
  String get title => 'Date Converter';
  @override
  String toGregorian(String era) => '$era to A.D.';
  @override
  String toTraditional(String era) => 'A.D. to $era';
  @override
  String get cancel => 'Cancel';
  @override
  String get convert => 'Convert';
  @override
  String get addEventReminder => 'Add Event Reminder';
  @override
  String get sunrise => 'Sunrise';
  @override
  String get sunset => 'Sunset';
  @override
  String get holiday => 'Holiday';
  @override
  String get panchanga => 'Panchanga';
  @override
  String get vikramSamvat => 'Vikram Samvat';
  @override
  String get difference => 'Difference from today';
  @override
  String get daysFromToday => 'days';
  @override
  String get daysAgo => 'days ago';
  @override
  String get daysAhead => 'days ahead';
  @override
  String get isToday => 'This is today';
  @override
  String get age => 'Age / duration';
  @override
  String get years => 'years';
  @override
  String get months => 'months';
  @override
  String get days => 'days';
  @override
  String get ads => 'HOME BELOW EVENT ADS';
  @override
  String get conversionFailed => 'Could not convert the date';
}

class _Hi extends DateConverterStrings {
  const _Hi();
  @override
  String get title => 'तिथि परिवर्तक';
  @override
  String toGregorian(String era) => '$era से ई.सं.';
  @override
  String toTraditional(String era) => 'ई.सं. से $era';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get convert => 'परिवर्तित करें';
  @override
  String get addEventReminder => 'कार्यक्रम रिमाइंडर जोड़ें';
  @override
  String get sunrise => 'सूर्योदय';
  @override
  String get sunset => 'सूर्यास्त';
  @override
  String get holiday => 'अवकाश';
  @override
  String get panchanga => 'पंचांग';
  @override
  String get vikramSamvat => 'विक्रम संवत्';
  @override
  String get difference => 'आज से अंतर';
  @override
  String get daysFromToday => 'दिन';
  @override
  String get daysAgo => 'दिन पहले';
  @override
  String get daysAhead => 'दिन बाद';
  @override
  String get isToday => 'आज की तिथि';
  @override
  String get age => 'आयु / अवधि';
  @override
  String get years => 'वर्ष';
  @override
  String get months => 'महीने';
  @override
  String get days => 'दिन';
  @override
  String get ads => 'HOME BELOW EVENT ADS';
  @override
  String get conversionFailed => 'तिथि परिवर्तित नहीं हो सकी';
}
