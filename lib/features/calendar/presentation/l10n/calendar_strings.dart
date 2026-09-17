import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/day_panchanga.dart';

/// Feature-local strings for the Patro (calendar) screens.
abstract class CalendarStrings {
  const CalendarStrings();

  static CalendarStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get title;
  String get today;

  /// Gregorian era label for the view toggle ("ई.सं." / "A.D."). The
  /// traditional label comes from `TraditionalCalendar.eraLabel`.
  String get gregorian;
  String get defaultCalendarView;
  String get events;
  String get noEvents;
  String get holiday;
  String get todayChip;
  String get panchanga;
  String get moreInfo;
  String get day;
  String get nakshatra;
  String get tithi;
  String get karan;
  String get yog;
  String get subhaSait;
  String get pleaseLogin;
  String get selectDate;
  String get selectMonth;
  String get cancel;
  String get confirm;
  String get patroAds;
  String get sunrise;
  String get sunset;
  String get featureImage;
  String get eventDetails;
  String get loadFailed;

  /// Shown beside panchanga values that are the on-device estimate.
  String get approximateNote;

  /// "until 07:22" — when the day's tithi ends.
  String until(String time);
  String get moonSign;
  String get adhika;
  String get addReminder;
  String get share;

  /// No panel has published an auspicious time for this day.
  String get noSaitsForDay;
  String get saitsUnavailable;
  String get vratDays;
  String get noVratDays;
  String get filterAll;
  String get legendEvent;

  String vrat(VratKind kind);
}

class _Ne extends CalendarStrings {
  const _Ne();
  @override
  String get approximateNote =>
      'अनुमानित मान — इन्टरनेटमा जोडिएपछि सटीक पञ्चाङ्ग देखिनेछ।';
  @override
  String until(String time) => '$time सम्म';
  @override
  String get moonSign => 'चन्द्रराशि';
  @override
  String get adhika => 'अधिक';
  @override
  String get addReminder => 'रिमाइन्डर थप्नुहोस्';
  @override
  String get share => 'सेयर';
  @override
  String get noSaitsForDay => 'यस दिनका लागि कुनै शुभ साइत प्रकाशित भएको छैन।';
  @override
  String get saitsUnavailable => 'शुभ साइत लोड गर्न सकिएन।';
  @override
  String get vratDays => 'व्रत';
  @override
  String get noVratDays => 'यो महिना कुनै व्रत छैन।';
  @override
  String get filterAll => 'सबै';
  @override
  String get legendEvent => 'कार्यक्रम भएको दिन';
  @override
  String vrat(VratKind kind) => switch (kind) {
    VratKind.ekadashi => 'एकादशी',
    VratKind.purnima => 'पूर्णिमा',
    VratKind.amavasya => 'औंसी',
  };
  @override
  String get title => 'पात्रो';
  @override
  String get today => 'आज';
  @override
  String get gregorian => 'ई.सं.';
  @override
  String get defaultCalendarView => 'पूर्वनिर्धारित क्यालेन्डर दृश्य';
  @override
  String get events => 'कार्यक्रमहरू';
  @override
  String get noEvents => 'कार्यक्रम उपलब्ध छैन |';
  @override
  String get holiday => 'बिदा';
  @override
  String get todayChip => 'आज';
  @override
  String get panchanga => 'पञ्चाङ्ग';
  @override
  String get moreInfo => 'थप जानकारी';
  @override
  String get day => 'दिन';
  @override
  String get nakshatra => 'नक्षत्र';
  @override
  String get tithi => 'तिथि';
  @override
  String get karan => 'करण';
  @override
  String get yog => 'योग';
  @override
  String get subhaSait => 'शुभ साइत';
  @override
  String get pleaseLogin => 'कृपया लग-इन गर्नुहोस्';
  @override
  String get selectDate => 'मिति छान्नुहोस्';
  @override
  String get selectMonth => 'महिना छान्नुहोस्';
  @override
  String get cancel => 'छाड्नुहोस्';
  @override
  String get confirm => 'छान्नुहोस्';
  @override
  String get patroAds => 'PATRO PAGE ADS';
  @override
  String get sunrise => 'सूर्योदय';
  @override
  String get sunset => 'सूर्यास्त';
  @override
  String get featureImage => 'Feature\nImage';
  @override
  String get eventDetails => 'कार्यक्रम विवरण';
  @override
  String get loadFailed => 'पात्रो लोड गर्न सकिएन';
}

