import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../domain/entities/horoscope_period.dart';

/// Feature-local strings (Nepali / English / Hindi) for the horoscope screens.
abstract class HoroscopeStrings {
  const HoroscopeStrings();

  static HoroscopeStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get title;
  String get audioRashifal;
  String get luckyDetails;
  String get moreDetails;
  String get lessDetails;
  String get luckyNumber;
  String get luckyColor;
  String get luckyDays;
  String get rulingPlanet;
  String get symbol;
  String get element;
  String get luckyStone;
  String get unluckyStone;
  String get luckyAlphabet;
  String get eventfulYears;
  String get shopNow;
  String get stayInformed;
  String get stayInformedBody;
  String get turnOn;
  String get selectSign;
  String get seeAll;
  String get horoscopeAds;
  String get like;
  String get share;
  String get copied;
  String get closingQuote;

  /// "मेष राशि को बारेमा" / "About Aries".
  String aboutSign(String name);

  /// Share text of a prediction: "मेष राशिफल (दैनिक): …".
  String shareText(String sign, String period, String text);

  /// Page title per period, e.g. "दैनिक राशिफल" / "Daily Horoscope".
  String periodTitle(HoroscopePeriod period);
}

class _Ne extends HoroscopeStrings {
  const _Ne();
  @override
  String get title => 'राशिफल';
  @override
  String get audioRashifal => 'अडियो राशिफल';
  @override
  String get luckyDetails => 'भाग्यशाली विवरण';
  @override
  String get moreDetails => 'थप विवरण';
  @override
  String get lessDetails => 'कम विवरण';
  @override
  String get luckyNumber => 'भाग्यशाली अंक';
  @override
  String get luckyColor => 'भाग्यशाली रङ';
  @override
  String get luckyDays => 'भाग्यशाली दिन';
  @override
  String get rulingPlanet => 'स्वामी ग्रह';
  @override
  String get symbol => 'चिन्ह';
  @override
  String get element => 'तत्व';
  @override
  String get luckyStone => 'भाग्यशाली रत्न';
  @override
  String get unluckyStone => 'अशुभ रत्न';
  @override
  String get luckyAlphabet => 'भाग्यशाली अक्षर';
  @override
  String get eventfulYears => 'महत्वपूर्ण वर्ष';
  @override
  String get shopNow => 'किन्नुहोस्';
  @override
  String get stayInformed => 'सूचित हुनुहोस्';
  @override
  String get stayInformedBody =>
      'दैनिक राशिफलको सूचना आफ्नो समयमा प्राप्त गर्नुहोस्।';
  @override
  String get turnOn => 'सूचना खोल्नुहोस्';
  @override
  String get selectSign => 'राशि छान्नुहोस्';
  @override
  String get seeAll => 'सबै हेर्नुहोस्';
  @override
  String get horoscopeAds => 'HOROSCOPE PAGE ADS';
  @override
  String get like => 'मन पर्‍यो';
  @override
  String get share => 'साझा गर्नुहोस्';
  @override
  String get copied => 'राशिफल कपी गरियो';
  @override
  String get closingQuote =>
      'राशिफल जे जस्तो भएपनि तपाईंको दिन मङ्गलमय रहोस् । - डा. उत्तम उपाध्याय न्यौपाने';
  @override
  String aboutSign(String name) => '$name राशि को बारेमा';
  @override
  String shareText(String sign, String period, String text) =>
      '$sign राशिफल ($period): $text';
  @override
  String periodTitle(HoroscopePeriod period) => '${period.nameNe} राशिफल';
}

class _En extends HoroscopeStrings {
  const _En();
  @override
  String get title => 'Horoscope';
  @override
  String get audioRashifal => 'Audio Rashifal';
  @override
  String get luckyDetails => 'Lucky Details';
  @override
  String get moreDetails => 'More Details';
  @override
  String get lessDetails => 'Less Details';
  @override
  String get luckyNumber => 'Lucky Number';
  @override
  String get luckyColor => 'Lucky Color';
  @override
  String get luckyDays => 'Lucky Days';
  @override
  String get rulingPlanet => 'Ruling Planet';
  @override
  String get symbol => 'Symbol';
  @override
  String get element => 'Element';
  @override
  String get luckyStone => 'Lucky Stone';
  @override
  String get unluckyStone => 'Unlucky Stone';
  @override
  String get luckyAlphabet => 'Lucky Alphabet';
  @override
  String get eventfulYears => 'Eventful Years';
  @override
  String get shopNow => 'Shop Now';
  @override
  String get stayInformed => 'Stay informed';
  @override
  String get stayInformedBody =>
      'Get your daily horoscope notification on your time.';
  @override
  String get turnOn => 'Turn on notifications';
  @override
  String get selectSign => 'Select sign';
  @override
  String get seeAll => 'See All';
  @override
  String get horoscopeAds => 'HOROSCOPE PAGE ADS';
  @override
  String get like => 'Like';
  @override
  String get share => 'Share';
  @override
  String get copied => 'Horoscope copied';
  @override
  String get closingQuote =>
      'Whatever the horoscope says, may your day be auspicious. '
      '– Dr. Uttam Upadhyaya Neupane';
  @override
  String aboutSign(String name) => 'About $name';
  @override
  String shareText(String sign, String period, String text) =>
      '$sign horoscope ($period): $text';
  @override
  String periodTitle(HoroscopePeriod period) => '${period.nameEn} Horoscope';
}

class _Hi extends HoroscopeStrings {
  const _Hi();
  @override
  String get title => 'राशिफल';
  @override
  String get audioRashifal => 'ऑडियो राशिफल';
  @override
  String get luckyDetails => 'भाग्यशाली विवरण';
  @override
  String get moreDetails => 'अधिक विवरण';
  @override
  String get lessDetails => 'कम विवरण';
  @override
  String get luckyNumber => 'भाग्यशाली अंक';
  @override
  String get luckyColor => 'भाग्यशाली रंग';
  @override
  String get luckyDays => 'भाग्यशाली दिन';
  @override
  String get rulingPlanet => 'स्वामी ग्रह';
  @override
  String get symbol => 'प्रतीक';
  @override
  String get element => 'तत्व';
  @override
  String get luckyStone => 'भाग्यशाली रत्न';
  @override
  String get unluckyStone => 'अशुभ रत्न';
  @override
  String get luckyAlphabet => 'भाग्यशाली अक्षर';
  @override
  String get eventfulYears => 'महत्वपूर्ण वर्ष';
  @override
  String get shopNow => 'अभी खरीदें';
  @override
  String get stayInformed => 'सूचित रहें';
  @override
  String get stayInformedBody =>
      'अपने समय पर दैनिक राशिफल की सूचना प्राप्त करें।';
  @override
  String get turnOn => 'सूचनाएँ चालू करें';
  @override
  String get selectSign => 'राशि चुनें';
  @override
  String get seeAll => 'सभी देखें';
  @override
  String get horoscopeAds => 'HOROSCOPE PAGE ADS';
  @override
  String get like => 'पसंद';
  @override
  String get share => 'साझा करें';
  @override
  String get copied => 'राशिफल कॉपी किया गया';
  @override
  String get closingQuote =>
      'राशिफल जो भी हो, आपका दिन मंगलमय हो । - डॉ. उत्तम उपाध्याय न्यौपाने';
  @override
  String aboutSign(String name) => '$name राशि के बारे में';
  @override
  String shareText(String sign, String period, String text) =>
      '$sign राशिफल ($period): $text';
  @override
  String periodTitle(HoroscopePeriod period) => '${period.nameHi} राशिफल';
}
