import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/event.dart';
import '../repositories/event_repository.dart';

part 'toggle_checklist_item.freezed.dart';

/// Parameters for [ToggleChecklistItem].
@freezed
abstract class ToggleChecklistParams with _$ToggleChecklistParams {
  const factory ToggleChecklistParams({
    required String eventId,
    required String itemId,
  }) = _ToggleChecklistParams;
}

/// Marks a checklist entry as done / not done.
class ToggleChecklistItem implements UseCase<Event, ToggleChecklistParams> {
  const ToggleChecklistItem(this._repo);
  final EventRepository _repo;

  @override
  Future<Result<Event>> call(ToggleChecklistParams params) =>
      _repo.toggleChecklistItem(params.eventId, params.itemId);
}
