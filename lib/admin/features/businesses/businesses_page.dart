import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/injection.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/status_chip.dart';
import '../../../features/profile/domain/entities/business_profile.dart';
import '../../../features/profile/presentation/cubit/admin_businesses_cubit.dart';
import '../../motion/motion.dart';
import '../../shell/widgets/console_page.dart';
import '../../shell/widgets/console_panel.dart';
import '../../shell/widgets/decision_dialog.dart';

/// Seller approvals.
///
/// Reuses the mobile app's [AdminBusinessesCubit] and its use cases outright
/// rather than growing a second copy in the console: the queue, the filters and
/// the decision call are the same product rule, and two implementations of one
/// rule is how the phone and the web start disagreeing about who is approved.
/// Only the presentation is new, which is exactly the layer that should differ
/// between a phone and a desk.
class BusinessesPage extends StatelessWidget {
  const BusinessesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AdminBusinessesCubit>()..load(),
      child: const _BusinessesView(),
    );
  }
}

class _BusinessesView extends StatelessWidget {
  const _BusinessesView();

  static const List<BusinessStatus?> _filters = [
    BusinessStatus.pending,
    BusinessStatus.approved,
    BusinessStatus.rejected,
    null,
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminBusinessesCubit>();

    return BlocBuilder<AdminBusinessesCubit, AdminBusinessesState>(
      builder: (context, state) {
        final visible = state.visible;

        return ConsolePage(
          title: 'Business approvals',
          subtitle:
              'A seller cannot list products until their business is approved',
          onRefresh: cubit.load,
          actions: [
            for (final filter in _filters)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: ChoiceChip(
                  selected: state.filter == filter,
                  onSelected: (_) => cubit.setFilter(filter),
                  label: Text(
                    '${_label(filter)} (${state.countFor(filter)})',
                  ),
                ),
              ),
          ],
          child: LoadStateView<List<BusinessProfile>>(
            state: state.businesses,
            onRetry: cubit.load,
            isEmpty: (_) => visible.isEmpty,
            emptyMessage: 'No ${_label(state.filter).toLowerCase()} businesses',
            emptyIcon: Icons.storefront_outlined,
            builder: (context, _) => Column(
              children: [
                for (final (index, business) in visible.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Reveal(
                      delay: Motion.stagger(index),
                      child: _BusinessCard(
                        business: business,
                        onDecide: (approve) =>
                            _decide(context, business, approve: approve),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  static String _label(BusinessStatus? status) => switch (status) {
    BusinessStatus.pending => 'Pending',
    BusinessStatus.approved => 'Approved',
    BusinessStatus.rejected => 'Rejected',
    null => 'All',
  };

  Future<void> _decide(
    BuildContext context,
    BusinessProfile business, {
    required bool approve,
  }) async {
    final cubit = context.read<AdminBusinessesCubit>();
    final decision = await showDecisionDialog(
      context,
      title: approve ? 'Approve business' : 'Reject business',
      subject: '${business.name} · ${business.category}',
      approve: approve,
    );
    if (decision == null) return;

    await cubit.moderate(
      business.id,
      decision.approve ? BusinessStatus.approved : BusinessStatus.rejected,
      note: decision.note,
    );
  }
}

class _BusinessCard extends StatelessWidget {
  const _BusinessCard({required this.business, required this.onDecide});

  final BusinessProfile business;
  final void Function(bool approve) onDecide;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final pending = business.status == BusinessStatus.pending;

    return ConsolePanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      business.name,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      business.category,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StatusChip(
                label: business.status.name,
                tone: switch (business.status) {
                  BusinessStatus.approved => StatusTone.success,
                  BusinessStatus.rejected => StatusTone.danger,
                  BusinessStatus.pending => StatusTone.warning,
                },
              ),
            ],
          ),
          if (business.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              business.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall?.copyWith(height: 1.45),
            ),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: [
              if (business.phone.isNotEmpty)
                _Detail(icon: Icons.call_rounded, value: business.phone),
              if (business.email.isNotEmpty)
                _Detail(icon: Icons.mail_outline_rounded, value: business.email),
              if (business.address.isNotEmpty)
                _Detail(
                  icon: Icons.location_on_outlined,
                  value: business.address,
                ),
              _Detail(
                icon: Icons.inventory_2_outlined,
                value: '${business.items.length} listings',
              ),
            ],
          ),
          if (business.moderationNote.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Note: ${business.moderationNote}',
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.textMuted,
              ),
            ),
          ],
          if (pending) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => onDecide(false),
                  style: TextButton.styleFrom(foregroundColor: colors.error),
                  child: const Text('Reject'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => onDecide(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.success,
                  ),
                  child: const Text('Approve'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: colors.iconMuted),
        const SizedBox(width: 6),
        Text(
          value,
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
