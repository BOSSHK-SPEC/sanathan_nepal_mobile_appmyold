import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/account_entities.dart';
import '../cubit/account_cubits.dart';
import '../l10n/account_strings.dart';

/// Sign-in details, two-step verification and signed-in devices.
class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<SecurityCubit>()..load(),
    child: const _SecurityView(),
  );
}

class _SecurityView extends StatelessWidget {
  const _SecurityView();

  @override
  Widget build(BuildContext context) {
    final s = AccountStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.security, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<SecurityCubit, SecurityState>(
          builder: (context, state) {
            final cubit = context.read<SecurityCubit>();
            final settings = state.current;

            if (state.settings.isLoading && state.settings.dataOrNull == null) {
              return const AppSkeletonList.tiles(count: 4);
            }

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                Text(s.signInDetails, style: context.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                AppCard(
                  child: KeyValueList(
                    divided: true,
                    children: [
                      KeyValueRow(
                        label: s.phone,
                        value: settings.phone,
                        icon: Icons.phone_outlined,
                      ),
                      KeyValueRow(
                        label: s.email,
                        value: settings.email,
                        icon: Icons.mail_outline_rounded,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabeledToggle(
                        label: s.twoFactor,
                        value: settings.twoFactorEnabled,
                        onChanged: (v) => cubit.setTwoFactor(enabled: v),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        s.twoFactorNote,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      Divider(color: colors.divider, height: AppSpacing.xl),
                      LabeledToggle(
                        label: s.loginAlerts,
                        value: settings.loginAlertsEnabled,
                        onChanged: (v) => cubit.setLoginAlerts(enabled: v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.devices,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    if (state.otherSessions.isNotEmpty)
                      TextButton(
                        onPressed: () async {
                          final confirmed = await AppConfirmSheet.show(
                            context,
                            title: s.revokeAll,
                            message: s.revokeAllBody,
                            confirmLabel: s.revoke,
                            cancelLabel: s.cancel,
                          );
                          if (confirmed) await cubit.revokeAllOthers();
                        },
                        child: Text(
                          s.revokeAll,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: colors.error,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                for (final device in state.sessions)
                  _DeviceCard(
                    device: device,
                    strings: s,
                    onRevoke: device.isCurrent
                        ? null
                        : () async {
                            final error = await cubit.revoke(device.id);
                            if (error != null && context.mounted) {
                              AppSnack.error(context, error);
                            }
                          },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  const _DeviceCard({
    required this.device,
    required this.strings,
    this.onRevoke,
  });

  final DeviceSession device;
  final AccountStrings strings;
  final VoidCallback? onRevoke;

  IconData get _icon => switch (device.platform) {
    'Web' => Icons.language_rounded,
    _ when device.platform.startsWith('iOS') => Icons.phone_iphone_rounded,
    _ => Icons.phone_android_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Icon(_icon, size: 22, color: colors.iconMuted),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        device.deviceName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    if (device.isCurrent) ...[
                      const SizedBox(width: AppSpacing.xs),
                      StatusChip(
                        label: strings.thisDevice,
                        tone: StatusTone.success,
                        dense: true,
                      ),
                    ],
                  ],
                ),
                Text(
                  '${device.platform}'
                  '${device.location.isEmpty ? '' : ' · ${device.location}'}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                Text(
                  device.isStale
                      ? strings.staleDeviceNote
                      : '${strings.lastActive} · '
                            '${relativeTime(context, device.lastActiveAt)}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: device.isStale ? colors.warning : colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (onRevoke != null)
            TextButton(
              onPressed: onRevoke,
              child: Text(
                strings.revoke,
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
