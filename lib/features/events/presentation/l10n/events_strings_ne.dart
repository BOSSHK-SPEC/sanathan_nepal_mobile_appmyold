part of 'events_strings.dart';

class _Ne extends EventsStrings {
  const _Ne();
  @override
  String get pageTitle => 'मेरो कार्यक्रमहरू';
  @override
  String get homeSectionTitle => 'कार्यक्रमहरू';
  @override
  String get viewCalendar => 'क्यालेन्डर हेर्नुहोस्';
  @override
  String get tabFestivals => 'चाडपर्वहरू';
  @override
  String get tabMyEvents => 'मेरो कार्यक्रमहरू';
  @override
  String get tabTodo => 'गर्नु-पर्ने कार्यहरु';
  @override
  String get filterAll => 'सबै';
  @override
  String get filterImportant => 'महत्वपुर्ण';
  @override
  String get filterGovHolidays => 'सरकारी बिदा';
  @override
  String get filterPublicHolidays => 'सार्वजनिक बिदा';
  @override
  String get holiday => 'बिदा';
  @override
  String get vrat => 'ब्रत';
  @override
  String get today => 'आज';
  @override
  String get homeAllEvents => 'सबै कार्यक्रमहरू';
  @override
  String get homeMyEvents => 'मेरो कार्यक्रमहरू';
  @override
  String get noEvents => 'कार्यक्रम उपलब्ध छैन |';
  @override
  String get daysLeft => 'दिन बाँकी';
  @override
  String get daysLeftLabel => 'दिन बाँकी';
  @override
  String get publicHoliday => 'सार्वजनिक विदा';
  @override
  String get others => 'अन्य';
  @override
  String get addEventReminder => 'Add Event/Reminder';
  @override
  String get newEvent => 'नयाँ कार्यक्रम';
  @override
  String get newReminder => 'गर्नु-पर्ने कार्यहरु';
  @override
  String get date => 'मिति';
  @override
  String get myEvents => 'मेरो कार्यक्रमहरू';
  @override
  String get todoLists => 'गर्नु-पर्ने कार्यहरु';
  @override
  String get reminderPrefix => 'अनुस्मारक';
  @override
  String get noReminder => 'यस कार्यक्रमको लागि अनुस्मारक सेट गरिएको छैन।';
  @override
  String get panchangaLink => 'पञ्चाङ्ग र शुभ साइत';
  @override
  String get panchangaLinkMuhurat => 'पञ्चाङ्ग र शुभ मुहूर्त';
  @override
  String get tabVideo => 'भिडियो';
  @override
  String get tabDescription => 'विवरण';
  @override
  String get tabHowToCelebrate => 'कसरि मनाउने';
  @override
  String get tabPlaces => 'आकर्षण स्थलहरू';
  @override
  String get checklist => 'गर्नुपर्ने सूची';
  @override
  String get location => 'स्थान';
  @override
  String get repeat => 'दोहोर्याउनुहोस्';
  @override
  String get formTitleNew => 'नयाँ कार्यक्रम';
  @override
  String get formTitleEdit => 'कार्यक्रम सम्पादन';
  @override
  String get createEvent => 'कार्यक्रम सिर्जना गर्नुहोस्';
  @override
  String get createTodo => 'सिर्जना गर्नुहोस्';
  @override
  String get titleHint => 'शीर्षक लेख्नुहोस्';
  @override
  String get eventDate => 'कार्यक्रम मिति';
  @override
  String get bs => 'वि.सं.';
  @override
  String get ad => 'ई.सं.';
  @override
  String get tithi => 'तिथि';
  @override
  String get eventTime => 'कार्यक्रम समय';
  @override
  String get pickTime => 'समय छान्नुहोस्';
  @override
  String get repeatYes => 'दोहोरिने';
  @override
  String get repeatNo => 'नदोहोरिने';
  @override
  String get addDescription => 'विवरण थप्नुहोस';
  @override
  String get descriptionHint => 'कार्यक्रमको विवरण लेख्नुहोस्';
  @override
  String get todoList => 'गर्नुपर्ने सूची';
  @override
  String get newListItem => 'नयाँ सूची थप्नुहोस्';
  @override
  String get add => 'थप्नुहोस्';
  @override
  String get locationHint => 'कार्यक्रम स्थान';
  @override
  String get category => 'वर्ग';
  @override
  String get reminderLabel => 'सूचना';
  @override
  String get remindBefore => 'सूचना';
  @override
  String get daysAt => 'दिन पहिले';
  @override
  String get daysBefore => 'दिन पहिले';
  @override
  String get cancel => 'रद्द गर्नुहोस्';
  @override
  String get create => 'सिर्जना गर्नुहोस्';
  @override
  String get update => 'अद्यावधिक गर्नुहोस्';
  @override
  String get titleRequired => 'कृपया शीर्षक लेख्नुहोस्';
  @override
  String get deleteTitle => 'के तपाईं यो कार्यक्रम मेटाउन निश्चित हुनुहुन्छ?';
  @override
  String get deleteMessage => 'यो कार्य पूर्ववत गर्न सकिँदैन।';
  @override
  String get delete => 'मेटाउनुहोस्';
  @override
  String get eventDeleted => 'कार्यक्रम मेटाइयो';
  @override
  String get eventSaved => 'कार्यक्रम सुरक्षित गरियो';
  @override
  String get selectDate => 'मिति छान्नुहोस्';
  @override
  String get confirm => 'परिवर्तन गर्नुहोस्';
  @override
  String get edit => 'सम्पादन';
  @override
  String get moreOptions => 'थप विकल्पहरू';

