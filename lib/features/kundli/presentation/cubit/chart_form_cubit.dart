import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/birth_profile.dart';
import '../../domain/usecases/kundli_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'chart_form_cubit.freezed.dart';
part 'chart_form_state.dart';

/// New or edited birth profile.
class ChartFormCubit extends AppCubit<ChartFormState> {
  ChartFormCubit({required SaveBirthProfile saveProfile, BirthProfile? initial})
    : _saveProfile = saveProfile,
      super(
        ChartFormState(
          profile:
              initial ??
              BirthProfile(
                id: '',
                name: '',
                birthDateTime: DateTime(DateTime.now().year - 25, 1, 1, 9),
                birthPlace: '',
              ),
        ),
      );

  final SaveBirthProfile _saveProfile;

  void setName(String name) =>
      emit(state.copyWith(profile: state.profile.copyWith(name: name)));

  void setPlace(String place) =>
      emit(state.copyWith(profile: state.profile.copyWith(birthPlace: place)));

  void setRelation(ChartRelation relation) =>
      emit(state.copyWith(profile: state.profile.copyWith(relation: relation)));

  void setFemale({required bool isFemale}) =>
      emit(state.copyWith(profile: state.profile.copyWith(isFemale: isFemale)));

  void setTimeUnknown({required bool unknown}) => emit(
    state.copyWith(profile: state.profile.copyWith(timeUnknown: unknown)),
  );

  /// Keeps the existing time component so picking a date does not reset it.
  void setDate(DateTime date) {
    final current = state.profile.birthDateTime;
    emit(
      state.copyWith(
        profile: state.profile.copyWith(
          birthDateTime: DateTime(
            date.year,
            date.month,
            date.day,
            current.hour,
            current.minute,
          ),
        ),
      ),
    );
  }

  void setTime(int hour, int minute) {
    final current = state.profile.birthDateTime;
    emit(
      state.copyWith(
        profile: state.profile.copyWith(
          birthDateTime: DateTime(
            current.year,
            current.month,
            current.day,
            hour,
            minute,
          ),
        ),
      ),
    );
  }

  Future<BirthProfile?> submit() async {
    if (!state.canSubmit) return null;
    emit(state.copyWith(saving: state.saving.toLoading()));
    final result = await _saveProfile(state.profile);
    return result.fold(
      (failure) {
        emit(state.copyWith(saving: state.saving.toFailed(failure)));
        return null;
      },
      (saved) {
        emit(state.copyWith(saving: LoadState.loaded(saved)));
        return saved;
      },
    );
  }
}
