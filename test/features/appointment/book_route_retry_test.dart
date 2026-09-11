import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// `setState` refuses a callback that returns a value, and an arrow body
/// returns whatever it evaluates to — so `setState(() => _future = _load())`
/// hands it a Future and throws the moment Retry is tapped.
///
/// This pins the shape rather than the page: the page needs a service locator
/// and a route, while the mistake is one line of Dart that any screen can
/// repeat.
void main() {
  testWidgets('assigning a Future inside an arrow setState throws', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: _Probe(arrow: true)));

    await tester.tap(find.text('retry'));
    await tester.pump();

    expect(tester.takeException(), isNotNull);
  });

  testWidgets('starting the work first, then assigning, is fine', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: _Probe(arrow: false)));

    await tester.tap(find.text('retry'));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}

class _Probe extends StatefulWidget {
  const _Probe({required this.arrow});

  final bool arrow;

  @override
  State<_Probe> createState() => _ProbeState();
}

class _ProbeState extends State<_Probe> {
  Future<int> _future = Future.value(1);

  Future<int> _load() => Future.value(2);

  void _retry() {
    if (widget.arrow) {
      // The bug, exactly as it was written.
      // ignore: avoid_returning_null_for_void
      setState(() => _future = _load());
      return;
    }
    // The fix: do the work first, then assign inside a *block* body — an
    // arrow would still evaluate to the Future it assigned.
    final next = _load();
    setState(() {
      _future = next;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Mirrors the page, which rebuilds a FutureBuilder off this field.
          FutureBuilder<int>(
            future: _future,
            builder: (context, snapshot) => Text('${snapshot.data ?? 0}'),
          ),
          TextButton(onPressed: _retry, child: const Text('retry')),
        ],
      ),
    ),
  );
}
