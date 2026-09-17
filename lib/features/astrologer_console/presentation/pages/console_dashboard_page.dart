import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../consultation/domain/entities/consultation.dart';
import '../../domain/entities/queue_entry.dart';
import '../cubit/console_dashboard_cubit.dart';
import '../l10n/console_strings.dart';
import '../widgets/upcoming_appointments_section.dart';
import '../widgets/compliance_banner.dart';
import '../widgets/incoming_request_sheet.dart';

/// Astrologer home: online switch, today's numbers, live queue.
class ConsoleDashboardPage extends StatelessWidget {
  const ConsoleDashboardPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ConsoleDashboardCubit>()..load(),
    child: const _DashboardView(),
  );
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<ConsoleDashboardCubit, ConsoleDashboardState>(
      listenWhen: (p, n) =>
          p.pending?.entry.id != n.pending?.entry.id ||
          // A refused go-online used to be silent: the switch sprang back and
          // nothing said why, which reads as a broken switch rather than a
          // rejected request.
          (p.togglingOnline && !n.togglingOnline && n.availability.isFailed),
      listener: (context, state) async {
        if (!state.togglingOnline && state.availability.isFailed) {
          AppSnack.error(
            context,
            state.availability.errorMessage ?? s.onlineChangeFailed,
          );
        }
        final request = state.pending;
        if (request == null) return;
        // A request is offered as a blocking sheet: it expires, so it must
        // not sit behind whatever the astrologer happens to be looking at.
        await IncomingRequestSheet.show(context, request: request);
      },
      builder: (context, state) {
        final cubit = context.read<ConsoleDashboardCubit>();
        final metrics = state.metrics;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: s.console,
            actions: [
              IconButton(
                tooltip: s.reviews,
                icon: const Icon(Icons.reviews_outlined),
                onPressed: () => context.push(AppRoutes.astrologerReviews),
              ),
              // The rest are settings-shaped and visited rarely; five icons
              // across a phone app bar leaves no room for the title.
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded),
                onSelected: context.push,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: AppRoutes.astrologerMyProfile,
                    child: _MenuRow(
                      icon: Icons.badge_outlined,
                      label: s.editProfile,
                    ),
                  ),
                  PopupMenuItem(
                    value: AppRoutes.astrologerPricing,
                    child: _MenuRow(
                      icon: Icons.sell_outlined,
                      label: s.pricing,
                    ),
                  ),
                  PopupMenuItem(
                    value: AppRoutes.astrologerWorkSettings,
                    child: _MenuRow(
                      icon: Icons.tune_rounded,
                      label: s.workSettings,
                    ),
                  ),
                  PopupMenuItem(
                    value: AppRoutes.astrologerCompliance,
                    child: _MenuRow(
                      icon: Icons.gavel_rounded,
                      label: s.compliance,
                    ),
                  ),
                  PopupMenuItem(
                    value: AppRoutes.astrologerBoost,
                    child: _MenuRow(
                      icon: Icons.rocket_launch_outlined,
                      label: s.boost,
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: RefreshIndicator(
              onRefresh: cubit.refresh,
              color: colors.accent,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.md,
                  AppSpacing.pageGutter,
                  AppSpacing.xxxl,
                ),
                children: [
                  const ComplianceBanner(),
                  _OnlineCard(state: state),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: StatTile(
                          label: s.earningsToday,
                          icon: Icons.payments_outlined,
                          valueWidget: MoneyText(
                            metrics.earningsToday,
                            style: context.textTheme.headlineMedium,
                          ),
                          trend: metrics.earningsTrend,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: StatTile(
                          label: s.earningsWeek,
                          icon: Icons.calendar_view_week_outlined,
                          valueWidget: MoneyText(
                            metrics.earningsThisWeek,
                            style: context.textTheme.headlineMedium,
                          ),
                          onTap: () =>
                              context.push(AppRoutes.astrologerEarnings),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: StatTile(
                          label: s.sessionsToday,
                          icon: Icons.forum_outlined,
                          value: _digits(context, metrics.sessionsToday),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: StatTile(
                          label: s.yourRating,
                          icon: Icons.star_outline_rounded,
                          value: metrics.rating.toStringAsFixed(1),
                          onTap: () =>
                              context.push(AppRoutes.astrologerReviews),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: StatTile(
                          label: s.acceptanceRate,
                          icon: Icons.task_alt_outlined,
                          value:
                              '${_digits(context, (metrics.acceptanceRate * 100).round())}%',
                          accentColor: metrics.acceptanceNeedsAttention
                              ? colors.error
                              : null,
                          delta: metrics.acceptanceNeedsAttention
                              ? s.acceptanceWarning
                              : null,
                          deltaPositive: metrics.acceptanceNeedsAttention
                              ? false
                              : null,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: StatTile(
                          label: s.responseTime,
                          icon: Icons.bolt_outlined,
                          value: metrics.responseLabel,
                          onTap: () =>
                              context.push(AppRoutes.astrologerAnalytics),
                        ),
                      ),
                    ],
                  ),
                  // Above the queue on purpose: a session already running is
                  // more urgent than one waiting to start, and it is the only
                  // route back into a conversation the astrologer has left.
                  if (state.hasLiveSessions) ...[
                    const SizedBox(height: AppSpacing.xl),
                    SectionHeader(title: s.ongoingSessions),
                    for (final session in state.liveSessions)
                      _OngoingSessionTile(session: session, strings: s),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  // Booked sittings: what the astrologer has to prepare for.
                  // Before the queue because it is planned work; the queue is
                  // whoever happens to be waiting right now.
                  const UpcomingAppointmentsSection(),
                  const SizedBox(height: AppSpacing.xl),
                  SectionHeader(title: s.liveQueue),
                  if (state.waiting.isEmpty)
                    _EmptyQueue(online: state.isOnline, strings: s)
                  else
                    for (final entry in state.waiting)
                      _QueueTile(entry: entry, strings: s),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OnlineCard extends StatelessWidget {
  const _OnlineCard({required this.state});

  final ConsoleDashboardState state;

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<ConsoleDashboardCubit>();
    final online = state.isOnline;

    return AppCard(
      color: online
          ? colors.success.withValues(alpha: 0.1)
          : colors.surfaceVariant,
      border: Border.all(color: online ? colors.success : colors.border),
      elevated: false,
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: online ? colors.success : colors.textMuted,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  online ? s.youAreOnline : s.youAreOffline,
                  style: context.textTheme.titleSmall,
                ),
                Text(
                  switch (state.onlineBlocker) {
                    OnlineBlocker.unavailable => s.availabilityUnavailable,
                    OnlineBlocker.noSchedule => s.setScheduleFirst,
                    OnlineBlocker.none || OnlineBlocker.loading =>
                      online ? s.queueEmptyOnline : s.queueEmptyOffline,
                  },
                  style: context.textTheme.labelSmall?.copyWith(
                    color: state.onlineBlocker == OnlineBlocker.unavailable
                        ? colors.error
                        : colors.textMuted,
                  ),
                ),
                // An explanation with nothing to act on strands the
                // astrologer on the one screen that decides whether they earn
                // today, so each blocker carries its own way out.
                if (state.onlineBlocker == OnlineBlocker.noSchedule)
                  TextButton(
                    style: _denseButton,
                    onPressed: () => context.go(AppRoutes.astrologerSchedule),
                    child: Text(s.setScheduleAction),
                  )
                else if (state.onlineBlocker == OnlineBlocker.unavailable)
                  TextButton(
                    style: _denseButton,
                    onPressed: cubit.retryAvailability,
                    child: Text(context.l10n.retry),
                  ),
              ],
            ),
          ),
          if (state.togglingOnline)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            Switch.adaptive(
              value: online,
              onChanged: state.canGoOnline ? (_) => cubit.toggleOnline() : null,
            ),
        ],
      ),
    );
  }

  /// Keeps the inline action from inheriting a full button's padding, which
  /// would push the card taller than the row it sits in.
  static final ButtonStyle _denseButton = TextButton.styleFrom(
    padding: EdgeInsets.zero,
    minimumSize: const Size(0, 28),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.compact,
  );
}

