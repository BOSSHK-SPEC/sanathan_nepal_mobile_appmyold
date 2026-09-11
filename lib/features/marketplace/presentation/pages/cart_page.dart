import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/cart_cubit.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_summary_card.dart';
import '../widgets/step_header.dart';

/// Shopping Cart (Figma 753:2273 light / 757:2636 dark).
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<CartCubit>()..load(),
    child: const CartView(),
  );
}

/// Widget-testable body of [CartPage].
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _coupon = TextEditingController();

  @override
  void dispose() {
    _coupon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;
    return Scaffold(
      appBar: AppTopBar(title: s.shoppingCart, showBack: true),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
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
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.pageGutter,
              AppSpacing.md,
              AppSpacing.pageGutter,
              AppSpacing.xxl,
            ),
            children: [
              Row(
                children: [
                  Text(
                    s.shoppingCart,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 20,
                    color: colors.icon,
                  ),
                  const SizedBox(width: 2),
                  Container(
                    width: 16,
                    height: 16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      MarketplaceFormat.digits(context, cart.itemCount),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.onPrimary,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              StepHeader(
                steps: [
                  StepItem(
                    label: s.myShoppingCart,
                    icon: Icons.shopping_bag_outlined,
                  ),
                  StepItem(
                    label: s.checkout,
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                ],
                activeIndex: 0,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              ),
              const SizedBox(height: AppSpacing.sm),
              if (cart.isEmpty)
                EmptyView(
                  message: s.emptyCart,
                  icon: Icons.shopping_bag_outlined,
                )
              else
                for (final item in cart.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: CartItemTile(
                      item: item,
                      onIncrement: () => cubit.increment(item.product.id),
                      onDecrement: () => cubit.decrement(item.product.id),
                      onRemove: () => cubit.remove(item.product.id),
                    ),
                  ),
              const SizedBox(height: AppSpacing.md),
              CartSummaryCard(
                cart: cart,
                couponController: _coupon,
                couponInvalid: state.couponInvalid,
                onApplyCoupon: () {
                  cubit.couponChanged(_coupon.text);
                  cubit.applyCoupon();
                },
                onContinueShopping: () => context.canPop()
                    ? context.pop()
                    : context.go(AppRoutes.marketplace),
                onCheckout: cart.isEmpty
                    ? null
                    : () => context.push(AppRoutes.checkout),
              ),
            ],
          );
        },
      ),
    );
  }
}
