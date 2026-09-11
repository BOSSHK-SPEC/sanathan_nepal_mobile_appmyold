import '../../../../core/session/app_session.dart';
import '../../../../core/session/session_resolver.dart';
import '../../presentation/cubit/session_cubit.dart';

/// Adapts [SessionCubit] to the core [SessionResolver] interface so the
/// data/domain layers can read the session without importing the cubit.
class SessionCubitResolver implements SessionResolver {
  const SessionCubitResolver(this._cubit);

  final SessionCubit _cubit;

  @override
  AppSession get session => _cubit.state;
}
