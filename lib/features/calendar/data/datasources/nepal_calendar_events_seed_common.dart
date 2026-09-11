import 'package:nepali_utils/nepali_utils.dart';

import '../models/calendar_event_model.dart';

/// Compact factory used by the Nepal seed files: entries are authored in
/// Bikram Sambat ([y]/[m]/[d]) and stored on their Gregorian date.
CalendarEventModel seedEvent(
  String id,
  int y,
  int m,
  int d,
  String ne,
  String en, {
  String descNe = '',
  String descEn = '',
  String tithiNe = '',
  String tithiEn = '',
  bool holiday = false,
}) => CalendarEventModel(
  id: id,
  date: _toGregorian(y, m, d),
  titleNe: ne,
  titleEn: en,
  descriptionNe: descNe,
  descriptionEn: descEn,
  tithiNe: tithiNe,
  tithiEn: tithiEn,
  isHoliday: holiday,
);

DateTime _toGregorian(int y, int m, int d) {
  final ad = NepaliDateTime(y, m, d).toDateTime();
  return DateTime(ad.year, ad.month, ad.day);
}

const String seedholiDescNe =
    'विभिन्न रङहरूका माध्यमबाट प्रेम, आत्मीयता र सद्भाव बर्साई संसारलाई हर्ष '
    'र उमङ्ग प्रदान गर्ने रमाइलो क्रीडापर्व हो– होली अर्थात् फागु पूर्णिमा। '
    'पहाडमा फागुन शुक्ल पूर्णिमाका दिन र तराईमा भोलिपल्ट मनाइन्छ।';
const String seedholiDescEn =
    'Holi, the festival of colours, celebrates love and harmony. In the '
    'hills it falls on Falgun Shukla Purnima and in the Terai the day after.';
const String seedshivaratriNe =
    'भगवान शिवको आराधना गरिने महापर्व। पशुपतिनाथमा लाखौँ भक्तजनको भीड लाग्छ।';
const String seedshivaratriEn =
    'The great night of Lord Shiva; devotees throng Pashupatinath temple.';
const String seeddashamiNe =
    'दशैंको मुख्य दिन – मान्यजनबाट टीका र जमरा लगाई आशीर्वाद लिइन्छ।';
const String seeddashamiEn =
    'Main day of Dashain – elders bless the young with tika and jamara.';
const String seedtiharNe =
    'धनकी देवी लक्ष्मीको पूजा गरी घर–आँगन दीपले सजाइन्छ।';
const String seedtiharEn =
    'Goddess Laxmi is worshipped and homes are lit with oil lamps.';
