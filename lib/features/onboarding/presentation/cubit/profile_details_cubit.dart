import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/user_profile_draft.dart';
import '../../domain/repositories/onboarding_progress_repository.dart';
import '../../domain/usecases/submit_profile.dart';
import '../../../../core/state/app_cubit.dart';

part 'profile_details_cubit.freezed.dart';
part 'profile_details_state.dart';

/// Holds the Details Input form draft and submits it.
///
/// With a [progress] store the draft survives the app being closed: it is
/// restored on open and saved shortly after each edit, then discarded once
/// the profile is accepted.
class ProfileDetailsCubit extends AppCubit<ProfileDetailsState> {
  ProfileDetailsCubit({
    required SubmitProfile submitProfile,
    OnboardingProgressRepository? progress,
    UserProfileDraft? initial,
  }) : _submit = submitProfile,
       _progress = progress,
       super(
         ProfileDetailsState(
           draft: initial ?? progress?.detailsDraft ?? const UserProfileDraft(),
         ),
       );

  final SubmitProfile _submit;
  final OnboardingProgressRepository? _progress;
  Timer? _saveTimer;

  /// Long enough that typing a name is one write, not one per keystroke.
  static const Duration saveDelay = Duration(milliseconds: 400);

  /// Applies an edit and clears any previous submission outcome.
  void _update(UserProfileDraft draft) {
    emit(state.copyWith(draft: draft, submission: const LoadState.idle()));
    _scheduleSave();
  }

  void _scheduleSave() {
    final progress = _progress;
    if (progress == null) return;
    _saveTimer?.cancel();
    _saveTimer = Timer(saveDelay, () => progress.saveDetailsDraft(state.draft));
  }

  void setFullName(String v) => _update(state.draft.copyWith(fullName: v));
  void setEmail(String v) => _update(state.draft.copyWith(email: v));
  void setDateOfBirth(DateTime v) =>
      _update(state.draft.copyWith(dateOfBirth: v));
  void setDateSystem(DateSystem v) =>
      _update(state.draft.copyWith(dateSystem: v));
  void setBirthTime(int minutesSinceMidnight) =>
      _update(state.draft.copyWith(birthTimeMinutes: minutesSinceMidnight));
  void setBirthPlace(String v) => _update(state.draft.copyWith(birthPlace: v));
  void setGender(Gender v) => _update(state.draft.copyWith(gender: v));
  void setZodiacSign(ZodiacSign v) =>
      _update(state.draft.copyWith(zodiacSign: v));

  /// Null removes the photo that was picked.
  void setAvatarUrl(String? url) =>
      _update(state.draft.copyWith(avatarUrl: url));

  Future<void> submit() async {
    _saveTimer?.cancel();
    // Surrounding spaces are not part of anyone's name or address. An email
    // of only spaces used to reach the server as a non-empty, invalid value.
    final draft = state.draft.copyWith(
      fullName: state.draft.fullName.trim(),
      email: state.draft.email.trim(),
      birthPlace: state.draft.birthPlace.trim(),
    );
    emit(
      state.copyWith(draft: draft, submission: state.submission.toLoading()),
    );

    final result = await _submit(draft);
    if (result.failureOrNull == null) {
      await _progress?.clearDetailsDraft();
    } else {
      // Keep what was typed: the person will retry, possibly after a restart.
      _scheduleSave();
    }
    emit(
      state.copyWith(
        submission: result.fold(
          state.submission.toFailed,
          (_) => const LoadState.loaded(null),
        ),
      ),
    );
  }

  /// A pending edit is written rather than dropped — leaving the screen is
  /// exactly when an unsaved draft would be lost.
  @override
  Future<void> close() async {
    final pending = _saveTimer?.isActive ?? false;
    _saveTimer?.cancel();
    if (pending) await _progress?.saveDetailsDraft(state.draft);
    return super.close();
  }
}
