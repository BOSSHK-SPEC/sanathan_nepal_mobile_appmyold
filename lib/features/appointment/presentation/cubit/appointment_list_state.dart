part of 'appointment_list_cubit.dart';

/// Astrologer profile + the user's appointments (Appointment page).
@freezed
abstract class AppointmentListState with _$AppointmentListState {
  const AppointmentListState._();

  const factory AppointmentListState({
    /// Astrologers offered in the active region.
    @Default(LoadState.idle()) LoadState<List<BookableAstrologer>> astrologers,
    @Default(LoadState.idle()) LoadState<List<Appointment>> appointments,
  }) = _AppointmentListState;

  /// Featured astrologer (first of the loaded list), if any.
  BookableAstrologer? get astrologer => astrologers.dataOrNull?.firstOrNull;

  List<Appointment> get _list => appointments.dataOrNull ?? const [];

  List<Appointment> get upcoming =>
      _list.where((a) => a.isUpcoming).toList()
        ..sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

  List<Appointment> get past =>
      _list.where((a) => !a.isUpcoming).toList()
        ..sort((a, b) => b.startDateTime.compareTo(a.startDateTime));
}
