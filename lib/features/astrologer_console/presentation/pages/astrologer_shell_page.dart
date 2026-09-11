import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/session/app_role.dart';
import '../../../session/presentation/cubit/session_cubit.dart';
import '../cubit/console_dashboard_cubit.dart';
import '../widgets/astrologer_nav_bar.dart';

/// The astrologer's own shell.
///
/// A second [StatefulNavigationShell] rather than extra tabs on the seeker's
/// bar: the two sides of the app have different jobs, different navigation
/// and different notions of "home". Mixing them is what makes a two-sided
/// app feel confusing to the people who are on both sides.
///
/// The dashboard cubit is provided here rather than per-page so the queue
/// badge stays live while the astrologer is on Schedule or Earnings.
class AstrologerShellPage extends StatelessWidget {
  const AstrologerShellPage({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => BlocProvider<ConsoleDashboardCubit>(
    create: (_) => GetIt.I<ConsoleDashboardCubit>()..load(),
    child: _AstrologerShellView(navigationShell: navigationShell),
  );
}

class _AstrologerShellView extends StatelessWidget {
  const _AstrologerShellView({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar:
          BlocBuilder<ConsoleDashboardCubit, ConsoleDashboardState>(
            buildWhen: (p, n) =>
                p.waiting.length != n.waiting.length ||
                p.isOnline != n.isOnline,
            builder: (context, state) => AstrologerNavBar(
              currentIndex: navigationShell.currentIndex,
              queueCount: state.waiting.length,
              isOnline: state.isOnline,
              onTap: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
              onSwitchRole: () {
                // Switching back to the seeker side changes the active role
                // *and* the shell, so it is a `go`, not a `push`.
                context.read<SessionCubit>().switchRole(AppRole.seeker);
                context.go(AppRoutes.home);
              },
            ),
          ),
    );
  }
}
