import '../../../../core/session/app_role.dart';
import '../../../../core/session/role_granter.dart';
import '../../../../core/session/session_sync.dart';

/// Live [RoleGranter]: the app never grants itself a role.
///
/// It asks the server what the account holds and adopts that answer. So a
/// caller saying "grant astrologer" after seeing an approved application gets
/// the role only if the server really approved it — and a caller that got the
/// status wrong grants nothing. [ProfileRoleGranter] remains for mock builds,
/// where the mock stands in for the server.
class ServerRoleGranter implements RoleGranter {
  const ServerRoleGranter(this._sync);

  final SessionSync _sync;

  @override
  Future<void> grant(AppRole role) => _sync.syncFromServer();

  @override
  Future<void> revoke(AppRole role) => _sync.syncFromServer();
}
