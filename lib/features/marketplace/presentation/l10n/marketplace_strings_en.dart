part of 'marketplace_strings.dart';

class _En extends MarketplaceStrings {
  const _En();
  @override
  String get marketplace => 'Marketplace';
  @override
  String get all => 'All';
  @override
  String get viewAll => 'View All';
  @override
  String get boostedPost => 'Boosted Post';
  @override
  String get boostPostToSellQuickly => 'Boost Post to sell quickly';
  @override
  String get myProductsAndServices => 'My Products & Services';
  @override
  String get boostAds => 'BOOST ADS';
  @override
  String get boostHeadline =>
      'We want to assist you in achieving a quicker sale.';
  @override
  String get boostBody =>
      'By providing top-of-the-category placement for a limited period, Boost '
      'can increase the exposure of your product to a larger audience of '
      'potential buyers. This ensures that your product receives high '
      'engagement and visibility. Our smart algorithm ensures that when '
      'people search for related products, your listings appear first, ahead '
      'of regular listings.';
  @override
  String get boostAnalytics =>
      'Once you have used Boost, you can track the growth in your product’s '
      'reach through the Analytics feature on your profile.';
  @override
  String get selectYourProductService => 'Select your Product/Service';
  @override
  String get checkout => 'Checkout';
  @override
  String get sortBy => 'Sort by :';
  @override
  String get latest => 'Latest';
  @override
  String get priceLowToHigh => 'Price Low to High';
  @override
  String get priceHighToLow => 'Price High to Low';
  @override
  String get next => 'Next';
  @override
  String get shoppingCart => 'Shopping Cart';
  @override
  String get boostYourListing => 'Boost your listing';
  @override
  String productsSelected(int count) =>
      '$count ${count == 1 ? 'Product' : 'Products'} Selected !';
  @override
  String get selectNumberOfHours => 'Select Number of Hours';
  @override
  String hoursPlan(String hours, String price) => '$hours Hours ($price)';
  @override
  String get firstName => 'First Name';
  @override
  String get lastName => 'Last Name';
  @override
  String get phoneNumber => 'Phone Number';
  @override
  String get productServiceLink => 'Product/Service Link';
  @override
  String get linkToYourAd => 'Link to your ad';
  @override
  String get total => 'Total';
  @override
  String get esewaId => 'eSewa ID';
  @override
  String get khaltiId => 'Khalti ID';
  @override
  String get upiId => 'UPI ID';
  @override
  String get scanQrToPay => 'Scan QR to pay';
  @override
  String get bankDetails => 'BANK DETAILS';
  @override
  String get bankName => 'Bank Name';
  @override
  String get accountHolder => 'A/C Holder Name';
  @override
  String get accountNumber => 'Account Number';
  @override
  String get ifscCode => 'IFSC Code';
  @override
  String get attachPaymentScreenshot =>
      'Please attach payment screenshot for Payment Confirmation.';
  @override
  String get nonRefundable =>
      '*The payments made are non-refundable. Please keep the payment receipt '
      'for your records.*';
  @override
  String get uploadReceipt => 'Upload Screenshot of Payment Receipt';
  @override
  String get selectFileOrDrop => 'Select a file or drag & drop here';
  @override
  String get selectFiles => 'SELECT FILES';
  @override
  String get boostNote =>
      'Boost requests are only accepted from 9AM to 6PM and each request is '
      'manually monitored to ensure compliance with the Safe community '
      'guidelines.';
  @override
  String get submit => 'Submit';
  @override
  String boostSubmitted(String ref) =>
      'Boost request $ref submitted. We will verify your payment shortly.';
  @override
  String get recent => 'Recent';
  @override
  String get recommendation => 'Recommendation';
  @override
  String get settingTabAds => 'SETTING TAB ADS';
  @override
  String get search => 'Search...';
  @override
  String get searchProduct => 'Search product';
  @override
  String productsFound(int count) =>
      '$count ${count == 1 ? 'product' : 'products'} found';
  @override
  String get used => 'Used';
  @override
  String get brandNew => 'Brand New';
  @override
  String get ratingsAndReviews => 'Ratings and reviews';

  @override
  String get allReviews => 'All reviews';

  @override
  String get writeReview => 'Write a review';

  @override
  String get editReview => 'Edit your review';

  @override
  String get rateThisProduct => 'Rate this product';

  @override
  String get yourRating => 'Your rating';

  @override
  String get reviewCommentHint => 'What should other buyers know? (optional)';

  @override
  String get addPhotos => 'Add photos';

  @override
  String get submitReview => 'Post review';

  @override
  String get reviewThanks => 'Thanks — your review is live.';

