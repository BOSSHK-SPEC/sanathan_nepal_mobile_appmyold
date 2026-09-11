import 'app_session.dart';

/// Read-side access to the current session for data/domain layers that have
/// no BuildContext — mirrors `RegionResolver`.
///
/// Repositories take this interface, never the cubit (DIP), so tests inject
/// [FixedSessionResolver].
abstract interface class SessionResolver {
  AppSession get session;
}

/// Fixed session for tests and previews.
class FixedSessionResolver implements SessionResolver {
  const FixedSessionResolver(this.session);

  @override
  final AppSession session;
}
