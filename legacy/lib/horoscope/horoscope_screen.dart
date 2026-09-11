import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/horoscope/daily_screem.dart';
import 'package:sanathan_nepal_mobile_app/horoscope/monthly_screen.dart';
import 'package:sanathan_nepal_mobile_app/horoscope/weekly_screen.dart';
import 'package:sanathan_nepal_mobile_app/horoscope/yearly_screen.dart';

import '../theme/theme_provider.dart';

class HoroScope extends StatefulWidget {
  const HoroScope({Key? key}) : super(key: key);

  @override
  State<HoroScope> createState() => _HoroScopeState();
}

class _HoroScopeState extends State<HoroScope>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          indicatorPadding: EdgeInsets.only(left: 12,right: 12),
          indicatorColor: themeProvider.tabColor,
          labelColor: themeProvider.tabUnSelectedLabelColor,

          controller: _tabController,
          tabs: const [
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
            Tab(text: 'Monthly'),
            Tab(text: 'Yearly'),
          ],
        ),
        title:  Text('Daily Horoscope',style: TextStyle(color: themeProvider.tabUnSelectedLabelColor)),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DailyScreen(),
          WeeklyScreen(),
          MonthlyScreen(),
          YearlyScreen(),
        ],
      ),
    );
  }
}
