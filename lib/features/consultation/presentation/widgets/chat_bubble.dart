import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/chat_message.dart';
import '../l10n/consultation_strings.dart';

/// One chat message.
///
/// Delivery state is shown with ticks on the seeker's own messages only —
/// mirroring it on the astrologer's side would be meaningless noise.
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.message,
    super.key,
    this.onRetry,
    this.viewer = ChatSender.seeker,
  });

  final ChatMessage message;
  final VoidCallback? onRetry;

  /// Whose screen this is. The astrologer console shows the same thread from
  /// the other side, so alignment is a property of the viewer — never of a
  /// rewritten sender.
  final ChatSender viewer;

  bool get _mine => message.sender == viewer;

  IconData? get _tick => switch (message.status) {
    MessageStatus.sending => Icons.schedule_rounded,
    MessageStatus.sent => Icons.check_rounded,
    MessageStatus.delivered => Icons.done_all_rounded,
    MessageStatus.read => Icons.done_all_rounded,
    MessageStatus.failed => Icons.error_outline_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    if (message.isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              ConsultationStrings.of(context).sessionStarted,
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.textMuted,
              ),
            ),
          ),
        ),
      );
    }

    final mine = _mine;
    final failed = message.status == MessageStatus.failed;
    final read = message.status == MessageStatus.read;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: mine
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: GestureDetector(
              onTap: failed ? onRetry : null,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: context.screenSize.width * 0.76,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: mine ? colors.accent : colors.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(AppRadius.xl),
                    topRight: const Radius.circular(AppRadius.xl),
                    bottomLeft: Radius.circular(mine ? AppRadius.xl : 4),
                    bottomRight: Radius.circular(mine ? 4 : AppRadius.xl),
                  ),
                  border: mine
                      ? null
                      : Border.all(color: colors.border.withValues(alpha: 0.6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message.text,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: mine ? colors.onPrimary : colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat.Hm().format(message.sentAt),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: mine
                                ? colors.onPrimary.withValues(alpha: 0.75)
                                : colors.textMuted,
                            fontSize: 9,
                          ),
                        ),
                        if (mine && _tick != null) ...[
                          const SizedBox(width: 3),
                          Icon(
                            _tick,
                            size: 12,
                            color: failed
                                ? colors.error
                                : read
                                ? colors.info
                                : colors.onPrimary.withValues(alpha: 0.75),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Three-dot indicator shown while the astrologer is composing.
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Respect a reduced-motion preference: the label alone still says what
    // is happening.
    if (MediaQuery.disableAnimationsOf(context)) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Text(
          ConsultationStrings.of(context).astrologerTyping,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.textMuted,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.xl),
                topRight: Radius.circular(AppRadius.xl),
                bottomRight: Radius.circular(AppRadius.xl),
                bottomLeft: Radius.circular(4),
              ),
              border: Border.all(color: colors.border.withValues(alpha: 0.6)),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (i) {
                  final phase = (_controller.value * 3 - i).clamp(0.0, 1.0);
                  final lift = (phase < 0.5 ? phase : 1 - phase) * 2;
                  return Padding(
                    padding: EdgeInsets.only(
                      right: i == 2 ? 0 : 4,
                      bottom: lift * 3,
                    ),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.textMuted,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
