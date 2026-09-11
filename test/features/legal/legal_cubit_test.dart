import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/data/datasources/legal_seed_privacy.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/domain/entities/legal_document.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/domain/usecases/get_legal_document.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/presentation/cubit/legal_cubit.dart';

class _MockGetLegalDocument extends Mock implements GetLegalDocument {}

void main() {
  late _MockGetLegalDocument getDocument;

  setUp(() => getDocument = _MockGetLegalDocument());

  blocTest<LegalCubit, LegalState>(
    'emits [loading, success] when document loads',
    build: () {
      when(
        () => getDocument(LegalDocumentType.privacyPolicy),
      ).thenAnswer((_) async => Result.success(privacyPolicySeed));
      return LegalCubit(getDocument);
    },
    act: (cubit) => cubit.load(LegalDocumentType.privacyPolicy),
    expect: () => [
      const LegalState(document: LoadState.loading()),
      LegalState(document: LoadState.loaded(privacyPolicySeed)),
    ],
  );

  blocTest<LegalCubit, LegalState>(
    'emits [loading, failure] on error',
    build: () {
      when(
        () => getDocument(LegalDocumentType.termsConditions),
      ).thenAnswer((_) async => const Result.failure(ServerFailure('boom')));
      return LegalCubit(getDocument);
    },
    act: (cubit) => cubit.load(LegalDocumentType.termsConditions),
    expect: () => const [
      LegalState(document: LoadState.loading()),
      LegalState(document: LoadState.failed(ServerFailure('boom'))),
    ],
  );
}
