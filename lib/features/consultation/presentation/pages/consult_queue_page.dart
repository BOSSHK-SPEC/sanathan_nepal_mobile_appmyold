import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../cubit/live_session_cubit.dart';
import '../l10n/consultation_strings.dart';
import '../widgets/consult_format.dart';
import '../widgets/live_session_scope.dart';

/// Waiting room: position in the queue, estimated wait, and a clear promise
/// that nothing is charged until the session actually starts.
class ConsultQueuePage extends StatelessWidget {
  const ConsultQueuePage({required this.consultationId, super.key});

  final String consultationId;

  @override
  Widget build(BuildContext context) => LiveSessionScope(
    consultationId: consultationId,
    child: const _QueueView(),
  );
}

class _QueueView extends StatelessWidget {
  const _QueueView();

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<LiveSessionCubit, LiveSessionState>(
      listenWhen: (p, n) => p.consultation?.status != n.consultation?.status,
      listener: (context, state) {
        // Hand off to the live screen the moment the astrologer accepts.
        if (state.isActive) {
          final id = state.consultation!.id;
          context.pushReplacement(
            state.consultation!.channel == ConsultChannel.chat
                ? AppRoutes.consultChatPath(id)
                : AppRoutes.consultCallPath(id),
          );
        } else if (state.isOver) {
          context.pushReplacement(AppRoutes.astrologers);
        }
      },
      builder: (context, state) {
        final cubit = context.read<LiveSessionCubit>();
        final session = state.consultation;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            await _confirmLeave(context, cubit);
          },
          child: Scaffold(
            backgroundColor: colors.background,
            appBar: AppTopBar(
              title: s.waitingRoom,
              leading: IconButton(
                icon: Icon(Icons.close_rounded, color: colors.icon),
                onPressed: () => _confirmLeave(context, cubit),
              ),
            ),
            body: SafeArea(
              child: session == null
                  ? const LoadingView()
                  : Padding(
                      padding: const EdgeInsets.all(AppSpacing.pageGutter),
                      child: Column(
                        children: [
                          const Spacer(),
                          AppAvatar(
                            source: session.astrologerAvatar,
                            name: session.astrologerName.en,
                            size: 96,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            session.astrologerName.forLanguage(
                              context.languageCode,
                            ),
                            style: context.textTheme.displaySmall,
                          ),
                          const SizedBox(height: AppSpacing.xxl),
                          if (state.isRinging)
                            _Connecting(strings: s)
                          else
                            _QueuePosition(state: state, strings: s),
                          const SizedBox(height: AppSpacing.xl),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: colors.success.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lock_outline_rounded,
                                  size: 14,
                                  color: colors.success,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Flexible(
                                  child: Text(
                                    s.noChargeYet,
                                    style: context.textTheme.labelSmall
                                        ?.copyWith(color: colors.success),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          SecondaryButton(
                            label: s.leaveQueue,
                            onPressed: () => _confirmLeave(context, cubit),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmLeave(
    BuildContext context,
    LiveSessionCubit cubit,
  ) async {
    final s = ConsultationStrings.of(context);
    final confirmed = await AppConfirmSheet.show(
      context,
      title: s.leaveQueueConfirm,
      message: s.leaveQueueBody,
      confirmLabel: s.leaveQueue,
      cancelLabel: s.stayInQueue,
      icon: Icons.exit_to_app_rounded,
    );
    if (!confirmed || !context.mounted) return;
    await cubit.cancel();
    if (context.mounted) context.go(AppRoutes.astrologers);
  }
}

class _QueuePosition extends StatelessWidget {
  const _QueuePosition({required this.state, required this.strings});

  final LiveSessionState state;
  final ConsultationStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final position = state.consultation?.queuePosition ?? 0;

    return Column(
      children: [
        Container(
          width: 112,
          height: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.accent.withValues(alpha: 0.12),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                consultDigits(context, position),
                style: context.textTheme.displayLarge?.copyWith(
                  color: colors.accent,
                  height: 1,
                ),
              ),
              Text(
                strings.inQueue,
                textAlign: TextAlign.center,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.accent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          strings.aheadOfYou(consultDigits(context, position)),
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          strings.estimatedWait(
            consultDigits(context, state.estimatedWaitMinutes),
          ),
          style: context.textTheme.bodyMedium?.copyWith(
            color: colors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _Connecting extends StatelessWidget {
  const _Connecting({required this.strings});

  final ConsultationStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        SizedBox(
          width: 52,
          height: 52,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: colors.accent,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(strings.connecting, style: context.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        Text(
          strings.ringingBody,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: colors.textMuted,
          ),
        ),
      ],
    );
  }
}
