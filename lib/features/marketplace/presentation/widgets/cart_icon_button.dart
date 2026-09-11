import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../cubit/cart_cubit.dart';
import '../utils/marketplace_format.dart';

/// Shopping-bag app-bar action with an item-count badge. Reads [CartCubit]
/// if one is available above it; otherwise shows no badge.
class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final cubit = context.watch<CartCubit?>();
    final count = cubit?.state.cart.dataOrNull?.itemCount ?? 0;
    return IconButton(
      tooltip: 'Cart',
      onPressed: () => context.push(AppRoutes.cart),
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(Icons.shopping_bag_outlined, color: colors.icon),
          Positioned(
            right: -6,
            bottom: -4,
            child: Container(
              width: 16,
              height: 16,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.accent,
                shape: BoxShape.circle,
              ),
              child: Text(
                MarketplaceFormat.digits(context, count),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.onPrimary,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
