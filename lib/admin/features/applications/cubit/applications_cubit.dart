import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../../domain/entities/astrologer_application.dart';
import '../../../domain/repositories/admin_repository.dart';

part 'applications_cubit.freezed.dart';
part 'applications_state.dart';

/// The astrologer verification queue.
class ApplicationsCubit extends AppCubit<ApplicationsState> {
  ApplicationsCubit(this._admin) : super(const ApplicationsState());

  final AdminRepository _admin;

  Future<void> load() async {
    emit(state.copyWith(applications: state.applications.toLoading()));
    final result = await _admin.pendingApplications();
    emit(
      state.copyWith(
        applications: result.fold(
          state.applications.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }

  /// Approve or reject, then refetch.
  ///
  /// Refetching rather than patching the row locally is deliberate: two
  /// reviewers can work the same queue, and the authoritative answer to "what
  /// is still pending" is the server's, not this tab's.
  Future<void> decide({
    required String applicationId,
    required bool approve,
    required String note,
  }) async {
    emit(state.copyWith(decidingId: applicationId, decisionError: null));

    final result = await _admin.decideApplication(
      applicationId: applicationId,
      approve: approve,
      note: note,
    );

    await result.fold(
      (failure) async => emit(
        state.copyWith(decidingId: null, decisionError: failure.message),
      ),
      (_) async {
        emit(state.copyWith(decidingId: null));
        await load();
      },
    );
  }
}
