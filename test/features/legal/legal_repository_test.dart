import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/data/datasources/legal_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/data/models/legal_document_model.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/data/repositories/legal_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/domain/entities/legal_document.dart';

class _MockDataSource extends Mock implements LegalLocalDataSource {}

void main() {
  setUpAll(() => registerFallbackValue(LegalDocumentType.privacyPolicy));

  group('LegalRepositoryImpl', () {
    test('returns Success with the mock document', () async {
      final repo = LegalRepositoryImpl(const MockLegalDataSource());
      final result = await repo.getDocument(LegalDocumentType.termsConditions);
      final doc = result.valueOrNull;
      expect(doc, isNotNull);
      expect(doc!.type, LegalDocumentType.termsConditions);
      expect(doc.sections.length, 10);
      expect(doc.title.of(nepali: true), 'नियम तथा सर्तहरू');
      expect(doc.title.resolve('hi'), 'नियम और शर्तें');
      expect(
        doc.sections[8].body.en,
        contains('the courts of Kathmandu, Nepal'),
      );
      expect(doc.sections.last.body.en, contains('info@ourvirtualtribes.com'));
    });

    test(
      'India region: terms use Indian governing law and contact block',
      () async {
        final repo = LegalRepositoryImpl(
          const MockLegalDataSource(
            regionResolver: FixedRegionResolver(Region.india),
          ),
        );
        final doc = (await repo.getDocument(
          LegalDocumentType.termsConditions,
        )).valueOrNull!;
        expect(doc.sections[0].body.en, contains('Country refers to: India'));
        expect(doc.sections[8].body.en, contains('the laws of India'));
        expect(
          doc.sections[8].body.en,
          contains('the courts of New Delhi, India'),
        );
        expect(doc.sections[8].body.resolve('hi'), contains('नई दिल्ली'));
        expect(doc.sections.last.body.en, contains('New Delhi, India'));
        expect(
          doc.sections.last.body.en,
          contains('info.in@ourvirtualtribes.com'),
        );
      },
    );

    test('India region: privacy policy references DPDP Act and grievance '
        'officer; Nepal does not', () async {
      final india = LegalRepositoryImpl(
        const MockLegalDataSource(
          regionResolver: FixedRegionResolver(Region.india),
        ),
      );
      final doc = (await india.getDocument(
        LegalDocumentType.privacyPolicy,
      )).valueOrNull!;
      // 1, 1.1, 1.2, 2–8 (10) + data law + grievance officer + contact.
      expect(doc.sections.length, 13);
      expect(
        doc.sections[10].body.en,
        contains('Digital Personal Data Protection Act, 2023'),
      );
      expect(doc.sections[11].heading.en, '10. Grievance Officer');
      expect(doc.sections[11].heading.hi, '१०. शिकायत अधिकारी');
      expect(
        doc.sections[11].body.en,
        contains('grievance.in@ourvirtualtribes.com'),
      );
      expect(doc.sections.last.heading.en, '11. Contact Us');

      final nepal = LegalRepositoryImpl(const MockLegalDataSource());
      final npDoc = (await nepal.getDocument(
        LegalDocumentType.privacyPolicy,
      )).valueOrNull!;
      expect(npDoc.sections.length, 12);
      expect(npDoc.sections[10].body.en, contains('Individual Privacy Act'));
      expect(npDoc.sections.last.heading.en, '10. Contact Us');
      expect(
        npDoc.sections.map((s) => s.heading.en),
        isNot(contains('10. Grievance Officer')),
      );
    });

    test(
      'Hindi: headings translated, body = Hindi summary + English text',
      () async {
        final doc = (await const MockLegalDataSource().fetch(
          LegalDocumentType.privacyPolicy,
        )).toEntity();
        for (final section in doc.sections) {
          expect(section.heading.hi, isNotNull, reason: section.heading.en);
        }
        final body = doc.sections[1].body;
        expect(body.resolve('hi'), startsWith('सारांश:'));
        expect(body.resolve('hi'), endsWith(body.en));
        expect(body.resolve('en'), body.en);
        expect(body.resolve('ne'), body.ne);
        // Section header without body has no Hindi body -> falls back to en.
        expect(doc.sections.first.body.resolve('hi'), '');
      },
    );

    test('maps exceptions to failures', () async {
      final ds = _MockDataSource();
      when(() => ds.fetch(any())).thenThrow(const NotFoundException());
      final repo = LegalRepositoryImpl(ds);
      final result = await repo.getDocument(LegalDocumentType.privacyPolicy);
      expect(result.failureOrNull, isA<NotFoundFailure>());
    });

    test('model round-trips through JSON', () async {
      const ds = MockLegalDataSource();
      final doc = await ds.fetch(LegalDocumentType.privacyPolicy);
      final copy = LegalDocumentModel.fromJson(doc.toJson());
      expect(copy, equals(doc));
      expect(copy.sections[1].heading.hi, doc.sections[1].heading.hi);
    });
  });
}
