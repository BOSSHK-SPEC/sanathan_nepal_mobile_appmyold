import '../../../../core/session/session_refresher.dart';
import '../../presentation/cubit/session_cubit.dart';

/// Adapts [SessionCubit] to [SessionRefresher], so a feature can trigger a
/// reload without depending on the cubit or on a `BuildContext`.
class SessionCubitRefresher implements SessionRefresher {
  const SessionCubitRefresher(this._cubit);

  final SessionCubit _cubit;

  @override
  Future<void> refresh() => _cubit.load();
}
