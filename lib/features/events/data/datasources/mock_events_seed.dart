import '../../../../core/calendar/calendar.dart';
import '../../../../core/region/region.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../models/event_model.dart';
import 'india_festivals_seed.dart';
import 'mock_festivals_seed.dart';

/// Deterministic seed data for [MockEventsDataSource].
///
/// Festivals are selected by region: Nepal rows are expressed in Bikram
/// Sambat (month/day) and resolved to the next occurrence on or after [now];
/// India rows carry real Gregorian dates (2025–2027). Personal events / to-dos
/// are placed relative to [now] so the lists always show something upcoming.
abstract final class MockEventsSeed {
  static List<EventModel> build(
    DateTime now, {
    RegionConfig config = RegionConfig.nepal,
  }) {
    final today = DateTime(now.year, now.month, now.day);
    return [
      ...festivals(today, config: config),
      ...userRows(today, config: config),
    ];
  }

  /// Personal events + to-dos (region only affects sample locations).
  static List<EventModel> userRows(
    DateTime now, {
    RegionConfig config = RegionConfig.nepal,
  }) {
    final today = DateTime(now.year, now.month, now.day);
    return _models([..._personal(today, config), ..._todos(today)]);
  }

  /// Region-specific festival / holiday rows.
  static List<EventModel> festivals(
    DateTime today, {
    required RegionConfig config,
  }) => _models(
    config.isIndia
        ? IndiaFestivalsSeed.build(today)
        : MockFestivalsSeed.build(today, _bs),
  );

  static List<EventModel> _models(List<Event> rows) => [
    for (final e in rows) EventModel.fromEntity(e),
  ];

  static const _bikram = BikramSambatCalendar();

  /// Next AD date on/after [today] for a BS month/day (Nepal seed only –
  /// Bikram Sambat is explicitly required here).
  static DateTime _bs(DateTime today, int month, int day) {
    var year = _bikram.fromGregorian(today).year;
    var ad = _safeBs(year, month, day);
    if (ad.isBefore(today)) ad = _safeBs(++year, month, day);
    return ad;
  }

  static DateTime _safeBs(int year, int month, int day) {
    final maxDay = _bikram.daysInMonth(year, month);
    return _bikram.toGregorian(
      TraditionalDate(year, month, day > maxDay ? maxDay : day),
    );
  }

