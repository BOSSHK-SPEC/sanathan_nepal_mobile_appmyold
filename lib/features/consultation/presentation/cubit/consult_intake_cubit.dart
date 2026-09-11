import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../astrologers/domain/entities/astrologer.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../astrologers/domain/usecases/get_astrologer.dart';
import '../../domain/entities/consult_intake.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/usecases/consultation_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'consult_intake_cubit.freezed.dart';
part 'consult_intake_state.dart';

/// Pre-session screen: confirm birth details, pick a channel, state the
/// question, and see what it will cost before committing.
class ConsultIntakeCubit extends AppCubit<ConsultIntakeState> {
  ConsultIntakeCubit({
    required String astrologerId,
    required ConsultChannel? initialChannel,
    required GetAstrologer getAstrologer,
    required GetSpendableBalance getBalance,
    required StartConsultation startConsultation,
  }) : _astrologerId = astrologerId,
       _getAstrologer = getAstrologer,
       _getBalance = getBalance,
       _startConsultation = startConsultation,
       super(
         ConsultIntakeState(
           intake: ConsultIntake(
             astrologerId: astrologerId,
             channel: initialChannel ?? ConsultChannel.chat,
           ),
         ),
       );

  final String _astrologerId;
  final GetAstrologer _getAstrologer;
  final GetSpendableBalance _getBalance;
  final StartConsultation _startConsultation;

  Future<void> load() async {
    emit(state.copyWith(astrologer: state.astrologer.toLoading()));
    final astrologerFuture = _getAstrologer(_astrologerId);
    final balanceFuture = _getBalance();
    final astrologer = await astrologerFuture;
    final balance = await balanceFuture;

    emit(
      state.copyWith(
        astrologer: astrologer.fold(
          state.astrologer.toFailed,
          LoadState.loaded,
        ),
        balance: balance.valueOrNull ?? 0,
        // Fall back to a channel the astrologer actually offers.
        intake: astrologer.valueOrNull == null
            ? state.intake
            : state.intake.copyWith(
                channel:
                    astrologer.valueOrNull!.channels.contains(
                      state.intake.channel,
                    )
                    ? state.intake.channel
                    : (astrologer.valueOrNull!.channels.firstOrNull ??
                          ConsultChannel.chat),
              ),
      ),
    );
  }

  void setChannel(ConsultChannel channel) =>
      emit(state.copyWith(intake: state.intake.copyWith(channel: channel)));

  void setName(String name) =>
      emit(state.copyWith(intake: state.intake.copyWith(name: name)));

  void setBirthDate(DateTime date) =>
      emit(state.copyWith(intake: state.intake.copyWith(birthDate: date)));

  void setBirthTime(String time) =>
      emit(state.copyWith(intake: state.intake.copyWith(birthTime: time)));

  void setBirthTimeUnknown({required bool unknown}) => emit(
    state.copyWith(intake: state.intake.copyWith(birthTimeUnknown: unknown)),
  );

  void setBirthPlace(String place) =>
      emit(state.copyWith(intake: state.intake.copyWith(birthPlace: place)));

  void setQuestion(String question) =>
      emit(state.copyWith(intake: state.intake.copyWith(question: question)));

  /// Starts the session. Affordability is decided by the data source, not
  /// pre-checked here, so there is one authority and no race.
  Future<Consultation?> start() async {
    if (!state.canStart) return null;
    emit(state.copyWith(starting: state.starting.toLoading()));
    final result = await _startConsultation(state.intake);
    return result.fold(
      (failure) {
        emit(state.copyWith(starting: state.starting.toFailed(failure)));
        return null;
      },
      (consultation) {
        emit(state.copyWith(starting: LoadState.loaded(consultation)));
        return consultation;
      },
    );
  }
}
