import 'dart:convert';

import '../../../../core/storage/key_value_store.dart';
import '../models/auth_session_model.dart';
import '../models/user_profile_draft_model.dart';

/// Persists the "logged in" flag, the current session and the submitted
/// profile draft via [KeyValueStore].
abstract interface class AuthLocalDataSource {
  bool get isLoggedIn;
  AuthSessionModel? readSession();
  Future<void> writeSession(AuthSessionModel session);
  Future<void> writeProfile(UserProfileDraftModel profile);
  UserProfileDraftModel? readProfile();
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._store);
  final KeyValueStore _store;

  static const String kLoggedIn = 'auth.logged_in';
  static const String kSession = 'auth.session';
  static const String kProfile = 'auth.profile';

  @override
  bool get isLoggedIn => _store.getBool(kLoggedIn) ?? false;

  @override
  AuthSessionModel? readSession() {
    final raw = _store.getString(kSession);
    if (raw == null) return null;
    return AuthSessionModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> writeSession(AuthSessionModel session) async {
    await Future.wait([
      _store.setBool(kLoggedIn, true),
      _store.setString(kSession, jsonEncode(session.toJson())),
    ]);
  }

  @override
  UserProfileDraftModel? readProfile() {
    final raw = _store.getString(kProfile);
    if (raw == null) return null;
    return UserProfileDraftModel.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> writeProfile(UserProfileDraftModel profile) =>
      _store.setString(kProfile, jsonEncode(profile.toJson()));

  @override
  Future<void> clear() async {
    await Future.wait([
      _store.remove(kLoggedIn),
      _store.remove(kSession),
      _store.remove(kProfile),
    ]);
  }
}
