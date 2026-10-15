import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../domain/entities/time_window.dart';
import '../../domain/services/day_factors.dart';

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

  // Day periods screen: Choghadiya, hora and the kaal windows on one page.
  String get dayPeriods;
  String get hora;

  /// The weekday kaal windows as a group (Rahu, Yamaganda, Gulika, Abhijit).
  /// Not "inauspicious": Abhijit sits among them and is the opposite.
  String get kaalWindows;
  String get dayHalf;
  String get nightHalf;
  String get nowLabel;
  String get neutralQuality;

  /// The night runs to tomorrow's sunrise, which is a second day's data.
  String get nightUnavailable;

  /// Footer: these divisions follow whichever sunrise is shown above them.
  String get periodsNote;

  // Day factors: season, ayana, the direction to avoid, and — once a birth
  // star is known — tara bala, chandra bala and chandrashtama.
  String get dayFactors;
  String get ritu;
  String get ayana;
  String get dishaShool;
  String get taraBala;
  String get chandraBala;
  String get chandrashtama;
  String get birthStar;
  String get pada;
  String get setBirthStar;
  String get birthStarWhy;

  /// Shown once both boxes are filled, in place of the explanation.
  String get birthStarSet;
  String get chandrashtamaToday;
  String get chandrashtamaNotToday;
  List<String> get taraNames;
  List<String> get rituNames;
  List<String> get ayanaNames;
  List<String> get dishaNames;

  /// "Moon in the 8th" — the house the Moon stands in from the birth sign.
  String houseLabel(int house);

  String taraLabel(Tara tara) => taraNames[tara.index];
  String rituLabel(Ritu ritu) => rituNames[ritu.index];
  String ayanaLabel(Ayana ayana) => ayanaNames[ayana.index];
  String dishaLabel(Disha disha) => dishaNames[disha.index];

  String dayQualityLabel(DayQuality quality) => switch (quality) {
    DayQuality.good => auspicious,
    DayQuality.mixed => neutralQuality,
    DayQuality.bad => inauspicious,
  };

  String qualityLabel(ChoghadiyaQuality quality) => switch (quality) {
    ChoghadiyaQuality.good => auspicious,
    ChoghadiyaQuality.neutral => neutralQuality,
    ChoghadiyaQuality.bad => inauspicious,
  };

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
    TimeWindowKind.hora => hora,
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
  String get dayPeriods => 'दिनका समयहरू';

  @override
  String get dayFactors => 'आजका योगहरू';
  @override
  String houseLabel(int house) => 'चन्द्रमा $house औं भावमा';
  @override
  String get ritu => 'ऋतु';
  @override
  String get ayana => 'अयन';
  @override
  String get dishaShool => 'दिशाशूल';
  @override
  String get taraBala => 'तारा बल';
  @override
  String get chandraBala => 'चन्द्र बल';
  @override
  String get chandrashtama => 'चन्द्राष्टम';
  @override
  String get birthStar => 'जन्म नक्षत्र';
  @override
  String get pada => 'चरण';
  @override
  String get setBirthStar => 'जन्म नक्षत्र छान्नुहोस्';
  @override
  String get birthStarWhy => 'तारा बल र चन्द्र बल जन्म नक्षत्रबाट गनिन्छ।';
  @override
  String get birthStarSet => 'माथिका तीन पङ्क्ति यसै जन्म नक्षत्रबाट गनिएका हुन्।';
  @override
  String get chandrashtamaToday => 'आज चन्द्राष्टम छ';
  @override
  String get chandrashtamaNotToday => 'आज चन्द्राष्टम छैन';
  @override
  List<String> get taraNames => const ['जन्म', 'सम्पत्', 'विपत्', 'क्षेम', 'प्रत्यरि', 'साधक', 'वध', 'मित्र', 'अतिमित्र'];
  @override
  List<String> get rituNames => const ['वसन्त', 'ग्रीष्म', 'वर्षा', 'शरद', 'हेमन्त', 'शिशिर'];
  @override
  List<String> get ayanaNames => const ['उत्तरायण', 'दक्षिणायन'];
  @override
  List<String> get dishaNames => const ['पूर्व', 'आग्नेय', 'दक्षिण', 'नैऋत्य', 'पश्चिम', 'वायव्य', 'उत्तर', 'ईशान'];

  @override
  String get kaalWindows => 'कालहरू';
  @override
  String get hora => 'होरा';
  @override
  String get dayHalf => 'दिन';
  @override
  String get nightHalf => 'रात';
  @override
  String get nowLabel => 'अहिले';
  @override
  String get neutralQuality => 'सामान्य';
  @override
  String get nightUnavailable => 'रातको समय भोलिको सूर्योदयमा निर्भर छ।';
  @override
  String get periodsNote => 'यी भागहरू माथि देखिएको सूर्योदय–सूर्यास्तबाटै गनिन्छन्।';

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
  String get dayPeriods => 'दिन के समय';

  @override
  String get dayFactors => 'आज के योग';
  @override
  String houseLabel(int house) => 'चंद्रमा $house वें भाव में';
  @override
  String get ritu => 'ऋतु';
  @override
  String get ayana => 'अयन';
  @override
  String get dishaShool => 'दिशाशूल';
  @override
  String get taraBala => 'तारा बल';
  @override
  String get chandraBala => 'चंद्र बल';
  @override
  String get chandrashtama => 'चंद्राष्टम';
  @override
  String get birthStar => 'जन्म नक्षत्र';
  @override
  String get pada => 'चरण';
  @override
  String get setBirthStar => 'जन्म नक्षत्र चुनें';
  @override
  String get birthStarWhy => 'तारा बल और चंद्र बल जन्म नक्षत्र से गिने जाते हैं।';
  @override
  String get birthStarSet => 'ऊपर की तीन पंक्तियाँ इसी जन्म नक्षत्र से गिनी गई हैं।';
  @override
  String get chandrashtamaToday => 'आज चंद्राष्टम है';
  @override
  String get chandrashtamaNotToday => 'आज चंद्राष्टम नहीं है';
  @override
  List<String> get taraNames => const ['जन्म', 'संपत्', 'विपत्', 'क्षेम', 'प्रत्यरि', 'साधक', 'वध', 'मित्र', 'अतिमित्र'];
  @override
  List<String> get rituNames => const ['वसंत', 'ग्रीष्म', 'वर्षा', 'शरद', 'हेमंत', 'शिशिर'];
  @override
  List<String> get ayanaNames => const ['उत्तरायण', 'दक्षिणायन'];
  @override
  List<String> get dishaNames => const ['पूर्व', 'आग्नेय', 'दक्षिण', 'नैऋत्य', 'पश्चिम', 'वायव्य', 'उत्तर', 'ईशान'];

  @override
  String get kaalWindows => 'काल';
  @override
  String get hora => 'होरा';
  @override
  String get dayHalf => 'दिन';
  @override
  String get nightHalf => 'रात';
  @override
  String get nowLabel => 'अभी';
  @override
  String get neutralQuality => 'सामान्य';
  @override
  String get nightUnavailable => 'रात का समय कल के सूर्योदय पर निर्भर है।';
  @override
  String get periodsNote => 'ये भाग ऊपर दिखाए गए सूर्योदय–सूर्यास्त से ही गिने जाते हैं।';

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
  String get dayPeriods => 'Day periods';

  @override
  String get dayFactors => "Today's factors";
  @override
  String houseLabel(int house) => 'Moon in the ${_ordinal(house)}';

  /// 1st, 2nd, 3rd, 4th … 11th, 12th — the teens take "th" whatever they end
  /// in, which is why 11 and 12 are not "11st" and "12nd".
  static String _ordinal(int n) {
    final suffix = (n % 100 >= 11 && n % 100 <= 13)
        ? 'th'
        : switch (n % 10) {
            1 => 'st',
            2 => 'nd',
            3 => 'rd',
            _ => 'th',
          };
    return '$n$suffix';
  }
  @override
  String get ritu => 'Ritu';
  @override
  String get ayana => 'Ayana';
  @override
  String get dishaShool => 'Disha Shool';
  @override
  String get taraBala => 'Tara Bala';
  @override
  String get chandraBala => 'Chandra Bala';
  @override
  String get chandrashtama => 'Chandrashtama';
  @override
  String get birthStar => 'Birth star';
  @override
  String get pada => 'Pada';
  @override
  String get setBirthStar => 'Choose your birth star';
  @override
  String get birthStarWhy => 'Tara Bala and Chandra Bala are counted from your birth star.';
  @override
  String get birthStarSet => 'The three rows above are counted from this.';
  @override
  String get chandrashtamaToday => 'Chandrashtama today';
  @override
  String get chandrashtamaNotToday => 'Not Chandrashtama today';
  @override
  List<String> get taraNames => const ['Janma', 'Sampat', 'Vipat', 'Kshema', 'Pratyari', 'Sadhaka', 'Vadha', 'Mitra', 'Ati Mitra'];
  @override
  List<String> get rituNames => const ['Vasanta', 'Grishma', 'Varsha', 'Sharad', 'Hemanta', 'Shishira'];
  @override
  List<String> get ayanaNames => const ['Uttarayana', 'Dakshinayana'];
  @override
  List<String> get dishaNames => const ['East', 'South-east', 'South', 'South-west', 'West', 'North-west', 'North', 'North-east'];

  @override
  String get kaalWindows => 'Kaal';
  @override
  String get hora => 'Hora';
  @override
  String get dayHalf => 'Day';
  @override
  String get nightHalf => 'Night';
  @override
  String get nowLabel => 'Now';
  @override
  String get neutralQuality => 'Fair';
  @override
  String get nightUnavailable => 'The night runs to tomorrow\'s sunrise.';
  @override
  String get periodsNote => 'Divisions of the sunrise and sunset shown above.';

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
