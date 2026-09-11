import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../models/notification_prefs_model.dart';
import 'notification_prefs_local_data_source.dart';

/// Notification preferences, written through to the server.
///
/// These settings decide what the push worker sends, so the server is the one
/// that has to know them: a device that only remembered "no festival
/// reminders" locally would keep receiving them. The server is written first —
/// if that call fails the local copy is left alone, so the switch the user
/// sees never claims something the sender does not know about.
///
/// Reads stay local and synchronous: the settings screen renders on the first
/// frame, and the values it shows were written by this same path.
class ApiNotificationPrefsDataSource
    implements NotificationPrefsLocalDataSource {
  const ApiNotificationPrefsDataSource({
    required ApiClient client,
    required NotificationPrefsLocalDataSource local,
  }) : _client = client,
       _local = local;

  final ApiClient _client;
  final NotificationPrefsLocalDataSource _local;

  @override
  NotificationPrefsModel read() => _local.read();

  @override
  Future<void> write(NotificationPrefsModel model) async {
    await guardApi(
      () => _client.patch<dynamic>(
        ApiEndpoints.notificationSettings,
        data: {
          // One flat map: the server keeps these as JSON precisely so a new
          // reminder kind does not need a schema change on either side.
          'channels': {
            'horoscopeDaily': model.horoscopeDaily,
            'horoscopeMonthly': model.horoscopeMonthly,
            'horoscopeYearly': model.horoscopeYearly,
            'horoscopeTimeMinutes': model.horoscopeTimeMinutes,
            'importantFestivals': model.importantFestivals,
            'commonFestivals': model.commonFestivals,
            'publicHolidays': model.publicHolidays,
            'festivalRemindDaysBefore': model.festivalRemindDaysBefore,
            'festivalTimeMinutes': model.festivalTimeMinutes,
            'birthdays': model.birthdays,
            'birthdayRemindDaysBefore': model.birthdayRemindDaysBefore,
            'birthdayTimeMinutes': model.birthdayTimeMinutes,
          },
        },
      ),
    );
    await _local.write(model);
  }
}
