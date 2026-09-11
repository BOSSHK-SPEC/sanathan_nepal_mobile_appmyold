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

/// Data export and account deletion.
///
/// Deletion says plainly what is removed and what is kept — a promise to
/// erase everything would be false, because completed transactions have to
/// survive for tax and dispute purposes.
class AccountPrivacyPage extends StatelessWidget {
  const AccountPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<PrivacyCubit>()..load(),
    child: const _PrivacyView(),
  );
}

class _PrivacyView extends StatelessWidget {
  const _PrivacyView();

  @override
  Widget build(BuildContext context) {
    final s = AccountStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.privacy, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<PrivacyCubit, PrivacyState>(
          builder: (context, state) {
            final cubit = context.read<PrivacyCubit>();
            final export = state.requestFor(DataRequestKind.export);
            final deletion = state.requestFor(DataRequestKind.deletion);

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                _RequestCard(
                  icon: Icons.download_outlined,
                  title: s.exportTitle,
                  body: s.exportBody,
                  actionLabel: s.requestExport,
                  request: export,
                  strings: s,
                  onRequest: () async {
                    final error = await cubit.request(DataRequestKind.export);
                    if (error != null && context.mounted) {
                      AppSnack.error(context, error);
                    }
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                _RequestCard(
                  icon: Icons.delete_forever_outlined,
                  title: s.deleteTitle,
                  body: s.deleteBody,
                  actionLabel: s.requestDeletion,
                  destructive: true,
                  request: deletion,
                  strings: s,
                  onRequest: () async {
                    final confirmed = await AppConfirmSheet.show(
                      context,
                      title: s.confirmDeletion,
                      message: s.deleteBody,
                      confirmLabel: s.requestDeletion,
                      cancelLabel: s.cancel,
                    );
                    if (!confirmed || !context.mounted) return;
                    final error = await cubit.request(DataRequestKind.deletion);
                    if (error != null && context.mounted) {
                      AppSnack.error(context, error);
                    }
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  s.requestNote,
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.actionLabel,
    required this.request,
    required this.strings,
    required this.onRequest,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String body;
  final String actionLabel;
  final DataRequest request;
  final AccountStrings strings;
  final VoidCallback onRequest;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tint = destructive ? colors.error : colors.accent;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: tint),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(title, style: context.textTheme.titleSmall)),
              if (request.isOpen)
                StatusChip(
                  label: strings.requestPending,
                  tone: StatusTone.warning,
                  dense: true,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            body,
            style: context.textTheme.bodySmall?.copyWith(
              color: colors.textSecondary,
            ),
          ),
          if (request.requestedAt != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              relativeTime(context, request.requestedAt!),
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.textMuted,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          if (destructive)
            SizedBox(
              height: 40,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colors.error),
                  foregroundColor: colors.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
                onPressed: request.isOpen ? null : onRequest,
                child: Text(actionLabel),
              ),
            )
          else
            SecondaryButton(
              label: actionLabel,
              onPressed: request.isOpen ? null : onRequest,
            ),
        ],
      ),
    );
  }
}
