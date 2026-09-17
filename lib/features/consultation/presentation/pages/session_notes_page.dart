import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/session_summary.dart';
import '../cubit/astrologer_session_cubit.dart';
import '../l10n/consultation_strings.dart';

/// The astrologer's write-up: notes and remedies.
///
/// This is the other half of the seeker's summary screen — everything typed
/// here is what they read afterwards, and the remedies with a product
/// attached are what turn a consultation into a purchase.
class SessionNotesPage extends StatelessWidget {
  const SessionNotesPage({required this.consultationId, super.key});

  final String consultationId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) =>
        GetIt.I<AstrologerSessionCubit>(param1: consultationId)..load(),
    child: const _NotesView(),
  );
}

class _NotesView extends StatefulWidget {
  const _NotesView();

  @override
  State<_NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<_NotesView> {
  final TextEditingController _notes = TextEditingController();

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  IconData _icon(RemedyKind kind) => switch (kind) {
    RemedyKind.gemstone => Icons.diamond_outlined,
    RemedyKind.mantra => Icons.record_voice_over_outlined,
    RemedyKind.puja => Icons.local_fire_department_outlined,
    RemedyKind.donation => Icons.volunteer_activism_outlined,
    RemedyKind.fasting => Icons.no_food_outlined,
    RemedyKind.practice => Icons.self_improvement_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);
    final colors = context.colors;

    return BlocConsumer<AstrologerSessionCubit, AstrologerSessionState>(
      listenWhen: (p, n) => p.savingNotes != n.savingNotes,
      listener: (context, state) {
        if (state.savingNotes.isLoaded) {
          AppSnack.success(context, s.writeUpSaved);
          context.go(AppRoutes.astrologerHome);
        } else if (state.savingNotes.isFailed) {
          AppSnack.error(
            context,
            state.savingNotes.errorMessage ?? context.l10n.somethingWentWrong,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AstrologerSessionCubit>();

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(
            title: s.writeUp,
            leading: IconButton(
              icon: Icon(Icons.close_rounded, color: colors.icon),
              onPressed: () => context.go(AppRoutes.astrologerHome),
            ),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                Text(
                  s.writeUpBody,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _notes,
                  label: s.notesLabel,
                  hint: s.notesHint,
                  maxLines: 8,
                  minLines: 5,
                  onChanged: cubit.setNotes,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${state.notes.trim().length} / 20',
                  textAlign: TextAlign.end,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: state.notes.trim().length >= 20
                        ? colors.success
                        : colors.textMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.remedies,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => _addRemedy(context, cubit),
                      icon: const Icon(Icons.add_rounded, size: 16),
                      label: Text(s.addRemedy),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                if (state.remedies.isEmpty)
                  Text(
                    s.noRemedies,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  )
                else
                  for (var i = 0; i < state.remedies.length; i++)
                    AppCard(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.accent.withValues(alpha: 0.12),
                            ),
                            child: Icon(
                              _icon(state.remedies[i].kind),
                              size: 16,
                              color: colors.accent,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.remedies[i].title.en,
                                  style: context.textTheme.titleSmall,
                                ),
                                Text(
                                  state.remedies[i].description.en,
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: colors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close_rounded,
                              size: 18,
                              color: colors.iconMuted,
                            ),
                            onPressed: () => cubit.removeRemedy(i),
                          ),
                        ],
                      ),
                    ),
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: s.saveWriteUp,
                  height: 46,
                  isLoading: state.savingNotes.isLoading,
                  onPressed: state.canSaveNotes ? cubit.saveNotes : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                SecondaryButton(
                  label: s.skipWriteUp,
                  onPressed: () => context.go(AppRoutes.astrologerHome),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _addRemedy(
    BuildContext context,
    AstrologerSessionCubit cubit,
  ) async {
    final draft = await AppBottomSheet.show<_RemedyDraft>(
      context,
      builder: (_) => const _RemedySheet(),
    );

    // Everything the sheet collected comes back in the result. Nothing is read
    // out of a controller after the sheet has closed, which is what used to
    // crash: the controllers were disposed the moment `show` resolved, while
    // the sheet was still rendering its exit animation, leaving a live
    // TextFormField holding a disposed controller.
    if (draft == null || !context.mounted) return;
    if (draft.title.trim().isEmpty) return;
    cubit.addRemedy(draft.kind, draft.title, draft.description);
  }
}

/// What the "add remedy" sheet collected.
@immutable
class _RemedyDraft {
  const _RemedyDraft({
    required this.kind,
    required this.title,
    required this.description,
  });

  final RemedyKind kind;
  final String title;
  final String description;
}

/// The "add remedy" sheet.
///
/// A widget rather than a closure so it owns its controllers: Flutter disposes
/// them when the route is genuinely gone, not when `show()` resolves — which
/// happens the instant `pop` is called, with the sheet still on screen and
/// still animating out.
class _RemedySheet extends StatefulWidget {
  const _RemedySheet();

  @override
  State<_RemedySheet> createState() => _RemedySheetState();
}

class _RemedySheetState extends State<_RemedySheet> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  RemedyKind _kind = RemedyKind.mantra;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  bool get _canAdd => _title.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final s = ConsultationStrings.of(context);

    return AppBottomSheet(
      title: s.addRemedy,
      actions: PrimaryButton(
        label: s.addLabel,
        height: 46,
        onPressed: _canAdd
            ? () => Navigator.of(context).pop(
                _RemedyDraft(
                  kind: _kind,
                  title: _title.text,
                  description: _description.text,
                ),
              )
            : null,
      ),
      // Scrollable: two fields and a soft keyboard do not fit a short sheet on
      // a small screen, and a fixed one simply overflows when it opens.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final option in RemedyKind.values)
                ChoiceChip(
                  label: Text(s.remedyKind(option)),
                  selected: _kind == option,
                  onSelected: (_) => setState(() => _kind = option),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _title,
            label: s.remedyTitle,
            required: true,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _description,
            label: s.remedyDescription,
            maxLines: 3,
            minLines: 2,
          ),
        ],
      ),
    );
  }
}
