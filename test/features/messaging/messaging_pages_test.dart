import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/datasources/app_preferences_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/data/repositories/app_preferences_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/get_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/domain/usecases/save_app_preferences.dart';
import 'package:sanathan_nepal_mobile_app/features/app_settings/presentation/cubit/app_settings_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/data/datasources/mock_messaging_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/data/repositories/messaging_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/domain/usecases/messaging_usecases.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/cubit/message_thread_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/cubit/message_threads_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/pages/message_thread_page.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/pages/message_threads_page.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/widgets/message_bubble.dart';
import 'package:sanathan_nepal_mobile_app/features/messaging/presentation/widgets/thread_tile.dart';
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
  });

  Widget wrap(Widget child, {Locale locale = const Locale('en')}) =>
      MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<AppSettingsCubit>.value(
          value: settings,
          child: child,
        ),
      );

  MessageThreadsCubit threadsCubit() => MessageThreadsCubit(
    getThreads: GetMessageThreads(repo),
    setArchived: SetThreadArchived(repo),
  );

  MessageThreadCubit threadCubit({String? threadId, String? businessId}) =>
      MessageThreadCubit(
        getThread: GetMessageThread(repo),
        getThreadWithBusiness: GetThreadWithBusiness(repo),
        getMessages: GetThreadMessages(repo),
        messageBusiness: MessageBusiness(repo),
        reply: ReplyToThread(repo),
        markRead: MarkThreadRead(repo),
        threadId: threadId,
        businessId: businessId,
      );

  testWidgets('the inbox lists conversations, both sides labelled', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => threadsCubit()..load(),
          child: const MessageThreadsView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ThreadTile), findsNWidgets(2));
    // The user here has both a shop and an enquiry, so the groups are named.
    expect(find.text('My business'), findsOneWidget);
    expect(find.text('My enquiries'), findsOneWidget);
    expect(find.text('Uttam Astro & Gems'), findsOneWidget);
  });

  testWidgets('an empty archived view says so rather than showing nothing', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => threadsCubit()..load(),
          child: const MessageThreadsView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Archived'));
    await tester.pumpAndSettle();

    expect(find.text('Nothing archived'), findsOneWidget);
    expect(find.byType(ThreadTile), findsNothing);
  });

  testWidgets('a conversation renders its transcript', (tester) async {
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => threadCubit(threadId: 'thread-seed-1')..load(),
          child: const MessageThreadView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MessageBubble), findsNWidgets(2));
    expect(find.text('Yes, we have 5 mukhi in stock.'), findsOneWidget);
    expect(find.text('Uttam Astro & Gems'), findsOneWidget);
  });

  testWidgets('a shop with no history opens on a prompt, not an error', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => threadCubit(businessId: 'biz-2')..load(),
          child: const MessageThreadView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Start the conversation'), findsOneWidget);
    expect(find.byType(MessageBubble), findsNothing);
  });

  testWidgets('typing and sending puts the message in the transcript', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => threadCubit(businessId: 'biz-2')..load(),
          child: const MessageThreadView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Do you ship to Pokhara?');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Do you ship to Pokhara?'), findsOneWidget);
    expect(find.byType(MessageBubble), findsOneWidget);
    // The composer is cleared, so tapping send twice cannot post it again.
    expect(find.text('Start the conversation'), findsNothing);
  });

  testWidgets('an empty composer cannot send', (tester) async {
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => threadCubit(businessId: 'biz-2')..load(),
          child: const MessageThreadView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(MessageBubble), findsNothing);
  });

  testWidgets('the owner reads the same thread from their own side', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => threadCubit(threadId: 'thread-seed-2')..load(),
          child: const MessageThreadView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The customer's enquiry, seen by the shop: the name in the bar is the
    // person who wrote in, not the shop itself.
    expect(find.text('Anisha Shrestha'), findsOneWidget);
    expect(find.text('Do you deliver to Pokhara?'), findsOneWidget);
  });

  testWidgets('the inbox renders in Nepali', (tester) async {
    await tester.pumpWidget(
      wrap(
        BlocProvider(
          create: (_) => threadsCubit()..load(),
          child: const MessageThreadsView(),
        ),
        locale: const Locale('ne'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('सन्देशहरू'), findsOneWidget);
    expect(find.text('इनबक्स'), findsOneWidget);
  });
}
