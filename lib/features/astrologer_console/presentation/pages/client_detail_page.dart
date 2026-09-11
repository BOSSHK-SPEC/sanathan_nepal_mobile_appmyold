import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/relative_time.dart';
import '../../../../core/widgets/widgets.dart';
import '../cubit/clients_cubit.dart';
import '../l10n/console_strings.dart';

/// One client: their history, birth details and the astrologer's own notes.
class ClientDetailPage extends StatelessWidget {
  const ClientDetailPage({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ClientsCubit>()..load(),
    child: _ClientDetailView(clientId: clientId),
  );
}

class _ClientDetailView extends StatefulWidget {
  const _ClientDetailView({required this.clientId});

  final String clientId;

  @override
  State<_ClientDetailView> createState() => _ClientDetailViewState();
}

class _ClientDetailViewState extends State<_ClientDetailView> {
  final TextEditingController _notes = TextEditingController();
  bool _seeded = false;

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<ClientsCubit, ClientsState>(
      builder: (context, state) {
        final matches = state.all.where((c) => c.id == widget.clientId);
        final client = matches.isEmpty ? null : matches.first;

        // Seed the notes field once, so re-renders do not clobber typing.
        if (client != null && !_seeded) {
          _notes.text = client.notes;
          _seeded = true;
        }

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: client?.name ?? '', showBack: true),
          body: SafeArea(
            top: false,
            child: client == null
                ? const LoadingView()
                : ListView(
                    padding: const EdgeInsets.all(AppSpacing.pageGutter),
                    children: [
                      Center(
                        child: AppAvatar(
                          source: client.avatar,
                          name: client.name,
                          size: 76,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        children: [
                          Expanded(
                            child: StatTile(
                              label: s.sessions,
                              icon: Icons.forum_outlined,
                              value: _digits(context, client.sessionCount),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: StatTile(
                              label: s.lifetimeValue,
                              icon: Icons.payments_outlined,
                              valueWidget: MoneyText(
                                client.lifetimeValue,
                                style: context.textTheme.headlineMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppCard(
                        child: KeyValueList(
                          divided: true,
                          children: [
                            KeyValueRow(
                              label: s.lastSession,
                              value: relativeTime(
                                context,
                                client.lastSessionAt,
                              ),
                            ),
                            if (client.birthDetails != null)
                              KeyValueRow(
                                label: s.birthDetails,
                                value: client.birthDetails!,
                              ),
                            if (client.averageRating != null)
                              KeyValueRow(
                                label: s.yourRating,
                                valueWidget: RatingSummary(
                                  rating: client.averageRating!,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      AppTextField(
                        controller: _notes,
                        label: s.privateNotes,
                        hint: s.notesHint,
                        maxLines: 6,
                        minLines: 4,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      PrimaryButton(
                        label: s.saveNotes,
                        height: 46,
                        onPressed: () async {
                          await context.read<ClientsCubit>().saveNotes(
                            client.id,
                            _notes.text,
                          );
                          if (context.mounted) {
                            AppSnack.success(context, s.saveNotes);
                          }
                        },
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}
