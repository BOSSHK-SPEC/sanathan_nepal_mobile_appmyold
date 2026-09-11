import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/extensions/context_extensions.dart';
import '../auth/admin_login_panel.dart';
import '../auth/cubit/admin_auth_cubit.dart';
import '../motion/motion.dart';
import '../router/admin_routes.dart';
import 'widgets/landing_sections.dart';

/// The public front door.
///
/// Anyone can reach this; it introduces the app and nothing else. Sign-in
/// lives in a drawer rather than on a route of its own, so there is no
/// `/login` page to link, index or hammer — and a visitor never loses their
/// place to a form they may not need.
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _openSignIn() => _scaffold.currentState?.openEndDrawer();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminAuthCubit, AdminAuthState>(
      // Only staff are forwarded. A signed-in seeker stays here and the panel
      // explains why, which is friendlier than a console that redirects them
      // straight back out again.
      listenWhen: (previous, current) =>
          previous.session != current.session && current.isSignedIn,
      listener: (context, state) {
        final user = state.user;
        if (user == null || !user.isStaff) return;
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        context.go(AdminRoutes.console);
      },
      child: Scaffold(
        key: _scaffold,
        endDrawer: const AdminLoginPanel(),
        body: AuroraBackground(
          child: Column(
            children: [
              _LandingNav(onSignIn: _openSignIn),
              Expanded(
                child: Scrollbar(
                  controller: _scroll,
                  child: SingleChildScrollView(
                    controller: _scroll,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1240),
                        child: Column(
                          children: [
                            LandingHero(onSignIn: _openSignIn),
                            const LandingFeatures(),
                            LandingConsoleSection(onSignIn: _openSignIn),
                            const LandingFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LandingNav extends StatelessWidget {
  const _LandingNav({required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: colors.primaryGradient,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                Icons.brightness_7_rounded,
                color: colors.onPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Sanatan Nepal',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            // Signed-in staff get a way back into the console without having
            // to remember the URL.
            BlocBuilder<AdminAuthCubit, AdminAuthState>(
              builder: (context, state) {
                final user = state.user;
                if (user != null && user.isStaff) {
                  return TextButton.icon(
                    onPressed: () => context.go(AdminRoutes.console),
                    icon: const Icon(Icons.dashboard_rounded, size: 18),
                    label: const Text('Open console'),
                  );
                }
                return TextButton.icon(
                  onPressed: onSignIn,
                  icon: const Icon(Icons.lock_open_rounded, size: 18),
                  label: const Text('Staff sign in'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
