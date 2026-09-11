/// Where a person is in first-run onboarding.
///
/// Saved after every step, so an app closed mid-registration reopens where it
/// was left rather than at the start. Starting over was not just tedious: by
/// the second sign-in the account already existed, the server no longer called
/// the person new, and the details step was skipped for good.
enum OnboardingStep {
  languageTheme,
  signIn,
  profileDetails,
  notifications;

  /// Reads a saved value, tolerating anything an older build may have stored.
  static OnboardingStep? tryParse(String? raw) =>
      values.where((step) => step.name == raw).firstOrNull;

  /// Steps that only make sense with a live login behind them.
  bool get needsSignIn => this == profileDetails || this == notifications;

  /// The step to reopen on.
  ///
  /// A signed-in step is only resumed while the login survives — after a
  /// sign-out or an expired session the details form would submit into a 401,
  /// so the person is sent to sign in again, and signing in brings them back
  /// here because the server still reports an incomplete profile.
  static OnboardingStep resume({
    required OnboardingStep? saved,
    required bool signedIn,
  }) => switch (saved) {
    final step? when step.needsSignIn => signedIn ? step : signIn,
    OnboardingStep.signIn => signIn,
    _ => languageTheme,
  };
}