class _QueueTile extends StatelessWidget {
  const _QueueTile({required this.entry, required this.strings});

  final QueueEntry entry;
  final ConsoleStrings strings;

  IconData get _icon => switch (entry.channel) {
    ConsultChannel.chat => Icons.chat_bubble_outline_rounded,
    ConsultChannel.voice => Icons.call_outlined,
    ConsultChannel.video => Icons.videocam_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(
            source: entry.seekerAvatar,
            name: entry.seekerName,
            size: 42,
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
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    if (entry.isRepeatClient) ...[
                      const SizedBox(width: AppSpacing.xs),
                      StatusChip(
                        label: strings.repeatClient,
                        tone: StatusTone.info,
                        dense: true,
                      ),
                    ],
                  ],
                ),
                if (entry.question.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    entry.question,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(_icon, size: 13, color: colors.iconMuted),
                    Text(
                      relativeTime(context, entry.joinedAt),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                    if (entry.isShortOnBalance)
                      StatusChip(
                        label: strings.lowBalanceWarning,
                        tone: StatusTone.warning,
                        dense: true,
                        icon: Icons.warning_amber_rounded,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyQueue extends StatelessWidget {
  const _EmptyQueue({required this.online, required this.strings});

  final bool online;
  final ConsoleStrings strings;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
    child: Column(
      children: [
        Icon(Icons.inbox_outlined, size: 38, color: context.colors.textMuted),
        const SizedBox(height: AppSpacing.sm),
        Text(strings.queueEmpty, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        Text(
          online ? strings.queueEmptyOnline : strings.queueEmptyOffline,
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.textMuted,
          ),
        ),
      ],
    ),
  );
}

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 18, color: context.colors.textSecondary),
      const SizedBox(width: AppSpacing.sm),
      Text(label, style: context.textTheme.bodyMedium),
    ],
  );
}

