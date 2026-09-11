import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/utils/nepali_date_utils.dart';

/// Feature-local strings for notifications (English / Nepali / Hindi).
///
/// Nothing here is region-specific – festival section labels read the same
/// for Nepal and India; region-dependent text lives in the seed data.
abstract class NotificationsStrings {
  const NotificationsStrings();

  static NotificationsStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get pageTitle;
  String get tabNotifications;
  String get tabSettings;
  String get markAllRead;
  String get empty;
  String get horoscopeSection;
  String get daily;
  String get monthly;
  String get yearly;
  String get notificationTime;
  String get festivalsSection;
  String get importantHinduFestivals;
  String get commonFestivals;
  String get publicHolidays;
  String get remindMeBefore;
  String get daysAt;
  String get birthdaySection;
  String get saved;

  /// "1h ago" / "१ घण्टा अघि" / "१ घंटा पहले"
  String timeAgo(Duration elapsed);

  String digits(int n);
}

class _En extends NotificationsStrings {
  const _En();
  @override
  String get pageTitle => 'Notifications';
  @override
  String get tabNotifications => 'Notifications';
  @override
  String get tabSettings => 'Notification Settings';
  @override
  String get markAllRead => 'Mark all as read';
  @override
  String get empty => 'No notifications yet';
  @override
  String get horoscopeSection => 'Horoscope Notification Setting';
  @override
  String get daily => 'Daily';
  @override
  String get monthly => 'Monthly';
  @override
  String get yearly => 'Yearly';
  @override
  String get notificationTime => 'Notification Time';
  @override
  String get festivalsSection => 'Festivals Notification Setting';
  @override
  String get importantHinduFestivals => 'Important Hindu Festivals';
  @override
  String get commonFestivals => 'Common Festivals';
  @override
  String get publicHolidays => 'Public Holidays';
  @override
  String get remindMeBefore => 'Remind me before';
  @override
  String get daysAt => 'Days at';
  @override
  String get birthdaySection => 'Birthday Notification Setting';
  @override
  String get saved => 'Settings saved';

  @override
  String timeAgo(Duration e) {
    if (e.inMinutes < 1) return 'just now';
    if (e.inHours < 1) return '${e.inMinutes}m ago';
    if (e.inDays < 1) return '${e.inHours}h ago';
    if (e.inDays < 30) return '${e.inDays}d ago';
    return '${e.inDays ~/ 30}mo ago';
  }

  @override
  String digits(int n) => '$n';
}

class _Ne extends NotificationsStrings {
  const _Ne();
  @override
  String get pageTitle => 'सूचनाहरू';
  @override
  String get tabNotifications => 'सूचनाहरू';
  @override
  String get tabSettings => 'सूचना सेटिङ';
  @override
  String get markAllRead => 'सबै पढिएको चिन्ह लगाउनुहोस्';
  @override
  String get empty => 'अहिलेसम्म कुनै सूचना छैन';
  @override
  String get horoscopeSection => 'राशिफल सूचना सेटिङ';
  @override
  String get daily => 'दैनिक';
  @override
  String get monthly => 'मासिक';
  @override
  String get yearly => 'वार्षिक';
  @override
  String get notificationTime => 'सूचना समय';
  @override
  String get festivalsSection => 'चाडपर्व सूचना सेटिङ';
  @override
  String get importantHinduFestivals => 'महत्वपूर्ण हिन्दु चाडपर्व';
  @override
  String get commonFestivals => 'सामान्य चाडपर्व';
  @override
  String get publicHolidays => 'सार्वजनिक बिदा';
  @override
  String get remindMeBefore => 'सम्झाउनुहोस्';
  @override
  String get daysAt => 'दिन पहिले';
  @override
  String get birthdaySection => 'जन्मदिन सूचना सेटिङ';
  @override
  String get saved => 'सेटिङ सुरक्षित गरियो';

  @override
  String timeAgo(Duration e) {
    if (e.inMinutes < 1) return 'भर्खरै';
    if (e.inHours < 1) return '${digits(e.inMinutes)} मिनेट अघि';
    if (e.inDays < 1) return '${digits(e.inHours)} घण्टा अघि';
    if (e.inDays < 30) return '${digits(e.inDays)} दिन अघि';
    return '${digits(e.inDays ~/ 30)} महिना अघि';
  }

  @override
  String digits(int n) => NepaliDateUtils.toDevanagari(n);
}

class _Hi extends NotificationsStrings {
  const _Hi();
  @override
  String get pageTitle => 'सूचनाएँ';
  @override
  String get tabNotifications => 'सूचनाएँ';
  @override
  String get tabSettings => 'सूचना सेटिंग';
  @override
  String get markAllRead => 'सभी को पढ़ा हुआ चिह्नित करें';
  @override
  String get empty => 'अभी तक कोई सूचना नहीं';
  @override
  String get horoscopeSection => 'राशिफल सूचना सेटिंग';
  @override
  String get daily => 'दैनिक';
  @override
  String get monthly => 'मासिक';
  @override
  String get yearly => 'वार्षिक';
  @override
  String get notificationTime => 'सूचना समय';
  @override
  String get festivalsSection => 'त्योहार सूचना सेटिंग';
  @override
  String get importantHinduFestivals => 'प्रमुख हिंदू त्योहार';
  @override
  String get commonFestivals => 'सामान्य त्योहार';
  @override
  String get publicHolidays => 'सार्वजनिक अवकाश';
  @override
  String get remindMeBefore => 'याद दिलाएँ';
  @override
  String get daysAt => 'दिन पहले';
  @override
  String get birthdaySection => 'जन्मदिन सूचना सेटिंग';
  @override
  String get saved => 'सेटिंग सहेजी गई';

  @override
  String timeAgo(Duration e) {
    if (e.inMinutes < 1) return 'अभी-अभी';
    if (e.inHours < 1) return '${digits(e.inMinutes)} मिनट पहले';
    if (e.inDays < 1) {
      final h = e.inHours;
      return '${digits(h)} ${h == 1 ? 'घंटा' : 'घंटे'} पहले';
    }
    if (e.inDays < 30) return '${digits(e.inDays)} दिन पहले';
    return '${digits(e.inDays ~/ 30)} महीने पहले';
  }

  @override
  String digits(int n) => '$n'.toDevanagariDigits();
}
