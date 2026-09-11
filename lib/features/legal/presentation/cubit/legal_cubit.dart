import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/legal_document.dart';
import '../../domain/usecases/get_legal_document.dart';
import '../../../../core/state/app_cubit.dart';

part 'legal_cubit.freezed.dart';
part 'legal_state.dart';

/// Loads and exposes a single [LegalDocument].
class LegalCubit extends AppCubit<LegalState> {
  LegalCubit(this._getDocument) : super(const LegalState());

  final GetLegalDocument _getDocument;

  Future<void> load(LegalDocumentType type) async {
    emit(state.copyWith(document: state.document.toLoading()));
    final result = await _getDocument(type);
    emit(
      state.copyWith(
        document: result.fold(state.document.toFailed, LoadState.loaded),
      ),
    );
  }
}