/// One consultation that is running right now.
///
/// Tapping it reopens the same screen accepting did — chat or call, according
/// to what the seeker asked for. Without this the only route in was the accept
/// sheet, which appears once and never again: a session survived being left,
/// but the astrologer's way back into it did not.
class _OngoingSessionTile extends StatelessWidget {
  const _OngoingSessionTile({required this.session, required this.strings});

  final Consultation session;
  final ConsoleStrings strings;

  IconData get _icon => switch (session.channel) {
    ConsultChannel.chat => Icons.chat_bubble_outline_rounded,
    ConsultChannel.voice => Icons.call_outlined,
    ConsultChannel.video => Icons.videocam_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final started = session.startedAt;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      onTap: () => context.push(
        session.channel == ConsultChannel.chat
            ? AppRoutes.astrologerSessionPath(session.id)
            : AppRoutes.astrologerCallPath(session.id),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.success.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(_icon, size: 18, color: colors.success),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // The seeker's name is not on this entity — it is the
                  // seeker's own view of the session. Their question is, and
                  // it is the more useful line anyway: it says what the
                  // astrologer is being asked before they open it.
                  session.question.isEmpty
                      ? strings.ongoingSessions
                      : session.question,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                // Genuinely live, not decoration: this session is being
                // billed by the minute right now.
                StatusDot(
                  tone: StatusTone.success,
                  label: started == null
                      ? strings.ongoingSessions
                      : relativeTime(context, started),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => context.push(
              session.channel == ConsultChannel.chat
                  ? AppRoutes.astrologerSessionPath(session.id)
                  : AppRoutes.astrologerCallPath(session.id),
            ),
            child: Text(strings.rejoin),
          ),
        ],
      ),
    );
  }
}
