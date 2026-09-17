import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';

import '../../domain/entities/product_review.dart';

part 'marketplace_strings_en.dart';
part 'marketplace_strings_hi.dart';
part 'marketplace_strings_ne.dart';

/// Feature-local trilingual (English / Nepali / Hindi) strings for the
/// marketplace.
abstract class MarketplaceStrings {
  const MarketplaceStrings();

  static MarketplaceStrings of(BuildContext context) => context.isHindi
      ? const _Hi()
      : context.isNepali
      ? const _Ne()
      : const _En();

  String get marketplace;
  String get all;
  String get viewAll;
  String get boostedPost;
  String get boostPostToSellQuickly;
  String get myProductsAndServices;
  String get boostAds;
  String get boostHeadline;
  String get boostBody;
  String get boostAnalytics;
  String get selectYourProductService;
  String get checkout;
  String get sortBy;
  String get latest;
  String get priceLowToHigh;
  String get priceHighToLow;
  String get next;
  String get shoppingCart;
  String get boostYourListing;
  String productsSelected(int count);
  String get selectNumberOfHours;
  String hoursPlan(String hours, String price);
  String get firstName;
  String get lastName;
  String get phoneNumber;
  String get productServiceLink;
  String get linkToYourAd;
  String get total;
  String get esewaId;
  String get khaltiId;
  String get upiId;
  String get scanQrToPay;
  String get bankDetails;
  String get bankName;
  String get accountHolder;
  String get accountNumber;
  String get ifscCode;
  String get attachPaymentScreenshot;
  String get nonRefundable;
  String get uploadReceipt;
  String get selectFileOrDrop;
  String get selectFiles;
  String get boostNote;
  String get submit;
  String boostSubmitted(String ref);
  String get recent;
  String get recommendation;
  String get settingTabAds;
  String get search;
  String get searchProduct;
  String productsFound(int count);
  String get used;
  String get brandNew;
  String get ratingsAndReviews;
  String get allReviews;
  String get writeReview;
  String get editReview;
  String get rateThisProduct;
  String get yourRating;
  String get reviewCommentHint;
  String get addPhotos;
  String get submitReview;
  String get reviewThanks;
  String get noReviewsTitle;
  String get noReviewsBody;
  String get beTheFirst;
  String get verifiedPurchase;
  String get withPhotos;
  String get helpful;
  String get sellerReplied;
  String get replyToReview;
  String get replyHint;
  String get sendReply;
  String get replySent;
  String get rateYourPurchases;
  String get rateYourPurchasesBody;
  String get deliveredOn;
  String get rateIt;
  String get noPendingReviews;
  String reviewCount(int value);
  String starsLabel(int value);
  String reviewSortName(ReviewSort sort);
  String get savedProducts;
  String get noSavedTitle;
  String get noSavedBody;
  String get browseMarketplace;
  String get savedCount;
  String get noProducts;
  String get noMyProducts;
  String get selectAtLeastOne;
  String get requiredField;
  String get invalidPhone;
  String get invalidWebsite;
  // Details
  String get productDetails;
  String get description;
  String get comments;
  String get call;
  String get chat;
  String get order;
  String get addToCart;
  String get addedToCart;
  String get general;
  String get location;
  String get negotiable;

  /// A listing whose seller never named a figure.
  String get askForPrice;

  /// Why a pending shop cannot publish yet.
  String get listingsNeedApproval;

  /// Shown when the business *is* approved but this device still has
  /// no seller permission — a stale cached role, not a pending review.
  String get sellerAccessSyncing;
  String get notNegotiable;
  String get websiteLink;
  String get adsPosted;
  String get adsExpiry;
  String get seller;
  String get verifiedSeller;
  String get noComments;
  String get commentHint;
  String get reply;
  String get inspectionNote;
  String get similarProducts;

  /// "Please Quote Your Price (NPR)" – [currencyCode] from the region.
  String quoteYourPrice(String currencyCode);
  String finalPriceHint(String currencyCode);
  String get sendOrderRequest;
  String get orderRequestSent;
  String get cancel;
  String get confirm;
  // Cart
  String get myShoppingCart;
  String get subtotal;
  String get discount;
  String get shippingCosts;
  String get shipping;
  String get couponCode;
  String get applyCoupon;
  String get invalidCoupon;
  String get continueShopping;
  String get emptyCart;
  String get securePaymentsBy;
  // Checkout
  String get deliveryAndPayment;
  String get countryRegion;
  String get streetAddress;
  String get houseNumberHint;
  String get apartmentHint;
  String get townCity;
  String get province;
  String get state;
  String get postcode;
  String get phoneOptional;
  String get emailAddress;
  String get shipToDifferentAddress;
  String get orderNotes;
  String get orderNotesHint;
  String get confirmAddress;
  String get placeOrder;
  String get paymentMethod;
  String get esewa;
  String get khalti;
  String get bankTransfer;
  String get cashOnDelivery;
  String get upi;
  String get card;
  String get netBanking;
  String get orderConfirmed;
  String get status;
  String get paid;
  String get pending;
  String get orderNumber;
  String get backToMarketplace;
  String get viewOrder;
  // Details extras
  String get buyNow;
  String get share;
  String get favourite;
  String get linkCopied;
  String get edit;
  String get delete;
  String get productNotFound;
  String get productVideos;
  String get postedBy;
  String get sellerContact;
  // Seller form
  String get addProduct;
  String get editProduct;
  String get productTitle;
  String get productTitleLocal;
  String get category;
  String get selectCategory;
  String get editCategory;
  String get productCategoryName;
  String get categoryPhoto;
  String get save;
  String get update;
  String get price;
  String get condition;
  String get listingType;
  String get product;
  String get service;
  String get photos;
  String get addPhoto;

  /// Says plainly that a listing can be published without a photo.
  String get photosOptional;

  /// Clears every selected photo in one action.
  String get removeAllPhotos;

  /// Removes one photo. Deliberately not the generic "Delete": on a
  /// thumbnail that word reads as deleting the listing.
  String get removePhoto;

  /// Confirmation after the photos are cleared.
  String get photosRemoved;
  String get contactPhone;
  String get website;
  String get expiryDays;
  String get invalidPrice;
  String get invalidCategory;
  String get productSaved;
  String get productUpdated;
  String get productDeleted;
  String get deleteProductTitle;
  String get deleteProductMessage;
  String get myProductBadge;
  // Time
  String justNow();
  String minutesAgo(String n);
  String hoursAgo(String n);
  String daysAgo(String n);
}
