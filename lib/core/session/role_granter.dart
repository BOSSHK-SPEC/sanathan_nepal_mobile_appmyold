import 'app_role.dart';

/// Grants or removes a role on the signed-in account.
///
/// The contract lives in core so a feature can promote someone — an approved
/// astrologer application, an approved business — without importing the
/// profile feature. Profile owns the implementation, the same inversion
/// [SessionSource] uses.
///
/// In production the server is what actually assigns roles; this exists so
/// the client can reflect that decision locally the moment it is known.
abstract interface class RoleGranter {
  Future<void> grant(AppRole role);

  Future<void> revoke(AppRole role);
}

/// Grants nothing. For tests and previews.
class NoopRoleGranter implements RoleGranter {
  const NoopRoleGranter();

  @override
  Future<void> grant(AppRole role) async {}

  @override
  Future<void> revoke(AppRole role) async {}
}
