import 'package:flutter/material.dart';

import '../../core/session/permission.dart';

/// Every path the console knows, in one place.
abstract final class AdminRoutes {
  static const String landing = '/';
  static const String console = '/console';
  static const String overview = '/console/overview';
  static const String applications = '/console/astrologers';
  static const String businesses = '/console/businesses';
  static const String moderation = '/console/moderation';
  static const String payouts = '/console/payouts';
  static const String flags = '/console/flags';
  static const String audit = '/console/audit';
}

/// One entry in the console's navigation.
///
/// Each destination names the permission that unlocks it, so the nav is built
/// by filtering this list against the signed-in user rather than by a chain of
/// `if (isFinance)` checks scattered through the shell. A finance reviewer and
/// a moderator get two different consoles out of the same code, and neither is
/// shown a door that will 403 when they open it.
@immutable
class ConsoleDestination {
  const ConsoleDestination({
    required this.path,
    required this.label,
    required this.icon,
    required this.permission,
    required this.blurb,
  });

  final String path;
  final String label;
  final IconData icon;

  /// The capability required. The server checks it again on every request —
  /// this only decides what is worth rendering.
  final Permission permission;

  /// One line describing the section, used on the overview's shortcut cards.
  final String blurb;

  static const List<ConsoleDestination> all = [
    ConsoleDestination(
      path: AdminRoutes.overview,
      label: 'Overview',
      icon: Icons.insights_rounded,
      permission: Permission.viewFinancialReports,
      blurb: 'Revenue, refunds and volume across the platform',
    ),
    ConsoleDestination(
      path: AdminRoutes.applications,
      label: 'Astrologers',
      icon: Icons.verified_user_rounded,
      permission: Permission.verifyAstrologer,
      blurb: 'Verify applicants and review their documents',
    ),
    ConsoleDestination(
      path: AdminRoutes.businesses,
      label: 'Businesses',
      icon: Icons.storefront_rounded,
      permission: Permission.approveBusiness,
      blurb: 'Approve sellers before their listings go live',
    ),
    ConsoleDestination(
      path: AdminRoutes.moderation,
      label: 'Moderation',
      icon: Icons.flag_rounded,
      permission: Permission.moderateContent,
      blurb: 'Abuse reports raised by users',
    ),
    ConsoleDestination(
      path: AdminRoutes.payouts,
      label: 'Payouts',
      icon: Icons.account_balance_rounded,
      permission: Permission.runPayouts,
      blurb: 'Release earnings to astrologers and sellers',
    ),
    ConsoleDestination(
      path: AdminRoutes.flags,
      label: 'Feature flags',
      icon: Icons.toggle_on_rounded,
      permission: Permission.manageFeatureFlags,
      blurb: 'Turn features on, and stage a rollout',
    ),
    ConsoleDestination(
      path: AdminRoutes.audit,
      label: 'Audit log',
      icon: Icons.receipt_long_rounded,
      permission: Permission.viewAuditLog,
      blurb: 'Every staff action, with its trace id',
    ),
  ];

  /// The destinations [permissions] actually unlocks, in declaration order.
  static List<ConsoleDestination> permittedFor(Set<Permission> permissions) => [
    for (final destination in all)
      if (permissions.contains(destination.permission)) destination,
  ];
}
