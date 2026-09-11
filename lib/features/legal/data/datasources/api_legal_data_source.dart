import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../domain/entities/legal_document.dart';
import '../models/legal_document_model.dart';
import 'legal_local_data_source.dart';

/// Terms and privacy policy served by the backend.
///
/// Fetched rather than bundled so a policy change reaches users without an
/// app-store release — the effective date is a legal commitment, not copy.
class ApiLegalDataSource implements LegalLocalDataSource {
  const ApiLegalDataSource(this._client);

  final ApiClient _client;

  @override
  Future<LegalDocumentModel> fetch(LegalDocumentType type) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.almanacLegal(_wireName(type)),
        );
        final json = asJsonMap(response);

        return LegalDocumentModel(
          type: type,
          title: _text(json['title']),
          intro: _text(json['intro']),
          lastUpdated: ApiTime.instantOr(json['effectiveAt'], DateTime.now()),
          sections: _sections(json['sections']),
        );
      });

  /// The app's enum names differ from the server's; this is the only place
  /// that knows both.
  static String _wireName(LegalDocumentType type) => switch (type) {
    LegalDocumentType.privacyPolicy => 'privacy',
    LegalDocumentType.termsConditions => 'terms',
  };

  List<LegalSectionModel> _sections(Object? raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map(
          (section) => LegalSectionModel(
            heading: _text(section['heading']),
            body: _text(section['body']),
            level: (section['level'] as num?)?.toInt() ?? 1,
          ),
        )
        .toList(growable: false);
  }

  /// English is the only translation the server guarantees, so it is the
  /// fallback for the others rather than an empty string.
  LegalTextModel _text(Object? raw) {
    if (raw is String) return LegalTextModel(en: raw, ne: raw);
    if (raw is! Map) return const LegalTextModel();
    final en = raw['en'] as String? ?? '';
    return LegalTextModel(
      en: en,
      ne: raw['ne'] as String? ?? en,
      hi: raw['hi'] as String?,
    );
  }
}
