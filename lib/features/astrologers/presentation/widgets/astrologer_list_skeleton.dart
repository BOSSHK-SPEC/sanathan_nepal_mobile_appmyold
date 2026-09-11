import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';

/// Placeholder that mirrors [AstrologerCard]'s real layout, so the list does
/// not jump when data arrives.
class AstrologerListSkeleton extends StatelessWidget {
  const AstrologerListSkeleton({super.key, this.count = 5});

  final int count;

  @override
  Widget build(BuildContext context) => AppShimmer(
    child: ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.sm,
        AppSpacing.pageGutter,
        AppSpacing.xxxl,
      ),
      itemCount: count,
      itemBuilder: (_, _) => Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSkeletonCircle(size: 58),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSkeleton.text(width: 150, height: 15),
                      SizedBox(height: AppSpacing.sm),
                      AppSkeleton.text(width: double.infinity),
                      SizedBox(height: AppSpacing.sm),
                      AppSkeleton.text(width: 110),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),
            AppSkeleton(height: 22, radius: AppRadius.pill),
            SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(child: AppSkeleton.text(width: 80, height: 20)),
                AppSkeleton(width: 96, height: 34, radius: AppRadius.pill),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
