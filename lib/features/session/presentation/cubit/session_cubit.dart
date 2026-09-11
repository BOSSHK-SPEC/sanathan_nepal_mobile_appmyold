import '../../../../core/session/app_role.dart';
import '../../../../core/session/app_session.dart';
import '../../../../core/session/session_source.dart';
import '../../../../core/state/app_cubit.dart';

/// Holds the active [AppSession] for the whole app.
///
/// State is the entity itself, matching `AppSettingsCubit`. Widgets read it
/// through `SessionScope` / `context.can(...)`; the data layer reads it
/// through `SessionResolver` — never through this class directly.
class SessionCubit extends AppCubit<AppSession> {
  SessionCubit({required SessionSource source})
    : _source = source,
      super(AppSession.guest);

  final SessionSource _source;

  Future<void> load() async {
    emit(await _source.load());
  }

  /// Switches which role's UI is shown. Ignored when the role isn't held.
  void switchRole(AppRole role) {
    if (!state.roles.contains(role)) return;
    emit(state.copyWith(activeRole: role));
  }

  /// Clears the session on sign-out.
  void clear() => emit(AppSession.guest);
}
