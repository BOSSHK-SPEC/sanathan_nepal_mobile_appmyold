import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/product.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/product_details_cubit.dart';
import '../l10n/marketplace_strings.dart';
import '../widgets/product_details_body.dart';
import '../widgets/product_details_action_bar.dart';

/// Product / service details (Figma 475:894 light, 1873:2931 dark).
///
/// Route: `/marketplace/product/:id` – pushed from marketplace cards, the
/// listing page, boosted cards, similar products and profile favourites.
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<ProductDetailsCubit>()..load(productId)),
      BlocProvider(create: (_) => sl<CartCubit>()..load()),
    ],
    child: const ProductDetailsView(),
  );
}

/// Widget-testable body of [ProductDetailsPage] (cubits must be provided).
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    return MultiBlocListener(
      listeners: [
        // A failed favourite toggle keeps the product visible – just notify.
        BlocListener<ProductDetailsCubit, ProductDetailsState>(
          listenWhen: (a, b) => a.product != b.product,
          listener: (context, state) {
            if (state.product case Failed(:final failure, previous: != null)) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            }
          },
        ),
        BlocListener<ProductDetailsCubit, ProductDetailsState>(
          listenWhen: (a, b) => a.addToCart != b.addToCart,
          listener: (context, state) {
            final messenger = ScaffoldMessenger.of(context);
            switch (state.addToCart) {
              case Loaded():
                context.read<CartCubit>().load();
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(s.addedToCart)));
                if (state.buyNow) context.push(AppRoutes.checkout);
              case Failed(:final failure):
                messenger.showSnackBar(
                  SnackBar(content: Text(failure.message)),
                );
              case Idle() || Loading():
                break;
            }
          },
        ),
      ],
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final product = state.product.dataOrNull;
          if (product == null) {
            return _StatusScaffold(state: state);
          }
          return Scaffold(
            body: ProductDetailsBody(
              product: product,
              state: state,
              onShare: () => _share(context, product),
              onEdit: product.isMine ? () => _edit(context, product) : null,
              onBuyNow: () =>
                  context.read<ProductDetailsCubit>().addToCart(buyNow: true),
            ),
            bottomNavigationBar: ProductDetailsActionBar(
              product: product,
              onEdit: product.isMine ? () => _edit(context, product) : null,
            ),
          );
        },
      ),
    );
  }

  Future<void> _share(BuildContext context, Product product) async {
    final s = MarketplaceStrings.of(context);
    await Clipboard.setData(
      ClipboardData(text: AppRoutes.productDetailsPath(product.id)),
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(s.linkCopied)));
  }

  Future<void> _edit(BuildContext context, Product product) async {
    final cubit = context.read<ProductDetailsCubit>();
    final result = await context.push<Object?>(
      AppRoutes.productEditPath(product.id),
    );
    if (result == true) {
      // Deleted – leave the details page.
      if (context.mounted && context.canPop()) context.pop();
      return;
    }
    if (result != null) await cubit.load(product.id);
  }
}

/// Loading / not-found / error chrome shown while there is no product yet.
class _StatusScaffold extends StatelessWidget {
  const _StatusScaffold({required this.state});
  final ProductDetailsState state;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    return Scaffold(
      appBar: AppTopBar(title: s.productDetails, showBack: true),
      body: switch (state.product) {
        Idle() || Loading() => const LoadingView(),
        Failed(failure: NotFoundFailure()) => _NotFound(
          message: s.productNotFound,
        ),
        Failed(:final failure) => ErrorView(message: failure.message),
        Loaded() => const ErrorView(),
      },
    );
  }
}

class _NotFound extends StatelessWidget {
  const _NotFound({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    return Center(
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmptyView(message: message, icon: Icons.search_off_rounded),
            const SizedBox(height: AppSpacing.lg),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: PrimaryButton(
                label: s.backToMarketplace,
                expanded: false,
                height: 40,
                onPressed: () => context.canPop()
                    ? context.pop()
                    : context.go(AppRoutes.marketplace),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
