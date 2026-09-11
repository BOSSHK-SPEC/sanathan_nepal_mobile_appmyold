import '../../../../core/error/failures.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/otp_challenge.dart';
import '../repositories/auth_repository.dart';

/// Validates a phone number for the active region and requests an OTP for it.
///
/// The dialling prefix (`+977` / `+91`) and the accepted national mobile
/// pattern come from the [RegionResolver] read at call time.
class SignInWithPhone implements UseCase<OtpChallenge, String> {
  const SignInWithPhone(this._repo, this._regions);
  final AuthRepository _repo;
  final RegionResolver _regions;

  /// National mobile-number patterns (10 digits in both regions):
  /// Nepal 96/97/98…, India 6–9….
  static final Map<Region, RegExp> _mobilePatterns = {
    Region.nepal: RegExp(r'^9[6-8]\d{8}$'),
    Region.india: RegExp(r'^[6-9]\d{9}$'),
  };

  /// Strips spaces/dashes/brackets and the region's dialling prefix
  /// (with or without a leading `+` / `00`), returning the national number.
  static String normalize(String raw, {required RegionConfig config}) {
    var value = raw.replaceAll(RegExp(r'[\s\-()]'), '');
    final prefix = config.phonePrefix; // e.g. "+977"
    final digitsPrefix = prefix.replaceFirst('+', ''); // "977"
    if (value.startsWith(prefix)) {
      value = value.substring(prefix.length);
    } else if (value.startsWith('00$digitsPrefix')) {
      value = value.substring(digitsPrefix.length + 2);
    } else if (value.startsWith(digitsPrefix) &&
        value.length == digitsPrefix.length + 10) {
      value = value.substring(digitsPrefix.length);
    }
    return value;
  }

  /// Whether [raw] is a valid national mobile number for [config]'s region.
  static bool isValid(String raw, {required RegionConfig config}) =>
      _mobilePatterns[config.region]!.hasMatch(normalize(raw, config: config));

  /// The number in E.164 (`+9779812345678`), which is the only form that
  /// leaves the app.
  ///
  /// The UI shows the dialling prefix beside the field rather than inside it,
  /// so what the user typed is a national number — unambiguous only while you
  /// also know which region they are in. Everything past the domain layer
  /// (the API, the account record, an SMS gateway) needs the number to carry
  /// its own country, so the prefix is attached here, once.
  ///
  /// Idempotent: a number that already carries the prefix is normalised back
  /// to national form first, so re-sending an OTP cannot double it.
  static String toE164(String raw, {required RegionConfig config}) =>
      '${config.phonePrefix}${normalize(raw, config: config)}';

  /// Instance helpers bound to the active region.
  String normalizePhone(String raw) => normalize(raw, config: _regions.config);

  /// [toE164] for the region that is active right now.
  String toInternational(String raw) => toE164(raw, config: _regions.config);
  bool isValidPhone(String raw) => isValid(raw, config: _regions.config);

  @override
  Future<Result<OtpChallenge>> call(String params) {
    final config = _regions.config;
    if (!isValid(params, config: config)) {
      return Future.value(
        const Result.failure(ValidationFailure('Invalid phone number')),
      );
    }
    return _repo.signInWithPhone(toE164(params, config: config));
  }
}
