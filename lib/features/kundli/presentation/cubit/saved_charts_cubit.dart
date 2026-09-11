import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/birth_profile.dart';
import '../../domain/usecases/kundli_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'saved_charts_cubit.freezed.dart';
part 'saved_charts_state.dart';

/// The list of saved birth profiles.
class SavedChartsCubit extends AppCubit<SavedChartsState> {
  SavedChartsCubit({
    required GetBirthProfiles getProfiles,
    required DeleteBirthProfile deleteProfile,
  }) : _getProfiles = getProfiles,
       _deleteProfile = deleteProfile,
       super(const SavedChartsState());

  final GetBirthProfiles _getProfiles;
  final DeleteBirthProfile _deleteProfile;

  Future<void> load() async {
    emit(state.copyWith(profiles: state.profiles.toLoading()));
    final result = await _getProfiles();
    emit(
      state.copyWith(
        profiles: result.fold(state.profiles.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> delete(String profileId) async {
    final result = await _deleteProfile(profileId);
    if (result.isSuccess) await load();
  }
}