class _En extends CalendarStrings {
  const _En();
  @override
  String get approximateNote =>
      'Approximate — connect to the internet for the exact panchanga.';
  @override
  String until(String time) => 'until $time';
  @override
  String get moonSign => 'Moon sign';
  @override
  String get adhika => 'Adhika';
  @override
  String get addReminder => 'Add reminder';
  @override
  String get share => 'Share';
  @override
  String get noSaitsForDay => 'No auspicious times published for this day.';
  @override
  String get saitsUnavailable => 'Could not load auspicious times.';
  @override
  String get vratDays => 'Vrat';
  @override
  String get noVratDays => 'No vrat days this month.';
  @override
  String get filterAll => 'All';
  @override
  String get legendEvent => 'Event day';
  @override
  String vrat(VratKind kind) => switch (kind) {
    VratKind.ekadashi => 'Ekadashi',
    VratKind.purnima => 'Purnima',
    VratKind.amavasya => 'Amavasya',
  };
  @override
  String get title => 'Patro';
  @override
  String get today => 'Today';
  @override
  String get gregorian => 'A.D.';
  @override
  String get defaultCalendarView => 'Default Calendar View';
  @override
  String get events => 'Events';
  @override
  String get noEvents => 'No events available';
  @override
  String get holiday => 'Holiday';
  @override
  String get todayChip => 'Today';
  @override
  String get panchanga => 'Panchanga';
  @override
  String get moreInfo => 'More info';
  @override
  String get day => 'Day';
  @override
  String get nakshatra => 'Nakshatra';
  @override
  String get tithi => 'Tithi';
  @override
  String get karan => 'Karan';
  @override
  String get yog => 'Yog';
  @override
  String get subhaSait => 'Auspicious times';
  @override
  String get pleaseLogin => 'Please log in';
  @override
  String get selectDate => 'Select Date';
  @override
  String get selectMonth => 'Select Month';
  @override
  String get cancel => 'Cancel';
  @override
  String get confirm => 'Confirm';
  @override
  String get patroAds => 'PATRO PAGE ADS';
  @override
  String get sunrise => 'Sunrise';
  @override
  String get sunset => 'Sunset';
  @override
  String get featureImage => 'Feature\nImage';
  @override
  String get eventDetails => 'Event details';
  @override
  String get loadFailed => 'Could not load the calendar';
}

class _Hi extends CalendarStrings {
  const _Hi();
  @override
  String get approximateNote =>
      'अनुमानित मान — सटीक पंचांग के लिए इंटरनेट से जुड़ें।';
  @override
  String until(String time) => '$time तक';
  @override
  String get moonSign => 'चंद्र राशि';
  @override
  String get adhika => 'अधिक';
  @override
  String get addReminder => 'रिमाइंडर जोड़ें';
  @override
  String get share => 'साझा करें';
  @override
  String get noSaitsForDay => 'इस दिन के लिए कोई शुभ मुहूर्त प्रकाशित नहीं है।';
  @override
  String get saitsUnavailable => 'शुभ मुहूर्त लोड नहीं हो सके।';
  @override
  String get vratDays => 'व्रत';
  @override
  String get noVratDays => 'इस महीने कोई व्रत नहीं।';
  @override
  String get filterAll => 'सभी';
  @override
  String get legendEvent => 'कार्यक्रम वाला दिन';
  @override
  String vrat(VratKind kind) => switch (kind) {
    VratKind.ekadashi => 'एकादशी',
    VratKind.purnima => 'पूर्णिमा',
    VratKind.amavasya => 'अमावस्या',
  };
  @override
  String get title => 'पंचांग कैलेंडर';
  @override
  String get today => 'आज';
  @override
  String get gregorian => 'ई.सं.';
  @override
  String get defaultCalendarView => 'डिफ़ॉल्ट कैलेंडर दृश्य';
  @override
  String get events => 'कार्यक्रम';
  @override
  String get noEvents => 'कोई कार्यक्रम उपलब्ध नहीं है।';
  @override
  String get holiday => 'अवकाश';
  @override
  String get todayChip => 'आज';
  @override
  String get panchanga => 'पंचांग';
  @override
  String get moreInfo => 'अधिक जानकारी';
  @override
  String get day => 'दिन';
  @override
  String get nakshatra => 'नक्षत्र';
  @override
  String get tithi => 'तिथि';
  @override
  String get karan => 'करण';
  @override
  String get yog => 'योग';
  @override
  String get subhaSait => 'शुभ मुहूर्त';
  @override
  String get pleaseLogin => 'कृपया लॉग-इन करें';
  @override
  String get selectDate => 'तिथि चुनें';
  @override
  String get selectMonth => 'महीना चुनें';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get confirm => 'चुनें';
  @override
  String get patroAds => 'PATRO PAGE ADS';
  @override
  String get sunrise => 'सूर्योदय';
  @override
  String get sunset => 'सूर्यास्त';
  @override
  String get featureImage => 'Feature\nImage';
  @override
  String get eventDetails => 'कार्यक्रम विवरण';
  @override
  String get loadFailed => 'कैलेंडर लोड नहीं हो सका';
}