  @override
  String get noReviewsTitle => 'No reviews yet';

  @override
  String get noReviewsBody =>
      'Reviews from people who bought this will appear here.';

  @override
  String get beTheFirst => 'Be the first to review';

  @override
  String get verifiedPurchase => 'Verified purchase';

  @override
  String get withPhotos => 'With photos';

  @override
  String get helpful => 'Helpful';

  @override
  String get sellerReplied => 'Seller replied';

  @override
  String get replyToReview => 'Reply';

  @override
  String get replyHint => 'Reply to this buyer';

  @override
  String get sendReply => 'Post reply';

  @override
  String get replySent => 'Reply posted.';

  @override
  String get rateYourPurchases => 'Rate your purchases';

  @override
  String get rateYourPurchasesBody =>
      'A short review helps the next buyer decide.';

  @override
  String get deliveredOn => 'Delivered';

  @override
  String get rateIt => 'Rate it';

  @override
  String get noPendingReviews => 'Nothing waiting to be reviewed.';

  @override
  String reviewSortName(ReviewSort sort) => switch (sort) {
    ReviewSort.recent => 'Most recent',
    ReviewSort.helpful => 'Most helpful',
    ReviewSort.highest => 'Highest first',
    ReviewSort.lowest => 'Lowest first',
  };

  @override
  String reviewCount(int value) => value == 1 ? '1 review' : '$value reviews';

  @override
  String starsLabel(int value) => '$value stars';

  @override
  String get savedProducts => 'Saved items';

  @override
  String get noSavedTitle => 'Nothing saved yet';

  @override
  String get noSavedBody =>
      'Tap the heart on any listing and it waits for you here.';

  @override
  String get browseMarketplace => 'Browse the marketplace';

  @override
  String get savedCount => 'saved';

  @override
  String get noProducts => 'No products or services found.';
  @override
  String get noMyProducts => 'You have not listed any products yet.';
  @override
  String get selectAtLeastOne => 'Select at least one product to boost.';
  @override
  String get requiredField => 'This field is required';
  @override
  String get invalidPhone => 'Enter a valid phone number';
  @override
  String get invalidWebsite => 'Enter a web address, e.g. example.com';
  @override
  String get productDetails => 'Product Details';
  @override
  String get description => 'Description';
  @override
  String get comments => 'Comments';
  @override
  String get call => 'Call';
  @override
  String get chat => 'Chat';
  @override
  String get order => 'Order';
  @override
  String get addToCart => 'Add to Cart';
  @override
  String get addedToCart => 'Added to cart';
  @override
  String get general => 'General';
  @override
  String get location => 'Location:';
  @override
  String get negotiable => 'Negotiable';

  @override
  String get askForPrice => 'Ask for price';

  @override
  String get listingsNeedApproval =>
      'Your business is still under review. You can publish listings once it is approved.';

