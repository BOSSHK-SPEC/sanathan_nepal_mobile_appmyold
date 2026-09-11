import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_role.dart';
import 'package:sanathan_nepal_mobile_app/core/session/role_granter.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/entities/application.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/domain/usecases/console_usecases.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologer_console/presentation/cubit/application_cubit.dart';

class _MockGet extends Mock implements GetApplication {}

class _MockSaveDraft extends Mock implements SaveApplicationDraft {}

class _MockUpload extends Mock implements UploadKycDocument {}

class _MockRemove extends Mock implements RemoveKycDocument {}

class _MockAcceptTerms extends Mock implements AcceptAstrologerTerms {}

class _MockSubmit extends Mock implements SubmitApplication {}

/// Records grants instead of writing them, so a test can assert the approval
/// actually reached the account.
class _RecordingGranter implements RoleGranter {
  final List<AppRole> granted = [];

  @override
  Future<void> grant(AppRole role) async => granted.add(role);

  @override
  Future<void> revoke(AppRole role) async {}
}

void main() {
  late _MockSaveDraft saveDraft;
  late List<AstrologerApplication> saved;

  setUpAll(() {
    registerFallbackValue(const AstrologerApplication());
    registerFallbackValue(
      const UploadKycParams(kind: KycDocumentKind.identityFront, fileRef: 'm'),
    );
    registerFallbackValue(KycDocumentKind.identityFront);
  });

  ApplicationCubit build() => ApplicationCubit(
    getApplication: _MockGet(),
    saveDraft: saveDraft,
    uploadDocument: _MockUpload(),
    removeDocument: _MockRemove(),
    acceptTerms: _MockAcceptTerms(),
    submit: _MockSubmit(),
    roles: const NoopRoleGranter(),
  );

  setUp(() {
    saved = [];
    saveDraft = _MockSaveDraft();
    when(() => saveDraft(any())).thenAnswer((invocation) async {
      final draft =
          invocation.positionalArguments.first as AstrologerApplication;
      saved.add(draft);
      return Result.success(draft);
    });
  });

  test('typing sends one draft, not one per keystroke', () async {
    final cubit = build();

    for (final text in ['R', 'Ra', 'Ram']) {
      cubit.setName(text);
    }
    // The field updates immediately regardless.
    expect(cubit.state.form.fullName, 'Ram');
    expect(saved, isEmpty);

    await Future<void>.delayed(
      ApplicationCubit.draftDebounce + const Duration(milliseconds: 120),
    );

    // One request carrying the final value. Before, each keystroke was its own
    // request and the responses raced — which is how a saved draft ended up
    // containing a single letter.
    expect(saved, hasLength(1));
    expect(saved.single.fullName, 'Ram');
    await cubit.close();
  });

  test('a response overtaken by newer typing is ignored', () async {
    var release = Completer<Result<AstrologerApplication>>();
    when(() => saveDraft(any())).thenAnswer((invocation) {
      saved.add(invocation.positionalArguments.first as AstrologerApplication);
      return release.future;
    });

    final cubit = build();
    cubit.setName('R');
    await Future<void>.delayed(
      ApplicationCubit.draftDebounce + const Duration(milliseconds: 60),
    );

    // Still typing while the first save is in flight.
    cubit.setName('Ram');
    release.complete(
      const Result.success(AstrologerApplication(fullName: 'R')),
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));

    // The stale response must not drag the field back to "R".
    expect(cubit.state.form.fullName, 'Ram');
    release = Completer();
    await cubit.close();
  });

  test('leaving a step flushes a pending draft', () async {
    final cubit = build();
    cubit.setName('Ram');

    await cubit.saveNow();

    expect(saved.single.fullName, 'Ram');
    await cubit.close();
  });

  test('a rejected draft is surfaced, keeping what was typed', () async {
    when(
      () => saveDraft(any()),
    ).thenAnswer((_) async => const Result.failure(ValidationFailure('nope')));
    final cubit = build();

    cubit.setName('Ram');
    await cubit.saveNow();

    expect(cubit.state.application.isFailed, isTrue);
    // Losing the text because the save failed would be the worse error.
    expect(cubit.state.form.fullName, 'Ram');
    await cubit.close();
  });

  group('failures reach the user', () {
    test('a rejected terms acceptance is surfaced', () async {
      final acceptTerms = _MockAcceptTerms();
      when(
        () => acceptTerms(any()),
      ).thenAnswer((_) async => const Result.failure(ServerFailure('nope')));
      final cubit = ApplicationCubit(
        getApplication: _MockGet(),
        saveDraft: saveDraft,
        uploadDocument: _MockUpload(),
        removeDocument: _MockRemove(),
        acceptTerms: acceptTerms,
        submit: _MockSubmit(),
        roles: const NoopRoleGranter(),
      );

      await cubit.acceptTerms();

      // Accepting the terms completes the final step. Swallowing the failure
      // left the box ticked and Submit disabled, with nothing to explain it.
      expect(cubit.state.application.isFailed, isTrue);
      await cubit.close();
    });

    test('a rejected document upload is surfaced', () async {
      final upload = _MockUpload();
      when(() => upload(any())).thenAnswer(
        (_) async => const Result.failure(ValidationFailure('bad kind')),
      );
      final cubit = ApplicationCubit(
        getApplication: _MockGet(),
        saveDraft: saveDraft,
        uploadDocument: upload,
        removeDocument: _MockRemove(),
        acceptTerms: _MockAcceptTerms(),
        submit: _MockSubmit(),
        roles: const NoopRoleGranter(),
      );

      await cubit.uploadDocument(KycDocumentKind.identityFront, 'media-1');

      expect(cubit.state.application.isFailed, isTrue);
      await cubit.close();
    });

    test('a rejected document removal is surfaced', () async {
      final remove = _MockRemove();
      when(() => remove(any())).thenAnswer(
        (_) async => const Result.failure(ValidationFailure('under review')),
      );
      final cubit = ApplicationCubit(
        getApplication: _MockGet(),
        saveDraft: saveDraft,
        uploadDocument: _MockUpload(),
        removeDocument: remove,
        acceptTerms: _MockAcceptTerms(),
        submit: _MockSubmit(),
        roles: const NoopRoleGranter(),
      );

      await cubit.removeDocument(KycDocumentKind.identityFront);

      expect(cubit.state.application.isFailed, isTrue);
      // The field must not be left spinning on a failure, or the only way out
      // of it is to leave the wizard.
      expect(cubit.state.removingDocument, isNull);
      await cubit.close();
    });
  });

  group('an approved application reaches the console', () {
    ApplicationCubit cubitFor(
      ApplicationStatus status,
      _RecordingGranter granter,
    ) {
      final get = _MockGet();
      when(get.call).thenAnswer(
        (_) async => Result.success(AstrologerApplication(status: status)),
      );
      return ApplicationCubit(
        getApplication: get,
        saveDraft: saveDraft,
        uploadDocument: _MockUpload(),
        removeDocument: _MockRemove(),
        acceptTerms: _MockAcceptTerms(),
        submit: _MockSubmit(),
        roles: granter,
      );
    }

    test(
      'reading an approved application grants the astrologer role',
      () async {
        final granter = _RecordingGranter();
        final cubit = cubitFor(ApplicationStatus.approved, granter);

        await cubit.load();

        // Without this the server approves, the local account stays a seeker,
        // and the console's route guard sends the new astrologer back to the
        // intro screen for the application they have just completed.
        expect(granter.granted, [AppRole.astrologer]);
        await cubit.close();
      },
    );

    test('an application still under review grants nothing', () async {
      final granter = _RecordingGranter();
      final cubit = cubitFor(ApplicationStatus.underReview, granter);

      await cubit.load();

      expect(granter.granted, isEmpty);
      await cubit.close();
    });

    test('claimConsoleAccess grants before the caller navigates', () async {
      final granter = _RecordingGranter();
      final cubit = cubitFor(ApplicationStatus.approved, granter);
      await cubit.load();
      granter.granted.clear();

      // The button awaits this precisely so the role is on the account before
      // the route guard reads the session.
      expect(await cubit.claimConsoleAccess(), isTrue);
      expect(granter.granted, [AppRole.astrologer]);
      await cubit.close();
    });

    test(
      'an already-approved application fires onApproved without waiting for a poll',
      () async {
        final granter = _RecordingGranter();
        final cubit = cubitFor(ApplicationStatus.approved, granter);
        await cubit.load();

        var approved = false;
        cubit.watchForDecision(onApproved: () => approved = true);

        // Approval usually lands while the app is closed, so there is no
        // transition to observe. Waiting for the first tick left a window in
        // which "Open console" bounced off its own guard.
        expect(approved, isTrue);
        await cubit.close();
      },
    );
  });

  group('discarding a document', () {
    test('a second tap while one is in flight is dropped', () async {
      final remove = _MockRemove();
      final gate = Completer<Result<AstrologerApplication>>();
      when(() => remove(any())).thenAnswer((_) => gate.future);

      final cubit = ApplicationCubit(
        getApplication: _MockGet(),
        saveDraft: saveDraft,
        uploadDocument: _MockUpload(),
        removeDocument: remove,
        acceptTerms: _MockAcceptTerms(),
        submit: _MockSubmit(),
        roles: const NoopRoleGranter(),
      );

      final first = cubit.removeDocument(KycDocumentKind.identityFront);
      expect(cubit.state.removingDocument, KycDocumentKind.identityFront);

      // The double tap. Without the guard this deletes a document the first
      // call has already removed, and the second server call fails on it.
      await cubit.removeDocument(KycDocumentKind.identityFront);

      gate.complete(const Result.success(AstrologerApplication()));
      await first;

      verify(() => remove(any())).called(1);
      expect(cubit.state.removingDocument, isNull);
      await cubit.close();
    });
  });
}
