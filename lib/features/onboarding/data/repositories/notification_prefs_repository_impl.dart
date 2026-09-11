import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/notification_prefs.dart';
import '../../domain/repositories/notification_prefs_repository.dart';
import '../datasources/notification_prefs_local_data_source.dart';
import '../models/notification_prefs_model.dart';

/// Local-only implementation of [NotificationPrefsRepository].
class NotificationPrefsRepositoryImpl implements NotificationPrefsRepository {
  NotificationPrefsRepositoryImpl(this._local);
  final NotificationPrefsLocalDataSource _local;

  @override
  Future<Result<NotificationPrefs>> load() =>
      guard(() => _local.read().toEntity());

  @override
  Future<Result<void>> save(NotificationPrefs prefs) =>
      guard(() => _local.write(NotificationPrefsModel.fromEntity(prefs)));
}
