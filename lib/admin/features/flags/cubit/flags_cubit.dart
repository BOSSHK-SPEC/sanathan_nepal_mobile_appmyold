import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../../domain/entities/feature_flag.dart';
import '../../../domain/repositories/admin_repository.dart';

part 'flags_cubit.freezed.dart';
part 'flags_state.dart';

/// Feature flags.
///
/// A toggle here changes what every user of the platform sees within seconds,
/// so nothing is optimistic: the switch shows a spinner until the server has
/// confirmed, and the value it then shows is the server's, not the one the
/// reviewer clicked.
class FlagsCubit extends AppCubit<FlagsState> {
  FlagsCubit(this._admin) : super(const FlagsState());

  final AdminRepository _admin;

  Future<void> load() async {
    emit(state.copyWith(flags: state.flags.toLoading()));
    final result = await _admin.featureFlags();
    emit(
      state.copyWith(
        flags: result.fold(state.flags.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> toggle(FeatureFlag flag) =>
      _apply(flag.key, enabled: !flag.enabled);

  Future<void> setRollout(FeatureFlag flag, int rolloutPct) =>
      _apply(flag.key, rolloutPct: rolloutPct.clamp(0, 100));

  Future<void> _apply(String key, {bool? enabled, int? rolloutPct}) async {
    emit(state.copyWith(savingKey: key, actionError: null));

    final result = await _admin.setFeatureFlag(
      key,
      enabled: enabled,
      rolloutPct: rolloutPct,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(savingKey: null, actionError: failure.message)),
      (updated) => emit(
        state.copyWith(
          savingKey: null,
          // Only the changed row is replaced: refetching the whole list would
          // discard a rollout slider another reviewer is mid-drag on.
          flags: LoadState.loaded([
            for (final flag in state.items)
              if (flag.key == updated.key) updated else flag,
          ]),
        ),
      ),
    );
  }
}
