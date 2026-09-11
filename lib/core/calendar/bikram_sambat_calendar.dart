import 'package:nepali_utils/nepali_utils.dart';

import '../utils/nepali_date_utils.dart';
import 'traditional_calendar.dart';
import 'traditional_date.dart';

/// Bikram Sambat (वि.सं.) – Nepal's official calendar, backed by
/// `nepali_utils` lookup tables (accurate 1970–2100 BS).
class BikramSambatCalendar implements TraditionalCalendar {
  const BikramSambatCalendar();

  @override
  String get id => 'bs';

  @override
  int get minYear => 1970;

  @override
  int get maxYear => 2100;

  @override
  List<int> get weekendWeekdays => const [6];

  @override
  String eraLabel({required String languageCode}) => switch (languageCode) {
    'ne' => 'वि.सं.',
    'hi' => 'वि.सं.',
    _ => 'B.S.',
  };

  @override
  String displayName({required String languageCode}) => switch (languageCode) {
    'ne' => 'बिक्रम सम्वत्',
    'hi' => 'विक्रम संवत् (नेपाल)',
    _ => 'Bikram Sambat',
  };

  @override
  TraditionalDate fromGregorian(DateTime date) {
    final bs = date.toNepaliDateTime();
    return TraditionalDate(bs.year, bs.month, bs.day);
  }

  @override
  DateTime toGregorian(TraditionalDate date) {
    final ad = NepaliDateTime(date.year, date.month, date.day).toDateTime();
    return DateTime(ad.year, ad.month, ad.day);
  }

  @override
  int daysInMonth(int year, int month) => NepaliDateTime(year, month).totalDays;

  @override
  List<String> monthNames({required String languageCode}) =>
      languageCode == 'ne' || languageCode == 'hi'
      ? NepaliDateUtils.monthsNe
      : NepaliDateUtils.monthsEn;

  @override
  String monthName(int month, {required String languageCode}) =>
      monthNames(languageCode: languageCode)[month - 1];
}
