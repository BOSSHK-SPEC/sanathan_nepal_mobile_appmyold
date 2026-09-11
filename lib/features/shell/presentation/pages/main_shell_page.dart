import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../consultation/presentation/cubit/active_session_cubit.dart';
import '../../../consultation/presentation/widgets/active_call_bar.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/quick_menu_sheet.dart';

/// Hosts the four bottom-nav branches (Home, Marketplace, Horoscope, Profile).
class MainShellPage extends StatelessWidget {
  const MainShellPage({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActiveSessionCubit>.value(
      value: GetIt.I<ActiveSessionCubit>()..start(),
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sits above the tab bar so a live, billing session stays
            // visible on every tab.
            const ActiveCallBar(),
            AppBottomNavBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
              onMenuTap: () => QuickMenuSheet.show(context),
            ),
          ],
        ),
      ),
    );
  }
}
