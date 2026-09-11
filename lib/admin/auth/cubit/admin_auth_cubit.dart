import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/failures.dart';
import '../../../core/state/app_cubit.dart';
import '../../../core/state/load_state.dart';
import '../../../core/utils/repository_guard.dart';
import '../../data/datasources/admin_auth_data_source.dart';
import '../../domain/entities/admin_session.dart';

part 'admin_auth_cubit.freezed.dart';
part 'admin_auth_state.dart';

/// Sign-in for the console, as two independent async slices.
///
/// [AdminAuthState.challenge] is "has a code been sent", and
/// [AdminAuthState.session] is "are we signed in". Keeping them apart means a
/// failed code entry does not wipe the challenge the user is still working
/// against — they get to retype the code, not restart the flow.
class AdminAuthCubit extends AppCubit<AdminAuthState> {
  AdminAuthCubit(this._auth) : super(const AdminAuthState());

  final AdminAuthDataSource _auth;

  /// Restores a session on first load, so a refresh does not sign staff out.
  Future<void> restore() async {
    emit(state.copyWith(session: state.session.toLoading()));
    final result = await guard(_auth.restore);

    emit(
      state.copyWith(
        session: result.fold(
          state.session.toFailed,
          // No stored session is not a failure — it is a visitor on the
          // landing page, which is the normal case for this app.
          (session) => session == null
              ? const LoadState.idle()
              : LoadState.loaded(session),
        ),
      ),
    );
  }

  void setPhone(String phone) =>
      emit(state.copyWith(phone: phone.trim(), challenge: const LoadState.idle()));

  Future<void> requestCode() async {
    final phone = state.phone;
    if (!_looksLikeE164(phone)) {
      emit(
        state.copyWith(
          challenge: const LoadState.failed(
            Failure.validation('Enter the number in +977… or +91… form'),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(challenge: state.challenge.toLoading()));
    final result = await guard(() => _auth.startPhoneChallenge(phone));
    emit(
      state.copyWith(
        challenge: result.fold(state.challenge.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> verify(String code) async {
    final challengeId = state.challenge.dataOrNull;
    if (challengeId == null) return;

    emit(state.copyWith(session: state.session.toLoading()));
    final result = await guard(
      () => _auth.verifyCode(
        challengeId: challengeId,
        code: code.trim(),
        region: state.region,
      ),
    );

    emit(
      state.copyWith(
        session: result.fold(state.session.toFailed, LoadState.loaded),
      ),
    );
  }

  /// The region a new staff account is created under. Defaults to Nepal and is
  /// switched on the sign-in panel, because it decides currency and calendar
  /// for everything that account later sees.
  void setRegion(String region) => emit(state.copyWith(region: region));

  Future<void> signOut() async {
    await _auth.signOut();
    emit(const AdminAuthState());
  }

  /// Back to the phone step, keeping the number so it need not be retyped.
  void changeNumber() => emit(
    state.copyWith(
      challenge: const LoadState.idle(),
      session: const LoadState.idle(),
    ),
  );

  /// The server enforces E.164 too; checking here saves a round trip and gives
  /// the message next to the field instead of in a snackbar.
  static bool _looksLikeE164(String value) =>
      RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(value);
}
