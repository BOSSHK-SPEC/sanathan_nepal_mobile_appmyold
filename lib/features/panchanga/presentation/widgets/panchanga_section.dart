import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/section_chevron_button.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/panchanga_cubit.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_table.dart';

/// Home-page "पञ्चाङ्ग" block: section header + today's [PanchangaTable].
///
/// Provides its own [PanchangaCubit] from GetIt unless [cubit] is passed
/// (pass the same cubit to [SuvaSaitSection] to share one load).
class PanchangaSection extends StatelessWidget {
  const PanchangaSection({
    super.key,
    this.cubit,
    this.showHeader = true,
    this.onSeeAll,
    this.padding = AppSpacing.page,
  });

  final PanchangaCubit? cubit;
  final bool showHeader;

  /// Defaults to `context.push(AppRoutes.panchanga)`.
  final VoidCallback? onSeeAll;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final body = _Body(
      showHeader: showHeader,
      onSeeAll: onSeeAll,
      padding: padding,
    );
    if (cubit != null) return BlocProvider.value(value: cubit!, child: body);
    return BlocProvider(
      create: (_) => sl<PanchangaCubit>()..load(),
      child: body,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.showHeader,
    required this.onSeeAll,
    required this.padding,
  });
  final bool showHeader;
  final VoidCallback? onSeeAll;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final s = PanchangaStrings.of(context);
    return BlocBuilder<PanchangaCubit, PanchangaState>(
      builder: (context, state) {
        final cubit = context.read<PanchangaCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHeader)
              SectionHeader(
                title: s.panchanga,
                padding: EdgeInsets.symmetric(
                  horizontal: padding.left,
                  vertical: AppSpacing.sm,
                ),
                trailing: SectionChevronButton(
                  onPressed:
                      onSeeAll ?? () => context.push(AppRoutes.panchanga),
                ),
              ),
            Padding(
              padding: padding,
              child: switch (state.panchanga) {
                Failed(:final failure) => ErrorView(
                  message: failure.message,
                  onRetry: cubit.load,
                ),
                Loaded(:final data) => PanchangaTable(panchanga: data),
                Loading(previous: final data?) => PanchangaTable(
                  panchanga: data,
                ),
                _ => const LoadingView(height: 200),
              },
            ),
          ],
        );
      },
    );
  }
}
