import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/chat_message.dart';
import '../cubit/astrologer_session_cubit.dart';
import '../l10n/consultation_strings.dart';
import '../widgets/chat_body.dart';

/// Where the astrologer actually conducts a session.
///
/// The client's question and details sit in a collapsible panel above the
/// thread rather than on another screen: an astrologer re-reads the birth
/// details constantly, and making that a navigation step would mean losing
/// the conversation every time.
class AstrologerConsolePage extends StatelessWidget {
  const AstrologerConsolePage({required this.consultationId, super.key});

  final String consultationId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        GetIt.I<AstrologerSessionCubit>(param1: consultationId)..load(),
    child: const _ConsoleView(),
  );
}

class _ConsoleView extends StatefulWidget {
  const _ConsoleView();

  @override
  State<_ConsoleView> createState() => _ConsoleViewState();
}

class _ConsoleViewState extends State<_ConsoleView> {
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();
  bool _panelOpen = true;

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
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

    return BlocConsumer<AstrologerSessionCubit, AstrologerSessionState>(
      listenWhen: (p, n) => p.chat.length != n.chat.length,
      listener: (context, state) => _scrollToEnd(),
      builder: (context, state) {
        final cubit = context.read<AstrologerSessionCubit>();
        final session = state.consultation;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(
            backgroundColor: colors.surface,
            titleSpacing: 0,
            title: session == null
                ? null
                : Row(
                    children: [
                      const SizedBox(width: AppSpacing.sm),
                      AppAvatar(
                        name: session.astrologerName.en,
                        size: 34,
                        online: state.isActive,
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
              // Elapsed time and gross earned: the astrologer's own meter,
              // which is the mirror of the seeker's cost meter.
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: colors.success.withValues(alpha: 0.14),
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
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      MoneyText(
                        state.grossSoFar,
                        style: context.textTheme.labelMedium,
                        color: colors.textPrimary,
                      ),
                    ],
                  ),
                ),
              ),
              if (state.isActive)
                TextButton(
                  onPressed: () => _end(context, cubit),
                  child: Text(
                    s.endSession,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                const SizedBox(width: AppSpacing.sm),
            ],
          ),
          body: SafeArea(
            child: session == null
                ? const LoadingView()
                : Column(
                    children: [
                      _ClientPanel(
                        question: session.question,
                        open: _panelOpen,
                        onToggle: () =>
                            setState(() => _panelOpen = !_panelOpen),
                      ),
                      Expanded(
                        child: ChatBody(
                          messages: state.chat,
                          isLoading: state.isLoadingChat,
                          isEmpty: state.hasNoMessagesYet,
                          errorMessage: state.chatError,
                          onRetry: cubit.refreshNow,
                          controller: _scroll,
                          // The same thread, seen from the other side.
                          viewer: ChatSender.astrologer,
                          strings: s,
                        ),
                      ),
                      if (state.isActive)
                        _Composer(
                          controller: _input,
                          canSend: state.canSend,
                          onChanged: cubit.setDraft,
                          onSend: () {
                            cubit.send();
                            _input.clear();
                          },
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: PrimaryButton(
                            label: s.writeUp,
                            height: 46,
                            onPressed: () => context.pushReplacement(
                              AppRoutes.astrologerNotesPath(session.id),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Future<void> _end(BuildContext context, AstrologerSessionCubit cubit) async {
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
      // Straight into the write-up while the reading is still fresh.
      context.pushReplacement(AppRoutes.astrologerNotesPath(ended.id));
    }
  }
}

/// Collapsible client context above the thread.
class _ClientPanel extends StatelessWidget {
  const _ClientPanel({
    required this.question,
    required this.open,
    required this.onToggle,
  });

  final String question;
  final bool open;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    if (question.isEmpty) return const SizedBox.shrink();
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return Container(
      width: double.infinity,
      color: colors.surfaceVariant,
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageGutter,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline_rounded,
                    size: 16,
                    color: colors.accent,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      s.theirQuestion,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: colors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(
                    open
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    size: 18,
                    color: colors.iconMuted,
                  ),
                ],
              ),
            ),
          ),
          if (open)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                0,
                AppSpacing.pageGutter,
                AppSpacing.md,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  question,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.canSend,
    required this.onChanged,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool canSend;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

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
                  minLines: 1,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: onChanged,
                  style: context.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: s.typeMessage,
                    hintStyle: context.textTheme.bodyMedium?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Opacity(
              opacity: canSend ? 1 : 0.4,
              child: GestureDetector(
                onTap: canSend ? onSend : null,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: colors.primaryGradient,
                  ),
                  child: Icon(
                    Icons.send_rounded,
                    size: 19,
                    color: colors.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
