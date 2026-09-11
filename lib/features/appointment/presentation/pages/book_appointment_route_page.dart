import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../../domain/usecases/get_bookable_astrologer.dart';
import 'book_appointment_page.dart';

/// Deep-linkable entry point for the booking wizard.
///
/// [BookAppointmentPage] takes a fully loaded [BookableAstrologer] because it is
/// usually pushed from the astrologer profile, which already has one. A URL
/// only carries an id, so this page resolves the astrologer first — which is
/// what makes `/appointments/book/:astrologerId` survive a cold start, a
/// browser reload and a push-notification tap.
class BookAppointmentRoutePage extends StatefulWidget {
  const BookAppointmentRoutePage({
    required this.astrologerId,
    super.key,
    this.initialServiceId,
  });

  final String astrologerId;
  final String? initialServiceId;

  @override
  State<BookAppointmentRoutePage> createState() =>
      _BookAppointmentRoutePageState();
}

class _BookAppointmentRoutePageState extends State<BookAppointmentRoutePage> {
  late Future<Result<BookableAstrologer>> _future = _load();

  Future<Result<BookableAstrologer>> _load() =>
      GetIt.I<GetBookableAstrologer>()(widget.astrologerId);

  void _retry() {
    // A block body, not an arrow: `() => _future = _load()` evaluates to the
    // assigned value — a Future — and setState rejects a callback that returns
    // one. The work is started here and the field is assigned synchronously,
    // which is exactly what setState asks for.
    final next = _load();
    // A block body. `setState(() => _future = next)` is still an arrow, and it
    // evaluates to `next` — a Future — which is the very thing setState
    // rejects. The braces are what make the callback return void.
    setState(() {
      _future = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Result<BookableAstrologer>>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: SafeArea(child: LoadingView()));
        }
        return switch (snapshot.data!) {
          Success<BookableAstrologer>(:final value) => BookAppointmentPage(
            astrologer: value,
            initialServiceId: widget.initialServiceId,
          ),
          ResultFailure<BookableAstrologer>(:final failure) => Scaffold(
            appBar: AppTopBar(
              title: context.l10n.somethingWentWrong,
              showBack: true,
            ),
            body: SafeArea(
              child: ErrorView(message: failure.message, onRetry: _retry),
            ),
          ),
        };
      },
    );
  }
}
