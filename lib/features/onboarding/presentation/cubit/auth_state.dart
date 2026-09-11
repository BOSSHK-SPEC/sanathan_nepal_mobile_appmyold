part of 'auth_cubit.dart';

/// State of the login / OTP flow: two independent async slices.
///
/// * [challenge] – OTP request (`Loaded` = OTP sent; describes the popup).
/// * [session] – sign-in (`Loaded` = authenticated; tells whether profile
///   details are needed).
@freezed
abstract class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    @Default(LoadState.idle()) LoadState<OtpChallenge> challenge,
    @Default(LoadState.idle()) LoadState<AuthSession> session,
  }) = _AuthState;

  bool get isLoading => challenge.isLoading || session.isLoading;
}
