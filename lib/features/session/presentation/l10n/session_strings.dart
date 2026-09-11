import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/session/app_role.dart';

/// Feature-local strings for the session / role-switching UI.
abstract class SessionStrings {
  const SessionStrings();

  static SessionStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  String get viewingAs;
  String get switchRole;
  String get becomeAstrologer;
  String get becomeAstrologerBody;
  String get switchRoleSubtitle;
  String get noAccessTitle;
  String get noAccessMessage;
  String get goBack;
  String get signInRequired;
  String get signInMessage;
  String get signIn;

  String roleName(AppRole role);
  String roleDescription(AppRole role);
}

class _En extends SessionStrings {
  const _En();
  @override
  String get becomeAstrologer => 'Become an astrologer';
  @override
  String get becomeAstrologerBody =>
      'Take consultations on your own schedule and set your own rates';
  @override
  String get viewingAs => 'Viewing as';
  @override
  String get switchRole => 'Switch role';
  @override
  String get switchRoleSubtitle => 'Choose which side of the app to use';
  @override
  String get noAccessTitle => 'You do not have access';
  @override
  String get noAccessMessage =>
      'This screen is limited to a role your account does not hold.';
  @override
  String get goBack => 'Go back';
  @override
  String get signInRequired => 'Sign in to continue';
  @override
  String get signInMessage =>
      'Create an account or sign in to use this feature.';
  @override
  String get signIn => 'Sign in';
  @override
  String roleName(AppRole role) => switch (role) {
    AppRole.seeker => 'Personal',
    AppRole.astrologer => 'Astrologer',
    AppRole.merchant => 'Business',
    AppRole.moderator => 'Moderator',
    AppRole.finance => 'Finance',
    AppRole.support => 'Support',
    AppRole.superAdmin => 'Administrator',
  };
  @override
  String roleDescription(AppRole role) => switch (role) {
    AppRole.seeker => 'Browse, consult and shop',
    AppRole.astrologer => 'Take consultations and manage your schedule',
    AppRole.merchant => 'Manage your products and orders',
    AppRole.moderator => 'Review businesses and reported content',
    AppRole.finance => 'Payouts, refunds and reconciliation',
    AppRole.support => 'Answer tickets and help users',
    AppRole.superAdmin => 'Full access to every tool',
  };
}

class _Ne extends SessionStrings {
  const _Ne();
  @override
  String get becomeAstrologer => 'ज्योतिषी बन्नुहोस्';
  @override
  String get becomeAstrologerBody => 'आफ्नै समय र दरअनुसार परामर्श दिनुहोस्';
  @override
  String get viewingAs => 'यसरी हेर्दै';
  @override
  String get switchRole => 'भूमिका बदल्नुहोस्';
  @override
  String get switchRoleSubtitle => 'एपको कुन पक्ष प्रयोग गर्ने छान्नुहोस्';
  @override
  String get noAccessTitle => 'तपाईंलाई पहुँच छैन';
  @override
  String get noAccessMessage =>
      'यो स्क्रिन तपाईंको खातामा नभएको भूमिकाका लागि मात्र हो ।';
  @override
  String get goBack => 'फर्कनुहोस्';
  @override
  String get signInRequired => 'जारी राख्न साइन इन गर्नुहोस्';
  @override
  String get signInMessage =>
      'यो सुविधा प्रयोग गर्न खाता खोल्नुहोस् वा साइन इन गर्नुहोस् ।';
  @override
  String get signIn => 'साइन इन';
  @override
  String roleName(AppRole role) => switch (role) {
    AppRole.seeker => 'व्यक्तिगत',
    AppRole.astrologer => 'ज्योतिषी',
    AppRole.merchant => 'व्यवसाय',
    AppRole.moderator => 'मध्यस्थकर्ता',
    AppRole.finance => 'वित्त',
    AppRole.support => 'सहयोग',
    AppRole.superAdmin => 'प्रशासक',
  };
  @override
  String roleDescription(AppRole role) => switch (role) {
    AppRole.seeker => 'हेर्नुहोस्, परामर्श लिनुहोस् र किन्नुहोस्',
    AppRole.astrologer => 'परामर्श लिनुहोस् र तालिका मिलाउनुहोस्',
    AppRole.merchant => 'आफ्ना सामान र अर्डर व्यवस्थापन गर्नुहोस्',
    AppRole.moderator => 'व्यवसाय र उजुरी समीक्षा गर्नुहोस्',
    AppRole.finance => 'भुक्तानी, फिर्ता र हिसाब मिलान',
    AppRole.support => 'टिकट जवाफ दिनुहोस् र सहयोग गर्नुहोस्',
    AppRole.superAdmin => 'सबै उपकरणमा पूर्ण पहुँच',
  };
}

class _Hi extends SessionStrings {
  const _Hi();
  @override
  String get becomeAstrologer => 'ज्योतिषी बनें';
  @override
  String get becomeAstrologerBody => 'अपने समय और दर के अनुसार परामर्श दें';
  @override
  String get viewingAs => 'इस रूप में देख रहे हैं';
  @override
  String get switchRole => 'भूमिका बदलें';
  @override
  String get switchRoleSubtitle => 'चुनें कि ऐप का कौन-सा हिस्सा उपयोग करना है';
  @override
  String get noAccessTitle => 'आपके पास पहुँच नहीं है';
  @override
  String get noAccessMessage =>
      'यह स्क्रीन उस भूमिका के लिए है जो आपके खाते में नहीं है।';
  @override
  String get goBack => 'वापस जाएँ';
  @override
  String get signInRequired => 'जारी रखने के लिए साइन इन करें';
  @override
  String get signInMessage =>
      'इस सुविधा का उपयोग करने के लिए खाता बनाएँ या साइन इन करें।';
  @override
  String get signIn => 'साइन इन';
  @override
  String roleName(AppRole role) => switch (role) {
    AppRole.seeker => 'व्यक्तिगत',
    AppRole.astrologer => 'ज्योतिषी',
    AppRole.merchant => 'व्यवसाय',
    AppRole.moderator => 'मॉडरेटर',
    AppRole.finance => 'वित्त',
    AppRole.support => 'सहायता',
    AppRole.superAdmin => 'प्रशासक',
  };
  @override
  String roleDescription(AppRole role) => switch (role) {
    AppRole.seeker => 'देखें, परामर्श लें और खरीदें',
    AppRole.astrologer => 'परामर्श लें और अपना समय प्रबंधित करें',
    AppRole.merchant => 'अपने उत्पाद और ऑर्डर प्रबंधित करें',
    AppRole.moderator => 'व्यवसाय और रिपोर्ट की समीक्षा करें',
    AppRole.finance => 'भुगतान, रिफंड और मिलान',
    AppRole.support => 'टिकट का उत्तर दें और मदद करें',
    AppRole.superAdmin => 'सभी टूल तक पूर्ण पहुँच',
  };
}
