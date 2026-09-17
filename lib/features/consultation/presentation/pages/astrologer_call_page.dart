import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../cubit/astrologer_session_cubit.dart';
import '../l10n/consultation_strings.dart';
import '../widgets/call_status_line.dart';
import '../widgets/call_video_view.dart';

/// The astrologer's voice and video call screen.
///
/// Mirrors the seeker's call screen — same dark treatment, same control
/// layout — with two differences that matter: the meter shows what the
/// astrologer is *earning* rather than spending, and chat stays one tap
/// away, because astrologers routinely send a chart or a remedy in writing
/// while talking.
class AstrologerCallPage extends StatelessWidget {
  const AstrologerCallPage({required this.consultationId, super.key});

  final String consultationId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        GetIt.I<AstrologerSessionCubit>(param1: consultationId)..load(),
    child: const _AstrologerCallView(),
  );
}

class _AstrologerCallView extends StatelessWidget {
  const _AstrologerCallView();

  static const Color _ground = Color(0xFF14121F);
  static const Color _onGround = Color(0xFFF2F0F7);
  static const Color _muted = Color(0xFF9C97B0);

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<AstrologerSessionCubit, AstrologerSessionState>(
      listenWhen: (p, n) => p.isOver != n.isOver,
      listener: (context, state) {
        if (state.isOver && state.consultation != null) {
          context.pushReplacement(
            AppRoutes.astrologerNotesPath(state.consultation!.id),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AstrologerSessionCubit>();
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
                        // Earning, not spending — the same meter read from
                        // the other side of the transaction.
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: colors.success.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 14,
                                color: colors.success,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                state.elapsedLabel,
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: colors.success,
                                  fontWeight: FontWeight.w700,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              MoneyText(
                                state.grossSoFar,
                                style: context.textTheme.labelMedium,
                                color: _onGround,
                              ),
                            ],
                          ),
                        ),
                        CallStatusLine(
                          state: state.callState,
                          error: state.callError,
                          onRetry: cubit.retryCall,
                        ),
                        // The client's picture on a video session — the same
                        // view the seeker sees, from the other side.
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
                              ),
                            ),
                          )
                        else ...[
                          const Spacer(),
                          AppAvatar(
                            name: session.astrologerName.en,
                            size: 148,
                            borderColor: colors.accent,
                          ),
                        ],
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          s.clientOnCall,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: _muted,
                          ),
                        ),
                        Text(
                          session.astrologerName.forLanguage(
                            context.languageCode,
                          ),
                          style: context.textTheme.displaySmall?.copyWith(
                            color: _onGround,
                          ),
                        ),
                        if (session.question.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.lg),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xxl,
                            ),
                            child: Text(
                              session.question,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: _muted,
                              ),
                            ),
                          ),
                        ],
                        // See the seeker's screen: with video above taking the
                        // free space, a second flexible child would halve it.
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
                            const SizedBox(width: AppSpacing.lg),
                            // Astrologers send charts and remedies in
                            // writing mid-call, so chat is a peer control.
                            _CallButton(
                              icon: Icons.chat_bubble_outline_rounded,
                              label: s.openChat,
                              active: false,
                              onTap: () => context.push(
                                AppRoutes.astrologerSessionPath(session.id),
                              ),
                            ),
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

  Future<void> _confirmEnd(
    BuildContext context,
    AstrologerSessionCubit cubit,
  ) async {
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
      context.pushReplacement(AppRoutes.astrologerNotesPath(ended.id));
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
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active
              ? _AstrologerCallView._onGround.withValues(alpha: 0.9)
              : _AstrologerCallView._onGround.withValues(alpha: 0.14),
        ),
        child: Icon(
          icon,
          size: 22,
          color: active
              ? _AstrologerCallView._ground
              : _AstrologerCallView._onGround,
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
