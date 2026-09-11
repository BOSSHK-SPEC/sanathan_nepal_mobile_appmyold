import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/chat_message.dart';
import '../cubit/live_session_cubit.dart';
import '../l10n/consultation_strings.dart';
import '../widgets/chat_bubble.dart';

/// Read-only transcript of a finished chat consultation.
///
/// Reuses the live session's message list rather than a second store: the
/// transcript *is* the thread, and duplicating it would let the two drift.
/// The composer is simply absent — a finished session cannot be added to.
class TranscriptPage extends StatelessWidget {
  const TranscriptPage({required this.consultationId, super.key});

  final String consultationId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<LiveSessionCubit>(param1: consultationId)..load(),
    child: const _TranscriptView(),
  );
}

class _TranscriptView extends StatelessWidget {
  const _TranscriptView();

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.transcript, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<LiveSessionCubit, LiveSessionState>(
          builder: (context, state) => switch (state.messages) {
            Idle() || Loading(previous: null) => const LoadingView(),
            _ when state.chat.isEmpty => EmptyView(
              message: s.noTranscript,
              icon: Icons.chat_bubble_outline_rounded,
            ),
            _ => ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              itemCount: state.chat.length,
              itemBuilder: (context, i) =>
                  ChatBubble(message: state.chat[i], viewer: ChatSender.seeker),
            ),
          },
        ),
      ),
    );
  }
}
