part of 'admin_auth_cubit.dart';

@freezed
abstract class AdminAuthState with _$AdminAuthState {
  const AdminAuthState._();

  const factory AdminAuthState({
    @Default('') String phone,
    @Default('NP') String region,

    /// The live challenge id once a code has been sent.
    @Default(LoadState<String>.idle()) LoadState<String> challenge,
    @Default(LoadState<AdminSession>.idle()) LoadState<AdminSession> session,
  }) = _AdminAuthState;

  /// A code is out and we are waiting for it to be typed.
  bool get awaitingCode => challenge.isLoaded && !session.isLoaded;

  bool get isSignedIn => session.isLoaded;

  /// Signed in, but not with an account that belongs in the console.
  bool get isSignedInWithoutAccess {
    final current = session.dataOrNull;
    return session.isLoaded && current != null && !current.isStaff;
  }

  AdminSession? get user => session.dataOrNull;

  /// Whichever step is currently in flight, for one spinner on the panel.
  bool get busy => challenge.isLoading || session.isLoading;

  /// The message to show under the fields, from whichever step failed.
  String? get errorMessage =>
      session.failureOrNull?.message ?? challenge.failureOrNull?.message;
}
