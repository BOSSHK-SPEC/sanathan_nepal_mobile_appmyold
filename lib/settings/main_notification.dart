import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/settings/notifications_screen.dart';
import 'package:sanathan_nepal_mobile_app/settings/notifications_setting_screen.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class MainNotification extends StatefulWidget {
  const MainNotification({Key? key}) : super(key: key);

  @override
  State<MainNotification> createState() => _MainNotificationState();
}

class _MainNotificationState extends State<MainNotification>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 33,
                    width: 220,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: themeProvider.tabColor,
                      labelColor: themeProvider.tabUnSelectedLabelColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(
                            child: Text('Notifications',
                                style: TextStyle(fontSize: 8))),
                        Tab(
                            child: Text(
                          'Notifications Settings',
                          style: TextStyle(fontSize: 8),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6),
              child: SizedBox(
                height: 500,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    NotificationsScreen(),
                    NotificationsSettingScreen(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
