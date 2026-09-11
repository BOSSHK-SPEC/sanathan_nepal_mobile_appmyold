import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import 'app_image.dart';

/// Circular profile image with initials fallback, plus the two badges the
/// marketplace needs everywhere: an online dot and a verified tick.
///
/// Falls back through image → initials → person icon, so a missing avatar
/// never renders as a broken box.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.source,
    this.name,
    this.size = 44,
    this.online,
    this.verified = false,
    this.onTap,
    this.borderColor,
    this.borderWidth = 2,
  });

  /// Asset path or network URL.
  final String? source;

  /// Used for the initials fallback.
  final String? name;
  final double size;

  /// `null` hides the presence dot entirely; `true`/`false` show it.
  final bool? online;
  final bool verified;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderWidth;

  String get _initials {
    final parts = (name ?? '')
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts[1].characters.first)
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final badgeSize = (size * 0.28).clamp(10.0, 18.0);

    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: source == null ? colors.primaryGradient : null,
        color: source == null ? null : colors.surfaceVariant,
        border: borderColor == null
            ? null
            : Border.all(color: borderColor!, width: borderWidth),
      ),
      clipBehavior: Clip.antiAlias,
      child: source != null
          ? AppImage(source!, width: size, height: size)
          : Center(
              child: _initials.isEmpty
                  ? Icon(
                      Icons.person_rounded,
                      size: size * 0.55,
                      color: colors.onPrimary,
                    )
                  : Text(
                      _initials,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: colors.onPrimary,
                        fontSize: size * 0.36,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
            ),
    );

    if (online != null || verified) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          if (online != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: badgeSize,
                height: badgeSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: online! ? colors.success : colors.textMuted,
                  border: Border.all(color: colors.surface, width: 2),
                ),
              ),
            ),
          if (verified)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.surface,
                ),
                child: Icon(
                  Icons.verified_rounded,
                  size: badgeSize,
                  color: colors.info,
                ),
              ),
            ),
        ],
      );
    }

    if (onTap == null) return avatar;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: avatar,
    );
  }
}

/// Overlapping avatar row ("+3" overflow) for group contexts such as
/// "12 people consulted today".
class AppAvatarStack extends StatelessWidget {
  const AppAvatarStack({
    required this.sources,
    super.key,
    this.size = 28,
    this.maxVisible = 3,
    this.overlap = 0.35,
  });

  final List<String?> sources;
  final double size;
  final int maxVisible;
  final double overlap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visible = sources.take(maxVisible).toList();
    final extra = sources.length - visible.length;
    final step = size * (1 - overlap);

    return SizedBox(
      height: size,
      width: visible.isEmpty
          ? 0
          : step * (visible.length + (extra > 0 ? 1 : 0)) + size * overlap,
      child: Stack(
        children: [
          for (var i = 0; i < visible.length; i++)
            Positioned(
              left: i * step,
              child: AppAvatar(
                source: visible[i],
                size: size,
                borderColor: colors.surface,
              ),
            ),
          if (extra > 0)
            Positioned(
              left: visible.length * step,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.surfaceVariant,
                  border: Border.all(color: colors.surface, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+$extra',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
