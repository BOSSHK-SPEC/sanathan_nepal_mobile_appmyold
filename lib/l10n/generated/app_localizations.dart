import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ne.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('ne'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Sanatan Nepal'**
  String get appName;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navMarketplace.
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get navMarketplace;

  /// No description provided for @navHoroscope.
  ///
  /// In en, this message translates to:
  /// **'Horoscope'**
  String get navHoroscope;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navMenu;

  /// No description provided for @menuPatro.
  ///
  /// In en, this message translates to:
  /// **'Patro'**
  String get menuPatro;

  /// No description provided for @menuBazar.
  ///
  /// In en, this message translates to:
  /// **'Bazar'**
  String get menuBazar;

  /// No description provided for @menuNotification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get menuNotification;

  /// No description provided for @menuSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get menuSupport;

  /// No description provided for @menuSuvaSaits.
  ///
  /// In en, this message translates to:
  /// **'Suva Saits'**
  String get menuSuvaSaits;

  /// No description provided for @menuDateConverter.
  ///
  /// In en, this message translates to:
  /// **'Date Converter'**
  String get menuDateConverter;

  /// No description provided for @menuHoroscope.
  ///
  /// In en, this message translates to:
  /// **'Horoscope'**
  String get menuHoroscope;

  /// No description provided for @menuEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get menuEvents;

  /// No description provided for @menuForex.
  ///
  /// In en, this message translates to:
  /// **'FOREX'**
  String get menuForex;

  /// No description provided for @menuPanchanga.
  ///
  /// In en, this message translates to:
  /// **'Panchanga'**
  String get menuPanchanga;

  /// No description provided for @menuWeather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get menuWeather;

  /// No description provided for @menuAppointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get menuAppointment;

  /// No description provided for @menuWishlist.
  ///
  /// In en, this message translates to:
  /// **'Wishlist'**
  String get menuWishlist;

  /// No description provided for @menuSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get menuSettings;

  /// No description provided for @menuProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get menuProfile;

  /// No description provided for @menuChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get menuChat;

  /// No description provided for @menuAddProducts.
  ///
  /// In en, this message translates to:
  /// **'Add Products'**
  String get menuAddProducts;

  /// No description provided for @menuSellerProfile.
  ///
  /// In en, this message translates to:
  /// **'Seller Profile'**
  String get menuSellerProfile;

  /// No description provided for @menuMyProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get menuMyProfile;

  /// No description provided for @silentMode.
  ///
  /// In en, this message translates to:
  /// **'Silent Mode'**
  String get silentMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @nepali.
  ///
  /// In en, this message translates to:
  /// **'Nepali'**
  String get nepali;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get search;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @moreInfo.
  ///
  /// In en, this message translates to:
  /// **'More Info'**
  String get moreInfo;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'Nothing to show'**
  String get noData;

  /// No description provided for @advertisement.
  ///
  /// In en, this message translates to:
  /// **'ADVERTISEMENT'**
  String get advertisement;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @settingTabAds.
  ///
  /// In en, this message translates to:
  /// **'SETTING TAB ADS'**
  String get settingTabAds;

  /// No description provided for @homeBelowEventAds.
  ///
  /// In en, this message translates to:
  /// **'HOME BELOW EVENT ADS'**
  String get homeBelowEventAds;

  /// No description provided for @patroPageAds.
  ///
  /// In en, this message translates to:
  /// **'PATRO PAGE ADS'**
  String get patroPageAds;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @selectRegion.
  ///
  /// In en, this message translates to:
  /// **'Select your region'**
  String get selectRegion;

  /// No description provided for @regionNepal.
  ///
  /// In en, this message translates to:
  /// **'Nepal'**
  String get regionNepal;

  /// No description provided for @regionIndia.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get regionIndia;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get hindi;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose theme'**
  String get chooseTheme;

  /// No description provided for @menuBlogs.
  ///
  /// In en, this message translates to:
  /// **'Blogs'**
  String get menuBlogs;

  /// No description provided for @menuNews.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get menuNews;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hr ago'**
  String hoursAgo(int count);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// No description provided for @monthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} months ago'**
  String monthsAgo(int count);

  /// No description provided for @yearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} years ago'**
  String yearsAgo(int count);

  /// No description provided for @menuAstrologers.
  ///
  /// In en, this message translates to:
  /// **'Talk to Astrologer'**
  String get menuAstrologers;

  /// No description provided for @menuWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get menuWallet;

  /// No description provided for @menuConsultations.
  ///
  /// In en, this message translates to:
  /// **'My consultations'**
  String get menuConsultations;

  /// No description provided for @menuKundli.
  ///
  /// In en, this message translates to:
  /// **'Kundli'**
  String get menuKundli;

  /// No description provided for @menuReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get menuReports;

  /// No description provided for @menuPuja.
  ///
  /// In en, this message translates to:
  /// **'Online puja'**
  String get menuPuja;

  /// No description provided for @menuSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved items'**
  String get menuSaved;

  /// No description provided for @menuOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get menuOffers;

  /// No description provided for @menuOrders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get menuOrders;

  /// No description provided for @menuBecomeAstrologer.
  ///
  /// In en, this message translates to:
  /// **'Become an astrologer'**
  String get menuBecomeAstrologer;

  /// No description provided for @menuAstrologerConsole.
  ///
  /// In en, this message translates to:
  /// **'Astrologer console'**
  String get menuAstrologerConsole;

  /// No description provided for @addAPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add a photo'**
  String get addAPhoto;

  /// No description provided for @takeAPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takeAPhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @chooseAFile.
  ///
  /// In en, this message translates to:
  /// **'Choose a file'**
  String get chooseAFile;

  /// No description provided for @pdfOrImage.
  ///
  /// In en, this message translates to:
  /// **'PDF or image'**
  String get pdfOrImage;

  /// Largest file the current upload accepts
  ///
  /// In en, this message translates to:
  /// **'Max {size}'**
  String maxFileSize(String size);

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading…'**
  String get uploading;

  /// No description provided for @uploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed'**
  String get uploadFailed;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// Label of the year field in a date picker.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// Label of the month field in a date picker.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// Label of the day-of-month field in a date picker.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ne':
      return AppLocalizationsNe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
