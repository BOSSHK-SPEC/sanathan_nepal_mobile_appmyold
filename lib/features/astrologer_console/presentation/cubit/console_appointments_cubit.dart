import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/console_appointment.dart';
import '../../domain/usecases/console_usecases.dart';

part 'console_appointments_cubit.freezed.dart';
part 'console_appointments_state.dart';

/// The astrologer's appointment book: what is coming up, and what is over.
///
/// Each tab loads on first view and keeps its list, so switching back and
/// forth does not refetch.
class ConsoleAppointmentsCubit extends AppCubit<ConsoleAppointmentsState> {
  ConsoleAppointmentsCubit({required GetConsoleAppointments getAppointments})
    : _getAppointments = getAppointments,
      super(const ConsoleAppointmentsState());

  final GetConsoleAppointments _getAppointments;

  /// Loads (or reloads) the tab being shown.
  Future<void> load() => _load(state.scope);

  Future<void> selectScope(AppointmentScope scope) async {
    if (scope == state.scope) return;
    emit(state.copyWith(scope: scope));
    if (state.slice(scope).isIdle) await _load(scope);
  }

  Future<void> _load(AppointmentScope scope) async {
    emit(_withSlice(scope, state.slice(scope).toLoading()));
    final result = await _getAppointments(scope);
    emit(
      _withSlice(
        scope,
        result.fold(state.slice(scope).toFailed, LoadState.loaded),
      ),
    );
  }

  ConsoleAppointmentsState _withSlice(
    AppointmentScope scope,
    LoadState<List<ConsoleAppointment>> value,
  ) => scope == AppointmentScope.upcoming
      ? state.copyWith(upcoming: value)
      : state.copyWith(past: value);
}
