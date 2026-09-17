import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../domain/entities/time_window.dart';

/// Feature-local trilingual strings for panchanga & suva sait / muhurat.
abstract class PanchangaStrings {
  const PanchangaStrings();

  static PanchangaStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get pageTitle;
  String get panchanga;
  String get suvaSait;
  String get bikramSambat;
  String get vikramSamvat;
  String get gregorian;
  String get shakaSamvat;
  String get nepalSamvat;
  String get tithi;
  String get nakshatra;
  String get karana;
  String get yoga;
  String get sunrise;
  String get sunset;
  String get moonrise;
  String get moonset;
  String get moreInfo;
  String get lessInfo;
  String get ghatiPala;
  String get until;
  String get thenAfter;
  String get bhukta;
  String get bhogya;
  String spashta(String element);
  String get chandraRashi;
  String get anandadiYoga;
  String get planetsAtSunrise;
  String get moreSaits;
  String get noSaitToday;

  /// Nothing has been published at all — distinct from "none falls today".
  /// Saits are editorial: an almanac chooses them and nothing computes them,
  /// so an empty list means no panel has published, not that today is
  /// inauspicious.
  String get noSaitsPublished;
  String get noMuhuratsPublished;
  String get todayLabel;
  String get previousMonth;
  String get nextMonth;
  String get panchangaAds;

  // India-only muhurta rows.
  String get muhurtaTitle;
  String get rahuKaal;
  String get yamaganda;
  String get gulikaKaal;
  String get abhijitMuhurat;
  String get choghadiya;
  String get inauspicious;
  String get auspicious;

  // "Suva Sait" (Nepal) vs "Shubh Muhurat" (India) wording.
  String get shubhMuhurat;
  String get pageTitleMuhurat;
  String get moreMuhurats;
  String get noMuhuratToday;

  /// Shown on a day whose values are the on-device estimate.
  String get approximateNote;

  /// Weekday names, index 0 = Sunday.
  List<String> get weekdays;

  /// Era label for [kind] as shown in the samvat header.
  String samvatLabel(SamvatKind kind) => switch (kind) {
    SamvatKind.bikram => bikramSambat,
    SamvatKind.vikram => vikramSamvat,
    SamvatKind.shaka => shakaSamvat,
    SamvatKind.nepalSambat => nepalSamvat,
    SamvatKind.gregorian => gregorian,
  };

  String kaalLabel(TimeWindowKind kind) => switch (kind) {
    TimeWindowKind.rahuKaal => rahuKaal,
    TimeWindowKind.yamaganda => yamaganda,
    TimeWindowKind.gulikaKaal => gulikaKaal,
    TimeWindowKind.abhijit => abhijitMuhurat,
    TimeWindowKind.choghadiya => choghadiya,
  };

  /// Section title / page title / links depending on the region wording.
  String saitTitle(RegionConfig config) =>
      config.isIndia ? shubhMuhurat : suvaSait;
  String pageTitleFor(RegionConfig config) =>
      config.isIndia ? pageTitleMuhurat : pageTitle;
  String moreSaitsFor(RegionConfig config) =>
      config.isIndia ? moreMuhurats : moreSaits;
  String noSaitTodayFor(RegionConfig config) =>
      config.isIndia ? noMuhuratToday : noSaitToday;
  String noSaitsPublishedFor(RegionConfig config) =>
      config.isIndia ? noMuhuratsPublished : noSaitsPublished;
}

class _Ne extends PanchangaStrings {
  const _Ne();
  @override
  String get approximateNote =>
      'अनुमानित मान — इन्टरनेटमा जोडिएपछि सटीक पञ्चाङ्ग देखिनेछ।';
  @override
  String get pageTitle => 'पञ्चाङ्ग तथा शुभ साइत';
  @override
  String get panchanga => 'पञ्चाङ्ग';
  @override
  String get suvaSait => 'शुभ साइत';
  @override
  String get bikramSambat => 'वि.सं.';
  @override
  String get vikramSamvat => 'विक्रम संवत्';
  @override
  String get gregorian => 'ई.सं.';
  @override
  String get shakaSamvat => 'शक संवत्';
  @override
  String get nepalSamvat => 'नेपाल संवत्';
  @override
  String get tithi => 'तिथि';
  @override
  String get nakshatra => 'नक्षत्र';
  @override
  String get karana => 'करण';
  @override
  String get yoga => 'योग';
  @override
  String get sunrise => 'सूर्योदय';
  @override
  String get sunset => 'सूर्यास्त';
  @override
  String get moonrise => 'चन्द्रोदय';
  @override
  String get moonset => 'चन्द्रास्त';
  @override
  String get moreInfo => 'थप जानकारी';
  @override
  String get lessInfo => 'कम जानकारी';
  @override
  String get ghatiPala => 'घ: प: वि: प्र';
  @override
  String get until => 'बजे सम्म';
  @override
  String get thenAfter => 'उप्रान्त';
  @override
  String get bhukta => 'भुक्त घडी';
  @override
  String get bhogya => 'भोग्य घडी';
  @override
  String spashta(String element) => 'स्पष्ट $element (घडीमा)';
  @override
  String get chandraRashi => 'चन्द्रराशि';
  @override
  String get anandadiYoga => 'आनन्दादि योग';
  @override
  String get planetsAtSunrise => 'सूर्योदयकालीन स्पष्ट ग्रहहरू';
  @override
  String get moreSaits => 'थप शुभ साइत तथा मुहूर्तहरू हेर्नुहोस्';
  @override
  String get noSaitToday => 'आज कुनै शुभ साइत तथा मुहूर्त फेला परेन ।';

