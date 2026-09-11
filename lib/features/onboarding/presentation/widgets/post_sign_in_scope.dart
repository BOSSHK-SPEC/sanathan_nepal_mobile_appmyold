import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Blocks the way back into sign-in once a person is signed in.
///
/// These steps are reached with `go`, so there is nothing legitimate behind
/// them — a Back that "worked" could only land on the OTP dialog or the login
/// screen for an account that is already signed in. Instead, Back leaves the
/// app the way it would from any root screen. Progress is saved, so reopening
/// returns to this same step.
class PostSignInScope extends StatelessWidget {
  const PostSignInScope({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop) SystemNavigator.pop();
    },
    child: child,
  );
}
