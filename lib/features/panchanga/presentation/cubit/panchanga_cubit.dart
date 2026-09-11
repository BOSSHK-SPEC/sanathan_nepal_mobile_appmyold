import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/calendar/traditional_calendar.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/panchanga.dart';
import '../../domain/entities/suva_sait.dart';
import '../../domain/usecases/get_panchanga.dart';
import '../../domain/usecases/get_suva_saits.dart';
import '../../../../core/state/app_cubit.dart';

part 'panchanga_cubit.freezed.dart';
part 'panchanga_state.dart';

/// Loads the panchanga of a day plus the auspicious-timing list and drives
/// the monthly / yearly sait tables.
class PanchangaCubit extends AppCubit<PanchangaState> {
  PanchangaCubit({
    required GetPanchanga getPanchanga,
    required GetSuvaSaits getSuvaSaits,
    RegionResolver resolver = const FixedRegionResolver(Region.nepal),
    DateTime? initialDate,
  }) : _getPanchanga = getPanchanga,
       _getSuvaSaits = getSuvaSaits,
       _resolver = resolver,
       super(_initial(resolver.config.calendar, initialDate ?? DateTime.now()));

  final GetPanchanga _getPanchanga;
  final GetSuvaSaits _getSuvaSaits;
  final RegionResolver _resolver;

  /// Traditional calendar of the active region (B.S. / Saka).
  TraditionalCalendar get calendar => _resolver.config.calendar;

  static DateTime _midnight(DateTime d) => DateTime(d.year, d.month, d.day);

  static PanchangaState _initial(TraditionalCalendar calendar, DateTime d) {
    final day = _midnight(d);
    final t = calendar.fromGregorian(day);
    return PanchangaState(date: day, saitYear: t.year, saitMonth: t.month);
  }

  /// Loads panchanga for the current date and (once) the sait list.
  Future<void> load() => selectDate(state.date, force: true);

  Future<void> selectDate(DateTime date, {bool force = false}) async {
    final day = _midnight(date);
    if (!force && day == state.date && state.panchanga.isLoaded) return;
    // Saits are date-independent: fetch them only until they have loaded.
    final needsSaits = !state.saits.isLoaded;
    final t = calendar.fromGregorian(day);
    emit(
      state.copyWith(
        date: day,
        saitYear: t.year,
        saitMonth: t.month,
        panchanga: state.panchanga.toLoading(),
        saits: needsSaits ? state.saits.toLoading() : state.saits,
      ),
    );
    final panchangaFuture = _getPanchanga(day);
    final saitsFuture = needsSaits ? _getSuvaSaits() : null;
    final panchangaResult = await panchangaFuture;
    final saitsResult = await saitsFuture;
    if (isClosed) return;
    emit(
      state.copyWith(
        panchanga: panchangaResult.fold(
          state.panchanga.toFailed,
          LoadState.loaded,
        ),
        saits: saitsResult == null
            ? state.saits
            : saitsResult.fold(state.saits.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> nextDay() => selectDate(state.date.add(const Duration(days: 1)));

  Future<void> previousDay() =>
      selectDate(state.date.subtract(const Duration(days: 1)));

  Future<void> today() => selectDate(DateTime.now());

  // ------------------------------------------------------------ sait tables

  /// Switches between the monthly and yearly sait tables.
  void setSaitView(SaitView view) => emit(state.copyWith(saitView: view));

  /// Browses the sait table to a traditional month (clamped to the calendar).
  void selectSaitMonth({required int year, required int month}) {
    var y = year;
    var m = month;
    while (m < 1) {
      m += 12;
      y--;
    }
    while (m > 12) {
      m -= 12;
      y++;
    }
    y = y.clamp(calendar.minYear, calendar.maxYear);
    emit(state.copyWith(saitYear: y, saitMonth: m));
  }

  void nextSaitMonth() =>
      selectSaitMonth(year: state.saitYear, month: state.saitMonth + 1);

  void previousSaitMonth() =>
      selectSaitMonth(year: state.saitYear, month: state.saitMonth - 1);

  void nextSaitYear() =>
      selectSaitMonth(year: state.saitYear + 1, month: state.saitMonth);

  void previousSaitYear() =>
      selectSaitMonth(year: state.saitYear - 1, month: state.saitMonth);
}
