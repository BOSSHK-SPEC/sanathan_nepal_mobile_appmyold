import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/birth_profile.dart';
import '../../domain/entities/dasha.dart';
import '../../domain/entities/dosha.dart';
import '../../domain/entities/gun_milan.dart';
import '../../domain/entities/kundli_chart.dart';
import '../../domain/repositories/kundli_repository.dart';
import '../datasources/kundli_data_source.dart';

class KundliRepositoryImpl implements KundliRepository {
  const KundliRepositoryImpl(this._source);

  final KundliDataSource _source;

  @override
  Future<Result<List<BirthProfile>>> profiles() => guard(_source.profiles);

  @override
  Future<Result<BirthProfile>> saveProfile(BirthProfile profile) =>
      guard(() => _source.saveProfile(profile));

  @override
  Future<Result<void>> deleteProfile(String profileId) =>
      guard(() => _source.deleteProfile(profileId));

  @override
  Future<Result<KundliChart>> chart(String profileId) =>
      guard(() => _source.chart(profileId));

  @override
  Future<Result<List<DashaPeriod>>> dashas(String profileId) =>
      guard(() => _source.dashas(profileId));

  @override
  Future<Result<List<DoshaReading>>> doshas(String profileId) =>
      guard(() => _source.doshas(profileId));

  @override
  Future<Result<GunMilanResult>> match({
    required String brideProfileId,
    required String groomProfileId,
  }) => guard(
    () => _source.match(
      brideProfileId: brideProfileId,
      groomProfileId: groomProfileId,
    ),
  );
}