  @override
  String get noSaitsPublished => 'हाल कुनै शुभ साइत प्रकाशित भएको छैन।';

  @override
  String get noMuhuratsPublished => 'हाल कुनै शुभ मुहूर्त प्रकाशित भएको छैन।';
  @override
  String get todayLabel => 'आज';
  @override
  String get previousMonth => 'अघिल्लो महिना';
  @override
  String get nextMonth => 'आगामी महिना';
  @override
  String get panchangaAds => 'PANCHANGA PAGE ADS';
  @override
  String get muhurtaTitle => 'दिनका मुहूर्तहरू';
  @override
  String get rahuKaal => 'राहु काल';
  @override
  String get yamaganda => 'यमगण्ड';
  @override
  String get gulikaKaal => 'गुलिक काल';
  @override
  String get abhijitMuhurat => 'अभिजित मुहूर्त';
  @override
  String get choghadiya => 'चौघडिया';
  @override
  String get inauspicious => 'अशुभ';
  @override
  String get auspicious => 'शुभ';
  @override
  String get shubhMuhurat => 'शुभ मुहूर्त';
  @override
  String get pageTitleMuhurat => 'पञ्चाङ्ग तथा शुभ मुहूर्त';
  @override
  String get moreMuhurats => 'थप शुभ मुहूर्तहरू हेर्नुहोस्';
  @override
  String get noMuhuratToday => 'आज कुनै शुभ मुहूर्त छैन।';
  @override
  List<String> get weekdays => const [
    'आइतबार',
    'सोमबार',
    'मंगलबार',
    'बुधबार',
    'बिहीबार',
    'शुक्रबार',
    'शनिबार',
  ];
}

class _Hi extends PanchangaStrings {
  const _Hi();
  @override
  String get approximateNote =>
      'अनुमानित मान — सटीक पंचांग के लिए इंटरनेट से जुड़ें।';
  @override
  String get pageTitle => 'पंचांग एवं शुभ मुहूर्त';
  @override
  String get panchanga => 'पंचांग';
  @override
  String get suvaSait => 'शुभ साइत';
  @override
  String get bikramSambat => 'वि.सं.';
  @override
  String get vikramSamvat => 'विक्रम संवत्';
  @override
  String get gregorian => 'ई.सं.';
  @override
  String get shakaSamvat => 'शक संवत्';
  @override
  String get nepalSamvat => 'नेपाल संवत्';
  @override
  String get tithi => 'तिथि';
  @override
  String get nakshatra => 'नक्षत्र';
  @override
  String get karana => 'करण';
  @override
  String get yoga => 'योग';
  @override
  String get sunrise => 'सूर्योदय';
  @override
  String get sunset => 'सूर्यास्त';
  @override
  String get moonrise => 'चन्द्रोदय';
  @override
  String get moonset => 'चन्द्रास्त';
  @override
  String get moreInfo => 'अधिक जानकारी';
  @override
  String get lessInfo => 'कम जानकारी';
  @override
  String get ghatiPala => 'घ: प: वि: प्र';
  @override
  String get until => 'बजे तक';
  @override
  String get thenAfter => 'उसके बाद';
  @override
  String get bhukta => 'भुक्त घटी';
  @override
  String get bhogya => 'भोग्य घटी';
  @override
  String spashta(String element) => 'स्पष्ट $element (घटी में)';
  @override
  String get chandraRashi => 'चन्द्र राशि';
  @override
  String get anandadiYoga => 'आनन्दादि योग';
  @override
  String get planetsAtSunrise => 'सूर्योदयकालीन स्पष्ट ग्रह';
  @override
  String get moreSaits => 'और शुभ साइत एवं मुहूर्त देखें';
  @override
  String get noSaitToday => 'आज कोई शुभ मुहूर्त नहीं मिला ।';

