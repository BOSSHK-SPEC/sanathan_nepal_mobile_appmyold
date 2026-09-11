part of 'events_strings.dart';

class _Hi extends EventsStrings {
  const _Hi();
  @override
  String get pageTitle => 'मेरे कार्यक्रम';
  @override
  String get homeSectionTitle => 'कार्यक्रम';
  @override
  String get viewCalendar => 'कैलेंडर देखें';
  @override
  String get tabFestivals => 'त्योहार';
  @override
  String get tabMyEvents => 'मेरे कार्यक्रम';
  @override
  String get tabTodo => 'करने योग्य कार्य';
  @override
  String get filterAll => 'सभी';
  @override
  String get filterImportant => 'महत्वपूर्ण';
  @override
  String get filterGovHolidays => 'सरकारी अवकाश';
  @override
  String get filterPublicHolidays => 'सार्वजनिक अवकाश';
  @override
  String get holiday => 'अवकाश';
  @override
  String get vrat => 'व्रत';
  @override
  String get today => 'आज';
  @override
  String get homeAllEvents => 'सभी कार्यक्रम';
  @override
  String get homeMyEvents => 'मेरे कार्यक्रम';
  @override
  String get noEvents => 'कोई कार्यक्रम उपलब्ध नहीं है।';
  @override
  String get daysLeft => 'दिन शेष';
  @override
  String get daysLeftLabel => 'दिन शेष';
  @override
  String get publicHoliday => 'सार्वजनिक अवकाश';
  @override
  String get others => 'अन्य';
  @override
  String get addEventReminder => 'कार्यक्रम/रिमाइंडर जोड़ें';
  @override
  String get newEvent => 'नया कार्यक्रम';
  @override
  String get newReminder => 'नया रिमाइंडर';
  @override
  String get date => 'तिथि';
  @override
  String get myEvents => 'मेरे कार्यक्रम';
  @override
  String get todoLists => 'कार्य सूची';
  @override
  String get reminderPrefix => 'रिमाइंडर';
  @override
  String get noReminder => 'इस कार्यक्रम के लिए कोई रिमाइंडर सेट नहीं है।';
  @override
  String get panchangaLink => 'पंचांग एवं शुभ साइत';
  @override
  String get panchangaLinkMuhurat => 'पंचांग एवं शुभ मुहूर्त';
  @override
  String get tabVideo => 'वीडियो';
  @override
  String get tabDescription => 'विवरण';
  @override
  String get tabHowToCelebrate => 'कैसे मनाएँ';
  @override
  String get tabPlaces => 'आकर्षण स्थल';
  @override
  String get checklist => 'चेकलिस्ट';
  @override
  String get location => 'स्थान';
  @override
  String get repeat => 'दोहराएँ';
  @override
  String get formTitleNew => 'नया कार्यक्रम';
  @override
  String get formTitleEdit => 'कार्यक्रम संपादित करें';
  @override
  String get createEvent => 'कार्यक्रम बनाएँ';
  @override
  String get createTodo => 'कार्य बनाएँ';
  @override
  String get titleHint => 'शीर्षक';
  @override
  String get eventDate => 'कार्यक्रम की तिथि';
  @override
  String get bs => 'वि.सं.';
  @override
  String get ad => 'ई.सं.';
  @override
  String get tithi => 'तिथि';
  @override
  String get eventTime => 'कार्यक्रम का समय';
  @override
  String get pickTime => 'समय चुनें';
  @override
  String get repeatYes => 'हाँ';
  @override
  String get repeatNo => 'नहीं';
  @override
  String get addDescription => 'विवरण जोड़ें';
  @override
  String get descriptionHint => 'कार्यक्रम का विवरण';
  @override
  String get todoList => 'कार्य सूची';
  @override
  String get newListItem => 'नया आइटम जोड़ें';
  @override
  String get add => 'जोड़ें';
  @override
  String get locationHint => 'कार्यक्रम का स्थान';
  @override
  String get category => 'श्रेणी';
  @override
  String get reminderLabel => 'सूचना';
  @override
  String get remindBefore => 'मुझे पहले याद दिलाएँ';
  @override
  String get daysAt => 'दिन, समय';
  @override
  String get daysBefore => 'दिन पहले';
  @override
  String get cancel => 'रद्द करें';
  @override
  String get create => 'बनाएँ';
  @override
  String get update => 'अपडेट करें';
  @override
  String get titleRequired => 'कृपया शीर्षक लिखें';
  @override
  String get deleteTitle => 'क्या आप वाकई इस कार्यक्रम को हटाना चाहते हैं?';
  @override
  String get deleteMessage => 'यह कार्रवाई पूर्ववत नहीं की जा सकती।';
  @override
  String get delete => 'हटाएँ';
  @override
  String get eventDeleted => 'कार्यक्रम हटा दिया गया';
  @override
  String get eventSaved => 'कार्यक्रम सहेजा गया';
  @override
  String get selectDate => 'तिथि चुनें';
  @override
  String get confirm => 'पुष्टि करें';
  @override
  String get edit => 'संपादित करें';
  @override
  String get moreOptions => 'अधिक विकल्प';

  @override
  String daysRemaining(int days) => days == 0
      ? 'आज'
      : days < 0
      ? '${NepaliDateUtils.toDevanagari(-days)} दिन पहले'
      : '${NepaliDateUtils.toDevanagari(days)} दिन शेष';
  @override
  String reminderText(int days, String time) =>
      'रिमाइंडर: ${NepaliDateUtils.toDevanagari(days)} दिन पहले $time बजे';
  @override
  String category_(EventCategory c) => switch (c) {
    EventCategory.hinduFestival => 'हिन्दू',
    EventCategory.buddhistFestival => 'बौद्ध',
    EventCategory.islamicFestival => 'मुस्लिम',
    EventCategory.kiratFestival => 'किरात',
    EventCategory.christianFestival => 'ईसाई',
    EventCategory.sikhFestival => 'सिख',
    EventCategory.jainFestival => 'जैन',
    EventCategory.publicHoliday => 'सार्वजनिक अवकाश',
    EventCategory.birthday => 'जन्मदिन',
    EventCategory.personal => 'व्यक्तिगत',
    EventCategory.official => 'कार्यालयीन',
    EventCategory.anniversary => 'वर्षगाँठ',
    EventCategory.travel => 'यात्रा',
    EventCategory.picnic => 'पिकनिक',
    EventCategory.adventure => 'साहसिक',
    EventCategory.sports => 'खेल',
    EventCategory.todo => 'कार्य',
  };
  @override
  String group(EventGroup g) => switch (g) {
    EventGroup.festival => tabFestivals,
    EventGroup.personal => tabMyEvents,
    EventGroup.todo => tabTodo,
  };
  @override
  String repeatLabel(EventRepeat r) => switch (r) {
    EventRepeat.none => 'दोहराया नहीं जाता',
    EventRepeat.daily => 'हर दिन',
    EventRepeat.weekly => 'हर सप्ताह',
    EventRepeat.monthly => 'हर महीने',
    EventRepeat.yearly => 'हर वर्ष',
  };
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
