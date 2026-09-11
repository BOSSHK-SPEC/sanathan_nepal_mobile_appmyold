import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/checkout_cubit.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import '../widgets/cart_summary_card.dart';
import '../widgets/checkout_address_form.dart';
import '../widgets/order_confirmed_card.dart';
import '../widgets/order_summary_rows.dart';
import '../widgets/payment_method_selector.dart';
import '../widgets/step_header.dart';

/// Checkout / "Delivery & Payment" (Figma 753:2274 light / 757:2462 dark).
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<CheckoutCubit>()..load(),
    child: const CheckoutView(),
  );
}

/// Widget-testable body of [CheckoutPage].
class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _form = CheckoutFormController();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _placeOrder(BuildContext context) {
    if (!_form.validate()) return;
    context.read<CheckoutCubit>().placeOrder(
      address: _form.toAddress(),
      notes: _form.notes.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;
    return Scaffold(
      appBar: AppTopBar(title: s.deliveryAndPayment, showBack: true),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        listenWhen: (a, b) => a.order != b.order,
        listener: (context, state) {
          if (state.order case Failed(:final failure)) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<CheckoutCubit>();
          if (state.order case Loaded(data: final order)) {
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                OrderConfirmedCard(order: order),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: s.viewOrder,
                  height: 40,
                  radius: AppRadius.sm,
                  onPressed: () => context.go(AppRoutes.marketplace),
                ),
                const SizedBox(height: AppSpacing.md),
                SecondaryButton(
                  label: s.backToMarketplace,
                  height: 40,
                  radius: AppRadius.sm,
                  onPressed: () => context.go(AppRoutes.marketplace),
                ),
              ],
            );
          }
          final cart = state.cart.dataOrNull;
          if (cart == null) {
            return switch (state.cart) {
              Failed(:final failure) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ => const LoadingView(),
            };
          }
          String price(num v) =>
              MarketplaceFormat.priceOf(context, v, decimals: true);
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.pageGutter,
              AppSpacing.md,
              AppSpacing.pageGutter,
              AppSpacing.xxl,
            ),
            children: [
              StepHeader(
                steps: [
                  StepItem(
                    label: s.shoppingCart,
                    icon: Icons.shopping_bag_outlined,
                  ),
                  StepItem(
                    label: s.checkout,
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                ],
                activeIndex: 1,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                onStepTap: (i) {
                  if (i == 0 && context.canPop()) context.pop();
                },
              ),
              const SizedBox(height: AppSpacing.md),
              CheckoutAddressForm(
                controller: _form,
                shipToDifferent: state.shipToDifferentAddress,
                onShipToDifferentChanged: cubit.toggleShipToDifferent,
              ),
              const SizedBox(height: AppSpacing.lg),
              PaymentMethodSelector(
                value: state.paymentMethod,
                onChanged: cubit.setPaymentMethod,
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: colors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SummaryRow(label: s.subtotal, value: price(cart.subtotal)),
                    SummaryRow(
                      label: s.shipping,
                      value: _form.city.text.isEmpty
                          ? _form.country
                          : '${_form.city.text}, ${_form.country}',
                    ),
                    SummaryRow(label: s.discount, value: price(cart.discount)),
                    SummaryRow(
                      label: s.shippingCosts,
                      value: price(cart.isEmpty ? 0 : cart.shippingCost),
                    ),
                    Divider(height: AppSpacing.lg, color: colors.divider),
                    InkWell(
                      onTap: () =>
                          cubit.toggleAddressConfirmed(!state.addressConfirmed),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              key: const Key('confirm_address'),
                              value: state.addressConfirmed,
                              visualDensity: VisualDensity.compact,
                              onChanged: (v) =>
                                  cubit.toggleAddressConfirmed(v ?? false),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: s.confirmAddress,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: colors.textSecondary,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(color: colors.error),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: AppSpacing.lg, color: colors.divider),
                    if (state.isSubmitting)
                      const LoadingView(height: 40)
                    else
                      TotalActionButton(
                        label: s.placeOrder,
                        total: price(cart.total),
                        onPressed: state.canPlaceOrder
                            ? () => _placeOrder(context)
                            : null,
                      ),
                    const SizedBox(height: AppSpacing.md),
                    SecurePaymentsFooter(label: s.securePaymentsBy),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
