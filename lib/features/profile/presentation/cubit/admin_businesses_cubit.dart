import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/business_profile.dart';
import '../../domain/usecases/get_businesses.dart';
import '../../domain/usecases/set_business_status.dart';
import '../../../../core/state/app_cubit.dart';

part 'admin_businesses_cubit.freezed.dart';
part 'admin_businesses_state.dart';

/// Admin "Business approvals" list: loads every listing and filters it by
/// moderation status (pending / approved / rejected / all).
class AdminBusinessesCubit extends AppCubit<AdminBusinessesState> {
  AdminBusinessesCubit({
    required GetBusinesses getBusinesses,
    required SetBusinessStatus setStatus,
  }) : _getBusinesses = getBusinesses,
       _setStatus = setStatus,
       super(const AdminBusinessesState());

  final GetBusinesses _getBusinesses;
  final SetBusinessStatus _setStatus;

  Future<void> load() async {
    emit(state.copyWith(businesses: state.businesses.toLoading()));
    final result = await _getBusinesses(null);
    emit(
      state.copyWith(
        businesses: result.fold(state.businesses.toFailed, LoadState.loaded),
      ),
    );
  }

  /// `null` shows every listing.
  void setFilter(BusinessStatus? status) =>
      emit(state.copyWith(filter: status));

  /// Quick approve/reject from the list; the list is refreshed afterwards.
  Future<void> moderate(
    String id,
    BusinessStatus status, {
    String note = '',
  }) async {
    final result = await _setStatus(
      SetBusinessStatusParams(id: id, status: status, note: note),
    );
    result.fold(
      (f) => emit(state.copyWith(businesses: state.businesses.toFailed(f))),
      (_) {},
    );
    if (result.isSuccess) await load();
  }
}
