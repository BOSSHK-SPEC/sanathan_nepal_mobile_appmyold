import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/messaging_strings.dart';

/// The text field + send button at the bottom of a conversation.
class MessageComposer extends StatelessWidget {
  const MessageComposer({
    required this.controller,
    required this.onChanged,
    required this.onSend,
    required this.canSend,
    super.key,
    this.enabled = true,
    this.sending = false,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;
  final bool canSend;
  final bool enabled;
  final bool sending;

  @override
  Widget build(BuildContext context) {
    final s = MessagingStrings.of(context);
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
                  enabled: enabled,
                  minLines: 1,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: onChanged,
                  onSubmitted: (_) {
                    if (canSend) onSend();
                  },
                  style: context.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: sending ? s.sending : s.typeMessage,
                    hintStyle: context.textTheme.bodyMedium?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Semantics(
              button: true,
              label: s.send,
              child: Opacity(
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
                    child: sending
                        ? Padding(
                            padding: const EdgeInsets.all(12),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.onPrimary,
                            ),
                          )
                        : Icon(
                            Icons.send_rounded,
                            size: 19,
                            color: colors.onPrimary,
                          ),
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
