import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Drives the shimmer sweep for every [AppSkeleton] beneath it.
///
/// One controller per loading screen rather than one per placeholder, so a
/// list of 20 skeletons costs a single ticker. Wrap the whole placeholder
/// layout:
///
/// ```dart
/// AppShimmer(
///   child: Column(children: [AppSkeleton.text(width: 120), ...]),
/// )
/// ```
///
/// The sweep is suppressed when the platform asks for reduced motion.
class AppShimmer extends StatefulWidget {
  const AppShimmer({required this.child, super.key, this.enabled = true});

  final Widget child;
  final bool enabled;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void initState() {
    super.initState();
    if (widget.enabled) _controller.repeat();
  }

  @override
  void didUpdateWidget(AppShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.enabled && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (!widget.enabled || reduceMotion) return widget.child;

    final colors = context.colors;
    final highlight = context.isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.white.withValues(alpha: 0.7);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [colors.shimmer, highlight, colors.shimmer],
            stops: [
              (t - 0.3).clamp(0.0, 1.0),
              t.clamp(0.0, 1.0),
              (t + 0.3).clamp(0.0, 1.0),
            ],
          ).createShader(bounds),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// A single grey placeholder block. Static on its own — put it under an
/// [AppShimmer] to animate.
class AppSkeleton extends StatelessWidget {
  const AppSkeleton({
    super.key,
    this.width,
    this.height = 14,
    this.radius = AppRadius.sm,
    this.margin,
  });

  /// Text-line placeholder: slightly rounded, body-line height.
  const AppSkeleton.text({
    super.key,
    this.width,
    this.height = 12,
    this.radius = AppRadius.xs,
    this.margin,
  });

  /// Square/rectangular block for images and cards.
  const AppSkeleton.block({
    super.key,
    this.width = double.infinity,
    this.height = 120,
    this.radius = AppRadius.lg,
    this.margin,
  });

  final double? width;
  final double height;
  final double radius;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    margin: margin,
    decoration: BoxDecoration(
      color: context.colors.shimmer,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

/// Circular placeholder for avatars.
class AppSkeletonCircle extends StatelessWidget {
  const AppSkeletonCircle({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: context.colors.shimmer,
      shape: BoxShape.circle,
    ),
  );
}

/// Repeats a placeholder row [count] times — the common list-loading shape.
class AppSkeletonList extends StatelessWidget {
  const AppSkeletonList({
    required this.itemBuilder,
    super.key,
    this.count = 6,
    this.separator = AppSpacing.md,
    this.padding = const EdgeInsets.all(AppSpacing.pageGutter),
  });

  /// Convenience: avatar + two text lines, the shape most lists use.
  const AppSkeletonList.tiles({
    super.key,
    this.count = 6,
    this.separator = AppSpacing.md,
    this.padding = const EdgeInsets.all(AppSpacing.pageGutter),
  }) : itemBuilder = null;

  final Widget Function(BuildContext context, int index)? itemBuilder;
  final int count;
  final double separator;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => AppShimmer(
    child: ListView.separated(
      padding: padding,
      itemCount: count,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, _) => SizedBox(height: separator),
      itemBuilder: itemBuilder ?? (_, _) => const _SkeletonTile(),
    ),
  );
}

class _SkeletonTile extends StatelessWidget {
  const _SkeletonTile();

  @override
  Widget build(BuildContext context) => const Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppSkeletonCircle(size: 48),
      SizedBox(width: AppSpacing.md),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSkeleton.text(width: 140, height: 14),
            SizedBox(height: AppSpacing.sm),
            AppSkeleton.text(width: double.infinity),
            SizedBox(height: AppSpacing.xs + 2),
            AppSkeleton.text(width: 90),
          ],
        ),
      ),
    ],
  );
}
