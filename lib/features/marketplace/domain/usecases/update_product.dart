import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/product.dart';
import '../entities/product_draft.dart';
import '../repositories/product_repository.dart';

part 'update_product.freezed.dart';

/// Parameters for [UpdateProduct].
@freezed
abstract class UpdateProductParams with _$UpdateProductParams {
  const factory UpdateProductParams({
    required String id,
    required ProductDraft draft,
  }) = _UpdateProductParams;
}

/// Overwrites the editable fields of one of the current seller's listings.
class UpdateProduct implements UseCase<Product, UpdateProductParams> {
  const UpdateProduct(this._repo);
  final ProductRepository _repo;

  @override
  Future<Result<Product>> call(UpdateProductParams params) =>
      _repo.update(params.id, params.draft);
}
