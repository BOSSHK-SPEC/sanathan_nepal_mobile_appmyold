import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/settings/about_screen.dart';
import 'package:sanathan_nepal_mobile_app/settings/activites_screen.dart';
import 'package:sanathan_nepal_mobile_app/settings/edit_user_profile.dart';
import 'package:sanathan_nepal_mobile_app/settings/link_screen.dart';
import 'package:sanathan_nepal_mobile_app/settings/main_notification.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with
        AutomaticKeepAliveClientMixin<SettingScreen>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  late TabController tabController;
  int currentIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabControllerListener);
    tabController.index = 0;
    super.initState();
  }

  void tabControllerListener() {
    currentIndex = tabController.index;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          Container(
              decoration: BoxDecoration(gradient: themeProvider.appBar),
              width: MediaQuery.of(context).size.width,
              height: 170,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topLeft,
                children: [
                  Positioned(
                      top: 99,
                      left: 18,
                      child:Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33),
                          border: Border.all(
                            color: themeProvider.corner!
                          ),
                          color: Colors.grey
                        ),
                        child: const Icon(Icons.camera_alt,size: 12),
                      )),
                  Positioned(
                      top: 33,
                      right: 18,
                      child: Row(
                        children:  [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.notifications,
                              size: 18,
                              color: themeProvider.whiteTextColor!,
                            ),
                          ),
                          Icon(
                            Icons.logout_outlined,
                            size: 18,
                            color: themeProvider.whiteTextColor!,

                          ),
                        ],
                      )),
                  Positioned(
                      top: 118,
                      left: 120,
                      child: Row(
                        children:  [
                          Text("Kritika Paudel",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18,color: themeProvider.whiteTextColor!,
                              )),
                          Image.asset('assets/images/verified (1) 1.png'),
                          SizedBox(width: 4,),
                          Image.asset('assets/images/Cancel.png'),

                        ],
                      )),
                  Positioned(
                      top: 140,
                      left: 120,
                      child: Row(
                        children: [
                           SizedBox(
                            width: 170,
                            child: Text("kritikapaudel9@gmail.com",
                                style: TextStyle(fontSize: 13,color: themeProvider.whiteTextColor!)),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>const EditUserProfile()));
                            },
                            child: Container(
                              height: 20,
                              width: 77,
                              decoration: BoxDecoration(
                                  color: themeProvider.tabColor,
                                  borderRadius: BorderRadius.circular(33)),
                              child: Row(
                                children:  [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      'Edit Profile',
                                      style: TextStyle(fontSize: 9,color: themeProvider.whiteTextColor!),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset('assets/images/Union.png',height: 12,width: 12,)
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                  Positioned(
                      top: 82,
                      left: 2,
                      child: Image.asset('assets/images/Ellipse 6.png')),
                  Positioned(
                      top: 166,
                      left: 16,
                      child: Container(
                        height: 16,
                        width: 99,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: themeProvider.appBar),
                        child: Center(
                            child: Text(
                          'Complete Your Profile',
                          style: TextStyle(fontSize: 9,color: themeProvider.whiteTextColor!),
                        )),
                      )),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 44.0, right: 44, top: 24),
            child: SizedBox(
              height: 28,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: themeProvider.bookAppointmentBackground,
                  borderRadius: BorderRadius.circular(33),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 4, bottom: 4),
                  child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                      color: themeProvider.tabColor,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: themeProvider.tabUnSelectedLabelColor,
                    tabs: const [
                      FittedBox(
                        child: Padding(
                          padding: EdgeInsets.only(top: 3.0),
                          child: Tab(
                            text: 'ABOUT',
                            height: 25,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Padding(
                          padding: EdgeInsets.only(top: 3.0),
                          child: Tab(
                            text: 'ACTIVITIES',
                            height: 25,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Padding(
                          padding: EdgeInsets.only(top: 3.0),
                          child: Tab(
                            text: 'NOTIFICATIONS',
                            height: 22,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Padding(
                          padding: EdgeInsets.only(top: 3.0),
                          child: Tab(
                            text: 'LINK',
                            height: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 562,
            child: TabBarView(
              controller: tabController,
              children: const [
                AboutScreen(),
                ActivitesScreen(),
                MainNotification(),
                LinkScreen(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