  @override
  String get sellerAccessSyncing =>
      'Your seller access is still syncing. Pull to refresh, or sign out and back in if it persists.';
  @override
  String get notNegotiable => 'Fixed price';
  @override
  String get websiteLink => 'Website Link:';
  @override
  String get adsPosted => 'Ads Posted:';
  @override
  String get adsExpiry => 'Ads Expiry:';
  @override
  String get seller => 'Seller';
  @override
  String get verifiedSeller => 'Verified seller';
  @override
  String get noComments =>
      'No Comments till Now!! Be the first to leave a comment.';
  @override
  String get commentHint => 'Comment...';
  @override
  String get reply => 'Reply';
  @override
  String get inspectionNote =>
      'Note: We recommend you to Contact the Seller and conduct a thorough '
      'physical inspection of the Product / Services, testing it '
      'appropriately before making any payment.';
  @override
  String get similarProducts => 'Similar Products';
  @override
  String quoteYourPrice(String currencyCode) =>
      'Please Quote Your Price ($currencyCode)';
  @override
  String finalPriceHint(String currencyCode) =>
      'Final Product Price ($currencyCode)';
  @override
  String get sendOrderRequest => 'Send your order request to the seller';
  @override
  String get orderRequestSent => 'Order request sent to the seller.';
  @override
  String get cancel => 'Cancel';
  @override
  String get confirm => 'Confirm';
  @override
  String get myShoppingCart => 'My Shopping Cart';
  @override
  String get subtotal => 'Subtotal';
  @override
  String get discount => 'Discount';
  @override
  String get shippingCosts => 'Shipping Costs';
  @override
  String get shipping => 'Shipping';
  @override
  String get couponCode => 'Coupon code';
  @override
  String get applyCoupon => 'Apply Coupon';
  @override
  String get invalidCoupon => 'Invalid coupon code';
  @override
  String get continueShopping => 'Continue Shopping';
  @override
  String get emptyCart => 'Your cart is empty.';
  @override
  String get securePaymentsBy => 'SECURE PAYMENTS PROVIDED BY';
  @override
  String get deliveryAndPayment => 'Delivery & Payment';
  @override
  String get countryRegion => 'Country / Region';
  @override
  String get streetAddress => 'Street address';
  @override
  String get houseNumberHint => 'House number and street name';
  @override
  String get apartmentHint => 'Apartment, suite, unit, etc. (optional)';
  @override
  String get townCity => 'Town / City';
  @override
  String get province => 'Province';
  @override
  String get state => 'State';
  @override
  String get postcode => 'Postcode / ZIP';
  @override
  String get phoneOptional => 'Phone (optional)';
  @override
  String get emailAddress => 'Email address';
  @override
  String get shipToDifferentAddress => 'Ship to a different Address?';
  @override
  String get orderNotes => 'Order Notes (optional)';
  @override
  String get orderNotesHint =>
      'Notes about your order, e.g. special notes for delivery.';
  @override
  String get confirmAddress =>
      'I confirm that my address is 100% correct and WILL NOT hold Sanatan '
      'Nepal liable if this shipment is sent to an incorrect address.';
  @override
  String get placeOrder => 'Place Order';
  @override
  String get paymentMethod => 'Payment Method';
  @override
  String get esewa => 'eSewa';
  @override
  String get khalti => 'Khalti';
  @override
  String get bankTransfer => 'Bank Transfer';
  @override
  String get cashOnDelivery => 'Cash on Delivery';
  @override
  String get upi => 'UPI';
  @override
  String get card => 'Credit / Debit Card';
  @override
  String get netBanking => 'Net Banking';
  @override
  String get orderConfirmed => 'Your Order has been confirmed.';
  @override
  String get status => 'Status';
  @override
  String get paid => 'Paid';
  @override
  String get pending => 'Pending';
  @override
  String get orderNumber => 'Order';
  @override
  String get backToMarketplace => 'Back to Marketplace';
  @override
  String get viewOrder => 'View Order';
  @override
  String get buyNow => 'Buy Now';
  @override
  String get share => 'Share';
  @override
  String get favourite => 'Favourite';
  @override
  String get linkCopied => 'Product link copied';
  @override
  String get edit => 'Edit';
  @override
  String get delete => 'Delete';
  @override
  String get productNotFound => 'This product is no longer available.';
  @override
  String get productVideos => 'Product Videos';
  @override
  String get postedBy => 'Posted by';
  @override
  String get sellerContact => 'Seller contact';
  @override
  String get addProduct => 'Add Product';
  @override
  String get editProduct => 'Edit Product';
  @override
  String get productTitle => 'Product / Service title';
  @override
  String get productTitleLocal => 'Title (Nepali / Hindi)';
  @override
  String get category => 'Category';
  @override
  String get selectCategory => 'Select category';
  @override
  String get editCategory => 'Product Category edit';
  @override
  String get productCategoryName => 'Product Category Name';
  @override
  String get categoryPhoto => 'Category photo';
  @override
  String get save => 'Save';
  @override
  String get update => 'Update';
  @override
  String get price => 'Price';
  @override
  String get condition => 'Condition';
  @override
  String get listingType => 'Listing type';
  @override
  String get product => 'Product';
  @override
  String get service => 'Service';
  @override
  String get photos => 'Photos';
  @override
  String get addPhoto => 'Add photo';

  @override
  String get photosOptional =>
      'Optional — a listing without photos shows a category icon';

  @override
  String get removeAllPhotos => 'Remove all';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get photosRemoved => 'Photos removed';
  @override
  String get contactPhone => 'Contact phone';
  @override
  String get website => 'Website';
  @override
  String get expiryDays => 'Ad expiry (days)';
  @override
  String get invalidPrice => 'Enter a valid price';
  @override
  String get invalidCategory => 'Please choose a category';
  @override
  String get productSaved => 'Product published';
  @override
  String get productUpdated => 'Product updated';
  @override
  String get productDeleted => 'Product deleted';
  @override
  String get deleteProductTitle => 'Delete this product?';
  @override
  String get deleteProductMessage =>
      'The listing will be removed from the marketplace. This cannot be undone.';
  @override
  String get myProductBadge => 'My listing';
  @override
  String justNow() => 'Just now';
  @override
  String minutesAgo(String n) => '$n minutes ago';
  @override
  String hoursAgo(String n) => '$n hours ago';
  @override
  String daysAgo(String n) => '$n days ago';
}
