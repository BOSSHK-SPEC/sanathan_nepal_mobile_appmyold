import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../domain/entities/consultation.dart';
import '../cubit/active_session_cubit.dart';
import '../l10n/consultation_strings.dart';

/// Persistent bar shown while a session is live and the seeker has
/// navigated away from it.
///
/// Without this, leaving the call screen either kills a paid session or
/// leaves it billing invisibly — both of which are how people end up
/// disputing charges. Tapping returns to the session; the meter keeps
/// running either way, and stays visible while it does.
class ActiveCallBar extends StatelessWidget {
  const ActiveCallBar({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActiveSessionCubit, Consultation?>(
        builder: (context, session) =>
            session == null ? const SizedBox.shrink() : _Bar(session: session),
      );
}

class _Bar extends StatelessWidget {
  const _Bar({required this.session});

  final Consultation session;

  String get _elapsed {
    final seconds = session.elapsedSeconds();
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ConsultationStrings.of(context);
    final isChat = session.channel == ConsultChannel.chat;

    return Material(
      color: colors.success,
      child: InkWell(
        onTap: () => context.push(
          isChat
              ? AppRoutes.consultChatPath(session.id)
              : AppRoutes.consultCallPath(session.id),
        ),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.pageGutter,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  isChat
                      ? Icons.chat_bubble_rounded
                      : Icons.phone_in_talk_rounded,
                  size: 16,
                  color: colors.onPrimary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    session.astrologerName.forLanguage(context.languageCode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  _elapsed,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.onPrimary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                MoneyText(
                  session.costSoFar(),
                  style: context.textTheme.labelMedium,
                  color: colors.onPrimary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  s.costSoFar,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
