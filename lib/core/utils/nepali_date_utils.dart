import 'package:nepali_utils/nepali_utils.dart';

/// Pure helpers for Bikram Sambat ⇄ Gregorian conversion and formatting.
abstract final class NepaliDateUtils {
  static const List<String> monthsNe = [
    'बैशाख',
    'जेठ',
    'असार',
    'साउन',
    'भदौ',
    'असोज',
    'कार्तिक',
    'मंसिर',
    'पुष',
    'माघ',
    'फागुन',
    'चैत',
  ];
  static const List<String> monthsEn = [
    'Baishakh',
    'Jestha',
    'Ashadh',
    'Shrawan',
    'Bhadra',
    'Ashwin',
    'Kartik',
    'Mangsir',
    'Poush',
    'Magh',
    'Falgun',
    'Chaitra',
  ];
  static const List<String> weekdaysNe = [
    'आ',
    'सो',
    'मं',
    'बु',
    'बि',
    'शु',
    'श',
  ];
  static const List<String> weekdaysEn = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  static const List<String> weekdaysFullNe = [
    'आइतबार',
    'सोमबार',
    'मंगलबार',
    'बुधबार',
    'बिहीबार',
    'शुक्रबार',
    'शनिबार',
  ];

  static NepaliDateTime toBs(DateTime ad) => ad.toNepaliDateTime();
  static DateTime toAd(NepaliDateTime bs) => bs.toDateTime();

  static String monthName(int month, {required bool nepali}) =>
      (nepali ? monthsNe : monthsEn)[month - 1];

  /// e.g. "फागुन, २०७९"
  static String formatBsMonthYear(NepaliDateTime d, {required bool nepali}) {
    final year = nepali ? NepaliUnicode.convert('${d.year}') : '${d.year}';
    return '${monthName(d.month, nepali: nepali)}, $year';
  }

  /// e.g. "फागुन ११, २०७९"
  static String formatBsFull(NepaliDateTime d, {required bool nepali}) {
    final year = nepali ? NepaliUnicode.convert('${d.year}') : '${d.year}';
    final day = nepali ? NepaliUnicode.convert('${d.day}') : '${d.day}';
    return '${monthName(d.month, nepali: nepali)} $day, $year';
  }

  static String weekdayFullNe(DateTime d) => weekdaysFullNe[d.weekday % 7];

  static String toDevanagari(int n) => NepaliUnicode.convert('$n');
}
