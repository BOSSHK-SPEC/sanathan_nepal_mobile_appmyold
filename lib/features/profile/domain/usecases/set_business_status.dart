import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/business_profile.dart';
import '../repositories/business_repository.dart';

part 'set_business_status.freezed.dart';

/// Parameters for [SetBusinessStatus].
@freezed
abstract class SetBusinessStatusParams with _$SetBusinessStatusParams {
  const factory SetBusinessStatusParams({
    required String id,
    required BusinessStatus status,

    /// Optional reason (rejection) shown to the owner.
    @Default('') String note,
  }) = _SetBusinessStatusParams;
}

/// Admin approve/reject action.
class SetBusinessStatus
    implements UseCase<BusinessProfile, SetBusinessStatusParams> {
  const SetBusinessStatus(this._repo);
  final BusinessRepository _repo;

  @override
  Future<Result<BusinessProfile>> call(SetBusinessStatusParams params) =>
      _repo.setStatus(params.id, params.status, note: params.note);
}
