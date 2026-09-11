import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';

/// How the user authenticated.
enum AuthProvider { google, apple, phone }

/// Result of a successful authentication.
///
/// [isNewUser] tells the presentation layer whether to collect profile
/// details ([UserProfileDraft]) before entering the app.
@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String userId,
    required AuthProvider provider,
    required bool isNewUser,
    String? displayName,
    String? phoneNumber,
    String? email,
  }) = _AuthSession;
}
