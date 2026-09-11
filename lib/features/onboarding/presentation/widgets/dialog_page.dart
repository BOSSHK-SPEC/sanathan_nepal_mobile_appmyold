import 'package:flutter/material.dart';

/// A go_router [Page] that presents its child as a Material dialog, so popup
/// screens (OTP) can still live at a real route (`AppRoutes.otp`).
class DialogPage<T> extends Page<T> {
  const DialogPage({
    required this.builder,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    this.barrierDismissible = true,
    this.barrierColor,
  });

  final WidgetBuilder builder;
  final bool barrierDismissible;
  final Color? barrierColor;

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
    context: context,
    settings: this,
    builder: builder,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor ?? Colors.black54,
  );
}
