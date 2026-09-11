import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/message_thread.dart';
import '../../domain/usecases/messaging_usecases.dart';

part 'message_threads_cubit.freezed.dart';
part 'message_threads_state.dart';

/// The inbox: every conversation the user takes part in, on either side.
class MessageThreadsCubit extends AppCubit<MessageThreadsState> {
  MessageThreadsCubit({
    required GetMessageThreads getThreads,
    required SetThreadArchived setArchived,
  }) : _getThreads = getThreads,
       _setArchived = setArchived,
       super(const MessageThreadsState());

  final GetMessageThreads _getThreads;
  final SetThreadArchived _setArchived;

  Future<void> load() async {
    emit(state.copyWith(threads: state.threads.toLoading()));
    final result = await _getThreads(state.showArchived);
    emit(
      state.copyWith(
        threads: result.fold(state.threads.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> showArchived({required bool archived}) async {
    if (state.showArchived == archived) return;
    emit(state.copyWith(showArchived: archived));
    await load();
  }

  Future<void> archive(String threadId, {required bool archived}) async {
    final result = await _setArchived(
      ArchiveParams(threadId: threadId, archived: archived),
    );
    // Reload rather than patching in place: archiving moves a thread between
    // the two lists, and which one it lands in is the server's call.
    await result.fold((failure) async {
      emit(state.copyWith(threads: state.threads.toFailed(failure)));
    }, (_) => load());
  }
}
