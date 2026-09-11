import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extensions/context_extensions.dart';

/// Standard centred-title app bar (Figma "गृहपृष्ठ" header style).
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    required this.title,
    super.key,
    this.actions,
    this.showBack = false,
    this.onBack,
    this.bottom,
    this.leading,
    this.backgroundColor,
    this.centerTitle = true,
  });

  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBack;
  final PreferredSizeWidget? bottom;
  final Widget? leading;
  final Color? backgroundColor;
  final bool centerTitle;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      leading:
          leading ??
          (showBack
              ? IconButton(
                  icon: Icon(Icons.arrow_back, color: colors.icon),
                  onPressed:
                      onBack ??
                      () => context.canPop()
                          ? context.pop()
                          : context.go('/home'),
                )
              : null),
      actions: actions,
      bottom:
          bottom ??
          PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(height: 1, color: colors.divider),
          ),
    );
  }
}
