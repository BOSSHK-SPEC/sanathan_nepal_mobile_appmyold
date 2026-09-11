import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/di/injection.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/data/datasources/mock_messaging_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/data/repositories/messaging_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/domain/usecases/messaging_usecases.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/messaging_routes.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/cubit/message_thread_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/cubit/message_threads_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/pages/message_thread_page.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/pages/message_threads_page.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

void main() {
  late InMemoryKeyValueStore store;
  late MessagingRepositoryImpl repo;
  late AppSettingsCubit settings;

  setUp(() {
    store = InMemoryKeyValueStore();
    repo = MessagingRepositoryImpl(MockMessagingDataSource(store));
    final prefsRepo = AppPreferencesRepositoryImpl(
      AppPreferencesLocalDataSourceImpl(store),
    );
    settings = AppSettingsCubit(
      getPreferences: GetAppPreferences(prefsRepo),
      savePreferences: SaveAppPreferences(prefsRepo),
    );

    if (sl.isRegistered<MessageThreadsCubit>()) {
      sl.unregister<MessageThreadsCubit>();
    }
    if (sl.isRegistered<MessageThreadCubit>()) {
      sl.unregister<MessageThreadCubit>();
    }
    sl
      ..registerFactory(
        () => MessageThreadsCubit(
          getThreads: GetMessageThreads(repo),
          setArchived: SetThreadArchived(repo),
        ),
      )
      ..registerFactoryParam<MessageThreadCubit, String?, String?>(
        (threadId, businessId) => MessageThreadCubit(
          getThread: GetMessageThread(repo),
          getThreadWithBusiness: GetThreadWithBusiness(repo),
          getMessages: GetThreadMessages(repo),
          messageBusiness: MessageBusiness(repo),
          reply: ReplyToThread(repo),
          markRead: MarkThreadRead(repo),
          threadId: threadId,
          businessId: businessId,
        ),
      );
  });

  Future<void> open(WidgetTester tester, String location) async {
    final router = GoRouter(initialLocation: location, routes: messagingRoutes);
    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
        builder: (context, child) => BlocProvider<AppSettingsCubit>.value(
          value: settings,
          child: child!,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('/messages opens the inbox', (tester) async {
    await open(tester, AppRoutes.messages);
    expect(find.byType(MessageThreadsPage), findsOneWidget);
  });

  testWidgets('/messages/:id opens that conversation', (tester) async {
    await open(tester, AppRoutes.messageThreadPath('thread-seed-1'));
    expect(find.byType(MessageThreadPage), findsOneWidget);
    expect(find.text('Yes, we have 5 mukhi in stock.'), findsOneWidget);
  });

  testWidgets('/messages/business/:id is matched before /messages/:id', (
    tester,
  ) async {
    // Registered in that order on purpose: read as a thread id, `business`
    // would open a conversation that does not exist.
    await open(tester, AppRoutes.businessMessageThreadPath('biz-2'));
    expect(find.byType(MessageThreadPage), findsOneWidget);
    expect(find.text('Start the conversation'), findsOneWidget);
  });
}
