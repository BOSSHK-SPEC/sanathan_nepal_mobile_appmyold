/// Every server path in one place.
///
/// Endpoints are constants rather than strings scattered through data sources,
/// so a rename on the server is a single edit here and the compiler finds
/// every caller.
abstract final class ApiEndpoints {
  const ApiEndpoints._();

  // --- identity ---
  static const String authSocial = '/auth/social';
  static const String authPhoneStart = '/auth/phone/start';
  static const String authPhoneVerify = '/auth/phone/verify';
  static const String authRefresh = '/auth/refresh';
  static const String authSignOut = '/auth/signout';
  static const String authSignOutOthers = '/auth/signout-others';
  static const String authMe = '/auth/me';
  static const String authDevices = '/auth/devices';
  static String authDevice(String id) => '/auth/devices/$id';

  // --- profile & business ---
  static const String profile = '/profile';
  static const String profileFavourites = '/profile/favourites';
  static const String profileLogout = '/profile/logout';
  static const String businessMine = '/business/mine';
  static String business(String id) => '/business/$id';
  static String businessReview(String id) => '/business/$id/reviews';
  static const String adminBusinesses = '/admin/businesses';
  static String adminBusinessDecision(String id) =>
      '/admin/businesses/$id/decision';

  // --- messaging (customer ↔ business) ---
  static const String messageThreads = '/messaging/threads';
  static const String messagingUnread = '/messaging/unread';
  static String messageThread(String id) => '/messaging/threads/$id';
  static String messageThreadMessages(String id) =>
      '/messaging/threads/$id/messages';
  static String messageThreadRead(String id) => '/messaging/threads/$id/read';
  static String messageThreadArchive(String id) =>
      '/messaging/threads/$id/archive';
  static String businessThread(String businessId) =>
      '/messaging/business/$businessId/thread';
  static String businessMessages(String businessId) =>
      '/messaging/business/$businessId/messages';

  // --- account ---
  static const String accountAddresses = '/account/addresses';
  static String accountAddress(String id) => '/account/addresses/$id';
  static String accountAddressDefault(String id) =>
      '/account/addresses/$id/default';
  static const String accountSecurity = '/account/security';
  static const String accountDevices = '/account/devices';
  static String accountDevice(String id) => '/account/devices/$id';
  static const String accountRevokeOtherDevices =
      '/account/devices/revoke-others';
  static const String accountDataRequests = '/account/data-requests';
  static const String accountTickets = '/account/tickets';
  static String accountTicket(String id) => '/account/tickets/$id';
  static String accountTicketReply(String id) => '/account/tickets/$id/reply';
  static const String accountOffers = '/account/offers';
  static const String accountReferral = '/account/referral';

  // --- almanac ---
  static const String almanacCalendar = '/almanac/calendar';
  static const String almanacCalendarMonth = '/almanac/calendar/month';
  static const String almanacFestivals = '/almanac/festivals';
  static String almanacFestival(String slug) => '/almanac/festivals/$slug';
  static const String almanacPanchanga = '/almanac/panchanga';
  static const String almanacSuvaSaits = '/almanac/suva-saits';
  static const String almanacHoroscope = '/almanac/horoscope';
  static String almanacHoroscopeSign(String sign) => '/almanac/horoscope/$sign';
  static String almanacLegal(String type) => '/almanac/legal/$type';

  // --- content ---
  static const String articles = '/content/articles';
  static String article(String id) => '/content/articles/$id';
  static String articleRelated(String id) => '/content/articles/$id/related';
  static String articleLike(String id) => '/content/articles/$id/like';

  // --- date converter ---
  static const String toTraditional = '/date-converter/to-traditional';
  static const String toGregorian = '/date-converter/to-gregorian';

  // --- marketplace ---
  static const String categories = '/marketplace/categories';
  static const String products = '/marketplace/products';
  static const String myProducts = '/marketplace/products/mine';
  static String product(String id) => '/marketplace/products/$id';
  static String productFavourite(String id) =>
      '/marketplace/products/$id/favourite';
  static const String boostPlans = '/marketplace/boost-plans';
  static const String boosts = '/marketplace/boosts';

