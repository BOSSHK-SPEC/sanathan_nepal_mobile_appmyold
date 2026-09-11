import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/system/app_status.dart';
import '../../../../core/system/connectivity.dart';
import '../../../../core/state/app_cubit.dart';

part 'system_cubit.freezed.dart';
part 'system_state.dart';

/// App-wide availability and connectivity.
///
/// Sits above the router so a forced upgrade or a maintenance window can
/// stop every screen, and the offline banner can appear over any of them.
class SystemCubit extends AppCubit<SystemState> {
  SystemCubit({
    required AppStatusSource statusSource,
    required ConnectivityStatus connectivity,
  }) : _statusSource = statusSource,
       _connectivity = connectivity,
       super(const SystemState());

  final AppStatusSource _statusSource;
  final ConnectivityStatus _connectivity;

  StreamSubscription<bool>? _connectionSub;

  Future<void> start() async {
    await refreshStatus();
    _connectionSub?.cancel();
    _connectionSub = _connectivity.onChanged.listen((online) {
      if (isClosed) return;
      emit(state.copyWith(online: online));
    });
  }

  Future<void> refreshStatus() async {
    final status = await _statusSource.check();
    if (isClosed) return;
    emit(state.copyWith(status: status));
  }

  /// Dismisses an optional update prompt for this session.
  void dismissUpdatePrompt() => emit(state.copyWith(updateDismissed: true));

  @override
  Future<void> close() {
    _connectionSub?.cancel();
    return super.close();
  }
}
