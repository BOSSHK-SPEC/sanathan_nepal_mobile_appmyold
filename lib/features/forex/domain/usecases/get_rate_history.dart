import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/forex_history_point.dart';
import '../entities/forex_range.dart';
import '../repositories/forex_repository.dart';

part 'get_rate_history.freezed.dart';

/// Parameters for [GetRateHistory].
@freezed
abstract class GetRateHistoryParams with _$GetRateHistoryParams {
  const factory GetRateHistoryParams({
    required String iso3,
    required ForexRange range,
  }) = _GetRateHistoryParams;
}

class GetRateHistory
    implements UseCase<List<ForexHistoryPoint>, GetRateHistoryParams> {
  const GetRateHistory(this._repo);
  final ForexRepository _repo;

  @override
  Future<Result<List<ForexHistoryPoint>>> call(GetRateHistoryParams params) =>
      _repo.getRateHistory(params.iso3, params.range);
}
