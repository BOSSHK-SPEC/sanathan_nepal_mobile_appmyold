part of 'my_pujas_cubit.dart';

@freezed
abstract class MyPujasState with _$MyPujasState {
  const MyPujasState._();

  const factory MyPujasState({
    @Default(LoadState.idle()) LoadState<List<PujaBooking>> bookings,
    String? busyId,
    String? actionError,
  }) = _MyPujasState;

  List<PujaBooking> get all => bookings.dataOrNull ?? const [];

  List<PujaBooking> get upcoming =>
      all.where((b) => b.isUpcoming || b.isLive).toList()
        ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

  List<PujaBooking> get past =>
      all.where((b) => !b.isUpcoming && !b.isLive).toList();

  bool get isEmpty => bookings.isLoaded && all.isEmpty;
}
