import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/booking_request.dart';
import '../../domain/entities/sitting_option.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../../domain/entities/time_slot.dart';
import '../../domain/repositories/booking_contact_source.dart';
import '../../domain/usecases/book_appointment.dart';
import '../../domain/usecases/get_astrologer_calendar.dart';
import '../../domain/usecases/get_time_slots.dart';
import '../../../../core/state/app_cubit.dart';

part 'book_appointment_cubit.freezed.dart';
part 'book_appointment_state.dart';

/// Drives the 3-step booking form and submits the [BookingRequest].
///
/// Region defaults (country name, first offered payment rail) come from the
/// injected [RegionResolver]; the UI lists the rails from `RegionConfig`.
class BookAppointmentCubit extends AppCubit<BookAppointmentState> {
  BookAppointmentCubit({
    required GetTimeSlots getTimeSlots,
    GetAstrologerCalendar? getCalendar,
    required BookAppointment bookAppointment,
    required BookableAstrologer astrologer,
    RegionResolver? regionResolver,
    BookingContactSource? contacts,
    String? initialServiceId,
    DateTime? initialDate,
  }) : _getTimeSlots = getTimeSlots,
       _getCalendar = getCalendar,
       _book = bookAppointment,
       _contacts = contacts,
       _region = regionResolver ?? const FixedRegionResolver(Region.nepal),
       super(
         BookAppointmentState(
           astrologer: astrologer,
           serviceId: _resolveServiceId(astrologer, initialServiceId),
           date: _dateOnly(
             initialDate ?? DateTime.now().add(const Duration(days: 1)),
           ),
           country: (regionResolver ?? const FixedRegionResolver(Region.nepal))
               .config
               .nameEn,
           paymentMethod: PaymentMethod.fromRail(
             (regionResolver ?? const FixedRegionResolver(Region.nepal))
                 .config
                 .paymentRails
                 .first,
           ),
         ),
       );

  final GetTimeSlots _getTimeSlots;
  final GetAstrologerCalendar? _getCalendar;
  final BookAppointment _book;
  final RegionResolver _region;
  final BookingContactSource? _contacts;

  /// Payment methods offered in the active region (read at call time).
  List<PaymentMethod> get paymentMethods =>
      _region.config.paymentRails.map(PaymentMethod.fromRail).toList();

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  /// The service the wizard opens on.
  ///
  /// A deep link carries whatever id was in the URL, which may name a service
  /// this astrologer has since withdrawn; falling back to the first one keeps a
  /// stale link on a working screen instead of throwing while the page is
  /// being built. Callers guarantee the astrologer has at least one service —
  /// [BookAppointmentPage] refuses to open the wizard otherwise.
  static String _resolveServiceId(BookableAstrologer astrologer, String? requested) {
    final services = astrologer.services;
    if (services.isEmpty) return '';
    return services.any((s) => s.id == requested)
        ? requested!
        : services.first.id;
  }

  /// Starts the form from the signed-in user's own details.
  ///
  /// Only empty fields are filled, so this can never overwrite something the
  /// user has already typed, and a booking made for somebody else stays that
  /// way. A profile that cannot be read is not an error here — the form simply
  /// opens blank, which is what it did before.
  Future<void> prefillFromProfile() async {
    final contacts = _contacts;
    if (contacts == null) return;
    final contact = await contacts.current();
    if (contact == null) return;

    emit(
      state.copyWith(
        customerName: state.customerName.isEmpty
            ? contact.name
            : state.customerName,
        phone: state.phone.isEmpty ? _localPhone(contact.phone) : state.phone,
        email: state.email.isEmpty ? contact.email : state.email,
        birthPlace: state.birthPlace.isEmpty
            ? (contact.birthPlace ?? '')
            : state.birthPlace,
        birthDate: state.birthDate ?? contact.birthDate,
        birthTime: state.birthTime ?? contact.birthTime,
      ),
    );
  }

  /// The national part of a stored number.
  ///
  /// Profiles keep phone numbers in E.164 (`+919686912639`), and the form's
  /// field already prints the region's dial code beside the box — pasting the
  /// stored value in whole showed "+91 +919686912639". A number from another
  /// country is left alone rather than mangled.
  String _localPhone(String raw) {
    final trimmed = raw.replaceAll(RegExp(r'[\s-]'), '');
    final prefix = _region.config.phonePrefix;
    return trimmed.startsWith(prefix)
        ? trimmed.substring(prefix.length)
        : trimmed;
  }

