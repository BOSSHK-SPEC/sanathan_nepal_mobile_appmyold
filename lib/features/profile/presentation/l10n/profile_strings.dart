import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';

part 'profile_strings_en.dart';
part 'profile_strings_hi.dart';
part 'profile_strings_ne.dart';

/// Returns [value] with Devanagari digits when the app language uses them
/// (Nepali / Hindi).
String localizeDigits(BuildContext context, String value) =>
    context.usesDevanagariDigits ? value.toDevanagariDigits() : value;

/// Feature-local strings (English / Nepali / Hindi) for the profile feature.
abstract class ProfileStrings {
  const ProfileStrings();

  static ProfileStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  // Header
  String get profile;
  String get editProfile;
  String get completeYourProfile;
  String get logout;
  String get logoutTitle;
  String get logoutMessage;
  String get verified;
  String get notVerified;

  // Tabs
  String get about;
  String get activities;
  String get notifications;
  String get links;

  // About
  String get gender;
  String get horoscope;
  String get dob;
  String get birthTime;
  String get birthPlace;
  String get currentAddress;
  String get contact;
  String get shortBio;
  String get preferences;
  String get language;
  String get theme;
  String get english;
  String get nepali;
  String get dark;
  String get light;
  String get favourite;
  String get yourFavouriteProducts;
  String get noFavourites;
  String get male;
  String get female;
  String get other;
  String get notSet;

  // Activities
  String get myAppointments;
  String get myOrders;
  String get noAppointments;
  String get bookAppointmentNow;
  String get noOrdersYet;
  String get noOngoingOrders;
  String get browseProducts;
  String get userMyPurchase;
  String get sellerMySales;
  String get orderPlaced;
  String get orderApproved;
  String get purchaseCompleted;
  String get orderCancelled;
  String get newOrderReceived;
  String get processingOrderTo;
  String get soldTo;
  String get processing;
  String get completed;
  String get sold;
  String get cancelled;
  String get cancelOrder;
  String get accept;
  String get cancel;
  String get complete;
  String get call;
  String get chat;
  String get rateThisProduct;
  String get visitSellerProfile;
  String get from;
  String get to;
  String get sellingPrice;
  String youHaveAppointmentWith(String service, String doctor);
  String ago(String value);
  String get minutes;
  String get hours;
  String get days;
  String get justNow;

  // Notifications
  String get notificationSettings;
  String get horoscopeNotificationSetting;
  String get daily;
  String get monthly;
  String get yearly;
  String get notificationTime;
  String get festivalsNotificationSetting;
  String get importantHinduFestivals;
  String get commonFestivals;
  String get publicHolidays;
  String get remindMeBefore;
  String get daysAt;
  String get birthdayNotificationSetting;
  String get noNotifications;

  // Links
  String get usefulLinks;
  String get helpSupport;
  String get termsConditions;
  String get privacyPolicy;
  String get deleteAccount;

  // Support page
  String get supportIntro;
  String get contactUs;
  String get callUs;
  String get emailUs;
  String get whatsapp;
  String get faq;
  List<({String q, String a})> get faqItems;

  // Edit profile
  String get profilePhoto;
  String get noFileChosen;
  String get chooseFile;
  String get fullName;
  String get email;
  String get phoneNumber;
  String get religion;

  /// "Date of Birth (B.S.)" / "Date of Birth (Saka)" – [era] comes from the
  /// active `TraditionalCalendar.eraLabel`.
  String dobIn(String era);
  String get dobAd;

  /// Short Gregorian era label shown next to AD dates ("A.D." / "ई.सं.").
  String get eraAd;
  String get selectHoroscope;
  String get save;
  String get saveChanges;
  String get profileSaved;
  String get required;
  String get invalidEmail;

  // Delete popup
  String get deleteTitle;
  String get deleteMessage;
  String get deleteAccountMessage;
  String get delete;

  // Business profile
  String get businessProfile;
  String get services;
  String get products;
  String get reviews;
  String get contactTab;
  String get aboutTab;
  String get allProducts;
  String productsFound(String count);
  String get customerReviews;
  String basedOnReviews(String count);
  String get recommended;
  String get ratings;
  String get review;
  String get writeReview;
  String get message;
  String get sendMessage;
  String get follow;
  String get following;
  String get website;
  String get officeLocation;
  String get viewOnGoogleMap;
  String get workingHours;
  String get helpful;
  String get approve;
  String get reject;
  String get approved;
  String get rejected;
  String get pendingApproval;
  String get adminActions;
  String get addNewProduct;
  String get addOtherServices;
  String get editBusiness;
  String get noItems;

  /// Explains that the registration form's item list is what the reviewer
  /// reads, not the shop's public catalogue.
  String get itemsAreForReview;
  String get noReviews;

  // Business form
  String get businessForm;
  String get businessDetails;
  String get productsServicesDetails;
  String get businessName;
  String get businessType;
  String get websiteUrl;
  String get whatsappNumber;
  String get googleMapLink;
  String get businessDescription;
  String get documents;
  String get uploadDocument;
  String get itemTitle;
  String get itemDescription;
  String get itemPrice;
  String get itemCategory;
  String get isService;
  String get fixed;
  String get variable;
  String get negotiable;
  String get yes;
  String get no;
  String get addProductPhotos;
  String get pngJpegHint;

  /// Names an attached document, which is stored by id and has no name.
  String documentNumber(int index);

  String get discardChanges;
  String get discardChangesMessage;
  String get discard;
  String get keepEditing;
  String get addItem;
  String get next;
  String get back;
  String get submit;
  String get submitted;
  String get submittedMessage;

  // Seller / admin
  String get myBusiness;
  String get addresses;
  String get security;
  String get dataPrivacy;
  String get rateYourPurchases;
  String get savedProducts;
  String get followingAstrologers;
  String get inviteFriends;
  String get becomeAstrologer;
  String get astrologerConsole;
  String get adminBusinessApprovals;
  String get businessApprovals;
  String get pending;
  String get all;
  String get noBusinesses;
  String get sellerApproval;
  String get approveMessage;
  String get rejectMessage;
  String get rejectionReason;
  String get adminNote;
  String get statusLabel;
  String get submittedForApproval;
  String get submittedForApprovalMessage;
  String get ok;
  String get addNewCategory;
  String get newCategoryName;
  String get purchaseLink;
  String get tiktokLink;
  String get youtubeLink;
  String get remove;
  String get viewBusiness;
  String get ownerHint;
  String get postProductsNote;
}
