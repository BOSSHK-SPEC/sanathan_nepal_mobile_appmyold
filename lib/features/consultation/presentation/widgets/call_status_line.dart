import 'package:flutter/material.dart';

import '../../../../core/call/call_session.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/consultation_strings.dart';

/// Says where the call is, on a screen that is already charging for it.
///
/// A live consultation bills from the moment the astrologer accepts, which is
/// before the media connection exists and continues through a reconnect. Both
/// screens showed a full set of call controls throughout, so a call that never
/// connected looked exactly like one in progress. This is the difference.
///
/// Nothing is drawn once the call is connected: a permanent "connected" badge
/// is noise on a screen whose whole purpose is the call.
class CallStatusLine extends StatelessWidget {
  const CallStatusLine({
    required this.state,
    required this.error,
    required this.onRetry,
    super.key,
  });

  final CallConnectionState state;

  /// What went wrong, in the server's or the platform's words.
  final String? error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return switch (state) {
      CallConnectionState.connecting => _Line(
        label: s.connectingCall,
        color: colors.textSecondary,
        showSpinner: true,
      ),
      CallConnectionState.reconnecting => _Line(
        label: s.reconnecting,
        color: colors.warning,
        showSpinner: true,
      ),
      CallConnectionState.failed => _Failed(
        // The reason is far more useful than "failed": a refused microphone
        // and an unreachable server need different things from the user.
        label: error ?? s.callFailed,
        actionLabel: s.retry,
        onRetry: onRetry,
      ),
      CallConnectionState.idle ||
      CallConnectionState.connected ||
      CallConnectionState.disconnected => const SizedBox.shrink(),
    };
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.label,
    required this.color,
    required this.showSpinner,
  });

  final String label;
  final Color color;
  final bool showSpinner;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.md),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showSpinner) ...[
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(strokeWidth: 2, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(color: color),
        ),
      ],
    ),
  );
}

class _Failed extends StatelessWidget {
  const _Failed({
    required this.label,
    required this.actionLabel,
    required this.onRetry,
  });

  final String label;
  final String actionLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageGutter,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 16, color: colors.error),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(color: colors.error),
            ),
          ),
          TextButton(onPressed: onRetry, child: Text(actionLabel)),
        ],
      ),
    );
  }
}
