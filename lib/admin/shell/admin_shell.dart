import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/extensions/context_extensions.dart';
import '../auth/cubit/admin_auth_cubit.dart';
import '../motion/motion.dart';
import '../router/admin_routes.dart';
import 'widgets/console_nav.dart';

/// Chrome around every console page: background, rail, header.
///
/// Three widths, because a console is used on all of them: a phone gets a
/// drawer, a tablet an icon rail, a desktop the full rail. The breakpoints are
/// content-driven — 1180 is where the rail plus a seven-column table stops
/// fitting, not a device name.
class AdminShell extends StatelessWidget {
  const AdminShell({required this.child, required this.location, super.key});

  final Widget child;
  final String location;

  static const double _fullRail = 1180;
  static const double _iconRail = 820;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocBuilder<AdminAuthCubit, AdminAuthState>(
      builder: (context, state) {
        final session = state.user;
        // The router redirects an unauthorised visitor away before this
        // builds; this is the belt to that braces, for the frame between a
        // sign-out and the redirect landing.
        if (session == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final destinations = ConsoleDestination.permittedFor(
          session.permissions,
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final showRail = width >= _iconRail;
            final compact = width < _fullRail;

            return Scaffold(
              backgroundColor: colors.background,
              drawer: showRail
                  ? null
                  : Drawer(
                      backgroundColor: colors.surface,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _RailContent(
                            destinations: destinations,
                            location: location,
                            compact: false,
                            onSelect: (path) {
                              Navigator.of(context).pop();
                              context.go(path);
                            },
                          ),
                        ),
                      ),
                    ),
              body: AuroraBackground(
                intensity: 0.55,
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (showRail)
                        Container(
                          width: compact ? 76 : 244,
                          padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
                          decoration: BoxDecoration(
                            color: colors.surface.withValues(alpha: 0.72),
                            border: Border(
                              right: BorderSide(color: colors.border),
                            ),
                          ),
                          child: _RailContent(
                            destinations: destinations,
                            location: location,
                            compact: compact,
                            onSelect: context.go,
                          ),
                        ),
                      Expanded(
                        child: Column(
                          children: [
                            _ConsoleHeader(
                              showMenuButton: !showRail,
                              label: session.label,
                              roles: session.roles
                                  .map((role) => role.name)
                                  .join(' · '),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: ConstrainedBox(
                                  // Tables become unreadable past this width —
                                  // the eye loses the row on the way back.
                                  constraints: const BoxConstraints(maxWidth: 1340),
                                  child: child,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _RailContent extends StatelessWidget {
  const _RailContent({
    required this.destinations,
    required this.location,
    required this.compact,
    required this.onSelect,
  });

  final List<ConsoleDestination> destinations;
  final String location;
  final bool compact;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Wordmark(compact: compact),
        const SizedBox(height: 28),
        Expanded(
          child: SingleChildScrollView(
            child: ConsoleNav(
              destinations: destinations,
              location: location,
              compact: compact,
              onSelect: onSelect,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _SignOutButton(compact: compact),
        if (!compact) ...[
          const SizedBox(height: 12),
          Text(
            'Staff console',
            textAlign: TextAlign.center,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final mark = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: colors.primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.4),
            blurRadius: 18,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Icon(Icons.brightness_7_rounded, color: colors.onPrimary, size: 22),
    );

    if (compact) return Center(child: mark);

    return Row(
      children: [
        mark,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sanatan',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              Text(
                'Console',
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Tooltip(
      message: 'Sign out',
      child: OutlinedButton(
        onPressed: () => context.read<AdminAuthCubit>().signOut(),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colors.border),
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 0 : 16,
            vertical: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, size: 18, color: colors.textSecondary),
            if (!compact) ...[
              const SizedBox(width: 10),
              Text(
                'Sign out',
                style: context.textTheme.labelLarge?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ConsoleHeader extends StatelessWidget {
  const _ConsoleHeader({
    required this.showMenuButton,
    required this.label,
    required this.roles,
  });

  final bool showMenuButton;
  final String label;
  final String roles;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 24, 4),
      child: Row(
        children: [
          if (showMenuButton)
            IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: Scaffold.of(context).openDrawer,
              tooltip: 'Sections',
            ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                // The roles are shown, not just a generic "Admin": staff hold
                // different sets, and knowing which one you are acting as
                // explains why a section is missing.
                roles,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundColor: colors.chipSelected,
            child: Text(
              label.characters.first.toUpperCase(),
              style: context.textTheme.labelLarge?.copyWith(
                color: colors.onChipSelected,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
