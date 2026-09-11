import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: themeProvider.gradient2,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Notification Title',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('1h ago',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey))
                      ],
                    ),
                    subtitle: const Text(
                        'Lorem Ipsum Dolor Sit Ameet,Consectetur Adipi Scing Elit...',
                        style: TextStyle(fontSize: 12)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('My Birthday',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('2h ago',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey))
                      ],
                    ),
                    subtitle: const Text(
                        'Lorem Ipsum Dolor Ameet,Consectetur Adipi Scing Elit.Lorem Ipsum Dolor Sit Ameet,Consectetur Adipi Scing Elit...',
                        style: TextStyle(fontSize: 11)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Notification Title',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('1h ago',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey))
                      ],
                    ),
                    subtitle: const Text(
                        'Lorem Ipsum Dolor Sit Ameet,Consectetur Adipi Scing Elit...',
                        style: TextStyle(fontSize: 12)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Notification Title',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        Text('1h ago',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey))
                      ],
                    ),
                    subtitle: const Text(
                        'Lorem Ipsum Dolor Sit Ameet,Consectetur Adipi Scing Elit...',
                        style: TextStyle(fontSize: 12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
