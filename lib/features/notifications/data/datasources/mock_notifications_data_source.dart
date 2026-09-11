import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/app_notification.dart';
import '../models/app_notification_model.dart';
import 'notifications_data_source.dart';

/// In-memory inbox with deterministic trilingual seed data (relative to
/// [now]).
///
/// The seed is region-aware: it is rebuilt on every call from
/// `resolver.config`, so switching Nepal ⇄ India at runtime changes the
/// festival / welcome items. Read state is kept per notification id and
/// survives region switches.
class MockNotificationsDataSource implements NotificationsDataSource {
  MockNotificationsDataSource({required RegionResolver resolver, DateTime? now})
    : _resolver = resolver,
      _now = now ?? DateTime.now();

  final RegionResolver _resolver;
  final DateTime _now;

  /// Read-state overrides keyed by notification id (`markRead` survives
  /// region switches because the seed itself is never cached).
  final Map<String, bool> _read = {};

  List<AppNotificationModel> _items() => [
    for (final n in _seed(_resolver.config, _now))
      _read.containsKey(n.id) ? n.copyWith(isRead: _read[n.id]!) : n,
  ];

  static List<AppNotificationModel> _seed(RegionConfig config, DateTime now) {
    final india = config.isIndia;
    return [
      AppNotificationModel(
        id: 'n1',
        titleNe: 'आजको राशिफल तयार छ',
        titleEn: 'Your daily horoscope is ready',
        titleHi: 'आपका आज का राशिफल तैयार है',
        bodyNe: 'मेष राशिका लागि आज मनोबल उच्च रहनेछ। रोकिएका काम बन्नेछन्।',
        bodyEn: 'Aries: high spirits today – stalled work moves forward.',
        bodyHi: 'मेष: आज मनोबल ऊँचा रहेगा – रुके हुए काम आगे बढ़ेंगे।',
        createdAt: now.subtract(const Duration(hours: 1)),
        type: NotificationType.horoscope,
        route: '/horoscope',
      ),
      AppNotificationModel(
        id: 'n2',
        titleNe: 'मेरो जन्मदिन',
        titleEn: 'My Birthday',
        titleHi: 'मेरा जन्मदिन',
        bodyNe:
            'तपाईंको जन्मदिन ७ दिनमा आउँदैछ। दृश्य लाउन्जमा साथीभाइसँग मनाउने '
            'योजना सम्झनुहोस्।',
        bodyEn:
            'Your birthday is in 7 days. Remember the plan to celebrate with '
            'friends and family at Drishya Lounge.',
        bodyHi:
            'आपका जन्मदिन ७ दिनों में है। दृश्य लाउंज में दोस्तों और परिवार '
            'के साथ मनाने की योजना याद रखें।',
        createdAt: now.subtract(const Duration(hours: 2)),
        type: NotificationType.birthday,
        route: '/events?tab=personal',
      ),
      if (india)
        AppNotificationModel(
          id: 'n7',
          titleNe: 'दीपावली सम्झना',
          titleEn: 'Diwali reminder',
          titleHi: 'दिवाली अनुस्मारक',
          bodyNe:
              'दीपावली ३ दिनमा छ। दियो, रङ्गोली र लक्ष्मी पूजाको सामग्री '
              'तयार गर्नुहोस्।',
          bodyEn:
              'Diwali is in 3 days. Get your diyas, rangoli and Lakshmi '
              'puja items ready.',
          bodyHi:
              'दिवाली ३ दिन बाद है। दीये, रंगोली और लक्ष्मी पूजा की सामग्री '
              'तैयार रखें।',
          createdAt: now.subtract(const Duration(hours: 3)),
          type: NotificationType.festival,
          route: '/events',
        )
      else
        AppNotificationModel(
          id: 'n7',
          titleNe: 'दशैँ सम्झना',
          titleEn: 'Dashain reminder',
          titleHi: 'दशैं अनुस्मारक',
          bodyNe:
              'घटस्थापना ३ दिनमा छ – दशैँ सुरु हुँदैछ। टीका, जमरा र पूजा '
              'सामग्री तयार गर्नुहोस्।',
          bodyEn:
              'Ghatasthapana is in 3 days – Dashain begins. Get your tika, '
              'jamara and puja items ready.',
          bodyHi:
              'घटस्थापना ३ दिन बाद है – दशैं शुरू हो रहा है। टीका, जमरा और '
              'पूजा सामग्री तैयार रखें।',
          createdAt: now.subtract(const Duration(hours: 3)),
          type: NotificationType.festival,
          route: '/events',
        ),
      AppNotificationModel(
        id: 'n3',
        titleNe: 'सार्वजनिक बिदा भोलि',
        titleEn: 'Public holiday tomorrow',
        titleHi: 'कल सार्वजनिक अवकाश',
        bodyNe: 'भोलि सार्वजनिक बिदा छ। सरकारी कार्यालय र बैंक बन्द रहनेछन्।',
        bodyEn:
            'Tomorrow is a public holiday. Government offices and banks will '
            'remain closed.',
        bodyHi: 'कल सार्वजनिक अवकाश है। सरकारी कार्यालय और बैंक बंद रहेंगे।',
        createdAt: now.subtract(const Duration(hours: 5)),
        type: NotificationType.festival,
        isRead: true,
        route: '/events',
      ),
      AppNotificationModel(
        id: 'n4',
        titleNe: 'अर्डर पुष्टि भयो',
        titleEn: 'Order confirmed',
        titleHi: 'ऑर्डर की पुष्टि हुई',
        bodyNe: 'तपाईंको रुद्राक्ष मालाको अर्डर बिक्रेताले स्वीकार गर्नुभयो।',
        bodyEn:
            'Your order for the Rudraksha mala has been approved by the seller.',
        bodyHi:
            'आपके रुद्राक्ष माला के ऑर्डर को विक्रेता ने स्वीकार कर लिया है।',
        createdAt: now.subtract(const Duration(days: 1)),
        type: NotificationType.order,
        isRead: true,
        route: '/profile',
      ),
      AppNotificationModel(
        id: 'n5',
        titleNe: 'चिना हेराइ अपोइन्टमेन्ट',
        titleEn: 'Cheena reading appointment',
        titleHi: 'कुंडली पठन अपॉइंटमेंट',
        bodyNe: 'डा. उत्तम उपाध्यायसँगको अपोइन्टमेन्ट भोलि साँझ ८:३० बजे छ।',
        bodyEn:
            'Your appointment with Dr. Uttam Upadhyaya is tomorrow at 8:30 PM.',
        bodyHi: 'डॉ. उत्तम उपाध्याय के साथ आपका अपॉइंटमेंट कल रात ८:३० बजे है।',
        createdAt: now.subtract(const Duration(days: 2)),
        type: NotificationType.appointment,
        isRead: true,
        route: '/appointments',
      ),
      if (india)
        AppNotificationModel(
          id: 'n6',
          titleNe: 'सनातनमा स्वागत छ',
          titleEn: 'Welcome to Sanatan',
          titleHi: 'सनातन में आपका स्वागत है',
          bodyNe:
              'पात्रो, राशिफल, पञ्चाङ्ग र कार्यक्रम एकै ठाउँमा। सूचना सेटिङ '
              'आफ्नो अनुसार मिलाउनुहोस्।',
          bodyEn:
              'Calendar, horoscope, panchang and events in one place. Tune '
              'your notification settings to your liking.',
          bodyHi:
              'कैलेंडर, राशिफल, पंचांग और कार्यक्रम एक ही जगह। सूचना '
              'सेटिंग अपनी पसंद के अनुसार सेट करें।',
          createdAt: now.subtract(const Duration(days: 6)),
          isRead: true,
          route: '/notifications/settings',
        )
      else
        AppNotificationModel(
          id: 'n6',
          titleNe: 'सनातन नेपालमा स्वागत छ',
          titleEn: 'Welcome to Sanatan Nepal',
          titleHi: 'सनातन नेपाल में आपका स्वागत है',
          bodyNe:
              'पात्रो, राशिफल, पञ्चाङ्ग र कार्यक्रम एकै ठाउँमा। सूचना सेटिङ '
              'आफ्नो अनुसार मिलाउनुहोस्।',
          bodyEn:
              'Patro, horoscope, panchanga and events in one place. Tune '
              'your notification settings to your liking.',
          bodyHi:
              'पात्रो, राशिफल, पंचांग और कार्यक्रम एक ही जगह। सूचना सेटिंग '
              'अपनी पसंद के अनुसार सेट करें।',
          createdAt: now.subtract(const Duration(days: 6)),
          isRead: true,
          route: '/notifications/settings',
        ),
    ];
  }

  @override
  Future<List<AppNotificationModel>> fetchAll() async {
    final list = _items()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return List.unmodifiable(list);
  }

  @override
  Future<AppNotificationModel> markRead(String id) async {
    final item = _items().where((n) => n.id == id).firstOrNull;
    if (item == null) throw NotFoundException('Notification $id not found');
    _read[id] = true;
    return item.copyWith(isRead: true);
  }

  @override
  Future<void> markAllRead() async {
    for (final n in _items()) {
      _read[n.id] = true;
    }
  }
}