  /// Opens the wizard on the first day the astrologer actually works.
  ///
  /// It used to open on "tomorrow", which is a day they do not work roughly
  /// two days in seven — arriving at an empty grid reads as "nobody can book
  /// this person" rather than "not on a Saturday". The whole fortnight is read
  /// once, so this costs one request, not fourteen.
  Future<void> openOnFirstFreeDay() async {
    final getCalendar = _getCalendar;
    if (getCalendar == null) return loadSlots();

    final calendar = (await getCalendar(state.astrologer.id)).valueOrNull;
    final free = (calendar ?? const [])
        .where((slot) => slot.available)
        .toList(growable: false);
    if (free.isEmpty) return loadSlots();

    final days = free.map((slot) => slot.day).toSet().toList()..sort();
    // Only move if today's choice has nothing; a date the caller asked for
    // explicitly (a deep link, a reschedule) is not overridden when it works.
    final selected = days.contains(state.date) ? state.date : days.first;
    emit(state.copyWith(date: selected, availableDays: days));
    await loadSlots();
  }

  /// Loads slots for the currently selected date and service.
  Future<void> loadSlots() async {
    emit(state.copyWith(slots: state.slots.toLoading()));
    final result = await _getTimeSlots(
      SlotQuery(
        astrologerId: state.astrologer.id,
        date: state.date,
        // Carried for symmetry with the booking; it does not narrow the
        // result. An astrologer publishes one calendar of half hours, and the
        // same half hour cannot be free for chat and taken for video.
        serviceId: state.serviceId,
      ),
    );
    emit(
      state.copyWith(
        slots: result.fold(state.slots.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Switches the service and reloads its slots.
  ///
  /// The previously picked time belongs to the old service's grid, so it is
  /// dropped rather than carried into a booking the server would refuse.
  Future<void> selectService(String id) async {
    if (id == state.serviceId) return;
    emit(state.copyWith(serviceId: id, slotId: null));
    await loadSlots();
  }

  void setDateMode(DateMode mode) => emit(state.copyWith(dateMode: mode));

  Future<void> selectDate(DateTime date) async {
    emit(state.copyWith(date: _dateOnly(date), slotId: null));
    await loadSlots();
  }

  void selectSlot(String id) => emit(state.copyWith(slotId: id));

  void updateDetails({
    String? customerName,
    String? phone,
    String? email,
    String? country,
    String? birthPlace,
    String? notes,
  }) => emit(
    state.copyWith(
      customerName: customerName ?? state.customerName,
      phone: phone ?? state.phone,
      email: email ?? state.email,
      country: country ?? state.country,
      birthPlace: birthPlace ?? state.birthPlace,
      notes: notes ?? state.notes,
    ),
  );

  void setBirthDate(DateTime? date) => emit(state.copyWith(birthDate: date));

  void setBirthTime(String? hhmm) => emit(state.copyWith(birthTime: hhmm));

  void setPaymentMethod(PaymentMethod method) =>
      emit(state.copyWith(paymentMethod: method));

  /// Attaches (or clears, with null) the customer's existing birth chart.
  void setCheena(String? mediaId) =>
      emit(state.copyWith(cheenaMediaId: mediaId));

  /// Attaches (or clears, with null) the payment receipt.
  void setReceipt(String? mediaId) =>
      emit(state.copyWith(receiptMediaId: mediaId));

  void nextStep() => goToStep(state.step.index + 1);

  void previousStep() => goToStep(state.step.index - 1);

  /// Jumps to the step at [index] (clamped to the wizard's range).
  void goToStep(int index) => emit(
    state.copyWith(
      step: BookingStep.values[index.clamp(0, BookingStep.values.length - 1)],
    ),
  );

  Future<void> submit() async {
    final slot = state.slot;
    if (slot == null) return;
    emit(state.copyWith(submission: state.submission.toLoading()));
    final result = await _book(
      BookingRequest(
        astrologerId: state.astrologer.id,
        serviceId: state.serviceId,
        quantity: state.quantity,
        date: state.date,
        slotId: slot.id,
        customerName: state.customerName.trim(),
        phone: state.phone.trim(),
        email: state.email.trim(),
        country: state.country.trim(),
        paymentMethod: state.paymentMethod,
        birthPlace: state.birthPlace.trim().isEmpty ? null : state.birthPlace,
        birthDate: state.birthDate,
        birthTime: state.birthTime,
        notes: state.notes.trim().isEmpty ? null : state.notes.trim(),
        cheenaMediaId: state.cheenaMediaId,
        receiptMediaId: state.receiptMediaId,
      ),
    );
    emit(
      state.copyWith(
        submission: result.fold(state.submission.toFailed, LoadState.loaded),
      ),
    );
  }
}
