import '../../domain/entities/birth_profile.dart';
import '../../domain/entities/dasha.dart';
import '../../domain/entities/dosha.dart';
import '../../domain/entities/gun_milan.dart';
import '../../domain/entities/kundli_chart.dart';

abstract interface class KundliDataSource {
  Future<List<BirthProfile>> profiles();
  Future<BirthProfile> saveProfile(BirthProfile profile);
  Future<void> deleteProfile(String profileId);
  Future<KundliChart> chart(String profileId);
  Future<List<DashaPeriod>> dashas(String profileId);
  Future<List<DoshaReading>> doshas(String profileId);
  Future<GunMilanResult> match({
    required String brideProfileId,
    required String groomProfileId,
  });
}
