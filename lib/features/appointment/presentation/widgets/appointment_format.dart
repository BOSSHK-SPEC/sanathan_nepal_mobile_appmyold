import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_format.dart';
import '../../domain/entities/time_slot.dart';

/// Region + language aware date / time / money formatting for the
/// appointment UI.
///
/// The traditional calendar (Bikram Sambat in Nepal, Saka in India),
/// currency symbol and digit script all come from the [RegionConfig] and the
/// language code – widgets obtain an instance with [AppointmentFormat.of].
class AppointmentFormat {
  const AppointmentFormat({required this.config, required this.languageCode});

  factory AppointmentFormat.of(BuildContext context) => AppointmentFormat(
    config: context.regionConfig,
    languageCode: context.languageCode,
  );

  final RegionConfig config;
  final String languageCode;

  TraditionalCalendar get calendar => config.calendar;

  /// Nepali and Hindi render digits in Devanagari.
  bool get devanagari => TraditionalCalendar.devanagariDigits(languageCode);

  /// "B.S." / "वि.सं." (Nepal) · "Saka" / "शक" (India).
  String get eraLabel => calendar.eraLabel(languageCode: languageCode);

  /// Applies the digit script of the current language to [s].
  String digits(String s) => devanagari ? s.toDevanagariDigits() : s;

  // ---------------------------------------------------------------- dates

  /// "Chaitra 16, 2079 | 30 Mar, 2023, Wednesday" (Nepal)
  /// / "Shravana 27, 1948 | 18 Aug, 2026, Tuesday" (India)
  /// / "चैत १६, २०७९ | ३० मार्च, २०२३, बुधबार".
  String dateLine(DateTime date) =>
      '${traditionalDate(date)} | ${gregorianDate(date)}, ${weekday(date)}';

  /// "Chaitra 16, 2079" / "चैत १६, २०७९" / "श्रावण २७, १९४८".
  String traditionalDate(DateTime date) {
    final t = calendar.fromGregorian(date);
    return '${calendar.monthName(t.month, languageCode: languageCode)} '
        '${digits('${t.day}')}, ${digits('${t.year}')}';
  }

  /// "Falgun, 2079" / "फागुन, २०७९" – calendar header.
  String traditionalMonthYear(TraditionalDate t) =>
      '${calendar.monthName(t.month, languageCode: languageCode)}, '
      '${digits('${t.year}')}';

  /// "March 2023" / "मार्च २०२३" – Gregorian calendar header.
  String gregorianMonthYear(int year, int month) =>
      '${gregorianMonthName(month)} ${digits('$year')}';

  /// "30 Mar, 2023" / "३० मार्च, २०२३".
  String gregorianDate(DateTime date) => devanagari
      ? '${digits('${date.day}')} ${_adMonthShort(date.month)}, '
            '${digits('${date.year}')}'
      : DateFormat('d MMM, yyyy').format(date);

  /// "2023-03-30" / "२०२३-०३-३०".
  String adIso(DateTime date) => digits(DateFormat('yyyy-MM-dd').format(date));

  /// "2079-11-04" / "२०७९-११-०४" in the traditional calendar.
  String traditionalIso(DateTime date) {
    final t = calendar.fromGregorian(date);
    return digits('${t.year}-${_two(t.month)}-${_two(t.day)}');
  }

  /// Full weekday name in the current language.
  String weekday(DateTime date) => _weekdaysFor(languageCode)[date.weekday % 7];

  /// One/two letter weekday headers (Sun … Sat).
  List<String> get weekdayInitials => switch (languageCode) {
    'ne' => const ['आ', 'सो', 'मं', 'बु', 'बि', 'शु', 'श'],
    'hi' => const ['र', 'सो', 'मं', 'बु', 'गु', 'शु', 'श'],
    _ => const ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
  };

