import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/activity_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../l10n/profile_strings.dart';
import '../widgets/delete_confirm_dialog.dart';
import '../../../session/presentation/widgets/role_switch_banner.dart';
import '../widgets/profile_about_tab.dart';
import '../widgets/profile_activities_tab.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_links_tab.dart';
import '../widgets/profile_notifications_tab.dart';

/// Profile bottom-nav tab (Figma "User Profile Page" 1873:3487 dark /
/// 1351:2735 light): gradient header + ABOUT / ACTIVITIES / NOTIFICATIONS /
/// LINKS pill tabs.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<ProfileCubit>()..load()),
      BlocProvider(create: (_) => sl<ActivityCubit>()..load()),
    ],
    child: const ProfileView(),
  );
}

/// Widget-testable body of [ProfilePage] (expects the cubits above).
class ProfileView extends StatefulWidget {
  const ProfileView({super.key, this.initialTab = 0});
  final int initialTab;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late int _tab = widget.initialTab;

  Future<void> _confirmLogout(BuildContext context) async {
    final s = ProfileStrings.of(context);
    final cubit = context.read<ProfileCubit>();
    final ok = await DeleteConfirmDialog.show(
      context,
      title: s.logoutTitle,
      message: s.logoutMessage,
      confirmLabel: s.logout,
      icon: Icons.logout_rounded,
    );
    if (ok) await cubit.logout();
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final s = ProfileStrings.of(context);
    final cubit = context.read<ProfileCubit>();
    final ok = await DeleteConfirmDialog.show(
      context,
      title: s.deleteTitle,
      message: s.deleteAccountMessage,
    );
    if (ok) await cubit.deleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (p, n) => p.signOut != n.signOut,
      listener: (context, state) {
        switch (state.signOut) {
          case Loaded():
            context.go(AppRoutes.login);
          case Failed(:final failure):
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          case Idle() || Loading():
            break;
        }
      },
      child: Scaffold(
        backgroundColor: colors.background,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final profile = state.profile.dataOrNull;
            if (profile == null) {
              return switch (state.profile) {
                Failed(:final failure) => ErrorView(
                  message: failure.message,
                  onRetry: context.read<ProfileCubit>().load,
                ),
                _ => const LoadingView(),
              };
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProfileHeader(
                    profile: profile,
                    onEdit: () async {
                      await context.push(AppRoutes.editProfile);
                      if (context.mounted) {
                        await context.read<ProfileCubit>().refresh();
                      }
                    },
                    onLogout: () => _confirmLogout(context),
                    onNotifications: () => setState(() => _tab = 2),
                  ),
                  // Only renders for accounts that hold the astrologer role.
                  const RoleSwitchBanner(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: context.isDark
                            ? colors.surfaceVariant
                            : colors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: PillTabs(
                        labels: [
                          s.about,
                          s.activities,
                          s.notifications,
                          s.links,
                        ],
                        selectedIndex: _tab,
                        scrollable: true,
                        onChanged: (i) => setState(() => _tab = i),
                      ),
                    ),
                  ),
                  switch (_tab) {
                    0 => ProfileAboutTab(
                      profile: profile,
                      favourites: state.favourites.dataOrNull ?? const [],
                    ),
                    1 => const ProfileActivitiesTab(),
                    2 => const ProfileNotificationsTab(),
                    _ => ProfileLinksTab(
                      isAdmin: profile.isAdmin,
                      onDeleteAccount: () => _confirmDelete(context),
                    ),
                  },
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
