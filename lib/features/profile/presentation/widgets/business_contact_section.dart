import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/system/external_links.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_snack.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../messaging/presentation/cubit/business_contact_cubit.dart';
import '../../../messaging/presentation/l10n/messaging_strings.dart';
import '../../domain/entities/business_profile.dart';
import '../l10n/profile_strings.dart';
import 'profile_section_card.dart';
import 'small_gradient_button.dart';

/// "Contact" tab: email / location / phone rows, Call · Chat · WhatsApp
/// hand-offs and the "Send Message" enquiry form.
///
/// Every action here reaches something real: Call and WhatsApp hand off to the
/// phone, Chat opens the conversation with this shop, and the form posts an
/// enquiry that lands in the owner's inbox.
class BusinessContactSection extends StatelessWidget {
  const BusinessContactSection({required this.business, super.key});
  final BusinessProfile business;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<BusinessContactCubit>(param1: business.id),
    child: _ContactView(business: business),
  );
}

class _ContactView extends StatefulWidget {
  const _ContactView({required this.business});
  final BusinessProfile business;

  @override
  State<_ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<_ContactView> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final s = MessagingStrings.of(context);
    if (_message.text.trim().isEmpty) {
      AppSnack.error(context, s.messageRequired);
      return;
    }

    final cubit = context.read<BusinessContactCubit>();
    final thread = await cubit.send(
      body: _message.text,
      name: _name.text,
      email: _email.text,
    );
    if (!mounted) return;

    if (thread == null) {
      // The cubit holds the failure; the banner under the form explains it and
      // the text stays in the box so nothing the user typed is thrown away.
      AppSnack.error(context, cubit.state.errorMessage ?? s.failedToSend);
      return;
    }

    _message.clear();
    AppSnack.show(
      context,
      s.messageSent,
      actionLabel: s.viewConversation,
      onAction: () => context.push(AppRoutes.messageThreadPath(thread.id)),
    );
  }

  /// A hand-off that no app can service is a dead end, so say so rather than
  /// letting the tap do nothing at all.
  Future<void> _handOff(Future<bool> Function() action, String label) async {
    final opened = await action();
    if (!opened && mounted) {
      AppSnack.error(context, '$label — ${context.l10n.somethingWentWrong}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final m = MessagingStrings.of(context);
    final colors = context.colors;
    final b = widget.business;

    return Column(
      children: [
        ProfileSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Row(
                Icons.mail_outline_rounded,
                b.email,
                onTap: b.email.isEmpty
                    ? null
                    : () => _handOff(
                        () => ExternalLinks.email(b.email, subject: b.name),
                        b.email,
                      ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _Row(
                Icons.location_on_outlined,
                b.address,
                onTap: b.mapLink.isEmpty
                    ? null
                    : () => _handOff(
                        () => ExternalLinks.website(b.mapLink),
                        b.address,
                      ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _Row(
                Icons.call_outlined,
                localizeDigits(context, b.phone),
                onTap: b.phone.isEmpty
                    ? null
                    : () => _handOff(() => ExternalLinks.call(b.phone), s.call),
              ),
              if (b.website.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                _Row(
                  Icons.language,
                  b.website,
                  onTap: () => _handOff(
                    () => ExternalLinks.website(b.website),
                    b.website,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  if (b.phone.isNotEmpty)
                    SmallGradientButton(
                      label: s.call,
                      icon: Icons.call,
                      height: 30,
                      onPressed: () =>
                          _handOff(() => ExternalLinks.call(b.phone), s.call),
                    ),
                  SmallGradientButton(
                    label: s.chat,
                    icon: Icons.mark_chat_unread_outlined,
                    height: 30,
                    onPressed: () =>
                        context.push(AppRoutes.businessMessageThreadPath(b.id)),
                  ),
                  if (b.whatsapp.isNotEmpty)
                    SmallGradientButton(
                      label: s.whatsapp,
                      icon: Icons.chat_outlined,
                      height: 30,
                      color: colors.success,
                      onPressed: () => _handOff(
                        () => ExternalLinks.whatsapp(b.whatsapp),
                        s.whatsapp,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        ProfileSectionCard(
          title: m.sendMessage,
          child: BlocBuilder<BusinessContactCubit, BusinessContactState>(
            builder: (context, state) {
              final thread = state.sentThread;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    controller: _name,
                    hint: m.yourName,
                    onChanged: (_) =>
                        context.read<BusinessContactCubit>().dismissError(),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppTextField(
                    controller: _email,
                    hint: m.yourEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppTextField(
                    controller: _message,
                    hint: m.message,
                    maxLines: 3,
                    onChanged: (_) =>
                        context.read<BusinessContactCubit>().dismissError(),
                  ),
                  if (state.errorMessage case final error?) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      error,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: m.sendMessage,
                    height: 36,
                    isLoading: state.isSending,
                    onPressed: state.isSending ? null : _send,
                  ),
                  if (thread != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      m.messageSentBody,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Center(
                      child: TextButton(
                        onPressed: () => context.push(
                          AppRoutes.messageThreadPath(thread.id),
                        ),
                        child: Text(m.viewConversation),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.icon, this.value, {this.onTap});
  final IconData icon;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tappable = onTap != null && value.isNotEmpty;
    return InkWell(
      onTap: tappable ? onTap : null,
      child: Row(
        children: [
          Icon(icon, size: 16, color: colors.accent),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              value.isEmpty ? '—' : value,
              style: context.textTheme.bodyMedium?.copyWith(
                color: tappable ? colors.accent : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
