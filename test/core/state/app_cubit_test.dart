import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/state/app_cubit.dart';

class _CounterCubit extends AppCubit<int> {
  _CounterCubit() : super(0);

  /// Stands in for every load in the app: emit, await I/O, emit again. The
  /// user closing the screen lands between the two.
  Future<void> load() async {
    emit(1);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    emit(2);
  }
}

void main() {
  test('a state emitted after close is dropped, not thrown', () async {
    final cubit = _CounterCubit();
    final pending = cubit.load();

    await cubit.close();
    // Base Cubit.emit throws StateError here — which surfaces as an unhandled
    // exception on an ordinary "open a tab and go back" interaction.
    await expectLater(pending, completes);
    expect(cubit.state, 1);
  });

  test('states still flow normally while open', () async {
    final cubit = _CounterCubit();
    final seen = <int>[];
    final subscription = cubit.stream.listen(seen.add);

    await cubit.load();
    await Future<void>.delayed(Duration.zero);

    expect(seen, [1, 2]);
    await subscription.cancel();
    await cubit.close();
  });
}
