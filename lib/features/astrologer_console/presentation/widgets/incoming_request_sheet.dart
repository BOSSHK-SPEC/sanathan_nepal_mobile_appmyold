import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../domain/entities/queue_entry.dart';
import '../cubit/console_dashboard_cubit.dart';
import '../l10n/console_strings.dart';

/// The timed accept/decline moment.
///
/// Modal and non-dismissible: an offer that expires must not be something
/// the astrologer can swipe away by accident, and letting it time out
/// silently is what erodes an acceptance rate. The countdown ring shows the
/// remaining time as shape as well as number.
class IncomingRequestSheet extends StatefulWidget {
  const IncomingRequestSheet({required this.request, super.key});

  final IncomingRequest request;

  static Future<void> show(
    BuildContext context, {
    required IncomingRequest request,
  }) {
    final cubit = context.read<ConsoleDashboardCubit>();
    return AppBottomSheet.show<void>(
      context,
      isDismissible: false,
      builder: (_) => BlocProvider<ConsoleDashboardCubit>.value(
        value: cubit,
        child: IncomingRequestSheet(request: request),
      ),
    );
  }

  @override
  State<IncomingRequestSheet> createState() => _IncomingRequestSheetState();
}

class _IncomingRequestSheetState extends State<IncomingRequestSheet> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {});
      if (widget.request.secondsRemaining() <= 0) _expire();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  /// Letting the timer run out is a decline, and is recorded as one — an
  /// offer that quietly vanishes teaches nothing.
  Future<void> _expire() async {
    _ticker?.cancel();
    if (!mounted) return;
    await context.read<ConsoleDashboardCubit>().respond(accept: false);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _respond({required bool accept}) async {
    _ticker?.cancel();
    final cubit = context.read<ConsoleDashboardCubit>();
    final sessionId = await cubit.respond(accept: accept);
    if (!mounted) return;
    Navigator.of(context).pop();
    if (sessionId != null && context.mounted) {
      // Accepting opens the session the seeker is already waiting in — as a
      // call or as chat, depending on what they asked for.
      context.push(
        widget.request.entry.channel == ConsultChannel.chat
            ? AppRoutes.astrologerSessionPath(sessionId)
            : AppRoutes.astrologerCallPath(sessionId),
      );
    }
  }

  IconData _icon(ConsultChannel channel) => switch (channel) {
    ConsultChannel.chat => Icons.chat_bubble_outline_rounded,
    ConsultChannel.voice => Icons.call_outlined,
    ConsultChannel.video => Icons.videocam_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;
    final entry = widget.request.entry;
    final remaining = widget.request.secondsRemaining();

    return PopScope(
      canPop: false,
      child: AppBottomSheet(
        showClose: false,
        scrollable: false,
        actions: Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: s.decline,
                onPressed: () => _respond(accept: false),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 2,
              child: PrimaryButton(
                label: s.accept,
                height: 46,
                onPressed: () => _respond(accept: true),
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 92,
              height: 92,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: widget.request.progress(),
                      strokeWidth: 5,
                      strokeCap: StrokeCap.round,
                      backgroundColor: colors.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation(
                        remaining <= 10 ? colors.error : colors.accent,
                      ),
                    ),
                  ),
                  Text(
                    '$remaining',
                    style: context.textTheme.displaySmall?.copyWith(
                      color: remaining <= 10 ? colors.error : colors.accent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(s.newRequest, style: context.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                AppAvatar(
                  source: entry.seekerAvatar,
                  name: entry.seekerName,
                  size: 46,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              entry.seekerName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                          if (entry.isRepeatClient) ...[
                            const SizedBox(width: AppSpacing.xs),
                            StatusChip(
                              label: s.repeatClient,
                              tone: StatusTone.info,
                              dense: true,
                            ),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            _icon(entry.channel),
                            size: 13,
                            color: colors.iconMuted,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            s.minutesLabel('${entry.affordableMinutes}'),
                            style: context.textTheme.labelSmall?.copyWith(
                              color: entry.isShortOnBalance
                                  ? colors.error
                                  : colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (entry.question.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              AppCard(
                elevated: false,
                color: colors.surfaceVariant,
                child: Text(
                  entry.question,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
            if (entry.isShortOnBalance) ...[
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 16,
                    color: colors.warning,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      s.lowBalanceWarning,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: colors.warning,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
