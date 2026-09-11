import 'package:flutter_bloc/flutter_bloc.dart';

/// A [Cubit] that cannot crash by outliving its widget.
///
/// Every cubit here loads asynchronously, and a user who leaves a screen
/// before its request finishes closes the cubit while the `await` is still in
/// flight. Base `Cubit.emit` throws `StateError: Cannot emit new states after
/// calling close` in that moment — an unhandled exception on a completely
/// ordinary interaction (open a tab, tap back immediately).
///
/// Dropping the state is the correct answer, not a workaround: the widget that
/// asked for it is gone, so there is nobody left to render it. Guarding here
/// rather than writing `if (isClosed) return;` before every emit means a new
/// cubit is safe by default instead of safe if its author remembered.
abstract class AppCubit<S> extends Cubit<S> {
  AppCubit(super.initialState);

  @override
  void emit(S state) {
    if (isClosed) return;
    super.emit(state);
  }
}
