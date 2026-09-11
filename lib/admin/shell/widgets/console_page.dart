import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../../core/state/load_state.dart';
import '../../../core/widgets/state_widgets.dart';
import '../../motion/motion.dart';

/// The frame every console section shares: title, subtitle, actions, body.
///
/// Having one of these rather than a bespoke header per page is what keeps
/// seven screens feeling like one product — and it means the refresh affordance
/// and the error surface are in the same place on all of them.
class ConsolePage extends StatelessWidget {
  const ConsolePage({
    required this.title,
    required this.subtitle,
    required this.child,
    super.key,
    this.actions = const [],
    this.onRefresh,
    this.banner,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final List<Widget> actions;
  final Future<void> Function()? onRefresh;

  /// An action-level error, shown above the content. Distinct from a failed
  /// body: the list on screen is still valid, one operation was refused.
  final String? banner;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 48),
      children: [
        Reveal(
          offset: 14,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ...actions,
                  if (onRefresh != null)
                    IconButton(
                      tooltip: 'Refresh',
                      onPressed: onRefresh,
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                ],
              ),
            ],
          ),
        ),
        if (banner != null) ...[
          const SizedBox(height: 16),
          _ActionBanner(message: banner!),
        ],
        const SizedBox(height: 24),
        child,
      ],
    );
  }
}

class _ActionBanner extends StatelessWidget {
  const _ActionBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.error.withValues(alpha: 0.10),
        border: Border.all(color: colors.error.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, size: 18, color: colors.error),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: context.textTheme.bodySmall?.copyWith(color: colors.error),
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders one [LoadState] with the console's own empty and error surfaces.
///
/// The `Loading` branch keeps stale data on screen when there is some — a
/// reviewer refreshing a queue should see it dim, not vanish and come back.
class LoadStateView<T> extends StatelessWidget {
  const LoadStateView({
    required this.state,
    required this.builder,
    required this.onRetry,
    super.key,
    this.isEmpty,
    this.emptyMessage = 'Nothing here right now',
    this.emptyIcon = Icons.inbox_outlined,
  });

  final LoadState<T> state;
  final Widget Function(BuildContext context, T data) builder;
  final VoidCallback onRetry;

  /// Whether loaded data should count as empty. Without it a page cannot tell
  /// an empty list from a loaded one.
  final bool Function(T data)? isEmpty;
  final String emptyMessage;
  final IconData emptyIcon;

  @override
  Widget build(BuildContext context) {
    final data = state.dataOrNull;

    return switch (state) {
      Idle<T>() => const LoadingView(height: 260),
      Loading<T>() when data == null => const LoadingView(height: 260),
      Loading<T>() => Opacity(opacity: 0.55, child: builder(context, data as T)),
      Failed<T>(:final failure) when data == null => ErrorView(
        message: failure.message,
        onRetry: onRetry,
      ),
      Failed<T>() => builder(context, data as T),
      Loaded<T>(:final data) =>
        (isEmpty?.call(data) ?? false)
            ? EmptyView(message: emptyMessage, icon: emptyIcon)
            : builder(context, data),
    };
  }
}