  // --- cart ---
  static const String cart = '/cart';
  static const String cartItems = '/cart/items';
  static String cartItem(String productId) => '/cart/items/$productId';
  static const String cartCoupon = '/cart/coupon';

  // --- product reviews ---
  static const String productReviews = '/product-reviews';
  static const String pendingReviews = '/product-reviews/pending';
  static String reviewsFor(String productId) => '/product-reviews/$productId';
  static String reviewSummary(String productId) =>
      '/product-reviews/$productId/summary';
  static String reviewHelpful(String reviewId) =>
      '/product-reviews/$reviewId/helpful';
  static String reviewReply(String reviewId) =>
      '/product-reviews/$reviewId/reply';

  // --- orders ---
  static const String orders = '/orders';
  static const String checkout = '/orders/checkout';
  static const String sellingOrders = '/orders/selling';
  static String order(String id) => '/orders/$id';
  static String orderAdvance(String id) => '/orders/$id/advance';
  static String orderCancel(String id) => '/orders/$id/cancel';
  static String orderRate(String id) => '/orders/$id/rate';
  static String orderReturn(String id) => '/orders/$id/return';

  // --- wallet & payments ---
  static const String walletBalance = '/wallet/balance';
  static const String walletTransactions = '/wallet/transactions';
  static const String walletTopUpOptions = '/wallet/topup-options';
  static const String walletTopUp = '/wallet/topup';
  static String walletPayment(String id) => '/wallet/payments/$id';
  static const String walletRefunds = '/wallet/refunds';

  // --- astrologers ---
  static const String astrologers = '/astrologers';
  static const String astrologerLanguages = '/astrologers/languages';
  static const String astrologerSearches = '/astrologers/searches';
  static const String astrologerReports = '/astrologers/reports';
  static const String astrologerReviews = '/astrologers/reviews';
  static String astrologerReviewReply(String id) =>
      '/astrologers/reviews/$id/reply';
  static String astrologer(String id) => '/astrologers/$id';
  static String astrologerReviewsFor(String id) => '/astrologers/$id/reviews';
  static String astrologerFollow(String id) => '/astrologers/$id/follow';

  // --- consultation ---
  static const String consultations = '/consultations';
  static const String activeConsultation = '/consultations/active';
  static const String spendable = '/consultations/spendable';
  static const String consultationQueue = '/consultations/queue';
  static const String astrologerSessions = '/consultations/astrologer';
  static String consultation(String id) => '/consultations/$id';
  static String consultationMessages(String id) =>
      '/consultations/$id/messages';
  static String consultationAccept(String id) => '/consultations/$id/accept';
  static String consultationDecline(String id) => '/consultations/$id/decline';
  static String consultationEnd(String id) => '/consultations/$id/end';
  static String consultationCancel(String id) => '/consultations/$id/cancel';
  static String consultationSummary(String id) => '/consultations/$id/summary';

  // --- astrologer console ---
  static const String consoleApplication = '/console/application';
  static const String consoleApplicationDocuments =
      '/console/application/documents';

  /// One KYC slot, addressed by its wire kind (`idFront`, `selfie`, …).
  static String consoleApplicationDocument(String kind) =>
      '/console/application/documents/$kind';
  static const String consoleApplicationTerms = '/console/application/terms';
  static const String consoleApplicationSubmit = '/console/application/submit';
  static const String consoleDashboard = '/console/dashboard';
  static const String consoleAvailability = '/console/availability';
  static const String consoleOnline = '/console/online';
  static const String consoleClients = '/console/clients';
  static String consoleClient(String id) => '/console/clients/$id';
  static String consoleClientNotes(String id) => '/console/clients/$id/notes';
  static const String consoleEarnings = '/console/earnings';
  static const String consolePerformance = '/console/performance';
  static const String consolePayoutAccount = '/console/payout-account';
  static const String consolePayouts = '/console/payouts';
  static const String consolePricing = '/console/pricing';
  static const String consoleProfile = '/console/profile';
  static const String consoleCompliance = '/console/compliance';
  static String consoleComplianceAcknowledge(String id) =>
      '/console/compliance/$id/acknowledge';
  static String consoleComplianceAppeal(String id) =>
      '/console/compliance/$id/appeal';
  static const String consoleWorkPreferences = '/console/work-preferences';
  static const String consoleQueue = '/console/queue';
  static const String consolePendingRequest = '/console/requests/pending';
  static String consoleRespondToRequest(String id) =>
      '/console/requests/$id/respond';
  static const String consoleReviews = '/console/reviews';
  static const String consoleBoosts = '/console/boosts';
  static const String consoleTaxDocuments = '/console/tax-documents';

