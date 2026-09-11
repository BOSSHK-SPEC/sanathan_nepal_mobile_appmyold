import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/boost_request.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_filter.dart';
import '../../domain/usecases/get_boost_plans.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/submit_boost_request.dart';
import '../../../../core/state/app_cubit.dart';

part 'boost_cubit.freezed.dart';
part 'boost_state.dart';

/// "BOOST ADS" section: choose your own listings, pick hours, pay, submit.
class BoostCubit extends AppCubit<BoostState> {
  BoostCubit({
    required GetProducts getProducts,
    required GetBoostPlans getPlans,
    required SubmitBoostRequest submitBoost,
  }) : _getProducts = getProducts,
       _getPlans = getPlans,
       _submit = submitBoost,
       super(const BoostState());

  final GetProducts _getProducts;
  final GetBoostPlans _getPlans;
  final SubmitBoostRequest _submit;

  Future<void> load() async {
    emit(
      state.copyWith(
        products: state.products.toLoading(),
        plans: state.plans.toLoading(),
      ),
    );
    final plans = await _getPlans();
    final products = await _getProducts(
      ProductFilter(mineOnly: true, sort: state.sort),
    );
    final planList = plans.valueOrNull;
    emit(
      state.copyWith(
        products: products.fold(state.products.toFailed, LoadState.loaded),
        plans: plans.fold(state.plans.toFailed, LoadState.loaded),
        plan: state.plan ?? planList?.firstOrNull,
      ),
    );
  }

  Future<void> setSort(ProductSort sort) async {
    emit(state.copyWith(sort: sort, products: state.products.toLoading()));
    final products = await _getProducts(
      ProductFilter(mineOnly: true, sort: sort),
    );
    emit(
      state.copyWith(
        products: products.fold(state.products.toFailed, LoadState.loaded),
      ),
    );
  }

  void toggleSelection(String productId) {
    final next = {...state.selectedIds};
    if (!next.remove(productId)) next.add(productId);
    emit(state.copyWith(selectedIds: next));
  }

  void next() {
    if (state.selectedIds.isEmpty) return;
    emit(state.copyWith(step: BoostStep.form));
  }

  void back() => emit(state.copyWith(step: BoostStep.select));

  void selectPlan(BoostPlan plan) => emit(state.copyWith(plan: plan));

  Future<void> submit({
    required String firstName,
    required String lastName,
    required String phone,
    required String productLink,
    String? receiptPath,
  }) async {
    final plan = state.plan;
    if (plan == null || state.selectedIds.isEmpty) return;
    emit(state.copyWith(submission: state.submission.toLoading()));
    final result = await _submit(
      BoostRequest(
        productIds: state.selectedIds.toList(),
        plan: plan,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        productLink: productLink,
        receiptPath: receiptPath,
      ),
    );
    result.fold(
      (f) => emit(state.copyWith(submission: state.submission.toFailed(f))),
      (receipt) => emit(
        state.copyWith(
          submission: LoadState.loaded(receipt),
          selectedIds: const {},
          step: BoostStep.select,
        ),
      ),
    );
  }
}
