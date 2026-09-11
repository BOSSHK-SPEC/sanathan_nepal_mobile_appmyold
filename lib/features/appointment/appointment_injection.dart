import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_appointment_data_source.dart';
import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import 'data/datasources/appointment_data_source.dart';
import 'data/repositories/appointment_repository_impl.dart';
import 'domain/entities/bookable_astrologer.dart';
import 'domain/repositories/appointment_repository.dart';
import 'domain/repositories/booking_contact_source.dart';
import 'domain/usecases/book_appointment.dart';
import 'domain/usecases/cancel_appointment.dart';
import 'domain/usecases/get_appointment.dart';
import 'domain/usecases/get_appointments.dart';
import 'domain/usecases/get_bookable_astrologer.dart';
import 'domain/usecases/get_bookable_astrologers.dart';
import 'domain/usecases/get_astrologer_calendar.dart';
import 'domain/usecases/get_time_slots.dart';
import 'domain/usecases/reschedule_appointment.dart';
import 'presentation/cubit/appointment_details_cubit.dart';
import 'presentation/cubit/appointment_list_cubit.dart';
import 'presentation/cubit/book_appointment_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `appointment`.
void registerAppointmentFeature(GetIt sl) {
  sl
    ..registerLazySingleton<AppointmentDataSource>(
      () => selectDataSource(
        mock: () => MockAppointmentDataSource(region: sl<RegionResolver>()),
        live: () => ApiAppointmentDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetBookableAstrologers(sl()))
    ..registerLazySingleton(() => GetBookableAstrologer(sl()))
    ..registerLazySingleton(() => GetTimeSlots(sl()))
    ..registerLazySingleton(() => GetAstrologerCalendar(sl()))
    ..registerLazySingleton(() => GetAppointments(sl()))
    ..registerLazySingleton(() => GetAppointment(sl()))
    ..registerLazySingleton(() => BookAppointment(sl()))
    ..registerLazySingleton(() => CancelAppointment(sl()))
    ..registerLazySingleton(() => RescheduleAppointment(sl()))
    ..registerFactory(
      () => AppointmentListCubit(getAstrologers: sl(), getAppointments: sl()),
    )
    ..registerFactory(
      () => AppointmentDetailsCubit(
        getAppointment: sl(),
        getAstrologer: sl(),
        getTimeSlots: sl(),
        cancelAppointment: sl(),
        rescheduleAppointment: sl(),
      ),
    )
    // param1 = BookableAstrologer, param2 = initial service id (nullable).
    ..registerFactoryParam<BookAppointmentCubit, BookableAstrologer, String?>(
      (astrologer, serviceId) => BookAppointmentCubit(
        getTimeSlots: sl(),
        getCalendar: sl(),
        bookAppointment: sl(),
        regionResolver: sl<RegionResolver>(),
        // Registered by the composition root after the profile feature; absent
        // in tests that wire this feature on its own.
        contacts: sl.isRegistered<BookingContactSource>()
            ? sl<BookingContactSource>()
            : null,
        astrologer: astrologer,
        initialServiceId: serviceId,
      ),
    );
}
