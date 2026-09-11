import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/domain/entities/app_notification.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/domain/usecases/get_notifications.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/domain/usecases/mark_all_notifications_read.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/domain/usecases/mark_notification_read.dart';
import 'package:sanathan_nepal_mobile_app/features/notifications/presentation/cubit/notifications_cubit.dart';

class _MockGet extends Mock implements GetNotifications {}

class _MockMarkRead extends Mock implements MarkNotificationRead {}

class _MockMarkAll extends Mock implements MarkAllNotificationsRead {}

void main() {
  late _MockGet get;
  late _MockMarkRead markRead;
  late _MockMarkAll markAll;

  final n1 = AppNotification(
    id: 'n1',
    titleNe: 'शीर्षक',
    titleEn: 'Title',
    bodyNe: 'विवरण',
    bodyEn: 'Body',
    createdAt: DateTime(2026, 8, 17, 9),
  );
  final n2 = n1.copyWith(isRead: true);

  setUp(() {
    get = _MockGet();
    markRead = _MockMarkRead();
    markAll = _MockMarkAll();
  });

  NotificationsCubit build() => NotificationsCubit(
    getNotifications: get,
    markRead: markRead,
    markAllRead: markAll,
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'load emits loading → success and counts unread',
    build: build,
    setUp: () => when(get.call).thenAnswer((_) async => Result.success([n1])),
    act: (c) => c.load(),
    expect: () => [
      const NotificationsState(notifications: LoadState.loading()),
      NotificationsState(notifications: LoadState.loaded([n1])),
    ],
    verify: (c) => expect(c.state.unreadCount, 1),
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'load failure',
    build: build,
    setUp: () => when(
      get.call,
    ).thenAnswer((_) async => const Result.failure(NetworkFailure())),
    act: (c) => c.load(),
    expect: () => const [
      NotificationsState(notifications: LoadState.loading()),
      NotificationsState(notifications: LoadState.failed(NetworkFailure())),
    ],
  );

  blocTest<NotificationsCubit, NotificationsState>(
    'markRead replaces the item; markAllRead flags all',
    build: build,
    seed: () => NotificationsState(
      notifications: LoadState.loaded([n1, n1.copyWith().copyWith()]),
    ),
    setUp: () {
      when(() => markRead('n1')).thenAnswer((_) async => Result.success(n2));
      when(markAll.call).thenAnswer((_) async => const Result.success(null));
    },
    act: (c) async {
      await c.markRead('n1');
      await c.markAllRead();
    },
    verify: (c) {
      expect(c.state.unreadCount, 0);
      verify(() => markRead('n1')).called(1);
      verify(markAll.call).called(1);
    },
  );
}
