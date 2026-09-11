import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/order_tracking.dart';
import '../cubit/order_tracking_cubit.dart';
import '../l10n/order_strings.dart';

/// Pick the items, give a reason, send it back.
class ReturnRequestPage extends StatelessWidget {
  const ReturnRequestPage({required this.orderId, super.key});

  final String orderId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<OrderTrackingCubit>(param1: orderId)..load(),
    child: const _ReturnRequestView(),
  );
}

class _ReturnRequestView extends StatefulWidget {
  const _ReturnRequestView();

  @override
  State<_ReturnRequestView> createState() => _ReturnRequestViewState();
}

class _ReturnRequestViewState extends State<_ReturnRequestView> {
  final TextEditingController _details = TextEditingController();

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = OrderStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<OrderTrackingCubit, OrderTrackingState>(
      listenWhen: (p, n) => p.returning != n.returning,
      listener: (context, state) {
        if (state.returning.isLoaded) {
          AppSnack.success(context, s.returnSubmitted);
          if (context.canPop()) {
            context.pop(true);
          } else {
            context.go(AppRoutes.myOrders);
          }
        } else if (state.returning.isFailed) {
          AppSnack.error(
            context,
            state.returning.errorMessage ?? context.l10n.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<OrderTrackingCubit>();
        final order = state.tracked;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.returnTitle, showBack: true),
          body: SafeArea(
            child: order == null
                ? const LoadingView()
                : ListView(
                    padding: const EdgeInsets.all(AppSpacing.pageGutter),
                    children: [
                      Text(s.selectItems, style: context.textTheme.titleSmall),
                      const SizedBox(height: AppSpacing.sm),
                      for (final item in order.items)
                        AppCard(
                          elevated: false,
                          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                          onTap: () => cubit.toggleItem(item.productId),
                          border: Border.all(
                            color: state.selectedItems.contains(item.productId)
                                ? colors.accent
                                : colors.border,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                state.selectedItems.contains(item.productId)
                                    ? Icons.check_box_rounded
                                    : Icons.check_box_outline_blank_rounded,
                                size: 20,
                                color:
                                    state.selectedItems.contains(item.productId)
                                    ? colors.accent
                                    : colors.iconMuted,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Text(
                                  '${item.quantity} × ${item.name}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ),
                              MoneyText(
                                item.lineTotal,
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(s.returnReason, style: context.textTheme.titleSmall),
                      const SizedBox(height: AppSpacing.sm),
                      for (final reason in ReturnReason.values)
                        AppRadioOption<ReturnReason?>(
                          value: reason,
                          groupValue: state.reason,
                          label: s.reasonName(reason),
                          onChanged: (v) =>
                              v == null ? null : cubit.selectReason(v),
                        ),
                      const SizedBox(height: AppSpacing.lg),
                      AppTextField(
                        controller: _details,
                        label: s.returnDetails,
                        hint: s.returnDetailsHint,
                        required: state.reason == ReturnReason.other,
                        maxLines: 5,
                        minLines: 3,
                        onChanged: cubit.setDetails,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      PrimaryButton(
                        label: s.submitReturn,
                        height: 46,
                        isLoading: state.returning.isLoading,
                        onPressed: state.canSubmitReturn
                            ? cubit.submitReturn
                            : null,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SecondaryButton(
                        label: s.cancel,
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
