import '../../../../core/calendar/calendar.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/utils/nepali_date_utils.dart';
import '../../domain/entities/calendar_month.dart';
import '../../domain/entities/calendar_view_mode.dart';

/// Pure formatting helpers shared by the calendar, date-converter and home
/// UI. Region-agnostic: callers pass the active [TraditionalCalendar] /
/// [RegionConfig] and the UI language code (`en`, `ne`, `hi`).
abstract final class CalendarFormat {
  static const List<String> adMonthsEn = [
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
  static const List<String> adMonthsNe = [
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
  static const List<String> adMonthsHi = [
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
  static const List<String> weekdaysShortEn = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];
  static const List<String> weekdaysShortHi = [
    'रवि',
    'सोम',
    'मंगल',
    'बुध',
    'गुरु',
    'शुक्र',
    'शनि',
  ];
  static const List<String> weekdaysFullEn = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  static const List<String> weekdaysFullHi = [
    'रविवार',
    'सोमवार',
    'मंगलवार',
    'बुधवार',
    'गुरुवार',
    'शुक्रवार',
    'शनिवार',
  ];

  /// Whether digits render in Devanagari for [languageCode] (ne, hi).
  static bool devanagari(String languageCode) =>
      TraditionalCalendar.devanagariDigits(languageCode);

  static String digits(int n, {required bool devanagari}) =>
      devanagari ? NepaliDateUtils.toDevanagari(n) : '$n';

  static String adMonth(int month, {required String languageCode}) =>
      switch (languageCode) {
        'ne' => adMonthsNe,
        'hi' => adMonthsHi,
        _ => adMonthsEn,
      }[month - 1];

  static String adMonthShort(int month) =>
      adMonthsEn[month - 1].substring(0, 3);

  /// "फागुन,२०७९" / "Falgun, 2079" / "Shravana, 1948 Saka" (with [era]).
  static String traditionalMonthTitle(
    TraditionalCalendar calendar,
    int year,
    int month, {
    required String languageCode,
    bool era = false,
  }) {
    final dev = devanagari(languageCode);
    final name = calendar.monthName(month, languageCode: languageCode);
    final y = digits(year, devanagari: dev);
    final title = dev ? '$name,$y' : '$name, $y';
    return era
        ? '$title ${calendar.eraLabel(languageCode: languageCode)}'
        : title;
  }

  /// "March, 2023" / "मार्च, २०२३"
  static String adMonthTitle(
    int year,
    int month, {
    required String languageCode,
  }) =>
      '${adMonth(month, languageCode: languageCode)}, '
      '${digits(year, devanagari: devanagari(languageCode))}';

  /// Header primary line for a month in its view mode.
  static String monthTitle(
    CalendarMonth m, {
    required TraditionalCalendar calendar,
    required String languageCode,
  }) => m.mode == CalendarViewMode.traditional
      ? traditionalMonthTitle(
          calendar,
          m.year,
          m.month,
          languageCode: languageCode,
        )
      : adMonthTitle(m.year, m.month, languageCode: languageCode);

  /// Header secondary line – the *other* calendar's span, e.g.
  /// "Feb/Mar , 2023" for a BS month, "फागुन/चैत , २०७९" for an AD month in
  /// Nepal, or "Shravana/Bhadrapada , 1948 Saka · Vikram Samvat 2083" for
  /// an AD month in India (regions listing `SamvatKind.vikram`).
  static String monthSubtitle(
    CalendarMonth m, {
    required RegionConfig config,
    required String languageCode,
  }) {
    final days = m.currentMonthDays;
    if (days.isEmpty) return '';
    final first = days.first;
    final last = days.last;
    if (m.mode == CalendarViewMode.traditional) {
      final a = adMonthShort(first.ad.month);
      final b = adMonthShort(last.ad.month);
      final years = first.ad.year == last.ad.year
          ? '${last.ad.year}'
          : '${first.ad.year}/${last.ad.year}';
      return a == b ? '$a , $years' : '$a/$b , $years';
    }
    final calendar = config.calendar;
    final dev = devanagari(languageCode);
    final a = calendar.monthName(
      first.traditional.month,
      languageCode: languageCode,
    );
    final b = calendar.monthName(
      last.traditional.month,
      languageCode: languageCode,
    );
    final years = first.traditional.year == last.traditional.year
        ? digits(last.traditional.year, devanagari: dev)
        : '${digits(first.traditional.year, devanagari: dev)}/'
              '${digits(last.traditional.year, devanagari: dev)}';
    var text = a == b ? '$a , $years' : '$a/$b , $years';
    if (config.samvatLabels.contains(SamvatKind.vikram)) {
      final vs = VikramSamvat.yearFor(last.ad);
      text =
          '$text ${calendar.eraLabel(languageCode: languageCode)} · '
          '${vikramSamvatLabel(languageCode)} ${digits(vs, devanagari: dev)}';
    }
    return text;
  }

  static String vikramSamvatLabel(String languageCode) =>
      devanagari(languageCode) ? 'विक्रम संवत्' : 'Vikram Samvat';

  /// "फागुन २२, २०७९" / "Falgun 22, 2079" / "Shravana 27, 1948 Saka".
  static String traditionalDate(
    TraditionalDate d, {
    required TraditionalCalendar calendar,
    required String languageCode,
    bool era = false,
  }) {
    final dev = devanagari(languageCode);
    final text =
        '${calendar.monthName(d.month, languageCode: languageCode)} '
        '${digits(d.day, devanagari: dev)}, ${digits(d.year, devanagari: dev)}';
    return era
        ? '$text ${calendar.eraLabel(languageCode: languageCode)}'
        : text;
  }

  /// "06 March, 2023" (Latin, matches Figma even in Nepali mode) or
  /// "६ मार्च, २०२३" when a Devanagari [languageCode] is passed explicitly.
  static String adDate(DateTime d, {String languageCode = 'en'}) {
    if (devanagari(languageCode)) {
      return '${digits(d.day, devanagari: true)} '
          '${adMonth(d.month, languageCode: languageCode)}, '
          '${digits(d.year, devanagari: true)}';
    }
    final day = d.day.toString().padLeft(2, '0');
    return '$day ${adMonth(d.month, languageCode: 'en')}, ${d.year}';
  }

  /// "February 23 , 2023" – event-card style.
  static String adDateLong(DateTime d) =>
      '${adMonth(d.month, languageCode: 'en')} ${d.day} , ${d.year}';

  static String weekdayFull(DateTime d, {required String languageCode}) =>
      switch (languageCode) {
        'ne' => NepaliDateUtils.weekdayFullNe(d),
        'hi' => weekdaysFullHi[d.weekday % 7],
        _ => weekdaysFullEn[d.weekday % 7],
      };

  static String weekdayShort(int index, {required String languageCode}) =>
      switch (languageCode) {
        'ne' => NepaliDateUtils.weekdaysNe[index],
        'hi' => weekdaysShortHi[index],
        _ => weekdaysShortEn[index],
      };

  /// "6:26" / "६:२६"
  static String time(DateTime t, {required bool devanagari}) {
    final s = '${t.hour}:${t.minute.toString().padLeft(2, '0')}';
    return devanagari ? s.toDevanagariDigits() : s;
  }

  /// "02:27 PM"
  static String time12(DateTime t) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final suffix = t.hour < 12 ? 'AM' : 'PM';
    return '${h.toString().padLeft(2, '0')}:'
        '${t.minute.toString().padLeft(2, '0')} $suffix';
  }
}
