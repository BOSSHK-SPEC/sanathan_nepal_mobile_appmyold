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
import '../widgets/billing_meter.dart';
import '../widgets/call_status_line.dart';
import '../widgets/call_video_view.dart';
import '../widgets/live_session_scope.dart';

/// Live voice or video consultation.
///
/// Committed to a single dark treatment rather than following the app theme:
/// a call screen is a full-attention surface, and a light one is unusable at
/// night, which is when most of these sessions happen.
class ConsultCallPage extends StatelessWidget {
  const ConsultCallPage({required this.consultationId, super.key});

  final String consultationId;

  @override
  Widget build(BuildContext context) => LiveSessionScope(
    consultationId: consultationId,
    child: const _CallView(),
  );
}

class _CallView extends StatelessWidget {
  const _CallView();

  static const Color _ground = Color(0xFF14121F);
  static const Color _onGround = Color(0xFFF2F0F7);
  static const Color _muted = Color(0xFF9C97B0);

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<LiveSessionCubit, LiveSessionState>(
      listenWhen: (p, n) => p.isOver != n.isOver,
      listener: (context, state) {
        if (state.isOver) {
          context.pushReplacement(
            AppRoutes.consultSummaryPath(state.consultation!.id),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<LiveSessionCubit>();
        final session = state.consultation;
        final isVideo = session?.channel == ConsultChannel.video;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (!didPop) await _confirmEnd(context, cubit);
          },
          child: Scaffold(
            backgroundColor: _ground,
            body: SafeArea(
              child: session == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        const SizedBox(height: AppSpacing.lg),
                        BillingMeter(state: state),
                        // Directly under the meter, because the two belong
                        // together: this is what says whether the minutes
                        // being charged are carrying any audio.
                        CallStatusLine(
                          state: state.callState,
                          error: state.callError,
                          onRetry: cubit.retryCall,
                        ),
                        if (state.isLowBalance)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppSpacing.md,
                              left: AppSpacing.pageGutter,
                              right: AppSpacing.pageGutter,
                            ),
                            child: _CallWarning(
                              label: state.isOutOfBalance
                                  ? s.outOfBalanceTitle
                                  : s.lowBalanceTitle,
                              actionLabel: s.topUpNow,
                              onAction: () =>
                                  context.push(AppRoutes.walletTopUp),
                            ),
                          ),
                        // A video session shows the person; a voice session
                        // shows who you are talking to. Same screen, and the
                        // controls below are identical either way.
                        if (isVideo)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.pageGutter,
                                vertical: AppSpacing.lg,
                              ),
                              child: CallVideoView(
                                room: cubit.mediaRoom,
                                placeholderName: session.astrologerName
                                    .forLanguage(context.languageCode),
                                avatarUrl: session.astrologerAvatar,
                              ),
                            ),
                          )
                        else ...[
                          const Spacer(),
                          AppAvatar(
                            source: session.astrologerAvatar,
                            name: session.astrologerName.en,
                            size: 148,
                            borderColor: colors.accent,
                          ),
                        ],
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          session.astrologerName.forLanguage(
                            context.languageCode,
                          ),
                          style: context.textTheme.displaySmall?.copyWith(
                            color: _onGround,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          s.statusName(session.status),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: _muted,
                          ),
                        ),
                        // The video already took the free space above; a second
                        // flexible child here would halve the picture.
                        if (!isVideo) const Spacer(),
                        if (isVideo) const SizedBox(height: AppSpacing.xl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _CallButton(
                              icon: state.muted
                                  ? Icons.mic_off_rounded
                                  : Icons.mic_rounded,
                              label: s.muted,
                              active: state.muted,
                              onTap: cubit.toggleMute,
                            ),
                            const SizedBox(width: AppSpacing.lg),
                            _CallButton(
                              icon: state.speakerOn
                                  ? Icons.volume_up_rounded
                                  : Icons.volume_down_rounded,
                              label: s.speaker,
                              active: state.speakerOn,
                              onTap: cubit.toggleSpeaker,
                            ),
                            if (isVideo) ...[
                              const SizedBox(width: AppSpacing.lg),
                              _CallButton(
                                icon: state.cameraOn
                                    ? Icons.videocam_rounded
                                    : Icons.videocam_off_rounded,
                                label: s.camera,
                                active: state.cameraOn,
                                onTap: cubit.toggleCamera,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        _EndCallButton(
                          onTap: () => _confirmEnd(context, cubit),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmEnd(BuildContext context, LiveSessionCubit cubit) async {
    final s = ConsultationStrings.of(context);
    final confirmed = await AppConfirmSheet.show(
      context,
      title: s.endSessionConfirm,
      message: s.endSessionBody,
      confirmLabel: s.endSession,
      cancelLabel: s.keepTalking,
      icon: Icons.call_end_rounded,
    );
    if (!confirmed || !context.mounted) return;
    final ended = await cubit.end();
    if (ended != null && context.mounted) {
      context.pushReplacement(AppRoutes.consultSummaryPath(ended.id));
    }
  }
}

class _CallButton extends StatelessWidget {
  const _CallButton({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    toggled: active,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active
              ? _CallView._onGround.withValues(alpha: 0.9)
              : _CallView._onGround.withValues(alpha: 0.14),
        ),
        child: Icon(
          icon,
          size: 24,
          color: active ? _CallView._ground : _CallView._onGround,
        ),
      ),
    ),
  );
}

class _EndCallButton extends StatelessWidget {
  const _EndCallButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: ConsultationStrings.of(context).endSession,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68,
        height: 68,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFE23B3B),
        ),
        child: const Icon(
          Icons.call_end_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
    ),
  );
}

class _CallWarning extends StatelessWidget {
  const _CallWarning({
    required this.label,
    required this.actionLabel,
    required this.onAction,
  });

  final String label;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFFE23B3B).withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(AppRadius.lg),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.error_outline_rounded,
          size: 18,
          color: Color(0xFFFF8A8A),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(
              color: const Color(0xFFFFC9C9),
            ),
          ),
        ),
        TextButton(
          onPressed: onAction,
          child: Text(
            actionLabel,
            style: context.textTheme.labelMedium?.copyWith(
              color: const Color(0xFFFFC9C9),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}