  @override
  String daysRemaining(int days) => days == 0
      ? 'आज'
      : days < 0
      ? '${NepaliDateUtils.toDevanagari(-days)} दिन अघि'
      : '${NepaliDateUtils.toDevanagari(days)} दिन बाँकी';
  @override
  String reminderText(int days, String time) =>
      'अनुस्मारक: ${NepaliDateUtils.toDevanagari(days)} दिन पहिले $time मा';
  @override
  String category_(EventCategory c) => switch (c) {
    EventCategory.hinduFestival => 'हिन्दु चाड',
    EventCategory.buddhistFestival => 'बौद्ध धर्म',
    EventCategory.islamicFestival => 'इस्लाम',
    EventCategory.kiratFestival => 'किरात',
    EventCategory.christianFestival => 'क्रिश्चियन',
    EventCategory.sikhFestival => 'सिख',
    EventCategory.jainFestival => 'जैन',
    EventCategory.publicHoliday => 'सार्वजनिक विदा',
    EventCategory.birthday => 'जन्मदिन',
    EventCategory.personal => 'व्यक्तिगत',
    EventCategory.official => 'आधिकारिक',
    EventCategory.anniversary => 'वार्षिक उत्सब',
    EventCategory.travel => 'यात्रा',
    EventCategory.picnic => 'बनभोज',
    EventCategory.adventure => 'साहसिक',
    EventCategory.sports => 'खेलकुद',
    EventCategory.todo => 'गर्नु-पर्ने',
  };
  @override
  String group(EventGroup g) => switch (g) {
    EventGroup.festival => tabFestivals,
    EventGroup.personal => tabMyEvents,
    EventGroup.todo => tabTodo,
  };
  @override
  String repeatLabel(EventRepeat r) => switch (r) {
    EventRepeat.none => 'नदोहोरिने',
    EventRepeat.daily => 'हरेक दिन',
    EventRepeat.weekly => 'हरेक हप्ता',
    EventRepeat.monthly => 'हरेक महिना',
    EventRepeat.yearly => 'हरेक वर्ष',
  };
  @override
  List<String> get weekdays => NepaliDateUtils.weekdaysFullNe;
}
