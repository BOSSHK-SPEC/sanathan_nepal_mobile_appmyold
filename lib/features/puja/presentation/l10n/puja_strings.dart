import 'package:flutter/widgets.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/region/region.dart';
import '../../domain/entities/puja_booking.dart';
import '../../domain/entities/puja_service.dart';

part 'puja_strings_en.dart';
part 'puja_strings_hi.dart';
part 'puja_strings_ne.dart';

/// Feature-local strings for online puja booking.
abstract class PujaStrings {
  const PujaStrings();

  static PujaStrings of(BuildContext context) => context.isNepali
      ? const _Ne()
      : context.isHindi
      ? const _Hi()
      : const _En();

  String get pujas;
  String get pujasSubtitle;
  String get myPujas;
  String get bookPuja;
  String get chooseMode;
  String get modeOnline;
  String get modeOnlineNote;
  String get modeAtHome;
  String get modeAtHomeNote;
  String get chooseDate;
  String get chooseMuhurta;
  String get noMuhurtaTitle;
  String get noMuhurtaBody;
  String get sankalpTitle;
  String get sankalpNote;
  String get devoteeName;
  String get gotra;
  String get gotraOptional;
  String get rashiNakshatra;
  String get addressTitle;
  String get addressHint;
  String get samagriTitle;
  String get samagriNote;
  String get includeSamagri;
  String get iHaveSamagri;
  String get paymentTitle;
  String get summaryTitle;
  String get basePriceLabel;
  String get samagriLabel;
  String get travelLabel;
  String get totalLabel;
  String get confirmBooking;
  String get bookedTitle;
  String get bookedBody;
  String get viewBooking;
  String get upcomingPujas;
  String get pastPujas;
  String get noPujasTitle;
  String get noPujasBody;
  String get browsePujas;
  String get joinLive;
  String get streamOpensSoon;
  String get priest;
  String get temple;
  String get watchRecording;
  String get prasadPhotos;
  String get cancelBooking;
  String get cancelReasonHint;
  String get cancelConfirmTitle;
  String get cancelConfirmBody;
  String get cancelled;
  String get cannotCancel;
  String get recordingUnavailable;
  String get duration;
  String get procedureTitle;
  String get bookingsThisMonth;
  String get popular;

  String purposeName(PujaPurpose purpose);
  String statusName(PujaBookingStatus status);
  String railName(PaymentRail rail);
  String minutes(int value);
}
