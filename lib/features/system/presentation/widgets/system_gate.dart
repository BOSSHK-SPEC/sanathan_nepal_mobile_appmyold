import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/system/app_status.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../l10n/system_strings.dart';

/// Blocks the app when the build is unsupported or the service is down.
///
/// Wraps the router rather than living on a route: a forced upgrade has to
/// stop screens that have never heard of it, including any the user deep
/// links into.
class SystemGate extends StatelessWidget {
  const SystemGate({required this.status, required this.child, super.key});

  final AppStatus status;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!status.isBlocking) return child;
    return switch (status.availability) {
      AppAvailability.updateRequired => BlockingScreen.updateRequired(status),
      AppAvailability.maintenance => BlockingScreen.maintenance(status),
      _ => child,
    };
  }
}

/// Full-screen stop: no app bar, no back, one action.
class BlockingScreen extends StatelessWidget {
  const BlockingScreen({
    required this.icon,
    required this.title,
    required this.body,
    super.key,
    this.detail,
    this.actionLabel,
    this.onAction,
  });

  factory BlockingScreen.updateRequired(AppStatus status) => BlockingScreen(
    icon: Icons.system_update_alt_rounded,
    title: (context) => SystemStrings.of(context).updateRequiredTitle,
    body: (context) => SystemStrings.of(context).updateRequiredBody,
    detail: status.latestVersion.isEmpty
        ? null
        : (context) => SystemStrings.of(
            context,
          ).versionLine(status.currentVersion, status.latestVersion),
    actionLabel: (context) => SystemStrings.of(context).updateNow,
  );

  factory BlockingScreen.maintenance(AppStatus status) => BlockingScreen(
    icon: Icons.build_circle_outlined,
    title: (context) => SystemStrings.of(context).maintenanceTitle,
    body: (context) =>
        status.message ?? SystemStrings.of(context).maintenanceBody,
    detail: status.expectedBackAt == null
        ? null
        : (context) =>
              '${SystemStrings.of(context).expectedBack}: '
              '${DateFormat.MMMEd(context.languageCode).add_Hm().format(status.expectedBackAt!)}',
  );

  final IconData icon;
  final String Function(BuildContext) title;
  final String Function(BuildContext) body;
  final String Function(BuildContext)? detail;
  final String Function(BuildContext)? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.accent.withValues(alpha: 0.12),
                ),
                child: Icon(icon, size: 42, color: colors.accent),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                title(context),
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                body(context),
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colors.textMuted,
                ),
              ),
              if (detail != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  detail!(context),
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
              if (actionLabel != null) ...[
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: actionLabel!(context),
                  height: 46,
                  expanded: false,
                  onPressed: onAction ?? () {},
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Thin banner shown while the device has no connection.
///
/// A banner rather than a takeover: patro, panchanga and saved charts all
/// work offline, so blocking the whole app would remove things that still
/// function.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({required this.online, super.key});

  final bool online;

  @override
  Widget build(BuildContext context) {
    if (online) return const SizedBox.shrink();
    final s = SystemStrings.of(context);
    final colors = context.colors;

    return Material(
      color: colors.error,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pageGutter,
            vertical: AppSpacing.xs + 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, size: 14, color: colors.onPrimary),
              const SizedBox(width: AppSpacing.sm),
              Text(
                s.youAreOffline,
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sheet shown when a signed-out user reaches a gated action.
///
/// Says what stays free as well as what needs an account — a wall that only
/// demands is the fastest way to lose a first-time visitor.
class SignInWall extends StatelessWidget {
  const SignInWall({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await AppBottomSheet.show<bool>(
      context,
      builder: (_) => const SignInWall(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final s = SystemStrings.of(context);
    final colors = context.colors;

    return AppBottomSheet(
      showClose: false,
      scrollable: false,
      actions: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: s.signIn,
            height: 46,
            onPressed: () {
              Navigator.of(context).pop(true);
              context.push(AppRoutes.login);
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          SecondaryButton(
            label: s.maybeLater,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.accent.withValues(alpha: 0.12),
            ),
            child: Icon(
              Icons.lock_open_rounded,
              size: 28,
              color: colors.accent,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            s.signInRequiredTitle,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            s.signInRequiredBody,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 16,
                  color: colors.success,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    s.freeToBrowse,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
