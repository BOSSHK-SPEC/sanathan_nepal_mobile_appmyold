import 'dart:convert';

import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/user_profile.dart';
import '../models/user_profile_model.dart';

/// Persists the user profile as JSON in [KeyValueStore]; falls back to a
/// region-aware mock default ("Kritika Paudel" for Nepal, "Priya Sharma" for
/// India) when nothing is stored yet.
abstract interface class ProfileLocalDataSource {
  UserProfileModel read();
  Future<void> write(UserProfileModel model);
  Future<void> clear();

  /// Clears the login flag written by the auth flow.
  Future<void> clearSession();
}

/// Storage keys shared with the auth/onboarding flow.
abstract final class ProfileStorageKeys {
  static const String profile = 'profile.user';
  static const String loggedIn = 'auth.logged_in';
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl(
    this._store,
    this._resolver, {
    this.seedWhenEmpty = true,
  });

  final KeyValueStore _store;
  final RegionResolver _resolver;

  /// Whether an empty store falls back to the demo profile below.
  ///
  /// True for the mock build, where the seed *is* the product being shown.
  /// False against a real backend: inventing "Priya Sharma" there would put a
  /// stranger's name and phone number on a real user's account screen until
  /// the fetch lands, and — worse — hand them the seed's admin role.
  final bool seedWhenEmpty;

  /// What an unknown user looks like: no identity, no privileges. `id` is
  /// empty, which is how [ProfileSessionSource] decides nobody is signed in.
  static const UserProfile empty = UserProfile(id: '', name: '', email: '');

  /// Deterministic seed profile from the Figma design (Nepal).
  ///
  /// The seed user holds [UserRole.admin] so the "Admin: Business approvals"
  /// flow (profile LINKS tab → `/admin/businesses`) can be demoed with mock
  /// data; a real backend would supply the role with the session.
  static const UserProfile seed = UserProfile(
    id: 'u-1001',
    name: 'Kritika Paudel',
    email: 'kritikapaudel9@gmail.com',
    phone: '+977 9876543210',
    gender: Gender.female,
    dobBs: '2054/12/20',
    dobAd: '1998/04/02',
    birthTime: '4:12:20 PM',
    birthPlace: 'Hetauda',
    address: 'Kathmandu, Nepal',
    zodiacSign: ProfileZodiac.taurus,
    religion: 'Hindu',
    verified: true,
    roles: {UserRole.admin},
  );

  /// India variant of [seed] (traditional DOB in the Saka calendar).
  static const UserProfile seedIndia = UserProfile(
    id: 'u-1001',
    name: 'Priya Sharma',
    email: 'priya.sharma98@gmail.com',
    phone: '+91 9876543210',
    gender: Gender.female,
    dobBs: '1920/01/12',
    dobAd: '1998/04/02',
    birthTime: '4:12:20 PM',
    birthPlace: 'Jaipur',
    address: 'New Delhi, India',
    zodiacSign: ProfileZodiac.taurus,
    religion: 'Hindu',
    verified: true,
    roles: {UserRole.admin},
  );

  /// Seed profile for [config]'s region.
  static UserProfile seedFor(RegionConfig config) =>
      config.isIndia ? seedIndia : seed;

  @override
  UserProfileModel read() {
    final raw = _store.getString(ProfileStorageKeys.profile);
    if (raw == null || raw.isEmpty) {
      return UserProfileModel.fromEntity(
        seedWhenEmpty ? seedFor(_resolver.config) : empty,
      );
    }
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return UserProfileModel.fromJson(json);
  }

  @override
  Future<void> write(UserProfileModel model) =>
      _store.setString(ProfileStorageKeys.profile, jsonEncode(model.toJson()));

  @override
  Future<void> clear() => _store.remove(ProfileStorageKeys.profile);

  @override
  Future<void> clearSession() async {
    await _store.setBool(ProfileStorageKeys.loggedIn, false);
  }
}
