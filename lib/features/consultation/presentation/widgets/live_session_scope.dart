import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/live_session_cubit.dart';

/// Provides a loaded [LiveSessionCubit] to one live-session screen.
///
/// The queue, chat and call screens each own their own instance rather than
/// sharing one: they are separate routes, and a cubit that outlived its route
/// would keep polling and billing after the user had navigated away.
class LiveSessionScope extends StatelessWidget {
  const LiveSessionScope({
    required this.consultationId,
    required this.child,
    super.key,
  });

  final String consultationId;
  final Widget child;

  @override
  Widget build(BuildContext context) => BlocProvider<LiveSessionCubit>(
    create: (_) => GetIt.I<LiveSessionCubit>(param1: consultationId)..load(),
    child: child,
  );
}
