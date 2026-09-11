import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';
import 'myappointment.dart';
import 'myorder_screen.dart';

class ActivitesScreen extends StatefulWidget {
  const ActivitesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitesScreen> createState() => _ActivitesScreenState();
}

class _ActivitesScreenState extends State<ActivitesScreen>
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
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: themeProvider.tabBackground2,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6))

                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 33,
                      width: 200,
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: themeProvider.tabColor,
                        labelColor: themeProvider.tabUnSelectedLabelColor,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(
                              child: Text('My Appointments',
                                  style: TextStyle(fontSize: 8))),
                          Tab(
                              child: Text(
                            'My Orders',
                            style: TextStyle(fontSize: 8),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: SizedBox(
                height: 500,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    MyAppointmentScreen(),
                    MyOrderScreen(),
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
