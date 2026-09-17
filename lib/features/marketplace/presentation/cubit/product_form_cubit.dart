import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region_all.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/utils/web_url.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_draft.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/update_product.dart';
import '../../../../core/state/app_cubit.dart';

part 'product_form_cubit.freezed.dart';
part 'product_form_state.dart';

/// Seller "Add / Edit Product" form: holds the [ProductDraft], validates it
/// and runs create / update / delete.
class ProductFormCubit extends AppCubit<ProductFormState> {
  ProductFormCubit({
    required CreateProduct createProduct,
    required UpdateProduct updateProduct,
    required DeleteProduct deleteProduct,
    required GetProductById getProductById,
    required GetCategories getCategories,
    required RegionResolver resolver,
    DateTime Function()? clock,
  }) : _createProduct = createProduct,
       _updateProduct = updateProduct,
       _deleteProduct = deleteProduct,
       _getProductById = getProductById,
       _getCategories = getCategories,
       _resolver = resolver,
       _clock = clock ?? DateTime.now,
       super(const ProductFormState());

  final CreateProduct _createProduct;
  final UpdateProduct _updateProduct;
  final DeleteProduct _deleteProduct;
  final GetProductById _getProductById;
  final GetCategories _getCategories;
  final RegionResolver _resolver;
  final DateTime Function() _clock;

  /// Maximum number of photos a listing can carry.
  static const int maxImages = 6;

  /// Loads categories and – when [productId] is given – the listing to edit.
  /// A new draft is pre-filled with the region's default city and phone
  /// prefix.
  Future<void> init({String? productId}) async {
    final config = _resolver.config;
    emit(
      state.copyWith(
        productId: productId,
        categories: state.categories.toLoading(),
        initial: productId == null
            ? const LoadState.idle()
            : state.initial.toLoading(),
        draft: ProductDraft(
          location: config.defaultCity.nameEn,
          locationLocal: _resolver.region == Region.india
              ? config.defaultCity.nameHi
              : config.defaultCity.nameNe,
          phone: '${config.phonePrefix}-',
        ),
      ),
    );
    final categories = await _getCategories();
    emit(
      state.copyWith(
        categories: categories.fold(
          state.categories.toFailed,
          LoadState.loaded,
        ),
      ),
    );
    if (productId == null) return;
    final product = await _getProductById(productId);
    emit(
      product.fold(
        (f) => state.copyWith(initial: state.initial.toFailed(f)),
        (p) => state.copyWith(
          initial: LoadState.loaded(p),
          draft: ProductDraft.fromProduct(p, now: _clock()),
        ),
      ),
    );
  }

  /// Applies a change to the draft; re-validates once a submit was attempted.
  void patch(ProductDraft Function(ProductDraft draft) change) {
    final draft = change(state.draft);
    emit(
      state.copyWith(
        draft: draft,
        errors: state.submitted ? validate(draft) : state.errors,
      ),
    );
  }

  /// Adds a placeholder photo (the demo has no image picker); the source
  /// uses the `category:` scheme rendered by `ProductPhoto`.
  /// Adds a photo the seller has already uploaded.
  ///
  /// Takes the stored reference rather than picking one itself: the cubit
  /// must stay free of Flutter, and a form that could not be tested without a
  /// camera would not be tested.
  void addImage(String reference) {
    if (state.draft.images.length >= maxImages || reference.isEmpty) return;
    if (state.draft.images.contains(reference)) return;
    patch((d) => d.copyWith(images: [...d.images, reference]));
  }

  /// Clears every photo at once.
  ///
  /// Separate from [removeImage] rather than a loop at the call site: removing
  /// six images one at a time emits six states, and the form rebuilds — and
  /// re-validates — on each.
  void clearImages() {
    if (state.draft.images.isEmpty) return;
    patch((d) => d.copyWith(images: const []));
  }

  void removeImage(int index) => patch(
    (d) => d.copyWith(
      images: [
        for (var i = 0; i < d.images.length; i++)
          if (i != index) d.images[i],
      ],
    ),
  );

  /// Display-only rename from the "Product Category edit" popup.
  void renameCategory(String id, String name) {
    if (name.trim().isEmpty) return;
    emit(
      state.copyWith(categoryNames: {...state.categoryNames, id: name.trim()}),
    );
  }

  /// Validates and creates / updates the listing.
  Future<void> submit() async {
    final errors = validate(state.draft);
    emit(state.copyWith(submitted: true, errors: errors));
    if (errors.isNotEmpty || state.isBusy) return;
    emit(state.copyWith(submission: state.submission.toLoading()));
    final id = state.productId;
    final result = id == null
        ? await _createProduct(state.draft)
        : await _updateProduct(UpdateProductParams(id: id, draft: state.draft));
    emit(
      state.copyWith(
        submission: result.fold(state.submission.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Deletes the listing being edited.
  Future<void> delete() async {
    final id = state.productId;
    if (id == null || state.isBusy) return;
    emit(state.copyWith(deletion: state.deletion.toLoading()));
    final result = await _deleteProduct(id);
    emit(
      state.copyWith(
        deletion: result.fold(
          state.deletion.toFailed,
          (_) => const LoadState.loaded(true),
        ),
      ),
    );
  }

  /// Pure validation – exposed for tests.
  static Map<ProductFormField, ProductFormError> validate(ProductDraft d) {
    final errors = <ProductFormField, ProductFormError>{};
    if (d.title.trim().isEmpty) {
      errors[ProductFormField.title] = ProductFormError.required;
    }
    if (d.categoryId.isEmpty || d.categoryId == Category.all.id) {
      errors[ProductFormField.category] = ProductFormError.invalidCategory;
    }
    if (d.description.trim().isEmpty) {
      errors[ProductFormField.description] = ProductFormError.required;
    }
    // Required by the API. Validating here turns "publish failed" after a
    // full form into an inline error on the field that is actually wrong.
    //
    // Photos are deliberately NOT in this list: a listing with no image
    // renders a themed category placeholder, and the server accepts an empty
    // `imageKeys`. Blocking publish on a photo stopped sellers drafting from a
    // phone with nothing to hand — and a listing nobody can save is worth less
    // than one without a picture.
    if (d.location.trim().isEmpty) {
      errors[ProductFormField.location] = ProductFormError.required;
    }
    if (d.price <= 0) {
      errors[ProductFormField.price] = ProductFormError.invalidPrice;
    }
    final digits = d.phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) {
      errors[ProductFormField.phone] = ProductFormError.invalidPhone;
    }
    // Optional — but something typed here has to be an address the app can
    // open. The server enforces the same rule, and used to do it *after* the
    // whole form was submitted, rejecting the listing without naming a field.
    if (!WebUrl.isAcceptable(d.websiteLink)) {
      errors[ProductFormField.website] = ProductFormError.invalidWebsite;
    }
    return errors;
  }
}
