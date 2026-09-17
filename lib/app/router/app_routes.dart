/// Single source of truth for route paths & names.
///
/// Features reference these constants – never hard-code paths in widgets.
abstract final class AppRoutes {
  // Onboarding / auth
  static const String splash = '/';
  static const String languageTheme = '/onboarding/language-theme';
  static const String login = '/auth/login';
  static const String otp = '/auth/otp';
  static const String detailsInput = '/auth/details';
  static const String notificationSettingsOnboarding = '/auth/notifications';

  // Bottom-nav shell tabs
  static const String home = '/home';
  static const String marketplace = '/marketplace';
  static const String horoscope = '/horoscope';
  static const String profile = '/profile';

  // Feature pages (pushed on top of the shell)
  static const String patro = '/patro';
  static const String dateConverter = '/date-converter';
  static const String weather = '/weather';
  static const String forex = '/forex';
  static const String panchanga = '/panchanga';
  static const String events = '/events';
  static const String eventDetails = '/events/:id';
  static const String eventCreate = '/events/new';
  // Account
  static const String addresses = '/profile/addresses';
  static const String accountSecurity = '/profile/security';
  static const String accountPrivacy = '/profile/privacy';
  static const String supportTickets = '/support/tickets';
  static const String supportTicket = '/support/tickets/:id';
  static const String offers = '/offers';
  static const String referral = '/referral';

  // Orders
  static const String myOrders = '/orders';
  static const String orderDetails = '/orders/:id';
  static const String orderReturn = '/orders/:id/return';
  static const String sellerOrders = '/seller/orders';

  // Astrologer console
  static const String astrologerApply = '/astrologer/apply';
  static const String astrologerKyc = '/astrologer/apply/kyc';
  static const String astrologerApplication = '/astrologer/application';
  static const String astrologerHome = '/astrologer';
  static const String astrologerSchedule = '/astrologer/schedule';
  static const String astrologerClients = '/astrologer/clients';
  static const String astrologerClient = '/astrologer/clients/:id';
  static const String astrologerEarnings = '/astrologer/earnings';
  static const String astrologerPayouts = '/astrologer/payouts';
  static const String astrologerPayoutAccount = '/astrologer/payouts/account';
  static const String astrologerWithdraw = '/astrologer/payouts/withdraw';
  static const String astrologerTax = '/astrologer/tax';
  static const String astrologerMyProfile = '/astrologer/profile';
  static const String astrologerWorkSettings = '/astrologer/settings';
  static const String astrologerCompliance = '/astrologer/notices';
  static const String astrologerPricing = '/astrologer/pricing';
  static const String astrologerReviews = '/astrologer/reviews';
  static const String astrologerAnalytics = '/astrologer/analytics';
  static const String astrologerAppointments = '/astrologer/appointments';
  static const String astrologerAppointment = '/astrologer/appointments/:id';
  static const String astrologerBoost = '/astrologer/boost';
  static const String astrologerSession = '/astrologer/session/:id';
  static const String astrologerCall = '/astrologer/session/:id/call';
  static const String astrologerNotes = '/astrologer/session/:id/notes';

  // Kundli
  // Online puja
  static const String pujas = '/pujas';
  static const String myPujas = '/pujas/mine';
  static const String pujaBooking = '/pujas/booking/:id';
  static const String pujaDetails = '/pujas/:id';

  // Paid reports
  static const String reports = '/reports';
  static const String myReports = '/reports/mine';
  static const String reportDelivery = '/reports/purchased/:id';
  static const String reportDetails = '/reports/:id';

  static const String kundli = '/kundli';
  static const String kundliNew = '/kundli/new';
  static const String kundliMatch = '/kundli/match';
  static const String kundliChart = '/kundli/:id';

  // Live consultation
  static const String consultIntake = '/consult/new/:astrologerId';
  static const String consultQueue = '/consult/:id/queue';
  static const String consultChat = '/consult/:id/chat';
  static const String consultCall = '/consult/:id/call';
  static const String consultSummary = '/consult/:id/summary';
  static const String consultTranscript = '/consult/:id/transcript';
  static const String consultHistory = '/consult/history';

  // Wallet & payments
  static const String wallet = '/wallet';
  static const String walletTopUp = '/wallet/topup';
  static const String walletTransactions = '/wallet/transactions';
  static const String walletPayment = '/wallet/payment/:intentId';
  static const String walletRefund = '/wallet/refund/:transactionId';

  // Astrologer discovery
  static const String astrologers = '/astrologers';
  static const String astrologerSearch = '/astrologers/search';
  static const String astrologersFollowing = '/astrologers/following';
  static const String astrologerProfile = '/astrologers/:id';
  static const String astrologerReview = '/astrologers/:id/review';