  /// Full Gregorian month name in the current language.
  String gregorianMonthName(int month) => switch (languageCode) {
    'ne' => _adMonthsNe[month - 1],
    'hi' => _adMonthsHi[month - 1],
    _ => _adMonthsEn[month - 1],
  };

  // ---------------------------------------------------------------- times

  /// "8:30 PM" / "८:३० PM".
  String slotLabel(TimeSlot slot) => time(slot.hour, slot.minute);

  String time(int hour, int minute) {
    final h12 = hour % 12 == 0 ? 12 : hour % 12;
    final suffix = hour < 12 ? 'AM' : 'PM';
    return '${digits('$h12:${_two(minute)}')} $suffix';
  }

  /// Hour part / meridiem part for the summary-card badge ("8:30", "PM").
  (String, String) timeParts(TimeSlot slot) {
    final full = slotLabel(slot);
    final idx = full.lastIndexOf(' ');
    return (full.substring(0, idx), full.substring(idx + 1));
  }

  /// "IST (02:27 PM)" – time-zone label from the region config.
  String timeZoneNow([DateTime? now]) {
    final t = now ?? DateTime.now();
    return '${config.timeZoneLabel} (${time(t.hour, t.minute)})';
  }

  // ---------------------------------------------------------------- money

  /// "Rs. 2,000" / "रु. २,०००" (Nepal) · "₹2,000" / "₹२,०००" (India).
  String money(num amount) =>
      RegionFormat.money(amount, config: config, languageCode: languageCode);

  /// "Rs. 5,000 - 10,000" / "₹5,000 - 10,000" – symbol shown once.
  String moneyRange(num min, num max) {
    final maxDigits = money(
      max,
    ).substring(config.currencySymbol.length).trimLeft();
    return '${money(min)} - $maxDigits';
  }

  /// "+977 9841000000" – national numbers get the region prefix.
  String phone(String national) => national.trim().startsWith('+')
      ? digits(national)
      : digits(RegionFormat.phone(national, config: config));

  // -------------------------------------------------------------- numbers

  /// "116K" / "११६K".
  String compact(int n) => digits(n >= 1000 ? '${(n / 1000).round()}K' : '$n');

  String number(num n) => digits('$n');

  static String _two(int n) => n.toString().padLeft(2, '0');

  static List<String> _weekdaysFor(String languageCode) =>
      switch (languageCode) {
        'ne' => _weekdaysNe,
        'hi' => _weekdaysHi,
        _ => _weekdaysEn,
      };

  String _adMonthShort(int month) => switch (languageCode) {
    'ne' => _adMonthsNe[month - 1],
    'hi' => _adMonthsHi[month - 1],
    _ => DateFormat('MMM').format(DateTime(2000, month)),
  };

  static const List<String> _weekdaysEn = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  static const List<String> _weekdaysNe = [
    'आइतबार',
    'सोमबार',
    'मंगलबार',
    'बुधबार',
    'बिहीबार',
    'शुक्रबार',
    'शनिबार',
  ];
  static const List<String> _weekdaysHi = [
    'रविवार',
    'सोमवार',
    'मंगलवार',
    'बुधवार',
    'गुरुवार',
    'शुक्रवार',
    'शनिवार',
  ];
  static const List<String> _adMonthsEn = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  static const List<String> _adMonthsNe = [
    'जनवरी',
    'फेब्रुअरी',
    'मार्च',
    'अप्रिल',
    'मे',
    'जुन',
    'जुलाई',
    'अगस्ट',
    'सेप्टेम्बर',
    'अक्टोबर',
    'नोभेम्बर',
    'डिसेम्बर',
  ];
  static const List<String> _adMonthsHi = [
    'जनवरी',
    'फ़रवरी',
    'मार्च',
    'अप्रैल',
    'मई',
    'जून',
    'जुलाई',
    'अगस्त',
    'सितंबर',
    'अक्टूबर',
    'नवंबर',
    'दिसंबर',
  ];
}
