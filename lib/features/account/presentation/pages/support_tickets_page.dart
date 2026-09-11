import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/account_entities.dart';
import '../cubit/account_cubits.dart';
import '../l10n/account_strings.dart';

/// Support tickets.
class SupportTicketsPage extends StatelessWidget {
  const SupportTicketsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<SupportTicketsCubit>()..load(),
    child: const _TicketsView(),
  );
}

class _TicketsView extends StatelessWidget {
  const _TicketsView();

  StatusTone _tone(TicketStatus status) => switch (status) {
    TicketStatus.open => StatusTone.info,
    TicketStatus.waitingOnYou => StatusTone.warning,
    TicketStatus.resolved => StatusTone.success,
    TicketStatus.closed => StatusTone.neutral,
  };

  @override
  Widget build(BuildContext context) {
    final s = AccountStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.myTickets, showBack: true),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton.extended(
          backgroundColor: colors.accent,
          foregroundColor: colors.onPrimary,
          onPressed: () => _newTicket(context),
          icon: const Icon(Icons.add_rounded),
          label: Text(s.newTicket),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<SupportTicketsCubit, SupportTicketsState>(
          builder: (context, state) {
            final cubit = context.read<SupportTicketsCubit>();

            return switch (state.tickets) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 3),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ when state.isEmpty => EmptyViewWithBody(
                title: s.noTickets,
                body: s.noTicketsBody,
                icon: Icons.support_agent_outlined,
                actionLabel: s.newTicket,
                onAction: () => _newTicket(context),
              ),
              _ => ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.md,
                  AppSpacing.pageGutter,
                  AppSpacing.xxxl * 2,
                ),
                children: [
                  for (final ticket in state.all)
                    AppCard(
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
                      onTap: () =>
                          context.push(AppRoutes.supportTicketPath(ticket.id)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  ticket.subject,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.titleSmall,
                                ),
                              ),
                              StatusChip(
                                label: s.ticketStatusName(ticket.status),
                                tone: _tone(ticket.status),
                                dense: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          if (ticket.lastMessage != null)
                            Text(
                              ticket.lastMessage!.body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            '${ticket.reference} · '
                            '${s.topicName(ticket.topic)} · '
                            '${relativeTime(context, ticket.updatedAt)}',
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            };
          },
        ),
      ),
    );
  }

  Future<void> _newTicket(BuildContext context) async {
    final cubit = context.read<SupportTicketsCubit>();
    final created = await AppBottomSheet.show<SupportTicket>(
      context,
      builder: (_) => BlocProvider<SupportTicketsCubit>.value(
        value: cubit,
        child: const _NewTicketSheet(),
      ),
    );
    if (created != null && context.mounted) {
      AppSnack.success(context, AccountStrings.of(context).ticketSubmitted);
      await context.push(AppRoutes.supportTicketPath(created.id));
    }
  }
}

class _NewTicketSheet extends StatefulWidget {
  const _NewTicketSheet();

  @override
  State<_NewTicketSheet> createState() => _NewTicketSheetState();
}

class _NewTicketSheetState extends State<_NewTicketSheet> {
  final _subject = TextEditingController();
  final _body = TextEditingController();
  TicketTopic _topic = TicketTopic.payment;
  String? _error;

  @override
  void dispose() {
    _subject.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AccountStrings.of(context);
    final cubit = context.read<SupportTicketsCubit>();
    final submitting = context
        .watch<SupportTicketsCubit>()
        .state
        .submitting
        .isLoading;

    return AppBottomSheet(
      title: s.newTicket,
      actions: PrimaryButton(
        label: s.submitTicket,
        height: 46,
        isLoading: submitting,
        onPressed: () async {
          final ticket = await cubit.create(
            subject: _subject.text,
            topic: _topic,
            body: _body.text,
          );
          if (!context.mounted) return;
          if (ticket == null) {
            setState(
              () => _error =
                  cubit.state.submitting.errorMessage ??
                  context.l10n.somethingWentWrong,
            );
          } else {
            Navigator.of(context).pop(ticket);
          }
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.topic, style: context.textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final topic in TicketTopic.values)
                ChoiceChip(
                  label: Text(s.topicName(topic)),
                  selected: _topic == topic,
                  onSelected: (_) => setState(() => _topic = topic),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _subject,
            label: s.subject,
            hint: s.subjectHint,
            required: true,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _body,
            label: s.describe,
            hint: s.describeHint,
            required: true,
            maxLines: 6,
            minLines: 4,
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              _error!,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colors.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// One ticket's message thread.
class SupportTicketPage extends StatelessWidget {
  const SupportTicketPage({required this.ticketId, super.key});

  final String ticketId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<SupportTicketsCubit>()..load(),
    child: _TicketThreadView(ticketId: ticketId),
  );
}

class _TicketThreadView extends StatefulWidget {
  const _TicketThreadView({required this.ticketId});

  final String ticketId;

  @override
  State<_TicketThreadView> createState() => _TicketThreadViewState();
}

class _TicketThreadViewState extends State<_TicketThreadView> {
  final _reply = TextEditingController();

  @override
  void dispose() {
    _reply.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AccountStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<SupportTicketsCubit, SupportTicketsState>(
      builder: (context, state) {
        final ticket = state.byId(widget.ticketId);
        final cubit = context.read<SupportTicketsCubit>();

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: ticket?.reference ?? s.support,
            showBack: true,
          ),
          body: SafeArea(
            child: ticket == null
                ? const LoadingView()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.pageGutter),
                        child: AppCard(
                          elevated: false,
                          color: colors.surfaceVariant,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  ticket.subject,
                                  style: context.textTheme.titleSmall,
                                ),
                              ),
                              StatusChip(
                                label: s.ticketStatusName(ticket.status),
                                tone: ticket.isOpen
                                    ? StatusTone.warning
                                    : StatusTone.success,
                                dense: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.pageGutter,
                          ),
                          children: [
                            for (final message in ticket.messages)
                              _MessageBubble(message: message, strings: s),
                          ],
                        ),
                      ),
                      if (ticket.canReply)
                        Container(
                          decoration: BoxDecoration(
                            color: colors.surface,
                            border: Border(
                              top: BorderSide(color: colors.divider),
                            ),
                          ),
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _reply,
                                  hint: s.replyHint,
                                  maxLines: 4,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              PrimaryButton(
                                label: s.send,
                                expanded: false,
                                height: 42,
                                onPressed: () async {
                                  final text = _reply.text.trim();
                                  if (text.isEmpty) return;
                                  final ok = await cubit.reply(ticket.id, text);
                                  if (ok) _reply.clear();
                                },
                              ),
                            ],
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.pageGutter),
                          child: Text(
                            s.ticketClosed,
                            textAlign: TextAlign.center,
                            style: context.textTheme.labelMedium?.copyWith(
                              color: colors.textMuted,
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
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.strings});

  final TicketMessage message;
  final AccountStrings strings;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fromSupport = message.fromSupport;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: fromSupport
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          if (fromSupport)
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                strings.supportTeam,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          Container(
            constraints: BoxConstraints(
              maxWidth: context.screenSize.width * 0.78,
            ),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: fromSupport ? colors.surface : colors.accent,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: fromSupport
                  ? Border.all(color: colors.border.withValues(alpha: 0.6))
                  : null,
            ),
            child: Text(
              message.body,
              style: context.textTheme.bodyMedium?.copyWith(
                color: fromSupport ? colors.textPrimary : colors.onPrimary,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            relativeTime(context, message.sentAt),
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
