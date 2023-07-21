import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/dashboard/myevent_screen.dart';
import 'package:sanathan_nepal_mobile_app/dashboard/home_screen.dart';
import 'package:sanathan_nepal_mobile_app/dashboard/menu_screen.dart';
import 'package:sanathan_nepal_mobile_app/dashboard/horoscope_screen.dart';
import 'package:sanathan_nepal_mobile_app/settings/setting_screen.dart';
import '../theme/theme_provider.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  static  List<Widget> allPage = <Widget>[
    const HomeScreen(),
    const HoroscopeScreen(),
    const MenuScreen(),
    const EventScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: themeProvider.bottomNavigationIconColor,
        type: BottomNavigationBarType.fixed,
        items:  [
          BottomNavigationBarItem(
            label: "Home",
            backgroundColor: Colors.white,
            icon: Image.asset('assets/images/home_icon.png',width: 22,height: 22,color: themeProvider.tabUnSelectedLabelColor),
            activeIcon: Image.asset('assets/images/home_icon.png',color: themeProvider.bottomNavigationIconColor),
          ),
          BottomNavigationBarItem(
            label: "horoscope",
            backgroundColor: Colors.white,
            icon: Image.asset('assets/images/horoscope 1.png',height: 22,width: 22,color: themeProvider.tabUnSelectedLabelColor,),
            activeIcon: Image.asset('assets/images/horoscope 1.png',color: themeProvider.bottomNavigationIconColor),
          ),
          const BottomNavigationBarItem(
            label: '',
            backgroundColor: Colors.white,
            icon: Icon(Icons.menu,size: 22),
            activeIcon: Icon(Icons.menu),
            // icon: Image.asset('assets/images/menu_icon.png',width: 33,height: 22),
            // activeIcon: Image.asset('assets/images/menu_icon.png',color: themeProvider.bottomNavigationIconColor),
          ),
          const BottomNavigationBarItem(
            label: "Event",
            backgroundColor: Colors.white,
            icon: Icon(Icons.calendar_today_outlined,size: 22),
            activeIcon: Icon(Icons.calendar_today),
          ),
          const BottomNavigationBarItem(
            label: "Profile",
            backgroundColor: Colors.white,
            icon: Icon(Icons.person_pin,size: 22),
            activeIcon: Icon(Icons.person_pin),
          ),
        ],
        currentIndex: selectIndex,
        onTap: onTapped,
      ),
      body: allPage.elementAt(selectIndex),
    );
  }

  onTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}
