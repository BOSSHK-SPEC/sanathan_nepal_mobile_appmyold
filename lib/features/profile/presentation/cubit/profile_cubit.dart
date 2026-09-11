import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/favourite_product.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/delete_account.dart';
import '../../domain/usecases/get_favourite_products.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/logout.dart';
import '../../../../core/state/app_cubit.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

/// Drives the profile tab: loads the profile + favourites and handles
/// logout / delete-account.
class ProfileCubit extends AppCubit<ProfileState> {
  ProfileCubit({
    required GetUserProfile getProfile,
    required GetFavouriteProducts getFavourites,
    required Logout logout,
    required DeleteAccount deleteAccount,
  }) : _getProfile = getProfile,
       _getFavourites = getFavourites,
       _logout = logout,
       _deleteAccount = deleteAccount,
       super(const ProfileState());

  final GetUserProfile _getProfile;
  final GetFavouriteProducts _getFavourites;
  final Logout _logout;
  final DeleteAccount _deleteAccount;

  Future<void> load() async {
    emit(
      state.copyWith(
        profile: state.profile.toLoading(),
        favourites: state.favourites.toLoading(),
      ),
    );
    final profileResult = await _getProfile();
    final favResult = await _getFavourites();
    emit(
      state.copyWith(
        profile: profileResult.fold(state.profile.toFailed, LoadState.loaded),
        favourites: favResult.fold(state.favourites.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Called after the edit page saves so the header refreshes.
  Future<void> refresh() async {
    final result = await _getProfile();
    result.fold(
      (_) {},
      (p) => emit(state.copyWith(profile: LoadState.loaded(p))),
    );
  }

  Future<void> logout() => _endSession(_logout.call);

  Future<void> deleteAccount() => _endSession(_deleteAccount.call);

  Future<void> _endSession(Future<Result<void>> Function() action) async {
    emit(state.copyWith(signOut: state.signOut.toLoading()));
    final result = await action();
    emit(
      state.copyWith(
        signOut: result.fold(state.signOut.toFailed, LoadState<void>.loaded),
      ),
    );
  }
}