  static List<Event> _personal(DateTime today, RegionConfig config) => [
    Event(
      id: 'usr-anniversary',
      title: const LocalizedText(
        ne: 'वार्षिक उत्सव',
        en: 'Anniversary',
        hi: 'वर्षगाँठ',
      ),
      description: const LocalizedText(
        ne: 'घरमा परिवार, आफन्त र साथीभाइसँग मनाउने।',
        en: 'Celebrate at home with family members, inviting relatives and friends.',
        hi: 'घर पर परिवार, रिश्तेदारों और दोस्तों के साथ मनाएँ।',
      ),
      date: today.add(const Duration(days: 20)),
      time: const EventTime(hour: 18, minute: 0),
      category: EventCategory.anniversary,
      location: LocalizedText(
        ne: 'घर, ${config.defaultCity.nameNe}',
        en: 'Home, ${config.defaultCity.nameEn}',
        hi: 'घर, ${config.defaultCity.nameHi}',
      ),
      checklist: const [
        ChecklistItem(id: 'c1', label: 'Invite guests', isDone: true),
        ChecklistItem(id: 'c2', label: 'Party Decoration', isDone: true),
        ChecklistItem(id: 'c3', label: 'Cake Order'),
        ChecklistItem(id: 'c4', label: 'Venue Fix'),
        ChecklistItem(id: 'c5', label: 'Party Theme Finalization'),
      ],
      reminder: const EventReminder(
        daysBefore: 1,
        time: EventTime(hour: 6, minute: 0),
      ),
      repeat: EventRepeat.yearly,
    ),
    Event(
      id: 'usr-office-meeting',
      title: const LocalizedText(
        ne: 'कार्यालय बैठक',
        en: 'Office Meeting',
        hi: 'कार्यालय बैठक',
      ),
      description: const LocalizedText(
        ne: 'प्रगति प्रतिवेदन र प्रस्तुति तयार गर्नुपर्ने। ABC को सहयोग चाहिन्छ।',
        en:
            'About Progress Report – needs to prepare report and presentation. '
            'Need help from ABC.',
        hi: 'प्रगति रिपोर्ट और प्रस्तुति तैयार करनी है। ABC की मदद चाहिए।',
      ),
      date: today.add(const Duration(days: 8)),
      time: const EventTime(hour: 10, minute: 30),
      category: EventCategory.official,
      location: config.isIndia
          ? const LocalizedText(
              ne: 'कार्यालय, गुरुग्राम',
              en: 'Office, Gurugram',
              hi: 'कार्यालय, गुरुग्राम',
            )
          : const LocalizedText(
              ne: 'कार्यालय, ललितपुर',
              en: 'Office, Lalitpur',
            ),
      reminder: const EventReminder(
        daysBefore: 1,
        time: EventTime(hour: 6, minute: 0),
      ),
    ),
    Event(
      id: 'usr-rafting',
      title: config.isIndia
          ? const LocalizedText(
              ne: 'ऋषिकेश में राफ्टिंग',
              en: 'Rafting at Rishikesh',
              hi: 'ऋषिकेश में राफ्टिंग',
            )
          : const LocalizedText(
              ne: 'सुकुटे बिचमा र्‍याफ्टिङ',
              en: 'Rafting at Sukute Beach',
            ),
      description: config.isIndia
          ? const LocalizedText(
              ne: 'लंबे सप्ताहांत पर दोस्तों के साथ गंगा में राफ्टिंग की योजना।',
              en: 'Rafting plan with friends on the Ganga over the long weekend.',
              hi: 'लंबे सप्ताहांत पर दोस्तों के साथ गंगा में राफ्टिंग की योजना।',
            )
          : const LocalizedText(
              ne: 'नयाँ वर्षमा साथीहरूसँग सुकुटे बिचमा र्‍याफ्टिङ जाने योजना।',
              en: 'Rafting plan with friends during Nepali New Year at Sukute Beach.',
            ),
      date: today.add(const Duration(days: 4)),
      category: EventCategory.adventure,
      location: config.isIndia
          ? const LocalizedText(
              ne: 'ऋषिकेश, उत्तराखंड',
              en: 'Rishikesh, Uttarakhand',
              hi: 'ऋषिकेश, उत्तराखंड',
            )
          : const LocalizedText(
              ne: 'सुकुटे, सिन्धुपाल्चोक',
              en: 'Sukute, Sindhupalchok',
            ),
      checklist: const [
        ChecklistItem(id: 'c1', label: 'Book raft'),
        ChecklistItem(id: 'c2', label: 'Hire jeep', isDone: true),
      ],
    ),
    Event(
      id: 'usr-birthday',
      title: const LocalizedText(
        ne: 'मेरो जन्मदिन',
        en: 'My Birthday',
        hi: 'मेरा जन्मदिन',
      ),
      description: const LocalizedText(
        ne: 'दृश्य लाउन्जमा साथीभाइ र परिवारसँग जन्मदिन मनाउने।',
        en: 'My birthday – celebrate with my friends and family at Drishya Lounge.',
        hi: 'मेरा जन्मदिन – दृश्य लाउंज में दोस्तों और परिवार के साथ मनाएँ।',
      ),
      date: today.add(const Duration(days: 34)),
      time: const EventTime(hour: 19, minute: 0),
      category: EventCategory.birthday,
      location: LocalizedText(
        ne: 'दृश्य लाउन्ज, ${config.defaultCity.nameNe}',
        en: 'Drishya Lounge, ${config.defaultCity.nameEn}',
        hi: 'दृश्य लाउंज, ${config.defaultCity.nameHi}',
      ),
      checklist: const [
        ChecklistItem(id: 'c1', label: 'Invite guests'),
        ChecklistItem(id: 'c2', label: 'Cake Order'),
        ChecklistItem(id: 'c3', label: 'Birthday Return Gift Shopping'),
      ],
      reminder: const EventReminder(
        daysBefore: 7,
        time: EventTime(hour: 0, minute: 0),
      ),
      repeat: EventRepeat.yearly,
    ),
    Event(
      id: 'usr-picnic',
      title: const LocalizedText(
        ne: 'कार्यालय बनभोज',
        en: 'Office Picnic',
        hi: 'कार्यालय पिकनिक',
      ),
      description: config.isIndia
          ? const LocalizedText(
              ne: 'लोधी गार्डन में वार्षिक कार्यालय पिकनिक।',
              en: 'Annual office picnic at Lodhi Garden.',
              hi: 'लोधी गार्डन में वार्षिक कार्यालय पिकनिक।',
            )
          : const LocalizedText(
              ne: 'गोदावरीमा वार्षिक कार्यालय बनभोज।',
              en: 'Annual office picnic at Godawari.',
            ),
      date: today.add(const Duration(days: 47)),
      category: EventCategory.picnic,
      location: config.isIndia
          ? const LocalizedText(
              ne: 'लोधी गार्डन, नई दिल्ली',
              en: 'Lodhi Garden, New Delhi',
              hi: 'लोधी गार्डन, नई दिल्ली',
            )
          : const LocalizedText(
              ne: 'गोदावरी, ललितपुर',
              en: 'Godawari, Lalitpur',
            ),
    ),
  ];

  static List<Event> _todos(DateTime today) => [
    Event(
      id: 'todo-house-rent',
      title: const LocalizedText(
        ne: 'घर भाडा',
        en: 'House Rent',
        hi: 'मकान किराया',
      ),
      date: today.add(const Duration(days: 2)),
      category: EventCategory.todo,
      reminder: const EventReminder(
        daysBefore: 1,
        time: EventTime(hour: 9, minute: 0),
      ),
      repeat: EventRepeat.monthly,
    ),
    Event(
      id: 'todo-medicine',
      title: const LocalizedText(
        ne: 'औषधी खाने समय',
        en: 'Medicine Time',
        hi: 'दवा का समय',
      ),
      date: today,
      time: const EventTime(hour: 8, minute: 0),
      category: EventCategory.todo,
      repeat: EventRepeat.daily,
    ),
    Event(
      id: 'todo-electricity',
      title: const LocalizedText(
        ne: 'बिजुली बिल',
        en: 'Electricity Bill',
        hi: 'बिजली बिल',
      ),
      date: today.add(const Duration(days: 6)),
      category: EventCategory.todo,
      repeat: EventRepeat.monthly,
    ),
    Event(
      id: 'todo-servicing',
      title: const LocalizedText(
        ne: 'गाडी सर्भिसिङ',
        en: 'Vehicle Servicing',
        hi: 'गाड़ी सर्विसिंग',
      ),
      date: today.add(const Duration(days: 12)),
      category: EventCategory.todo,
      checklist: const [
        ChecklistItem(id: 'c1', label: 'Oil change'),
        ChecklistItem(id: 'c2', label: 'Bluebook Renew'),
      ],
    ),
  ];
}
