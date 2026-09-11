import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/utils/nepali_date_utils.dart';
import '../../domain/entities/event_category.dart';

part 'events_strings_hi.dart';
part 'events_strings_ne.dart';

/// Feature-local trilingual strings for events (Figma "Events Page",
/// "Events Details", "ADD NEW EVENT FORM").
abstract class EventsStrings {
  const EventsStrings();

  static EventsStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get pageTitle;
  String get homeSectionTitle;
  String get viewCalendar;
  String get tabFestivals;
  String get tabMyEvents;
  String get tabTodo;
  String get filterAll;
  String get filterImportant;
  String get filterGovHolidays;
  String get filterPublicHolidays;
  String get holiday;
  String get vrat;
  String get today;
  String get homeAllEvents;
  String get homeMyEvents;
  String get noEvents;
  String get daysLeft;
  String get daysLeftLabel;
  String get publicHoliday;
  String get others;
  String get addEventReminder;
  String get newEvent;
  String get newReminder;
  String get date;
  String get myEvents;
  String get todoLists;
  String get reminderPrefix;
  String get noReminder;
  String get panchangaLink;
  String get panchangaLinkMuhurat;
  String get tabVideo;
  String get tabDescription;
  String get tabHowToCelebrate;
  String get tabPlaces;
  String get checklist;
  String get location;
  String get repeat;
  String get formTitleNew;
  String get formTitleEdit;
  String get createEvent;
  String get createTodo;
  String get titleHint;
  String get eventDate;
  String get bs;
  String get ad;
  String get tithi;
  String get eventTime;
  String get pickTime;
  String get repeatYes;
  String get repeatNo;
  String get addDescription;
  String get descriptionHint;
  String get todoList;
  String get newListItem;
  String get add;
  String get locationHint;
  String get category;
  String get reminderLabel;
  String get remindBefore;
  String get daysAt;
  String get daysBefore;
  String get cancel;
  String get create;
  String get update;
  String get titleRequired;
  String get deleteTitle;
  String get deleteMessage;
  String get delete;
  String get eventDeleted;
  String get eventSaved;
  String get selectDate;
  String get confirm;
  String get edit;
  String get moreOptions;

  String beforeAt(int days, String time) => '$remindBefore $days $daysAt $time';

  String daysRemaining(int days);
  String reminderText(int days, String time);
  String category_(EventCategory c);
  String group(EventGroup g);
  String repeatLabel(EventRepeat r);

  /// Full weekday names, index 0 = Sunday.
  List<String> get weekdays;

  /// Holidays chip: "Government Holidays" (Nepal) / "Public Holidays" (India).
  String filterHolidays(RegionConfig config) =>
      config.isIndia ? filterPublicHolidays : filterGovHolidays;

  /// Link to the panchanga page: Suva Sait (Nepal) / Shubh Muhurat (India).
  String panchangaLinkFor(RegionConfig config) =>
      config.isIndia ? panchangaLinkMuhurat : panchangaLink;
}

