import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/business_profile.dart';
import '../cubit/admin_businesses_cubit.dart';
import '../l10n/profile_strings.dart';
import '../widgets/admin_business_tile.dart';
import '../widgets/seller_approval_dialog.dart';
import 'business_profile_page.dart';

/// Admin → "Business approvals" (`/admin/businesses`): Pending / Approved /
/// Rejected / All filter and the list of listings; tapping one opens the
/// [BusinessProfilePage] in admin mode, quick actions moderate in place.
class AdminBusinessesPage extends StatelessWidget {
  const AdminBusinessesPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<AdminBusinessesCubit>()..load(),
    child: const AdminBusinessesView(),
  );
}

/// Widget-testable body of [AdminBusinessesPage].
class AdminBusinessesView extends StatelessWidget {
  const AdminBusinessesView({super.key});

  static const List<BusinessStatus?> _filters = [
    BusinessStatus.pending,
    BusinessStatus.approved,
    BusinessStatus.rejected,
    null,
  ];

  String _label(ProfileStrings s, BusinessStatus? status) => switch (status) {
    BusinessStatus.pending => s.pending,
    BusinessStatus.approved => s.approved,
    BusinessStatus.rejected => s.rejected,
    null => s.all,
  };

  Future<void> _moderate(
    BuildContext context,
    BusinessProfile b, {
    required bool approve,
  }) async {
    final cubit = context.read<AdminBusinessesCubit>();
    final reason = await SellerApprovalDialog.show(context, approve: approve);
    if (reason == null) return;
    await cubit.moderate(
      b.id,
      approve ? BusinessStatus.approved : BusinessStatus.rejected,
      note: reason,
    );
  }

  Future<void> _open(BuildContext context, BusinessProfile b) async {
    final cubit = context.read<AdminBusinessesCubit>();
    await context.push(
      AppRoutes.businessProfilePath(b.id) + BusinessProfileMode.admin.query,
    );
    if (context.mounted) await cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.businessApprovals, showBack: true),
      body: BlocConsumer<AdminBusinessesCubit, AdminBusinessesState>(
        listenWhen: (p, n) => p.businesses != n.businesses,
        listener: (context, state) {
          if (state.businesses case Failed(:final failure, previous: != null)) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<AdminBusinessesCubit>();
          final loaded = state.businesses.dataOrNull;
          if (loaded == null) {
            return switch (state.businesses) {
              Failed(:final failure) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ => const LoadingView(),
            };
          }
          final visible = state.visible;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: PillTabs(
                  labels: [
                    for (final f in _filters)
                      '${_label(s, f)} '
                          '(${localizeDigits(context, '${state.countFor(f)}')})',
                  ],
                  selectedIndex: _filters.indexOf(state.filter),
                  scrollable: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  onChanged: (i) => cubit.setFilter(_filters[i]),
                ),
              ),
              Expanded(
                child: visible.isEmpty
                    ? EmptyView(message: s.noBusinesses)
                    : RefreshIndicator(
                        onRefresh: cubit.load,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.xxl,
                          ),
                          itemCount: visible.length,
                          itemBuilder: (context, i) => AdminBusinessTile(
                            business: visible[i],
                            onTap: () => _open(context, visible[i]),
                            onApprove: () =>
                                _moderate(context, visible[i], approve: true),
                            onReject: () =>
                                _moderate(context, visible[i], approve: false),
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
