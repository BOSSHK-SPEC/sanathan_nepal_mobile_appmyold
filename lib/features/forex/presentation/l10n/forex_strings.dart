import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_all.dart';

/// Trilingual (English / Nepali / Hindi) strings for the forex feature.
abstract class ForexStrings {
  const ForexStrings();

  static ForexStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get title;
  String get trend;

  /// "USD TO NRS - TREND" – [localLabel] is the local currency label
  /// (`NRS` for Nepal, `INR` for India; see `ForexFormat.localLabel`).
  String trendTitle(String iso3, String localLabel);
  String get selectDateRange;
  String get oneWeek;
  String get oneMonth;
  String get oneYear;
  String get buying;
  String get selling;
  String get currency;
  String get buy;
  String get sell;
  String get conversion;
  String get amount;
  String get selectCurrencyToShow;
  String get selectHomeCurrencies;
  String get moreForexInfo;

  /// Attribution of the Nepal source (Nepal Rastra Bank).
  String get sourceNrb;

  /// Attribution of the India source (ECB reference rates via Frankfurter).
  String get sourceEcb;

  /// Attribution for the source that serves [config]'s region.
  String source(RegionConfig config) => config.isNepal ? sourceNrb : sourceEcb;
  String get maxFavourites;
  String get offlineData;
  String get noHistory;
}

class _En extends ForexStrings {
  const _En();
  @override
  String get title => 'Foreign Exchange';
  @override
  String get trend => 'TREND';
  @override
  String trendTitle(String iso3, String localLabel) =>
      '$iso3 TO $localLabel - TREND';
  @override
  String get selectDateRange => 'Select date range';
  @override
  String get oneWeek => '1 W';
  @override
  String get oneMonth => '1 M';
  @override
  String get oneYear => '1 Y';
  @override
  String get buying => 'Buying';
  @override
  String get selling => 'Selling';
  @override
  String get currency => 'Currency';
  @override
  String get buy => 'Buy';
  @override
  String get sell => 'Sell';
  @override
  String get conversion => 'Currency conversion';
  @override
  String get amount => 'Amount';
  @override
  String get selectCurrencyToShow => 'Select currency to display here';
  @override
  String get selectHomeCurrencies =>
      'Select currencies (up to 4) to show on the home page';
  @override
  String get moreForexInfo => 'More Currency Information';
  @override
  String get sourceNrb => 'Nepal Rastra Bank - https://www.nrb.org.np/';
  @override
  String get sourceEcb =>
      'European Central Bank reference rates via Frankfurter - '
      'https://www.frankfurter.app/';
  @override
  String get maxFavourites => 'You can pin up to 4 currencies';
  @override
  String get offlineData => 'Showing offline rates';
  @override
  String get noHistory => 'No trend data';
}

class _Ne extends ForexStrings {
  const _Ne();
  @override
  String get title => 'विदेशी विनिमय';
  @override
  String get trend => 'प्रवृत्ति';
  @override
  String trendTitle(String iso3, String localLabel) =>
      '$iso3 TO $localLabel - TREND';
  @override
  String get selectDateRange => 'मिति अवधि छान्नुहोस्';
  @override
  String get oneWeek => '१ हप्ता';
  @override
  String get oneMonth => '१ महिना';
  @override
  String get oneYear => '१ वर्ष';
  @override
  String get buying => 'खरिद';
  @override
  String get selling => 'बिक्री';
  @override
  String get currency => 'मुद्रा';
  @override
  String get buy => 'खरिद';
  @override
  String get sell => 'बिक्री';
  @override
  String get conversion => 'मुद्रा रूपान्तरण';
  @override
  String get amount => 'रकम';
  @override
  String get selectCurrencyToShow => 'यहाँ देखाउनको लागि मुद्रा छान्नुहोस्';
  @override
  String get selectHomeCurrencies =>
      'गृहपृष्ठमा देखाउनको लागि मुद्रा (४ वोटा सम्म) छान्नुहोस्';
  @override
  String get moreForexInfo => 'थप विदेशी विनिमयको जानकारी हेर्नुहोस्';
  @override
  String get sourceNrb => 'नेपाल राष्ट्र बैंक - https://www.nrb.org.np/';
  @override
  String get sourceEcb =>
      'युरोपेली केन्द्रीय बैंकको सन्दर्भ दर (Frankfurter) - '
      'https://www.frankfurter.app/';
  @override
  String get maxFavourites => 'बढीमा ४ वटा मुद्रा मात्र छान्न सकिन्छ';
  @override
  String get offlineData => 'अफलाइन दर देखाइँदैछ';
  @override
  String get noHistory => 'प्रवृत्ति डेटा छैन';
}

class _Hi extends ForexStrings {
  const _Hi();
  @override
  String get title => 'विदेशी मुद्रा विनिमय';
  @override
  String get trend => 'रुझान';
  @override
  String trendTitle(String iso3, String localLabel) =>
      '$iso3 TO $localLabel - TREND';
  @override
  String get selectDateRange => 'अवधि चुनें';
  @override
  String get oneWeek => '१ सप्ताह';
  @override
  String get oneMonth => '१ माह';
  @override
  String get oneYear => '१ वर्ष';
  @override
  String get buying => 'खरीद';
  @override
  String get selling => 'बिक्री';
  @override
  String get currency => 'मुद्रा';
  @override
  String get buy => 'खरीद';
  @override
  String get sell => 'बिक्री';
  @override
  String get conversion => 'मुद्रा रूपांतरण';
  @override
  String get amount => 'राशि';
  @override
  String get selectCurrencyToShow => 'यहाँ दिखाने के लिए मुद्रा चुनें';
  @override
  String get selectHomeCurrencies =>
      'होम पेज पर दिखाने के लिए मुद्राएँ (अधिकतम ४) चुनें';
  @override
  String get moreForexInfo => 'अधिक मुद्रा जानकारी देखें';
  @override
  String get sourceNrb => 'नेपाल राष्ट्र बैंक - https://www.nrb.org.np/';
  @override
  String get sourceEcb =>
      'यूरोपीय केंद्रीय बैंक की संदर्भ दरें (Frankfurter) - '
      'https://www.frankfurter.app/';
  @override
  String get maxFavourites => 'अधिकतम ४ मुद्राएँ ही पिन की जा सकती हैं';
  @override
  String get offlineData => 'ऑफ़लाइन दरें दिखाई जा रही हैं';
  @override
  String get noHistory => 'रुझान डेटा उपलब्ध नहीं';
}
