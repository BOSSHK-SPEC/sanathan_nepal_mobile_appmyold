import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/chat_message.dart';
import '../l10n/consultation_strings.dart';
import 'chat_bubble.dart';

/// The message list, in its three real states.
///
/// Three, not two. Both chat screens used to ask only "is the list empty?" and
/// show a spinner if it was — so a consultation that had just been accepted,
/// which correctly has no messages, sat loading forever. An empty live chat is
/// a normal, finished state that should invite the first message; only a fetch
/// that has not come back yet is loading; and one that failed should say so.
class ChatBody extends StatelessWidget {
  const ChatBody({
    required this.messages,
    required this.isLoading,
    required this.isEmpty,
    required this.errorMessage,
    required this.onRetry,
    required this.controller,
    required this.viewer,
    required this.strings,
    this.onRetryMessage,
    super.key,
  });

  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isEmpty;
  final String? errorMessage;
  final VoidCallback onRetry;
  final ScrollController controller;

  /// Whose screen this is. The astrologer console shows the same thread from
  /// the other side, so alignment follows the viewer.
  final ChatSender viewer;
  final ConsultationStrings strings;

  /// Retries a message that failed to send, when the screen offers it.
  final VoidCallback? onRetryMessage;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const LoadingView();

    if (errorMessage != null) {
      return ErrorView(message: errorMessage, onRetry: onRetry);
    }

    if (isEmpty) {
      final colors = context.colors;
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chat_bubble_outline_rounded,
                size: 40,
                color: colors.primary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                strings.chatEmptyTitle,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                strings.chatEmptyBody,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.all(AppSpacing.pageGutter),
      itemCount: messages.length,
      itemBuilder: (context, i) => ChatBubble(
        message: messages[i],
        viewer: viewer,
        onRetry: onRetryMessage,
      ),
    );
  }
}
