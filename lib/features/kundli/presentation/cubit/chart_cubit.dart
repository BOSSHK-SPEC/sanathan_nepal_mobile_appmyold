import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/dasha.dart';
import '../../domain/entities/dosha.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/usecases/kundli_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'chart_cubit.freezed.dart';
part 'chart_state.dart';

/// One cast chart with its tables, dashas and doshas.
class ChartCubit extends AppCubit<ChartState> {
  ChartCubit({
    required String profileId,
    required GetKundliChart getChart,
    required GetDashas getDashas,
    required GetDoshas getDoshas,
  }) : _profileId = profileId,
       _getChart = getChart,
       _getDashas = getDashas,
       _getDoshas = getDoshas,
       super(const ChartState());

  final String _profileId;
  final GetKundliChart _getChart;
  final GetDashas _getDashas;
  final GetDoshas _getDoshas;

  Future<void> load() async {
    emit(
      state.copyWith(
        chart: state.chart.toLoading(),
        dashas: state.dashas.toLoading(),
        doshas: state.doshas.toLoading(),
      ),
    );
    final chartFuture = _getChart(_profileId);
    final dashaFuture = _getDashas(_profileId);
    final doshaFuture = _getDoshas(_profileId);

    final chart = await chartFuture;
    final dashas = await dashaFuture;
    final doshas = await doshaFuture;

    emit(
      state.copyWith(
        chart: chart.fold(state.chart.toFailed, LoadState.loaded),
        dashas: dashas.fold(state.dashas.toFailed, LoadState.loaded),
        doshas: doshas.fold(state.doshas.toFailed, LoadState.loaded),
      ),
    );
  }

  void selectTab(int index) => emit(state.copyWith(tabIndex: index));

  void setStyle(ChartStyle style) => emit(state.copyWith(style: style));

  void expandDasha(String? key) => emit(
    state.copyWith(expandedDasha: state.expandedDasha == key ? null : key),
  );
}
