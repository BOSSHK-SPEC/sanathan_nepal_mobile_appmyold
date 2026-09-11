/// Runtime authorization roles.
///
/// A user holds a *set* of these, not one: the same person can be a seeker
/// who also consults as an astrologer and runs a shop. That is why this is
/// separate from `UserProfile.role`, which is only the persisted primary
/// role on the profile record.
///
/// Staff roles are deliberately split so support and finance staff do not
/// share one omnipotent "admin" bit.
enum AppRole {
  /// Every signed-in user. Browses, books, buys.
  seeker,

  /// Verified astrologer who sells consultation time.
  astrologer,

  /// Approved business that sells physical goods.
  merchant,

  /// Reviews businesses, listings, reviews and abuse reports.
  moderator,

  /// Handles payouts, refunds and reconciliation.
  finance,

  /// Answers tickets; read-mostly access to user records.
  support,

  /// Everything, including staff management.
  superAdmin;

  bool get isStaff => switch (this) {
    AppRole.moderator ||
    AppRole.finance ||
    AppRole.support ||
    AppRole.superAdmin => true,
    _ => false,
  };

  /// Roles a user can actively "view as" — the ones with their own UI shell.
  bool get isSwitchable => switch (this) {
    AppRole.seeker || AppRole.astrologer || AppRole.merchant => true,
    _ => false,
  };

  static AppRole fromName(String? name) => AppRole.values.firstWhere(
    (r) => r.name == name,
    orElse: () => AppRole.seeker,
  );
}
