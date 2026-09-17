import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../../domain/usecases/get_appointments.dart';
import '../../domain/usecases/get_bookable_astrologers.dart';
import '../../../../core/state/app_cubit.dart';

part 'appointment_list_cubit.freezed.dart';
part 'appointment_list_state.dart';

/// Loads the featured astrologer profile and the user's appointment list.
class AppointmentListCubit extends AppCubit<AppointmentListState> {
  AppointmentListCubit({
    required GetBookableAstrologers getAstrologers,
    required GetAppointments getAppointments,
  }) : _getAstrologers = getAstrologers,
       _getAppointments = getAppointments,
       super(const AppointmentListState());

  final GetBookableAstrologers _getAstrologers;
  final GetAppointments _getAppointments;

  Future<void> load() async {
    emit(
      state.copyWith(
        astrologers: state.astrologers.toLoading(),
        appointments: state.appointments.toLoading(),
      ),
    );
    final astrologers = await _getAstrologers();
    final appointments = await _getAppointments();
    emit(
      state.copyWith(
        astrologers: astrologers.fold(
          state.astrologers.toFailed,
          LoadState.loaded,
        ),
        appointments: appointments.fold(
          state.appointments.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }

  /// Refreshes only the appointment list (after booking / cancelling);
  /// the previous list stays visible while loading.
  Future<void> refreshAppointments() async {
    emit(state.copyWith(appointments: state.appointments.toLoading()));
    final result = await _getAppointments();
    emit(
      state.copyWith(
        appointments: result.fold(
          state.appointments.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }
}
