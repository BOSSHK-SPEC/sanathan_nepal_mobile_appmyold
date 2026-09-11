import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/message_thread_cubit.dart';
import '../l10n/messaging_strings.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_composer.dart';

/// One conversation.
///
/// Reached either from the inbox with a [threadId], or from a business page
/// with a [businessId] — in which case nothing is created until the first
/// message is actually sent, so opening the screen and backing out does not
/// leave an empty conversation in a shop's inbox.
class MessageThreadPage extends StatelessWidget {
  const MessageThreadPage({super.key, this.threadId, this.businessId});

  final String? threadId;
  final String? businessId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        sl<MessageThreadCubit>(param1: threadId, param2: businessId)..load(),
    child: const MessageThreadView(),
  );
}

/// Widget-testable body of [MessageThreadPage].
class MessageThreadView extends StatefulWidget {
  const MessageThreadView({super.key});

  @override
  State<MessageThreadView> createState() => _MessageThreadViewState();
}

class _MessageThreadViewState extends State<MessageThreadView> {
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    // After the frame, so the new bubble is laid out before we scroll to it.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = MessagingStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<MessageThreadCubit, MessageThreadState>(
      listenWhen: (p, n) =>
          p.chat.length != n.chat.length || p.sendFailure != n.sendFailure,
      listener: (context, state) {
        _scrollToEnd();
        final failure = state.sendFailure;
        if (failure != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(failure.message)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<MessageThreadCubit>();
        final thread = state.thread.dataOrNull;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(
            backgroundColor: colors.surface,
            titleSpacing: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colors.icon),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            title: thread == null
                ? Text(s.messages, style: context.textTheme.titleMedium)
                : Row(
                    children: [
                      AppAvatar(
                        source: thread.isOwnerSide
                            ? null
                            : thread.businessLogoUrl,
                        name: thread.counterpartName,
                        size: 34,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              thread.counterpartName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.titleMedium,
                            ),
                            if (thread.subject.isNotEmpty)
                              Text(
                                thread.subject,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
            actions: [
              // The shop behind the conversation is one tap away, so a
              // customer can check prices without losing their place.
              if (thread != null && !thread.isOwnerSide)
                IconButton(
                  tooltip: thread.businessName,
                  icon: Icon(Icons.storefront_outlined, color: colors.icon),
                  onPressed: () => context.push(
                    AppRoutes.businessProfilePath(thread.businessId),
                  ),
                ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: _Transcript(state: state, scroll: _scroll),
                ),
                MessageComposer(
                  controller: _input,
                  canSend: state.canSend,
                  sending: state.isSending,
                  onChanged: cubit.setDraft,
                  onSend: () {
                    cubit.send();
                    _input.clear();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Transcript extends StatelessWidget {
  const _Transcript({required this.state, required this.scroll});

  final MessageThreadState state;
  final ScrollController scroll;

  @override
  Widget build(BuildContext context) {
    final s = MessagingStrings.of(context);
    final cubit = context.read<MessageThreadCubit>();

    if (state.messages.isLoading && state.chat.isEmpty) {
      return const LoadingView();
    }
    if (state.messages case Failed(:final failure) when state.chat.isEmpty) {
      return ErrorView(message: failure.message, onRetry: cubit.load);
    }
    if (state.isEmpty) {
      return EmptyViewWithBody(
        title: s.startConversation,
        body: s.startConversationBody,
        icon: Icons.forum_outlined,
      );
    }

    return ListView.builder(
      controller: scroll,
      padding: const EdgeInsets.all(AppSpacing.pageGutter),
      itemCount: state.chat.length,
      itemBuilder: (context, i) => MessageBubble(
        message: state.chat[i],
        viewer: state.mySide,
        onRetry: cubit.retry,
      ),
    );
  }
}
