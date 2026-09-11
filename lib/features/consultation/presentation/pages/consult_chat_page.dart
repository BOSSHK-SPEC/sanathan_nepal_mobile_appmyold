import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/live_session_cubit.dart';
import '../l10n/consultation_strings.dart';
import '../widgets/billing_meter.dart';
import '../../domain/entities/chat_message.dart';
import '../widgets/chat_body.dart';
import '../widgets/live_session_scope.dart';

/// Live text consultation.
class ConsultChatPage extends StatelessWidget {
  const ConsultChatPage({required this.consultationId, super.key});

  final String consultationId;

  @override
  Widget build(BuildContext context) => LiveSessionScope(
    consultationId: consultationId,
    child: const _ChatView(),
  );
}

class _ChatView extends StatefulWidget {
  const _ChatView();

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    if (!_scroll.hasClients) return;
    // After the frame, so the new bubble is laid out before we scroll.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<LiveSessionCubit, LiveSessionState>(
      listenWhen: (p, n) =>
          p.chat.length != n.chat.length || p.isOver != n.isOver,
      listener: (context, state) {
        _scrollToEnd();
        if (state.isOver) {
          context.pushReplacement(
            AppRoutes.consultSummaryPath(state.consultation!.id),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<LiveSessionCubit>();
        final session = state.consultation;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (!didPop) await _confirmEnd(context, cubit);
          },
          child: Scaffold(
            backgroundColor: colors.background,
            appBar: AppBar(
              backgroundColor: colors.surface,
              titleSpacing: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: colors.icon),
                onPressed: () => _confirmEnd(context, cubit),
              ),
              title: session == null
                  ? null
                  : Row(
                      children: [
                        AppAvatar(
                          source: session.astrologerAvatar,
                          name: session.astrologerName.en,
                          size: 34,
                          online: true,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            session.astrologerName.forLanguage(
                              context.languageCode,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Center(child: BillingMeter(state: state)),
                ),
                TextButton(
                  onPressed: () => _confirmEnd(context, cubit),
                  child: Text(
                    s.endSession,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  LowBalanceBanner(
                    state: state,
                    onTopUp: () => context.push(AppRoutes.walletTopUp),
                    onEnd: () => _confirmEnd(context, cubit),
                  ),
                  Expanded(
                    child: ChatBody(
                      messages: state.chat,
                      isLoading: state.isLoadingChat,
                      isEmpty: state.hasNoMessagesYet,
                      errorMessage: state.chatError,
                      onRetry: cubit.refreshNow,
                      controller: _scroll,
                      viewer: ChatSender.seeker,
                      strings: s,
                      onRetryMessage: cubit.send,
                    ),
                  ),
                  _Composer(
                    controller: _input,
                    state: state,
                    onChanged: cubit.setDraft,
                    onSend: () {
                      cubit.send();
                      _input.clear();
                    },
                  ),
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
    if (!context.mounted) return;

    // Ending can fail, and it used to fail silently: the result was written to
    // state that nothing rendered, so the button simply did nothing and the
    // session stayed open with no explanation.
    if (ended == null) {
      final reason = cubit.state.endError;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(reason ?? context.l10n.somethingWentWrong)),
        );
      return;
    }

    if (context.mounted) {
      context.pushReplacement(AppRoutes.consultSummaryPath(ended.id));
    }
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.state,
    required this.onChanged,
    required this.onSend,
  });

  final TextEditingController controller;
  final LiveSessionState state;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;
    final enabled = state.isActive && !state.isOutOfBalance;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.divider)),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 110),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  minLines: 1,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: onChanged,
                  onSubmitted: (_) => enabled ? onSend() : null,
                  style: context.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: s.typeMessage,
                    hintStyle: context.textTheme.bodyMedium?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _SendButton(enabled: state.canSend, onTap: onSend),
          ],
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.enabled, required this.onTap});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: colors.primaryGradient,
          ),
          child: Icon(Icons.send_rounded, size: 19, color: colors.onPrimary),
        ),
      ),
    );
  }
}
