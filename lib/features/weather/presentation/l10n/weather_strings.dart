import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';

/// Trilingual (English / Nepali / Hindi) strings for the weather feature.
abstract class WeatherStrings {
  const WeatherStrings();

  static WeatherStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get title;
  String get today;
  String get nextForecast;
  String get hourly;
  String get humidity;
  String get wind;
  String get rain;
  String get sunrise;
  String get sunset;
  String get high;
  String get low;
  String get kmh;
  String get offlineData;
  String get useMyLocation;
  String get feelsLike;
  String get details;
  String get maxTemp;
  String get minTemp;
  String weekday(int weekday);
  String monthShort(int month);
}

class _En extends WeatherStrings {
  const _En();
  @override
  String get title => 'Weather';
  @override
  String get today => 'Today';
  @override
  String get nextForecast => 'Next Forecast';
  @override
  String get hourly => 'Hourly';
  @override
  String get humidity => 'Humidity';
  @override
  String get wind => 'Wind';
  @override
  String get rain => 'Rain';
  @override
  String get sunrise => 'Sunrise';
  @override
  String get sunset => 'Sunset';
  @override
  String get high => 'H';
  @override
  String get low => 'L';
  @override
  String get kmh => 'km/h';
  @override
  String get offlineData => 'Showing offline forecast';
  @override
  String get useMyLocation => 'Use my location';
  @override
  String get feelsLike => 'Feels like';
  @override
  String get details => 'Details';
  @override
  String get maxTemp => 'Max';
  @override
  String get minTemp => 'Min';

  static const _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  @override
  String weekday(int weekday) => _days[(weekday - 1) % 7];
  @override
  String monthShort(int month) => _months[(month - 1) % 12];
}

class _Ne extends WeatherStrings {
  const _Ne();
  @override
  String get title => 'मौसम';
  @override
  String get today => 'आज';
  @override
  String get nextForecast => 'आगामी पूर्वानुमान';
  @override
  String get hourly => 'घण्टैपिच्छे';
  @override
  String get humidity => 'आर्द्रता';
  @override
  String get wind => 'हावा';
  @override
  String get rain => 'वर्षा';
  @override
  String get sunrise => 'सूर्योदय';
  @override
  String get sunset => 'सूर्यास्त';
  @override
  String get high => 'अधिक';
  @override
  String get low => 'न्यून';
  @override
  String get kmh => 'किमी/घण्टा';
  @override
  String get offlineData => 'अफलाइन पूर्वानुमान देखाइँदैछ';
  @override
  String get useMyLocation => 'मेरो स्थान प्रयोग गर्नुहोस्';
  @override
  String get feelsLike => 'महसुस';
  @override
  String get details => 'विवरण';
  @override
  String get maxTemp => 'अधिकतम';
  @override
  String get minTemp => 'न्यूनतम';

  static const _days = [
    'सोमबार',
    'मंगलबार',
    'बुधबार',
    'बिहीबार',
    'शुक्रबार',
    'शनिबार',
    'आइतबार',
  ];
  static const _months = [
    'जन',
    'फेब',
    'मार्च',
    'अप्रिल',
    'मे',
    'जुन',
    'जुलाई',
    'अग',
    'सेप्ट',
    'अक्टो',
    'नोभे',
    'डिसे',
  ];
  @override
  String weekday(int weekday) => _days[(weekday - 1) % 7];
  @override
  String monthShort(int month) => _months[(month - 1) % 12];
}

class _Hi extends WeatherStrings {
  const _Hi();
  @override
  String get title => 'मौसम';
  @override
  String get today => 'आज';
  @override
  String get nextForecast => 'आगामी पूर्वानुमान';
  @override
  String get hourly => 'प्रति घंटा';
  @override
  String get humidity => 'नमी';
  @override
  String get wind => 'हवा';
  @override
  String get rain => 'बारिश';
  @override
  String get sunrise => 'सूर्योदय';
  @override
  String get sunset => 'सूर्यास्त';
  @override
  String get high => 'अधिक';
  @override
  String get low => 'न्यून';
  @override
  String get kmh => 'किमी/घंटा';
  @override
  String get offlineData => 'ऑफ़लाइन पूर्वानुमान दिखाया जा रहा है';
  @override
  String get useMyLocation => 'मेरा स्थान उपयोग करें';
  @override
  String get feelsLike => 'महसूस';
  @override
  String get details => 'विवरण';
  @override
  String get maxTemp => 'अधिकतम';
  @override
  String get minTemp => 'न्यूनतम';

  static const _days = [
    'सोमवार',
    'मंगलवार',
    'बुधवार',
    'गुरुवार',
    'शुक्रवार',
    'शनिवार',
    'रविवार',
  ];
  static const _months = [
    'जन',
    'फ़र',
    'मार्च',
    'अप्रैल',
    'मई',
    'जून',
    'जुला',
    'अग',
    'सित',
    'अक्टू',
    'नव',
    'दिस',
  ];
  @override
  String weekday(int weekday) => _days[(weekday - 1) % 7];
  @override
  String monthShort(int month) => _months[(month - 1) % 12];
}
