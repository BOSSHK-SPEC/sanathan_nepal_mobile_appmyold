import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/birth_profile.dart';
import '../entities/dasha.dart';
import '../entities/dosha.dart';
import '../entities/gun_milan.dart';
import '../entities/kundli_chart.dart';
import '../repositories/kundli_repository.dart';

class GetBirthProfiles implements NoParamsUseCase<List<BirthProfile>> {
  const GetBirthProfiles(this._repo);
  final KundliRepository _repo;

  @override
  Future<Result<List<BirthProfile>>> call() => _repo.profiles();
}

class SaveBirthProfile implements UseCase<BirthProfile, BirthProfile> {
  const SaveBirthProfile(this._repo);
  final KundliRepository _repo;

  @override
  Future<Result<BirthProfile>> call(BirthProfile params) =>
      _repo.saveProfile(params);
}

class DeleteBirthProfile implements UseCase<void, String> {
  const DeleteBirthProfile(this._repo);
  final KundliRepository _repo;

  @override
  Future<Result<void>> call(String params) => _repo.deleteProfile(params);
}

class GetKundliChart implements UseCase<KundliChart, String> {
  const GetKundliChart(this._repo);
  final KundliRepository _repo;

  @override
  Future<Result<KundliChart>> call(String params) => _repo.chart(params);
}

class GetDashas implements UseCase<List<DashaPeriod>, String> {
  const GetDashas(this._repo);
  final KundliRepository _repo;

  @override
  Future<Result<List<DashaPeriod>>> call(String params) => _repo.dashas(params);
}

class GetDoshas implements UseCase<List<DoshaReading>, String> {
  const GetDoshas(this._repo);
  final KundliRepository _repo;

  @override
  Future<Result<List<DoshaReading>>> call(String params) =>
      _repo.doshas(params);
}

class MatchParams {
  const MatchParams({
    required this.brideProfileId,
    required this.groomProfileId,
  });
  final String brideProfileId;
  final String groomProfileId;
}

class MatchKundlis implements UseCase<GunMilanResult, MatchParams> {
  const MatchKundlis(this._repo);
  final KundliRepository _repo;

  @override
  Future<Result<GunMilanResult>> call(MatchParams params) => _repo.match(
    brideProfileId: params.brideProfileId,
    groomProfileId: params.groomProfileId,
  );
}
