import 'package:firebase_core/firebase_core.dart';

/// Firebase credentials, from `--dart-define` rather than a checked-in file.
///
/// Same rule as [AppEnvironment]: nothing that identifies a project is
/// committed. A build that passes none of these still compiles and runs — push
/// simply reports itself unavailable — which is what keeps `flutter run`
/// working for anyone without the Firebase project.
///
/// ```
/// flutter run \
///   --dart-define=FIREBASE_API_KEY=… \
///   --dart-define=FIREBASE_APP_ID=1:123:android:abc \
///   --dart-define=FIREBASE_PROJECT_ID=sanatan-nepal \
///   --dart-define=FIREBASE_SENDER_ID=123456789
/// ```
///
/// A project configured the usual native way (`google-services.json` /
/// `GoogleService-Info.plist`) needs none of these: with no defines the app
/// initialises Firebase from the native configuration instead.
abstract final class PushConfig {
  const PushConfig._();

  static const String _apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const String _appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const String _projectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
  );
  static const String _senderId = String.fromEnvironment('FIREBASE_SENDER_ID');

  /// True when every value needed to initialise Firebase was passed in.
  static bool get hasDartDefineOptions =>
      _apiKey.isNotEmpty &&
      _appId.isNotEmpty &&
      _projectId.isNotEmpty &&
      _senderId.isNotEmpty;

  /// Options built from the defines. Only read when [hasDartDefineOptions].
  static FirebaseOptions get options => const FirebaseOptions(
    apiKey: _apiKey,
    appId: _appId,
    projectId: _projectId,
    messagingSenderId: _senderId,
  );
}

/// Android notification channels.
///
/// Declared in one place because the server names them too: a message sent to
/// a channel the app never created is shown with default importance on
/// Android, which is how "silent notifications" bugs start.
abstract final class PushChannels {
  const PushChannels._();

  /// Chat messages — heads-up, with sound.
  static const String messages = 'messages';

  /// Everything else: orders, festivals, horoscopes.
  static const String general = 'general';

  /// A ringing consultation. Highest importance; bypasses "silent" grouping.
  static const String calls = 'calls';
}
