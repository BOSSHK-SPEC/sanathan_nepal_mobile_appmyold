import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region_all.dart';
import '../../domain/entities/legal_document.dart';
import '../models/legal_document_model.dart';
import 'legal_seed_privacy.dart';
import 'legal_seed_terms.dart';

/// Source of legal documents (bundled / remote CMS in the future).
abstract interface class LegalLocalDataSource {
  Future<LegalDocumentModel> fetch(LegalDocumentType type);
}

/// Deterministic in-memory legal documents matching the Figma copy
/// (Privacy Policy `1265:2654`, Terms & Conditions `1332:2744`).
///
/// The active region is read from [RegionResolver] on every call so the
/// company/contact block, governing law and data-protection sections follow
/// a runtime region switch (Nepal ↔ India).
class MockLegalDataSource implements LegalLocalDataSource {
  const MockLegalDataSource({
    RegionResolver regionResolver = const FixedRegionResolver(Region.nepal),
  }) : _regions = regionResolver;

  final RegionResolver _regions;

  @override
  Future<LegalDocumentModel> fetch(LegalDocumentType type) async {
    final config = _regions.config;
    final document = switch (type) {
      LegalDocumentType.privacyPolicy => privacyPolicyFor(config),
      LegalDocumentType.termsConditions => termsConditionsFor(config),
    };
    return LegalDocumentModel.fromEntity(document);
  }

  /// Exposed for tests: fetching an unknown code throws.
  static LegalDocumentType parse(String code) {
    final match = LegalDocumentType.values.where((t) => t.code == code);
    if (match.isEmpty) throw const NotFoundException('Unknown legal document');
    return match.first;
  }
}
