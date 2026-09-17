import 'app_role.dart';

/// A single capability a role may hold.
///
/// Screens and routes ask for a [Permission], never for a role — so adding a
/// role, or moving a capability between roles, changes this file only.
///
/// Client-side permissions are a **UI hint**. They decide what to render and
/// which routes to allow; they are not a security boundary. Every mutation
/// must be re-authorized server-side against the session token.
enum Permission {
  // --- Seeker ---
  bookConsultation,
  manageWallet,
  purchaseProducts,
  writeReview,

  // --- Astrologer ---
  applyAsAstrologer,
  viewAstrologerConsole,
  manageAvailability,
  acceptConsultation,
  managePricing,
  viewEarnings,
  requestPayout,
  replyToReview,

  // --- Merchant ---
  manageProducts,
  fulfilOrders,
  purchaseBoost,

  // --- Staff ---
  moderateContent,
  verifyAstrologer,
  approveBusiness,
  manageUsers,
  issueRefund,
  runPayouts,
  viewFinancialReports,
  answerTickets,
  manageStaff,
  viewAuditLog,
  manageFeatureFlags;

  /// Capabilities that belong to *being* an astrologer: each acts on the
  /// caller's own astrologer profile.
  ///
  /// Staff do not hold them by virtue of being staff. An admin who is not an
  /// astrologer has no console to open — offering one only leads to "you do
  /// not have an astrologer profile" — and it is exactly the screen that must
  /// stay shut until an application is approved. An admin who *is* an
  /// approved astrologer holds the astrologer role as well, and gets them
  /// from that.
  static const Set<Permission> astrologerWorkspace = {
    Permission.viewAstrologerConsole,
    Permission.manageAvailability,
    Permission.acceptConsultation,
    Permission.managePricing,
    Permission.replyToReview,
  };

  static final Set<Permission> _superAdmin = Set.unmodifiable(
    Permission.values.toSet().difference(astrologerWorkspace),
  );

  /// Permissions granted by a single role.
  static Set<Permission> ofRole(AppRole role) => switch (role) {
    AppRole.seeker => const {
      Permission.bookConsultation,
      Permission.manageWallet,
      Permission.purchaseProducts,
      Permission.writeReview,
      Permission.applyAsAstrologer,
    },
    AppRole.astrologer => const {
      Permission.viewAstrologerConsole,
      Permission.manageAvailability,
      Permission.acceptConsultation,
      Permission.managePricing,
      Permission.viewEarnings,
      Permission.requestPayout,
      Permission.replyToReview,
      Permission.purchaseBoost,
    },
    AppRole.merchant => const {
      Permission.manageProducts,
      Permission.fulfilOrders,
      Permission.purchaseBoost,
      Permission.viewEarnings,
      Permission.requestPayout,
    },
    AppRole.moderator => const {
      Permission.moderateContent,
      Permission.verifyAstrologer,
      Permission.approveBusiness,
      Permission.viewAuditLog,
    },
    AppRole.finance => const {
      Permission.issueRefund,
      Permission.runPayouts,
      Permission.viewFinancialReports,
      Permission.viewAuditLog,
    },
    AppRole.support => const {
      Permission.answerTickets,
      Permission.manageUsers,
      Permission.issueRefund,
    },
    AppRole.superAdmin => _superAdmin,
  };

  /// Union of the permissions granted by [roles].
  static Set<Permission> ofRoles(Iterable<AppRole> roles) =>
      roles.fold(<Permission>{}, (acc, r) => acc..addAll(ofRole(r)));
}
