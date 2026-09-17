import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'push_config.dart';
import 'push_payload.dart';
import 'push_service.dart';

/// Handles a push that arrives while the app is in the background or dead.
///
/// Must be a top-level function with `vm:entry-point`: the platform starts a
/// *new* isolate to run it, with none of the app's state. It deliberately does
/// nothing — the system already displays the notification — but registering it
/// is what stops Firebase logging a warning on every background delivery.
@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {}

/// Firebase Cloud Messaging, plus local notifications for the foreground case.
///
/// Android does not display an incoming notification while the app is open, so
/// a message that arrives on a screen the user is looking at has to be drawn by
/// the app itself — that is what `flutter_local_notifications` is here for, and
/// why the channels are created at startup rather than on first use.
class FirebasePushService implements PushService {
  FirebasePushService({FlutterLocalNotificationsPlugin? local})
    : _local = local ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _local;
  final StreamController<PushPayload> _opened =
      StreamController<PushPayload>.broadcast();

  FirebaseMessaging? _messaging;
  bool _started = false;

  @override
  Stream<PushPayload> get onOpened => _opened.stream;

  @override
  Stream<String> get onTokenRefresh =>
      _messaging?.onTokenRefresh ?? const Stream<String>.empty();

  @override
  Future<bool> start() async {
    if (_started) return true;
    try {
      if (!await _initialiseFirebase()) return false;

      final messaging = FirebaseMessaging.instance;
      _messaging = messaging;

      // Asks once; on a later run the system returns the saved answer without
      // showing anything. Android 13+ treats this as the POST_NOTIFICATIONS
      // runtime permission.
      final settings = await messaging.requestPermission();
      final allowed =
          settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
      if (!allowed) {
        debugPrint('[push] permission not granted — notifications disabled');
        return false;
      }

      await _createChannels();
      await _local.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
        onDidReceiveNotificationResponse: _onLocalTap,
      );

      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      FirebaseMessaging.onMessage.listen(_showWhileOpen);
      FirebaseMessaging.onMessageOpenedApp.listen(_emitOpened);

      // A notification that launched the app from cold: delivered once, and
      // only after the app is listening, or the tap is lost.
      final initial = await messaging.getInitialMessage();
      if (initial != null) _emitOpened(initial);

      _started = true;
      return true;
    } catch (error, stack) {
      // No Firebase configuration, no Play Services, a simulator without a
      // provisioning profile: all of them mean "no push", none of them mean
      // "do not start the app".
      debugPrint('[push] unavailable: $error');
      debugPrintStack(stackTrace: stack);
      return false;
    }
  }

  @override
  Future<String?> token() async {
    try {
      return await _messaging?.getToken();
    } catch (error) {
      debugPrint('[push] could not read the token: $error');
      return null;
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _messaging?.deleteToken();
    } catch (error) {
      // The token is dropped server-side on the next failed send anyway.
      debugPrint('[push] could not delete the token: $error');
    }
  }

  Future<bool> _initialiseFirebase() async {
    if (Firebase.apps.isNotEmpty) return true;
    if (PushConfig.hasDartDefineOptions) {
      await Firebase.initializeApp(options: PushConfig.options);
      return true;
    }
    // No dart-defines: fall back to the native configuration file, and treat
    // its absence as "push is not set up in this build".
    await Firebase.initializeApp();
    return true;
  }

  Future<void> _createChannels() async {
    final android = _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android == null) return;

    for (final channel in const [
      AndroidNotificationChannel(
        PushChannels.messages,
        'Messages',
        description: 'Chat messages from shops and astrologers',
        importance: Importance.high,
      ),
      AndroidNotificationChannel(
        PushChannels.calls,
        'Calls',
        description: 'Incoming voice and video consultations',
        importance: Importance.max,
      ),
      AndroidNotificationChannel(
        PushChannels.general,
        'General',
        description: 'Orders, festivals, reminders and horoscopes',
      ),
    ]) {
      await android.createNotificationChannel(channel);
    }
  }

  /// Draws a notification for a message that arrived while the app is open.
  void _showWhileOpen(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    final channelId = switch (message.data['kind']) {
      'message' => PushChannels.messages,
      'consultation' => PushChannels.calls,
      _ => PushChannels.general,
    };

    unawaited(
      _local.show(
        // Same id for one conversation, so a burst replaces rather than piles
        // up — matching the collapse key the server sends.
        id: (message.data['threadId'] ?? message.messageId ?? '').hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            channelId,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.data),
      ),
    );
  }

  void _onLocalTap(NotificationResponse response) {
    final raw = response.payload;
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) _opened.add(PushPayload.fromData(decoded));
    } catch (_) {
      // A payload we cannot read is not a reason to crash on a tap.
    }
  }

  void _emitOpened(RemoteMessage message) =>
      _opened.add(PushPayload.fromData(message.data));

  Future<void> dispose() => _opened.close();
}
