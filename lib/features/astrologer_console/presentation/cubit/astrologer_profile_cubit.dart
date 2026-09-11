import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../astrologers/domain/entities/specialty.dart';
import '../../domain/entities/astrologer_profile.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'astrologer_profile_cubit.freezed.dart';
part 'astrologer_profile_state.dart';

/// Edits the profile seekers browse.
///
/// Edits accumulate in [AstrologerProfileState.draft] and only reach the
/// repository on [save], so leaving the screen half-edited publishes nothing.
class AstrologerProfileCubit extends AppCubit<AstrologerProfileState> {
  AstrologerProfileCubit({
    required GetAstrologerProfile getProfile,
    required SaveAstrologerProfile saveProfile,
  }) : _get = getProfile,
       _save = saveProfile,
       super(const AstrologerProfileState());

  final GetAstrologerProfile _get;
  final SaveAstrologerProfile _save;

  Future<void> load() async {
    emit(state.copyWith(profile: state.profile.toLoading()));
    final result = await _get();
    result.fold(
      (failure) =>
          emit(state.copyWith(profile: state.profile.toFailed(failure))),
      (profile) => emit(
        state.copyWith(profile: LoadState.loaded(profile), draft: profile),
      ),
    );
  }

  void _edit(AstrologerProfileDraft next) =>
      emit(state.copyWith(draft: next, saveError: null));

  void setDisplayName(String v) =>
      _edit(state.working.copyWith(displayName: v));

  void setHeadline(String v) => _edit(state.working.copyWith(headline: v));

  void setAbout(String v) => _edit(state.working.copyWith(about: v));

  void setExperienceYears(int v) =>
      _edit(state.working.copyWith(experienceYears: v));

  void toggleSpecialty(Specialty s) {
    final next = [...state.working.specialties];
    next.contains(s) ? next.remove(s) : next.add(s);
    _edit(state.working.copyWith(specialties: next));
  }

  void toggleLanguage(String code) {
    final next = [...state.working.languageCodes];
    next.contains(code) ? next.remove(code) : next.add(code);
    _edit(state.working.copyWith(languageCodes: next));
  }

  void setAvatar(String? ref) => _edit(state.working.copyWith(avatarRef: ref));

  void setIntroVideo(String? ref) =>
      _edit(state.working.copyWith(introVideoRef: ref));

  void setHiddenFromSearch(bool hidden) =>
      _edit(state.working.copyWith(hiddenFromSearch: hidden));

  Future<bool> save() async {
    emit(state.copyWith(saving: state.saving.toLoading(), saveError: null));
    final result = await _save(state.working);
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            saving: state.saving.toFailed(failure),
            saveError: failure.message,
          ),
        );
        return false;
      },
      (profile) {
        emit(
          state.copyWith(
            saving: LoadState.loaded(profile),
            profile: LoadState.loaded(profile),
            draft: profile,
          ),
        );
        return true;
      },
    );
  }
}
