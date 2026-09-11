import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_user_profile.dart';
import '../../domain/usecases/update_user_profile.dart';
import '../../../../core/state/app_cubit.dart';

part 'edit_profile_cubit.freezed.dart';
part 'edit_profile_state.dart';

/// Loads the current profile into the form and saves edits.
class EditProfileCubit extends AppCubit<EditProfileState> {
  EditProfileCubit({
    required GetUserProfile getProfile,
    required UpdateUserProfile updateProfile,
  }) : _getProfile = getProfile,
       _updateProfile = updateProfile,
       super(const EditProfileState());

  final GetUserProfile _getProfile;
  final UpdateUserProfile _updateProfile;

  Future<void> load() async {
    emit(state.copyWith(profile: state.profile.toLoading()));
    final result = await _getProfile();
    emit(
      state.copyWith(
        profile: result.fold(state.profile.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> save(UserProfile profile) async {
    emit(
      state.copyWith(
        profile: LoadState.loaded(profile),
        save: state.save.toLoading(),
      ),
    );
    final result = await _updateProfile(profile);
    emit(
      result.fold(
        (f) => state.copyWith(save: state.save.toFailed(f)),
        (p) => state.copyWith(
          profile: LoadState.loaded(p),
          save: LoadState.loaded(p),
        ),
      ),
    );
  }
}
