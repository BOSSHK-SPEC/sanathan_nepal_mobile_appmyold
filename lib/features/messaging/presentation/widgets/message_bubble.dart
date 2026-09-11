import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/business_message.dart';
import '../l10n/messaging_strings.dart';

/// One message in a business conversation.
///
/// Alignment is a property of the *viewer*, not of a stored sender: the shop
/// owner reads the same thread from the other side, and rewriting the sender
/// to make it look right would corrupt the transcript.
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    required this.viewer,
    super.key,
    this.onRetry,
  });

  final BusinessMessage message;
  final MessageSide viewer;
  final VoidCallback? onRetry;

  bool get _mine => message.sender == viewer;

  IconData get _tick => switch (message.delivery) {
    MessageDelivery.sending => Icons.schedule_rounded,
    MessageDelivery.sent => Icons.check_rounded,
    MessageDelivery.read => Icons.done_all_rounded,
    MessageDelivery.failed => Icons.error_outline_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MessagingStrings.of(context);
    final mine = _mine;
    final failed = message.hasFailed;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: mine
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: mine
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Semantics(
                  label: mine ? s.you : null,
                  button: failed,
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
                            : Border.all(
                                color: colors.border.withValues(alpha: 0.6),
                              ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message.body,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: mine
                                  ? colors.onPrimary
                                  : colors.textPrimary,
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
                              if (mine) ...[
                                const SizedBox(width: 3),
                                Icon(
                                  _tick,
                                  size: 12,
                                  color: failed
                                      ? colors.error
                                      : message.delivery == MessageDelivery.read
                                      ? colors.info
                                      : colors.onPrimary.withValues(
                                          alpha: 0.75,
                                        ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (failed)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '${s.failedToSend} · ${s.tapToRetry}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
