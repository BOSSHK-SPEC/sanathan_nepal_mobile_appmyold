import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';
import 'package:sanathan_nepal_mobile_app/event/myEventsScreen.dart';
import 'package:sanathan_nepal_mobile_app/view/screens/signupOrLoginScreen.dart';
import 'package:sanathan_nepal_mobile_app/view/screens/welcomeScreen.dart';
import 'dashboard/eventProvider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(
        ChangeNotifierProvider(
          create: (context) => EventProvider(),
          child: const MyApp(),
        ),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(false),
      child: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeProvider.themeData,
            initialRoute: '/',
            routes: {
              '/': (context) => const WelcomeScreen(),
              '/SignupOrLoginScreen': (context) => const SignupOrLoginScreen(),
              '/MyEventsScreen': (context) => const MyEventsScreen(),
            },
          );
        },
      ),
    );
  }
}
