import '../../../../core/utils/result.dart';
import '../entities/favourite_product.dart';
import '../entities/user_profile.dart';

/// Access to the signed-in user's profile, favourites and session.
abstract interface class ProfileRepository {
  Future<Result<UserProfile>> getProfile();
  Future<Result<UserProfile>> updateProfile(UserProfile profile);
  Future<Result<List<FavouriteProduct>>> getFavourites();

  /// Clears the login flag (and cached profile) so the app returns to login.
  Future<Result<void>> logout();

  /// Permanently removes the account data (mock: clears local cache).
  Future<Result<void>> deleteAccount();
}
