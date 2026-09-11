import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/astrologer_client.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'clients_cubit.freezed.dart';
part 'clients_state.dart';

/// Client list with search, and per-client notes.
class ClientsCubit extends AppCubit<ClientsState> {
  ClientsCubit({
    required GetClients getClients,
    required SaveClientNotes saveNotes,
  }) : _getClients = getClients,
       _saveNotes = saveNotes,
       super(const ClientsState());

  final GetClients _getClients;
  final SaveClientNotes _saveNotes;

  Future<void> load() async {
    emit(state.copyWith(clients: state.clients.toLoading()));
    final result = await _getClients();
    emit(
      state.copyWith(
        clients: result.fold(state.clients.toFailed, LoadState.loaded),
      ),
    );
  }

  void search(String query) => emit(state.copyWith(query: query));

  void setSort(ClientSort sort) => emit(state.copyWith(sort: sort));

  Future<void> saveNotes(String clientId, String notes) async {
    final result = await _saveNotes(
      SaveClientNotesParams(clientId: clientId, notes: notes),
    );
    if (result.isSuccess) await load();
  }
}
