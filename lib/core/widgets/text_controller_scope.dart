import 'package:flutter/material.dart';

/// Owns [TextEditingController]s for as long as the subtree is mounted.
///
/// For text fields inside a bottom sheet or dialog. The obvious pattern —
/// create the controllers, `await` the sheet, then dispose — is wrong in a way
/// that only shows up sometimes: `show()` resolves the moment `pop` is called,
/// while the sheet is still on screen playing its exit animation. Disposing
/// there leaves a live `TextFormField` holding a dead controller, and the next
/// frame throws *"A TextEditingController was used after being disposed"*.
///
/// Here the controllers belong to a widget, so Flutter disposes them when the
/// route is genuinely gone. Pass whatever the sheet collected back through
/// `Navigator.pop`, so nothing is read after it closes either.
///
/// ```dart
/// AppBottomSheet.show<String>(
///   context,
///   builder: (_) => TextControllerScope(
///     count: 1,
///     builder: (context, controllers) => AppBottomSheet(
///       actions: PrimaryButton(
///         onPressed: () => Navigator.of(context).pop(controllers.first.text),
///       ),
///       child: AppTextField(controller: controllers.first),
///     ),
///   ),
/// );
/// ```
class TextControllerScope extends StatefulWidget {
  const TextControllerScope({
    required this.count,
    required this.builder,
    super.key,
    this.initialValues,
  });

  /// How many controllers the subtree needs.
  final int count;

  /// Starting text, positionally. Shorter than [count] is fine; the rest start
  /// empty.
  final List<String>? initialValues;

  /// Rebuilt whenever a controller's text changes, so a submit button can be
  /// enabled from what has been typed without the caller wiring listeners.
  final Widget Function(
    BuildContext context,
    List<TextEditingController> controllers,
  )
  builder;

  @override
  State<TextControllerScope> createState() => _TextControllerScopeState();
}

class _TextControllerScopeState extends State<TextControllerScope> {
  late final List<TextEditingController> _controllers = [
    for (var i = 0; i < widget.count; i++)
      TextEditingController(
        text: (widget.initialValues?.length ?? 0) > i
            ? widget.initialValues![i]
            : '',
      ),
  ];

  @override
  void initState() {
    super.initState();
    // One listener each: the common case is a submit button that turns on once
    // a required field has something in it, and every sheet writing that by
    // hand is how one of them forgets.
    for (final controller in _controllers) {
      controller.addListener(_onChanged);
    }
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller
        ..removeListener(_onChanged)
        ..dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controllers);
}
