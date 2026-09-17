part of 'profile_strings.dart';

class _En extends ProfileStrings {
  const _En();

  @override
  String get profile => 'Profile';
  @override
  String get editProfile => 'Edit Profile';
  @override
  String get completeYourProfile => 'Complete Your Profile';
  @override
  String get logout => 'Logout';
  @override
  String get logoutTitle => 'Log out?';
  @override
  String get logoutMessage => 'You will need to sign in again to continue.';
  @override
  String get verified => 'Verified';
  @override
  String get notVerified => 'Not verified';

  @override
  String get about => 'ABOUT';
  @override
  String get activities => 'ACTIVITIES';
  @override
  String get notifications => 'NOTIFICATIONS';
  @override
  String get links => 'LINKS';

  @override
  String get gender => 'Gender';
  @override
  String get horoscope => 'Horoscope';
  @override
  String get dob => 'DOB';
  @override
  String get birthTime => 'Birth Time';
  @override
  String get birthPlace => 'Birth place';
  @override
  String get currentAddress => 'Current Address';
  @override
  String get contact => 'Contact';
  @override
  String get shortBio => 'Short bio';
  @override
  String get preferences => 'Preferences';
  @override
  String get language => 'Language';
  @override
  String get theme => 'Theme';
  @override
  String get english => 'English';
  @override
  String get nepali => 'Nepali';
  @override
  String get dark => 'Dark';
  @override
  String get light => 'Light';
  @override
  String get favourite => 'Favourite';
  @override
  String get yourFavouriteProducts => 'Your Favorite Product & Services';
  @override
  String get noFavourites => 'You have not added any favourites yet.';
  @override
  String get male => 'Male';
  @override
  String get female => 'Female';
  @override
  String get other => 'Other';
  @override
  String get notSet => 'Not set';

  @override
  String get myAppointments => 'My Appointments';
  @override
  String get myOrders => 'My Orders';
  @override
  String get noAppointments => "You don't have any appointments booked.";
  @override
  String get bookAppointmentNow => 'Book Your Appointment Now!';
  @override
  String get noOrdersYet => 'No Orders Yet !!';
  @override
  String get noOngoingOrders =>
      "You don't have an ongoing orders at this time.";
  @override
  String get browseProducts => 'Browse Products';
  @override
  String get userMyPurchase => 'User: My Purchase';
  @override
  String get sellerMySales => 'Seller: My Sales';
  @override
  String get orderPlaced => 'Order Placed !';
  @override
  String get orderApproved => 'Order Approved by Seller !';
  @override
  String get purchaseCompleted => 'Product Purchase Completed !';
  @override
  String get orderCancelled => 'Order Cancelled';
  @override
  String get newOrderReceived => 'New Order Received !';
  @override
  String get processingOrderTo => 'Processing Order to';
  @override
  String get soldTo => 'Sold to';
  @override
  String get processing => 'Processing';
  @override
  String get completed => 'Completed';
  @override
  String get sold => 'Sold';
  @override
  String get cancelled => 'Cancelled';
  @override
  String get cancelOrder => 'Cancel Order';
  @override
  String get accept => 'Accept';
  @override
  String get cancel => 'Cancel';
  @override
  String get complete => 'Complete';
  @override
  String get markShipped => 'Mark Shipped';
  @override
  String get markDelivered => 'Mark Delivered';
  @override
  String get shipped => 'Shipped';
  @override
  String get outForDelivery => 'Out for delivery';
  @override
  String get awaitingSeller => 'Awaiting seller';
  @override
  String get call => 'Call';
  @override
  String get chat => 'Chat';
  @override
  String get rateThisProduct => 'Rate this Product:';
  @override
  String get visitSellerProfile => 'Visit Seller Profile';
  @override
  String get from => 'From';
  @override
  String get to => 'To';
  @override
  String get sellingPrice => 'S.P';
  @override
  String youHaveAppointmentWith(String service, String doctor) =>
      'You have $service Appointment with $doctor.';
  @override
  String ago(String value) => '$value ago';
  @override
  String get minutes => 'mins';
  @override
  String get hours => 'hours';
  @override
  String get days => 'day';
  @override
  String get justNow => 'Just now';

  @override
  String get notificationSettings => 'Notification Settings';
  @override
  String get horoscopeNotificationSetting => 'Horoscope Notification Setting';
  @override
  String get daily => 'Daily';
  @override
  String get monthly => 'Monthly';
  @override
  String get yearly => 'Yearly';
  @override
  String get notificationTime => 'Notification Time';
  @override
  String get festivalsNotificationSetting => 'Festivals Notification Setting';
  @override
  String get importantHinduFestivals => 'Important Hindu Festivals';
  @override
  String get commonFestivals => 'Common Festivals';
  @override
  String get publicHolidays => 'Public Holidays';
  @override
  String get remindMeBefore => 'Remind me before';
  @override
  String get daysAt => 'Days at';
  @override
  String get birthdayNotificationSetting => 'Birthday Notification Setting';
  @override
  String get noNotifications => 'No notifications yet.';