class _En extends EventsStrings {
  const _En();
  @override
  String get pageTitle => 'My Events';
  @override
  String get homeSectionTitle => 'Events';
  @override
  String get viewCalendar => 'View Calendar';
  @override
  String get tabFestivals => 'Festivals';
  @override
  String get tabMyEvents => 'My Events';
  @override
  String get tabTodo => 'To-Do';
  @override
  String get filterAll => 'All';
  @override
  String get filterImportant => 'Important';
  @override
  String get filterGovHolidays => 'Government Holidays';
  @override
  String get filterPublicHolidays => 'Public Holidays';
  @override
  String get holiday => 'Holiday';
  @override
  String get vrat => 'Vrat';
  @override
  String get today => 'Today';
  @override
  String get homeAllEvents => 'All Events';
  @override
  String get homeMyEvents => 'My Events';
  @override
  String get noEvents => 'Events not available';
  @override
  String get daysLeft => 'Days';
  @override
  String get daysLeftLabel => 'Days Left';
  @override
  String get publicHoliday => 'Public Holiday';
  @override
  String get others => 'Others';
  @override
  String get addEventReminder => 'Add Event/Reminder';
  @override
  String get newEvent => 'New Event';
  @override
  String get newReminder => 'New Reminder';
  @override
  String get date => 'Date';
  @override
  String get myEvents => 'My Events';
  @override
  String get todoLists => 'To-Do Lists';
  @override
  String get reminderPrefix => 'Reminder';
  @override
  String get noReminder => 'No Reminder set for this event.';
  @override
  String get panchangaLink => 'Panchanga & Suva Sait';
  @override
  String get panchangaLinkMuhurat => 'Panchanga & Shubh Muhurat';
  @override
  String get tabVideo => 'Video';
  @override
  String get tabDescription => 'Description';
  @override
  String get tabHowToCelebrate => 'How To Celebrate';
  @override
  String get tabPlaces => 'Attraction Places';
  @override
  String get checklist => 'Checklist';
  @override
  String get location => 'Location';
  @override
  String get repeat => 'Repeat';
  @override
  String get formTitleNew => 'New Event';
  @override
  String get formTitleEdit => 'Edit Event';
  @override
  String get createEvent => 'Create Event';
  @override
  String get createTodo => 'Create To-Do';
  @override
  String get titleHint => 'Title';
  @override
  String get eventDate => 'Event Date';
  @override
  String get bs => 'B.S';
  @override
  String get ad => 'A.D';
  @override
  String get tithi => 'Tithi';
  @override
  String get eventTime => 'Event Time';
  @override
  String get pickTime => 'Select time';
  @override
  String get repeatYes => 'Yes';
  @override
  String get repeatNo => 'No';
  @override
  String get addDescription => 'Add Description';
  @override
  String get descriptionHint => 'Event Description';
  @override
  String get todoList => 'To Do List';
  @override
  String get newListItem => 'Add new list item';
  @override
  String get add => 'Add';
  @override
  String get locationHint => 'Event Location';
  @override
  String get category => 'Category';
  @override
  String get reminderLabel => 'Notification';
  @override
  String get remindBefore => 'Remind me before';
  @override
  String get daysAt => 'Days at';
  @override
  String get daysBefore => 'days before';
  @override
  String get cancel => 'Cancel';
  @override
  String get create => 'Create';
  @override
  String get update => 'Update';
  @override
  String get titleRequired => 'Please enter a title';
  @override
  String get deleteTitle => 'Are you sure you want to delete this event?';
  @override
  String get deleteMessage => 'This action cannot be undone.';
  @override
  String get delete => 'Delete';
  @override
  String get eventDeleted => 'Event deleted';
  @override
  String get eventSaved => 'Event saved';
  @override
  String get selectDate => 'Select Date';
  @override
  String get confirm => 'Confirm';
  @override
  String get edit => 'Edit';
  @override
  String get moreOptions => 'More options';

  @override
  String daysRemaining(int days) => days == 0
      ? 'Today'
      : days < 0
      ? '${-days} Days Ago'
      : '$days Days Remaining';
  @override
  String reminderText(int days, String time) =>
      'Reminder: $days day${days == 1 ? '' : 's'} before at $time';
  @override
  String category_(EventCategory c) => switch (c) {
    EventCategory.hinduFestival => 'Hindu',
    EventCategory.buddhistFestival => 'Buddhism',
    EventCategory.islamicFestival => 'Islam',
    EventCategory.kiratFestival => 'Kirat',
    EventCategory.christianFestival => 'Christianity',
    EventCategory.sikhFestival => 'Sikh',
    EventCategory.jainFestival => 'Jain',
    EventCategory.publicHoliday => 'Public Holiday',
    EventCategory.birthday => 'Birthday',
    EventCategory.personal => 'Personal',
    EventCategory.official => 'Official',
    EventCategory.anniversary => 'Anniversary',
    EventCategory.travel => 'Travel',
    EventCategory.picnic => 'Picnic',
    EventCategory.adventure => 'Adventure',
    EventCategory.sports => 'Sports',
    EventCategory.todo => 'To-Do',
  };
  @override
  String group(EventGroup g) => switch (g) {
    EventGroup.festival => tabFestivals,
    EventGroup.personal => tabMyEvents,
    EventGroup.todo => tabTodo,
  };
  @override
  String repeatLabel(EventRepeat r) => switch (r) {
    EventRepeat.none => 'Does not repeat',
    EventRepeat.daily => 'Every day',
    EventRepeat.weekly => 'Every week',
    EventRepeat.monthly => 'Every month',
    EventRepeat.yearly => 'Every year',
  };
  @override
  List<String> get weekdays => const [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
}
