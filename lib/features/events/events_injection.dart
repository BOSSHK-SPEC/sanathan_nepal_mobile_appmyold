import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import 'data/datasources/events_data_source.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_events_data_source.dart';
import 'data/datasources/mock_events_data_source.dart';
import 'data/repositories/event_repository_impl.dart';
import 'domain/repositories/event_repository.dart';
import 'domain/usecases/create_event.dart';
import 'domain/usecases/delete_event.dart';
import 'domain/usecases/get_event_by_id.dart';
import 'domain/usecases/get_events.dart';
import 'domain/usecases/toggle_checklist_item.dart';
import 'domain/usecases/update_event.dart';
import 'presentation/cubit/day_events_cubit.dart';
import 'presentation/cubit/event_details_cubit.dart';
import 'presentation/cubit/event_form_cubit.dart';
import 'presentation/cubit/events_list_cubit.dart';
import 'presentation/cubit/upcoming_events_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `events`.
void registerEventsFeature(GetIt sl) {
  sl
    ..registerLazySingleton<EventsDataSource>(
      () => selectDataSource(
        mock: () => MockEventsDataSource(resolver: sl<RegionResolver>()),
        live: () => ApiEventsDataSource(
          sl<ApiClient>(),
          resolver: sl<RegionResolver>(),
        ),
      ),
    )
    ..registerLazySingleton<EventRepository>(
      // The resolver carries the region's calendar, which is what lets a
      // B.S. / Saka anniversary recur on its own date.
      () => EventRepositoryImpl(sl(), resolver: sl<RegionResolver>()),
    )
    ..registerLazySingleton(() => GetEvents(sl()))
    ..registerLazySingleton(() => GetEventById(sl()))
    ..registerLazySingleton(() => CreateEvent(sl()))
    ..registerLazySingleton(() => UpdateEvent(sl()))
    ..registerLazySingleton(() => DeleteEvent(sl()))
    ..registerLazySingleton(() => ToggleChecklistItem(sl()))
    ..registerFactory(
      () => EventsListCubit(
        getEvents: sl(),
        deleteEvent: sl(),
        toggleChecklistItem: sl(),
      ),
    )
    ..registerFactory(
      () => EventDetailsCubit(
        getEventById: sl(),
        toggleChecklistItem: sl(),
        deleteEvent: sl(),
      ),
    )
    ..registerFactory(
      () => EventFormCubit(createEvent: sl(), updateEvent: sl()),
    )
    ..registerFactory(() => UpcomingEventsCubit(getEvents: sl()))
    ..registerFactory(
      () => DayEventsCubit(getEvents: sl(), toggleChecklistItem: sl()),
    );
}
