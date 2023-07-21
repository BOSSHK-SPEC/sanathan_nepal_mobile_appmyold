import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/settings/mypurchase_screen.dart';
import 'package:sanathan_nepal_mobile_app/settings/mysales_screen.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

import '../browseproduct/myorder_browse_product.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
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
        body: Container(
          decoration: BoxDecoration(color: themeProvider.tabBackground2),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  'No Orders Yet !!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Text("you don't have an ongoing orders at this time."),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MyOrderBrowseProduct()));
                },
                child: Container(
                  height: 33,
                  width: 155,
                  decoration: BoxDecoration(
                      gradient: themeProvider.appointmentButtonColor,
                      borderRadius: BorderRadius.circular(33)),
                  child:  Center(
                      child: Text(
                    "Browse Products!",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: themeProvider.whiteTextColor),
                  )),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                ),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                              child: Text('User: My Purchase',
                                  style: TextStyle(fontSize: 8))),
                          Tab(
                              child: Text(
                            'Seller: My Sales',
                            style: TextStyle(fontSize: 8),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: SizedBox(
                  height: 333,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      MyPurchaseScreen(),
                      MySaleScreen(),
                    ],
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
