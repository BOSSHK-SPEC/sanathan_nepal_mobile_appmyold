import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/message_thread.dart';
import '../cubit/message_threads_cubit.dart';
import '../l10n/messaging_strings.dart';
import '../widgets/thread_tile.dart';

/// Inbox: every conversation, grouped by which side of it the user is on.
class MessageThreadsPage extends StatelessWidget {
  const MessageThreadsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<MessageThreadsCubit>()..load(),
    child: const MessageThreadsView(),
  );
}

/// Widget-testable body of [MessageThreadsPage].
class MessageThreadsView extends StatelessWidget {
  const MessageThreadsView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MessagingStrings.of(context);
    return Scaffold(
      appBar: AppTopBar(title: s.messages, showBack: true),
      body: BlocBuilder<MessageThreadsCubit, MessageThreadsState>(
        builder: (context, state) {
          final cubit = context.read<MessageThreadsCubit>();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pageGutter,
                  vertical: AppSpacing.sm,
                ),
                child: PillTabs(
                  labels: [s.inbox, s.archived],
                  selectedIndex: state.showArchived ? 1 : 0,
                  onChanged: (i) => cubit.showArchived(archived: i == 1),
                ),
              ),
              Expanded(child: _Body(state: state)),
            ],
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});
  final MessageThreadsState state;

  @override
  Widget build(BuildContext context) {
    final s = MessagingStrings.of(context);
    final cubit = context.read<MessageThreadsCubit>();

    // Stale data stays on screen while refreshing; only a first load with
    // nothing to show gets the spinner.
    if (state.threads.isLoading && state.items.isEmpty) {
      return const LoadingView();
    }
    if (state.threads case Failed(:final failure) when state.items.isEmpty) {
      return ErrorView(message: failure.message, onRetry: cubit.load);
    }
    if (state.items.isEmpty) {
      return EmptyView(
        message: state.showArchived ? s.noArchived : s.noMessagesBody,
        icon: Icons.forum_outlined,
      );
    }

    return RefreshIndicator(
      onRefresh: cubit.load,
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          // The two groups are only labelled when the user actually has both
          // sides; a customer with no shop should not be told which of their
          // two lists they are reading.
          if (state.selling.isNotEmpty && state.buying.isNotEmpty) ...[
            SectionHeader(title: s.selling),
            for (final thread in state.selling) _Tile(thread: thread),
            SectionHeader(title: s.buying),
            for (final thread in state.buying) _Tile(thread: thread),
          ] else
            for (final thread in state.items) _Tile(thread: thread),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.thread});
  final MessageThread thread;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MessageThreadsCubit>();
    return ThreadTile(
      thread: thread,
      // Reload on the way back: the conversation just read is no longer
      // unread, and an inbox that still shows the badge looks broken.
      onTap: () async {
        await context.push(AppRoutes.messageThreadPath(thread.id));
        if (context.mounted) await cubit.load();
      },
      onArchiveToggle: () =>
          cubit.archive(thread.id, archived: !thread.archived),
    );
  }
}