  @override
  String get usefulLinks => 'Useful Links';
  @override
  String get helpSupport => 'Help & Support';
  @override
  String get termsConditions => 'Terms & Conditions';
  @override
  String get privacyPolicy => 'Privacy Policy';
  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get supportIntro =>
      'We are here to help. Reach us through any of the channels below.';
  @override
  String get contactUs => 'Contact Us';
  @override
  String get callUs => 'Call Us';
  @override
  String get emailUs => 'Email Us';
  @override
  String get whatsapp => 'WhatsApp';
  @override
  String get faq => 'Frequently Asked Questions';
  @override
  List<({String q, String a})> get faqItems => const [
    (
      q: 'How do I change the app language or theme?',
      a:
          'Open Profile → About → Preferences and choose your region '
          '(Nepal/India), language and Dark/Light theme. The change '
          'applies instantly.',
    ),
    (
      q: 'How do I book an appointment?',
      a:
          'Go to Profile → Activities → My Appointments and tap '
          '"Book Your Appointment Now!", or use the Appointment menu.',
    ),
    (
      q: 'How can I list my business or products?',
      a:
          'Open the business form from the marketplace or your seller '
          'profile, fill in the details and submit for approval.',
    ),
    (
      q: 'How do I delete my account?',
      a:
          'Profile → Links → Delete Account. This removes your data from '
          'this device and signs you out.',
    ),
  ];

  @override
  String get profilePhoto => 'Profile photo';

  @override
  String get businessLogo => 'Business logo';

  @override
  String get businessBanner => 'Cover banner';

  @override
  String get addLogo => 'Add logo';

  @override
  String get addBanner => 'Add banner';

  @override
  String get changeLogo => 'Change logo';

  @override
  String get changeBanner => 'Change banner';

  @override
  String get removeLogo => 'Remove logo';

  @override
  String get removeBanner => 'Remove banner';

  @override
  String get brandingHint =>
      'Banner: a wide picture, about 3:1. Logo: square. JPG, PNG or WebP, up to 8 MB.';

  @override
  String get imageUpdated => 'Picture updated';
  @override
  String get noFileChosen => 'no files choosen';
  @override
  String get chooseFile => 'Choose';
  @override
  String get fullName => 'Full Name';
  @override
  String get email => 'Email';
  @override
  String get phoneNumber => 'Phone Number';
  @override
  String get religion => 'Religion';
  @override
  String dobIn(String era) => 'Date of Birth ($era)';
  @override
  String get dobAd => 'Date of Birth (A.D.)';
  @override
  String get eraAd => 'A.D.';
  @override
  String get selectHoroscope => 'Select horoscope';
  @override
  String get save => 'Save';
  @override
  String get saveChanges => 'Save Changes';
  @override
  String get profileSaved => 'Profile updated successfully';
  @override
  String get required => 'This field is required';
  @override
  String get invalidEmail => 'Enter a valid email';

  @override
  String get deleteTitle => 'Are you sure you want to delete?';
  @override
  String get deleteMessage => 'This action cannot be undone.';
  @override
  String get deleteAccountMessage =>
      'Your profile data will be removed from this device and you will be '
      'signed out.';
  @override
  String get delete => 'Delete';

  @override
  String get businessProfile => 'Business Profile';
  @override
  String get services => 'Services';
  @override
  String get products => 'Products';
  @override
  String get reviews => 'Reviews';
  @override
  String get contactTab => 'Contact';
  @override
  String get aboutTab => 'About';
  @override
  String get allProducts => 'All Products';
  @override
  String productsFound(String count) => '$count products found';
  @override
  String get customerReviews => 'Customer reviews';
  @override
  String basedOnReviews(String count) => 'Based on $count Reviews';
  @override
  String get recommended => 'Recommended';
  @override
  String get ratings => 'Ratings';
  @override
  String get review => 'Review';
  @override
  String get writeReview => 'Write a review';
  @override
  String get message => 'Message';
  @override
  String get sendMessage => 'Send Message';
  @override
  String get follow => 'Follow';
  @override
  String get following => 'Following';
  @override
  String get website => 'Website';
  @override
  String get officeLocation => 'Office location';
  @override
  String get viewOnGoogleMap => 'View on Google Map';
  @override
  String get workingHours => 'Working hours';
  @override
  String get helpful => 'Helpful';
  @override
  String get approve => 'Approve';
  @override
  String get reject => 'Reject';
  @override
  String get approved => 'Approved';
  @override
  String get rejected => 'Rejected';
  @override
  String get pendingApproval => 'Pending approval';
  @override
  String get adminActions => 'Admin actions';
  @override
  String get addNewProduct => 'Add New Product';
  @override
  String get addOtherServices => 'Add Other Services';
  @override
  String get editBusiness => 'Edit business';
  @override
  String get noItems => 'Nothing listed yet.';

