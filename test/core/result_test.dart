import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/repository_guard.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';

void main() {
  test('Result.fold and map behave', () {
    const Result<int> ok = Result.success(2);
    expect(ok.map((v) => v * 2).valueOrNull, 4);
    expect(ok.fold((_) => 'f', (v) => 's$v'), 's2');
    const Result<int> bad = Result.failure(ServerFailure('x'));
    expect(bad.isFailure, isTrue);
    expect(bad.map((v) => v * 2).failureOrNull, const ServerFailure('x'));
  });

  test('guard maps exceptions to failures', () async {
    expect(
      (await guard<int>(() => throw const NetworkException())).failureOrNull,
      isA<NetworkFailure>(),
    );
    expect(
      (await guard<int>(() => throw const CacheException())).failureOrNull,
      isA<CacheFailure>(),
    );
    expect(
      (await guard<int>(() => throw StateError('boom'))).failureOrNull,
      isA<UnknownFailure>(),
    );
    expect((await guard<int>(() => 7)).valueOrNull, 7);
  });
}
