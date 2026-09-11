import '../../../../core/utils/result.dart';
import '../entities/birth_profile.dart';
import '../entities/dasha.dart';
import '../entities/dosha.dart';
import '../entities/gun_milan.dart';
import '../entities/kundli_chart.dart';

/// Saved birth profiles, cast charts, dashas, doshas and matching.
abstract interface class KundliRepository {
  Future<Result<List<BirthProfile>>> profiles();

  Future<Result<BirthProfile>> saveProfile(BirthProfile profile);

  Future<Result<void>> deleteProfile(String profileId);

  Future<Result<KundliChart>> chart(String profileId);

  /// Vimshottari mahadashas with their antardashas.
  Future<Result<List<DashaPeriod>>> dashas(String profileId);

  Future<Result<List<DoshaReading>>> doshas(String profileId);

  Future<Result<GunMilanResult>> match({
    required String brideProfileId,
    required String groomProfileId,
  });
}