  @override
  String get itemsPublishOnApproval =>
      'Add what you sell or offer. Once your business is approved, these are '
      "published as your shop's products and services.";
  @override
  String get noReviews => 'No reviews yet.';

  @override
  String get businessForm => 'Business Details Form';
  @override
  String get businessDetails => 'Business Details';
  @override
  String get productsServicesDetails => 'Products / Services Details';
  @override
  String get businessName => 'Business Name';
  @override
  String get businessType => 'Business Type';
  @override
  String get websiteUrl => 'Website URL';
  @override
  String get whatsappNumber => 'WhatsApp Number';
  @override
  String get googleMapLink => 'Google Map Link';
  @override
  String get businessDescription => 'Business Description';
  @override
  String get documents => 'Verification Documents';
  @override
  String get uploadDocument => 'Upload document';
  @override
  String get itemTitle => 'Product / Service Title';
  @override
  String get itemDescription => 'Description';
  @override
  String get itemPrice => 'Price';
  @override
  String get itemCategory => 'Product / Service Category';
  @override
  String get isService => 'This is a service';
  @override
  String get fixed => 'Fixed';
  @override
  String get variable => 'Variable';
  @override
  String get negotiable => 'Is this price negotiable ?';
  @override
  String get yes => 'Yes';
  @override
  String get no => 'No';
  @override
  String get addProductPhotos => 'Add Product Photos * (Upload 400*200px size)';
  @override
  String get pngJpegHint => 'PNG or JPEG, up to 16 MB';

  @override
  String documentNumber(int index) => 'Document $index';

  @override
  String get discardChanges => 'Discard this form?';

  @override
  String get discardChangesMessage =>
      'Your business details have not been submitted yet.';

  @override
  String get discard => 'Discard';

  @override
  String get keepEditing => 'Keep editing';
  @override
  String get addItem => 'Add New Product';
  @override
  String get next => 'Next';
  @override
  String get back => 'Back';
  @override
  String get submit => 'Submit';
  @override
  String get submitted => 'Submitted';
  @override
  String get submittedMessage =>
      'Your business details were submitted for approval.';
  @override
  String get myBusiness => 'My Business / Become a Seller';
  @override
  String get addresses => 'Addresses';
  @override
  String get security => 'Security';
  @override
  String get dataPrivacy => 'Data & privacy';
  @override
  String get rateYourPurchases => 'Rate your purchases';

  @override
  String get savedProducts => 'Saved items';

  @override
  String get followingAstrologers => 'Astrologers you follow';

  @override
  String get inviteFriends => 'Invite friends';
  @override
  String get becomeAstrologer => 'Become an astrologer';
  @override
  String get astrologerConsole => 'Astrologer console';
  @override
  String get adminBusinessApprovals => 'Admin: Business approvals';
  @override
  String get businessApprovals => 'Business approvals';
  @override
  String get pending => 'Pending';
  @override
  String get all => 'All';
  @override
  String get noBusinesses => 'No businesses in this list.';
  @override
  String get sellerApproval => 'Seller Approval';
  @override
  String get approveMessage =>
      'Approve this business? The listing will become visible to all users.';
  @override
  String get rejectMessage =>
      'Reject this business? Add a reason so the seller can fix the listing.';
  @override
  String get rejectionReason => 'Reason (optional)';
  @override
  String get adminNote => 'Admin note';
  @override
  String get statusLabel => 'Status';
  @override
  String get submittedForApproval => 'Submitted for approval';
  @override
  String get submittedForApprovalMessage =>
      'Your business details were submitted. Our team will review them and you will be notified once approved.';
  @override
  String get ok => 'OK';
  @override
  String get addNewCategory => '+ Add new Category';
  @override
  String get newCategoryName => 'New category name';
  @override
  String get purchaseLink => 'Product Purchase Link';
  @override
  String get tiktokLink => 'TikTok Video Link (product related)';
  @override
  String get youtubeLink => 'YouTube Video Link (product related)';
  @override
  String get remove => 'Remove';
  @override
  String get viewBusiness => 'View business';
  @override
  String get ownerHint =>
      'You own this business. Use Edit to update details or add products & services below.';
  @override
  String get postProductsNote =>
      'Post products & services – once you publish a product, it becomes visible in the Products tab.';
}
