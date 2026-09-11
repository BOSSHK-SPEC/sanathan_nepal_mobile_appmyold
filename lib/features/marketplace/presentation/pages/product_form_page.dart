import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/product_draft.dart';
import '../cubit/product_form_cubit.dart';
import '../l10n/marketplace_strings.dart';
import '../widgets/marketplace_dialogs.dart';
import '../widgets/product_form_fields.dart';

/// Seller "Add Product" (`/marketplace/product/new`) and "Edit Product"
/// (`/marketplace/product/:id/edit`) form.
class ProductFormPage extends StatelessWidget {
  const ProductFormPage({super.key, this.productId});

  /// Listing to edit; `null` creates a new one.
  final String? productId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<ProductFormCubit>()..init(productId: productId),
    child: const ProductFormView(),
  );
}

/// Widget-testable body of [ProductFormPage] (cubit must be provided).
class ProductFormView extends StatefulWidget {
  const ProductFormView({super.key});

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _title = TextEditingController();
  final _titleLocal = TextEditingController();
  final _description = TextEditingController();
  final _descriptionLocal = TextEditingController();
  final _price = TextEditingController();
  final _location = TextEditingController();
  final _phone = TextEditingController();
  final _website = TextEditingController();

  static const List<int> _expiryChoices = [7, 15, 30, 60, 90];
  bool _synced = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // `init()` emits the region defaults synchronously before this view
    // subscribes, so copy them once here; later loads go through the listener.
    if (!_synced) {
      _synced = true;
      _sync(context.read<ProductFormCubit>().state.draft);
    }
  }

  @override
  void dispose() {
    for (final c in [
      _title,
      _titleLocal,
      _description,
      _descriptionLocal,
      _price,
      _location,
      _phone,
      _website,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Copies the cubit draft into the text controllers (initial load / edit).
  void _sync(ProductDraft d) {
    _title.text = d.title;
    _titleLocal.text = d.titleLocal;
    _description.text = d.description;
    _descriptionLocal.text = d.descriptionLocal;
    _price.text = d.price > 0 ? _plain(d.price) : '';
    _location.text = d.location;
    _phone.text = d.phone;
    _website.text = d.websiteLink ?? '';
  }

  static String _plain(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();

  void _finish(BuildContext context, String message, {Object? result}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
    final router = GoRouter.maybeOf(context);
    if (router == null) {
      Navigator.of(context).maybePop(result);
    } else if (router.canPop()) {
      router.pop(result);
    } else {
      router.go(AppRoutes.marketplace);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    return MultiBlocListener(
      listeners: [
        // Pre-fill controllers once (create defaults / edited product).
        BlocListener<ProductFormCubit, ProductFormState>(
          listenWhen: (a, b) => a.initial != b.initial,
          listener: (context, state) => _sync(state.draft),
        ),
        BlocListener<ProductFormCubit, ProductFormState>(
          listenWhen: (a, b) => a.submission != b.submission,
          listener: (context, state) {
            switch (state.submission) {
              case Loaded(:final data):
                _finish(
                  context,
                  state.isEdit ? s.productUpdated : s.productSaved,
                  result: data,
                );
              case Failed(:final failure):
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(failure.message)));
              case Idle() || Loading():
                break;
            }
          },
        ),
        BlocListener<ProductFormCubit, ProductFormState>(
          listenWhen: (a, b) => a.deletion != b.deletion,
          listener: (context, state) {
            switch (state.deletion) {
              case Loaded():
                _finish(context, s.productDeleted, result: true);
              case Failed(:final failure):
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(failure.message)));
              case Idle() || Loading():
                break;
            }
          },
        ),
      ],
      child: BlocBuilder<ProductFormCubit, ProductFormState>(
        builder: (context, state) => Scaffold(
          appBar: AppTopBar(
            title: state.isEdit ? s.editProduct : s.addProduct,
            showBack: true,
            actions: [
              if (state.isEdit)
                IconButton(
                  tooltip: s.delete,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: context.colors.error,
                  ),
                  onPressed: state.isBusy ? null : () => _delete(context),
                ),
            ],
          ),
          body: switch (state.initial) {
            Loading() => const LoadingView(),
            Failed(:final failure, previous: null) => ErrorView(
              message: failure.message,
              onRetry: () => context.read<ProductFormCubit>().init(
                productId: state.productId,
              ),
            ),
            _ => ProductFormFields(
              state: state,
              title: _title,
              titleLocal: _titleLocal,
              description: _description,
              descriptionLocal: _descriptionLocal,
              price: _price,
              location: _location,
              phone: _phone,
              website: _website,
              expiryChoices: _expiryChoices,
            ),
          },
        ),
      ),
    );
  }

  Future<void> _delete(BuildContext context) async {
    final cubit = context.read<ProductFormCubit>();
    if (await showDeleteProductDialog(context)) await cubit.delete();
  }
}