  // --- appointments & puja ---
  /// An astrologer's own bookable calendar, generated from the weekly
  /// availability they keep in the console. Public: you can see when someone
  /// is free before you sign in.
  static String astrologerSlots(String id) =>
      '/appointments/astrologers/$id/slots';
  static const String appointments = '/appointments';
  static String appointment(String id) => '/appointments/$id';
  static String appointmentCancel(String id) => '/appointments/$id/cancel';
  static String appointmentReschedule(String id) =>
      '/appointments/$id/reschedule';
  static const String pujaServices = '/puja/services';
  static String pujaService(String id) => '/puja/services/$id';
  static String pujaServiceTimes(String id) => '/puja/services/$id/times';
  static const String pujaBookings = '/puja/bookings';
  static String pujaBooking(String id) => '/puja/bookings/$id';
  static String pujaBookingCancel(String id) => '/puja/bookings/$id/cancel';

  // --- kundli & reports ---
  static const String kundliProfiles = '/kundli/profiles';
  static String kundliProfile(String id) => '/kundli/profiles/$id';
  static String kundliChart(String id) => '/kundli/profiles/$id/chart';
  static String kundliDashas(String id) => '/kundli/profiles/$id/dashas';
  static String kundliDoshas(String id) => '/kundli/profiles/$id/doshas';
  static const String kundliMatch = '/kundli/match';
  static const String reportCatalogue = '/reports/catalogue';
  static String reportProduct(String id) => '/reports/catalogue/$id';
  static const String myReports = '/reports/mine';
  static const String reportPurchase = '/reports/purchase';
  static String report(String id) => '/reports/$id';

  // --- engagement ---
  static const String notifications = '/notifications';
  static const String notificationSettings = '/notifications/settings';
  static const String notificationsReadAll = '/notifications/read-all';
  static String notificationRead(String id) => '/notifications/$id/read';
  static const String events = '/events';
  static String event(String id) => '/events/$id';
  static String eventChecklistItem(String eventId, String itemId) =>
      '/events/$eventId/checklist/$itemId';

  // --- market data ---
  static const String forex = '/market/forex';
  static const String forexHistory = '/market/forex/history';
  static const String forexFavourites = '/market/forex/favourites';
  static const String metals = '/market/metals';
  static const String weather = '/market/weather';

  // --- media ---
  static const String mediaUploads = '/media/uploads';
  static String mediaConfirm(String id) => '/media/uploads/$id/confirm';
  static String media(String id) => '/media/$id';
  static String mediaDownload(String id) => '/media/$id/download';

  // --- admin ---
  static const String adminApplications = '/admin/astrologer-applications';
  static String adminApplicationDecision(String id) =>
      '/admin/astrologer-applications/$id/decision';
  static const String adminReports = '/admin/reports';
  static String adminResolveReport(String id) => '/admin/reports/$id/resolve';
  static const String adminAuditLog = '/admin/audit-log';
  static const String adminFeatureFlags = '/admin/feature-flags';
  static String adminFeatureFlag(String key) => '/admin/feature-flags/$key';
  static const String adminFinanceSummary = '/admin/finance/summary';
  static const String adminPayouts = '/admin/payouts';
  static String adminPayoutDecision(String id) => '/admin/payouts/$id/decision';
  static String adminRefundDecision(String id) => '/admin/refunds/$id/decision';
  static String adminTicketReply(String id) => '/admin/tickets/$id/reply';
}
