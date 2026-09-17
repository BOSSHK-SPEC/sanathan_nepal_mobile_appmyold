import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../motion/motion.dart';
import '../../router/admin_routes.dart';

/// The console's primary navigation.
///
/// Rendered from the destinations the signed-in user actually holds, so the
/// rail is short for a moderator and long for a superAdmin. An item the user
/// cannot use is never drawn — a disabled entry only teaches people to click
/// things that fail.
class ConsoleNav extends StatelessWidget {
  const ConsoleNav({
    required this.destinations,
    required this.location,
    required this.onSelect,
    super.key,
    this.compact = false,
  });

  final List<ConsoleDestination> destinations;
  final String location;
  final ValueChanged<String> onSelect;

  /// Icons only, for the tablet width where a full rail would eat the table.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, destination) in destinations.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Reveal(
              delay: Motion.stagger(index),
              offset: 12,
              child: _NavItem(
                destination: destination,
                selected: location == destination.path,
                compact: compact,
                onTap: () => onSelect(destination.path),
              ),
            ),
          ),
      ],
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.destination,
    required this.selected,
    required this.compact,
    required this.onTap,
  });

  final ConsoleDestination destination;
  final bool selected;
  final bool compact;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final active = widget.selected;
    final animate = Motion.enabled(context);

    return Semantics(
      button: true,
      selected: active,
      label: widget.destination.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: Motion.fast,
            curve: Motion.settle,
            // Slides toward the content when hovered — the rail's own small
            // piece of depth, and a clearer affordance than a colour change
            // alone for anyone who does not perceive the colour.
            transform: Matrix4.identity()
              ..translateByDouble(
                animate && _hovering && !active ? 4 : 0,
                0,
                0,
                1,
              ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 12 : 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              gradient: active ? colors.primaryGradient : null,
              color: active
                  ? null
                  : (_hovering ? colors.surfaceVariant : Colors.transparent),
              borderRadius: BorderRadius.circular(12),
              boxShadow: active
                  ? [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.32),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                        spreadRadius: -6,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: widget.compact
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Icon(
                  widget.destination.icon,
                  size: 20,
                  color: active ? colors.onPrimary : colors.icon,
                ),
                if (!widget.compact) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.destination.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: active ? colors.onPrimary : colors.textPrimary,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
