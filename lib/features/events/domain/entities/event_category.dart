/// High-level grouping used by the tabs of the events page
/// (Figma: "चाडपर्वहरू | मेरो कार्यक्रमहरू | गर्नु-पर्ने कार्यहरु").
enum EventGroup { festival, personal, todo }

/// Fine-grained category of an [Event]. Festival categories mirror the filter
/// chips of the "Festivals" tab, personal ones the chips of "My Events".
enum EventCategory {
  hinduFestival(EventGroup.festival),
  buddhistFestival(EventGroup.festival),
  islamicFestival(EventGroup.festival),
  kiratFestival(EventGroup.festival),
  christianFestival(EventGroup.festival),
  sikhFestival(EventGroup.festival),
  jainFestival(EventGroup.festival),
  publicHoliday(EventGroup.festival),
  birthday(EventGroup.personal),
  personal(EventGroup.personal),
  official(EventGroup.personal),
  anniversary(EventGroup.personal),
  travel(EventGroup.personal),
  picnic(EventGroup.personal),
  adventure(EventGroup.personal),
  sports(EventGroup.personal),
  todo(EventGroup.todo);

  const EventCategory(this.group);

  /// Tab this category belongs to.
  final EventGroup group;

  /// Categories the user may pick when creating an event of [group].
  static List<EventCategory> forGroup(EventGroup group) =>
      values.where((c) => c.group == group).toList(growable: false);

  /// Festival filter chips of the events page for Nepal
  /// (Figma: सबै | महत्वपुर्ण | सरकारी बिदा | हिन्दु | बौद्ध | इस्लाम | किरात | क्रिश्चियन).
  static const List<EventCategory> nepalFestivalFilters = [
    publicHoliday,
    hinduFestival,
    buddhistFestival,
    islamicFestival,
    kiratFestival,
    christianFestival,
  ];

  /// Festival filter chips for India
  /// (All | Important | Public Holidays | Hindu | Muslim | Sikh | Christian |
  /// Buddhist | Jain).
  static const List<EventCategory> indiaFestivalFilters = [
    publicHoliday,
    hinduFestival,
    islamicFestival,
    sikhFestival,
    christianFestival,
    buddhistFestival,
    jainFestival,
  ];

  static EventCategory fromName(String? name) => values.firstWhere(
    (c) => c.name == name,
    orElse: () => EventCategory.personal,
  );
}

/// Recurrence of a user-created event.
enum EventRepeat {
  none,
  daily,
  weekly,
  monthly,
  yearly;

  static EventRepeat fromName(String? name) =>
      values.firstWhere((r) => r.name == name, orElse: () => EventRepeat.none);
}