  static const String appointments = '/appointments';
  static const String appointmentAstrologers = '/appointments/astrologers';
  static const String appointmentBook = '/appointments/book/:astrologerId';
  static const String appointmentDetails = '/appointments/:id';
  static const String productCreate = '/marketplace/product/new';
  static const String productEdit = '/marketplace/product/:id/edit';
  static const String productDetails = '/marketplace/product/:id';
  static const String savedProducts = '/marketplace/saved';
  static const String productReviews = '/marketplace/product/:id/reviews';
  static const String productReviewNew = '/marketplace/product/:id/review';
  static const String pendingReviews = '/marketplace/reviews/pending';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String productListing = '/marketplace/listing';
  static const String editProfile = '/profile/edit';
  static const String businessProfile = '/business/:id';
  static const String businessForm = '/business/form';
  static const String myBusiness = '/business/mine';
  static const String adminBusinesses = '/admin/businesses';
  static const String messages = '/messages';
  static const String messageThread = '/messages/:id';
  static const String businessMessageThread = '/messages/business/:id';
  static const String notifications = '/notifications';
  static const String notificationSettings = '/notifications/settings';
  static const String privacyPolicy = '/legal/privacy';
  static const String termsConditions = '/legal/terms';
  static const String blogs = '/blogs';
  static const String news = '/news';
  static const String contentDetails = '/content/:type/:id';
  static const String support = '/support';

  static String eventDetailsPath(String id) => '/events/$id';
  static String supportTicketPath(String id) => '/support/tickets/$id';

  static String orderDetailsPath(String id) => '/orders/$id';
  static String orderReturnPath(String id) => '/orders/$id/return';

  static String astrologerSessionPath(String id) => '/astrologer/session/$id';
  static String astrologerNotesPath(String id) =>
      '/astrologer/session/$id/notes';
  static String astrologerCallPath(String id) => '/astrologer/session/$id/call';

  static String astrologerClientPath(String id) => '/astrologer/clients/$id';
  static String astrologerAppointmentPath(String id) =>
      '/astrologer/appointments/$id';

  static String kundliChartPath(String id) => '/kundli/$id';
  static String pujaDetailsPath(String id) => '/pujas/$id';
  static String pujaBookingPath(String id) => '/pujas/booking/$id';
  static String productReviewsPath(String id) =>
      '/marketplace/product/$id/reviews';
  static String productReviewNewPath(String id, {String? orderId}) =>
      '/marketplace/product/$id/review'
      '${orderId == null ? '' : '?orderId=$orderId'}';
  static String reportDetailsPath(String id) => '/reports/$id';
  static String reportDeliveryPath(String id) => '/reports/purchased/$id';

  static String consultIntakePath(String astrologerId, {String? channel}) =>
      '/consult/new/$astrologerId'
      '${channel == null ? '' : '?channel=$channel'}';
  static String consultQueuePath(String id) => '/consult/$id/queue';
  static String consultChatPath(String id) => '/consult/$id/chat';
  static String consultCallPath(String id) => '/consult/$id/call';
  static String consultSummaryPath(String id) => '/consult/$id/summary';
  static String consultTranscriptPath(String id) => '/consult/$id/transcript';

  static String walletTopUpPath({double? amount}) =>
      '/wallet/topup${amount == null ? '' : '?amount=$amount'}';
  static String walletPaymentPath(String intentId) =>
      '/wallet/payment/$intentId';
  static String walletRefundPath(String transactionId) =>
      '/wallet/refund/$transactionId';

  static String astrologerProfilePath(String id) => '/astrologers/$id';
  static String astrologerReviewPath(String id, {String? consultationId}) =>
      '/astrologers/$id/review'
      '${consultationId == null ? '' : '?consultation=$consultationId'}';

  static String appointmentDetailsPath(String id) => '/appointments/$id';
  static String appointmentBookPath(String astrologerId, {String? serviceId}) =>
      '/appointments/book/$astrologerId'
      '${serviceId == null ? '' : '?service=$serviceId'}';
  static String productDetailsPath(String id) => '/marketplace/product/$id';
  static String productEditPath(String id) => '/marketplace/product/$id/edit';
  static String businessProfilePath(String id) => '/business/$id';
  static String messageThreadPath(String id) => '/messages/$id';
  static String businessMessageThreadPath(String businessId) =>
      '/messages/business/$businessId';
  static String contentDetailsPath(String type, String id) =>
      '/content/$type/$id';
}
