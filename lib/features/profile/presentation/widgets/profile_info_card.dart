import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/user_profile.dart';
import '../l10n/profile_strings.dart';
import 'dob_format.dart';
import 'profile_section_card.dart';

/// "Gender / Horoscope / DOB / Birth Time / Birth place / Current Address /
/// Religion / Contact" card of the ABOUT tab. DOB shows the region's traditional date
/// (B.S. / Saka) alongside the Gregorian one.
class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({required this.profile, super.key});
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    String genderLabel(Gender? g) => switch (g) {
      Gender.female => s.female,
      Gender.male => s.male,
      Gender.other => s.other,
      null => s.notSet,
    };
    final zodiac = profile.zodiacSign;
    final zodiacLabel = zodiac == null
        ? s.notSet
        : zodiac.localName(context.languageCode);
    String v(String? value) => value == null || value.isEmpty
        ? s.notSet
        : localizeDigits(context, value);
    final dob = DobFormat.display(
      context,
      dobAd: profile.dobAd,
      stored: profile.dobBs,
    );

    return ProfileSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _Info(s.gender, genderLabel(profile.gender))),
              Expanded(child: _Info(s.horoscope, zodiacLabel)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _Info(s.dob, dob ?? s.notSet),
          const SizedBox(height: AppSpacing.sm),
          _Info(s.birthTime, v(profile.birthTime)),
          const SizedBox(height: AppSpacing.sm),
          _Info(s.birthPlace, v(profile.birthPlace)),
          const SizedBox(height: AppSpacing.sm),
          _Info(s.currentAddress, v(profile.address)),
          const SizedBox(height: AppSpacing.sm),
          _Info(s.religion, v(profile.religion)),
          const SizedBox(height: AppSpacing.sm),
          _Info(s.contact, v(profile.phone)),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            _Info(s.shortBio, profile.bio!),
          ],
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final t = context.textTheme;
    return RichText(
      text: TextSpan(
        style: t.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        children: [
          TextSpan(text: '$label: '),
          TextSpan(
            text: value,
            style: t.bodyMedium?.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
