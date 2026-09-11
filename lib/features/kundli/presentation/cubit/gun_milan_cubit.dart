import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/birth_profile.dart';
import '../../domain/entities/gun_milan.dart';
import '../../domain/usecases/kundli_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'gun_milan_cubit.freezed.dart';
part 'gun_milan_state.dart';

/// Pick two saved charts and score the match.
class GunMilanCubit extends AppCubit<GunMilanState> {
  GunMilanCubit({
    required GetBirthProfiles getProfiles,
    required MatchKundlis matchKundlis,
  }) : _getProfiles = getProfiles,
       _match = matchKundlis,
       super(const GunMilanState());

  final GetBirthProfiles _getProfiles;
  final MatchKundlis _match;

  Future<void> load() async {
    emit(state.copyWith(profiles: state.profiles.toLoading()));
    final result = await _getProfiles();
    emit(
      state.copyWith(
        profiles: result.fold(state.profiles.toFailed, LoadState.loaded),
      ),
    );
  }

  void selectBride(String? id) => emit(
    GunMilanState(
      profiles: state.profiles,
      brideId: id,
      groomId: state.groomId == id ? null : state.groomId,
    ),
  );

  void selectGroom(String? id) => emit(
    GunMilanState(
      profiles: state.profiles,
      brideId: state.brideId == id ? null : state.brideId,
      groomId: id,
    ),
  );

  Future<void> match() async {
    if (!state.canMatch) return;
    emit(state.copyWith(result: state.result.toLoading()));
    final result = await _match(
      MatchParams(
        brideProfileId: state.brideId!,
        groomProfileId: state.groomId!,
      ),
    );
    emit(
      state.copyWith(
        result: result.fold(state.result.toFailed, LoadState.loaded),
      ),
    );
  }
}
