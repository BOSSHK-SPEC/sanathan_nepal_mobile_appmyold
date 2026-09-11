/// Whether a login is currently stored on this device.
///
/// A port rather than a call into the session manager, because mock mode has
/// no tokens: live answers from the refresh token, mock from its own flag.
abstract interface class AuthPresence {
  bool get isSignedIn;
}
