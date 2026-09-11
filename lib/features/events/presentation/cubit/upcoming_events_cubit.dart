import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../../domain/entities/event_filter.dart';
import '../../domain/usecases/get_events.dart';
import '../../../../core/state/app_cubit.dart';

part 'upcoming_events_cubit.freezed.dart';
part 'upcoming_events_state.dart';

/// Loads the few upcoming events shown in the Home "कार्यक्रमहरू" block.
class UpcomingEventsCubit extends AppCubit<UpcomingEventsState> {
  UpcomingEventsCubit({required GetEvents getEvents, this.limit = 4})
    : _getEvents = getEvents,
      super(const UpcomingEventsState());

  final GetEvents _getEvents;
  final int limit;

  Future<void> load() async {
    emit(state.copyWith(events: state.events.toLoading()));
    await _refresh();
  }

  Future<void> selectScope(UpcomingScope scope) async {
    emit(state.copyWith(scope: scope));
    await _refresh();
  }

  Future<void> toggleHolidays() async {
    emit(state.copyWith(onlyHolidays: !state.onlyHolidays));
    await _refresh();
  }

  Future<void> toggleVrat() async {
    emit(state.copyWith(onlyVrat: !state.onlyVrat));
    await _refresh();
  }

  EventFilter get _filter => EventFilter(
    group: state.scope == UpcomingScope.mine ? EventGroup.personal : null,
    category: state.scope == UpcomingScope.governmentHolidays
        ? EventCategory.publicHoliday
        : null,
    onlyHolidays: state.onlyHolidays,
    onlyVrat: state.onlyVrat,
    limit: limit,
  );

  Future<void> _refresh() async {
    final result = await _getEvents(_filter);
    emit(
      state.copyWith(
        events: result.fold(state.events.toFailed, LoadState.loaded),
      ),
    );
  }
}