  @override
  String get noSaitsPublished => 'अभी कोई शुभ साइत प्रकाशित नहीं हुआ है।';

  @override
  String get noMuhuratsPublished => 'अभी कोई शुभ मुहूर्त प्रकाशित नहीं हुआ है।';
  @override
  String get todayLabel => 'आज';
  @override
  String get previousMonth => 'पिछला महीना';
  @override
  String get nextMonth => 'अगला महीना';
  @override
  String get panchangaAds => 'PANCHANGA PAGE ADS';
  @override
  String get muhurtaTitle => 'दिन के मुहूर्त';
  @override
  String get rahuKaal => 'राहु काल';
  @override
  String get yamaganda => 'यमगण्ड';
  @override
  String get gulikaKaal => 'गुलिक काल';
  @override
  String get abhijitMuhurat => 'अभिजित मुहूर्त';
  @override
  String get choghadiya => 'चौघड़िया';
  @override
  String get inauspicious => 'अशुभ';
  @override
  String get auspicious => 'शुभ';
  @override
  String get shubhMuhurat => 'शुभ मुहूर्त';
  @override
  String get pageTitleMuhurat => 'पंचांग एवं शुभ मुहूर्त';
  @override
  String get moreMuhurats => 'और शुभ मुहूर्त देखें';
  @override
  String get noMuhuratToday => 'आज कोई शुभ मुहूर्त नहीं है।';
  @override
  List<String> get weekdays => const [
    'रविवार',
    'सोमवार',
    'मंगलवार',
    'बुधवार',
    'गुरुवार',
    'शुक्रवार',
    'शनिवार',
  ];
}

class _En extends PanchangaStrings {
  const _En();
  @override
  String get approximateNote =>
      'Approximate — connect to the internet for the exact panchanga.';
  @override
  String get pageTitle => 'Panchanga & Suva Sait';
  @override
  String get panchanga => 'Panchanga';
  @override
  String get suvaSait => 'Suva Sait';
  @override
  String get bikramSambat => 'B.S.';
  @override
  String get vikramSamvat => 'Vikram Samvat';
  @override
  String get gregorian => 'A.D.';
  @override
  String get shakaSamvat => 'Shaka Samvat';
  @override
  String get nepalSamvat => 'Nepal Samvat';
  @override
  String get tithi => 'Tithi';
  @override
  String get nakshatra => 'Nakshatra';
  @override
  String get karana => 'Karana';
  @override
  String get yoga => 'Yoga';
  @override
  String get sunrise => 'Sunrise';
  @override
  String get sunset => 'Sunset';
  @override
  String get moonrise => 'Moonrise';
  @override
  String get moonset => 'Moonset';
  @override
  String get moreInfo => 'More Info';
  @override
  String get lessInfo => 'Less Info';
  @override
  String get ghatiPala => 'Gh: Pa: Vi: Pr';
  @override
  String get until => 'until';
  @override
  String get thenAfter => 'then';
  @override
  String get bhukta => 'Elapsed (ghati)';
  @override
  String get bhogya => 'Remaining (ghati)';
  @override
  String spashta(String element) => 'Apparent $element (ghati)';
  @override
  String get chandraRashi => 'Moon sign';
  @override
  String get anandadiYoga => 'Anandadi Yoga';
  @override
  String get planetsAtSunrise => 'Planets at sunrise';
  @override
  String get moreSaits => 'See more Suva Saits & Muhurtas';
  @override
  String get noSaitToday => 'No Sait and Muhurat Found Today.';

  @override
  String get noSaitsPublished =>
      'No auspicious timings have been published yet.';

  @override
  String get noMuhuratsPublished =>
      'No auspicious muhurats have been published yet.';
  @override
  String get todayLabel => 'Today';
  @override
  String get previousMonth => 'Previous month';
  @override
  String get nextMonth => 'Next month';
  @override
  String get panchangaAds => 'PANCHANGA PAGE ADS';
  @override
  String get muhurtaTitle => 'Muhurtas of the day';
  @override
  String get rahuKaal => 'Rahu Kaal';
  @override
  String get yamaganda => 'Yamaganda';
  @override
  String get gulikaKaal => 'Gulika Kaal';
  @override
  String get abhijitMuhurat => 'Abhijit Muhurat';
  @override
  String get choghadiya => 'Choghadiya';
  @override
  String get inauspicious => 'Inauspicious';
  @override
  String get auspicious => 'Auspicious';
  @override
  String get shubhMuhurat => 'Shubh Muhurat';
  @override
  String get pageTitleMuhurat => 'Panchanga & Shubh Muhurat';
  @override
  String get moreMuhurats => 'See more Shubh Muhurats';
  @override
  String get noMuhuratToday => 'No shubh muhurat found today.';
  @override
  List<String> get weekdays => const [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
}
