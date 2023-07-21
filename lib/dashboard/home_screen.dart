/*
import 'package:flutter/material.dart';

import '../horoscope/horoscope_screen.dart';
import '../view/helper/styles.dart';
import '../view/screens/homeScreen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 22,),
                  Card(
                    elevation: 4,
                    child: SizedBox(
                        height: 240,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              child: Card(
                                elevation: 0,
                                child: SizedBox(
                                  width: 100,
                                  height: 232,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 14,),
                                      Text(
                                        'Horoscope',
                                        style: TextStyles.subheading,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.amberAccent,
                                        child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/aeries 1.png',
                                              fit: BoxFit.cover,
                                              width: 80,
                                              height: 80,
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 88,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (_)=>const HoroScope()));
                                          },
                                          style: ButtonStyle(
                                            fixedSize: MaterialStateProperty.all<Size>(
                                              const Size(100,
                                                  40), // Set the desired width and height
                                            ),
                                          ),
                                          child: Text(
                                            'All Horoscope',
                                            style: TextStyles.body,
                                          ),
                                        ),
                                      ),
                                      const Icon(Icons.notifications_active_outlined),
                                      const Text('notification on your time '),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 94,
                              child: SizedBox(
                                width: 260,
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 0,
                                      child: TabBar(
                                        controller: _tabController,
                                        indicatorColor: Colors.deepOrange,
                                        labelColor: Colors.deepOrange,
                                        unselectedLabelColor: Colors.grey,
                                        tabs: const [
                                          SizedBox(
                                            width: 88,
                                              child: Tab(text: 'Tab 1')),
                                          Tab(text: 'Tab 2'),
                                          Tab(text: 'Tab 3'),
                                          Tab(text: 'Tab 4'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: 52,
                                left: 94,
                                right: 0,
                                child: Container(
                                  height: 188,
                                  width: 260,
                                  child: Card(
                                    elevation: 0,
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: const [
                                        Tab1Content(),
                                        Center(child: Text('Content for Tab 2')),
                                        Center(child: Text('Content for Tab 3')),
                                        Center(child: Text('Content for Tab 4')),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
*/

import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/horoscope/horoscope_screen.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/styles.dart';
import '../calendar/pages/feature_calendar.dart';
import '../view/widgets/lineGraphPointer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedValue = 1;
  late TabController _tabController;
  Country? countryName;
  Currency? name;
  Currency? nepalName;
  double? rate;
  double amountFrom = 0.0;
  double amountTo = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // bottomNavigationBar: CustomBottomNavBar(),
      appBar: AppBar(
        title: Text('Home Page',
            style: TextStyle(color: themeProvider.tabUnSelectedLabelColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                SizedBox(height: height*0.38, child: const FeatureCalendar()),

                Container(
                  height: 148,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Text('Kathmandu', style: TextStyles.subheading()),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Text('71°|',
                                    style: TextStyle(
                                        color: themeProvider.tabColor,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w900)),
                                Image.asset(
                                  'assets/images/Group 3.png',
                                  height: 28,
                                  width: 28,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              'party cloud',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              ' H:81° L:72°',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: 130,
                          width: 265,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: themeProvider.corner!),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 65,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Column(
                                            children: [
                                              const Text('6:45',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                width: 26,
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              const Text('29°C',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 22,
                                          ),
                                          Column(
                                            children: [
                                              const Text('7:45',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                width: 28,
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              const Text('29°C',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 22,
                                          ),
                                          Column(
                                            children: [
                                              const Text('8:45',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                width: 26,
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              const Text('29°C',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 22,
                                          ),
                                          Column(
                                            children: [
                                              const Text('9:45',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                width: 26,
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              const Text('29°C',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 22,
                                          ),
                                          Column(
                                            children: [
                                              const Text('10:45',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                width: 26,
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              const Text('29°C',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 22,
                                          ),

                                          /*  Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: const [
                                              Text('9:45'),
                                              Text('12:45'),
                                              Text('3:45'),
                                              Text('6:45'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                width: 30,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                height: 30,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                width: 30,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                height: 30,
                                              ),
                                            ],
                                          ),
                                          CustomPaint(
                                            size: const Size(200,
                                                50), // Set the desired size of the graph
                                            painter: LineGraphPainter(
                                              dataPoints: [
                                                2,
                                                4,
                                                3,
                                                6,
                                                5,
                                                2,
                                                5,
                                                2
                                              ], // Example data points
                                              maxValue:
                                              9, // Example maximum value on the y-axis
                                              lineWidth:
                                              2.0, // Optional: Set the line width
                                              lineColor: Colors
                                                  .blue, // Optional: Set the line color
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: const [
                                              Icon(
                                                Icons.water_drop,
                                                size: 15,
                                              ),
                                              Text('10%'),
                                              Icon(
                                                Icons.water_drop,
                                                size: 15,
                                              ),
                                              Text('10%'),
                                              Icon(
                                                Icons.water_drop,
                                                size: 15,
                                              ),
                                              Text('10%'),
                                              Icon(
                                                Icons.water_drop,
                                                size: 15,
                                              ),
                                              Text('10%'),
                                            ],
                                          ),*/
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Column(
                                        children: [
                                          CustomPaint(
                                            size: const Size(220,
                                                26), // Set the desired size of the graph
                                            painter: LineGraphPainter(
                                              dataPoints: [
                                                2,
                                                4,
                                                3,
                                                6,
                                                5,
                                                2,
                                                5,
                                                2,
                                              ], // Example data points
                                              maxValue:
                                                  9, // Example maximum value on the y-axis
                                              lineWidth:
                                                  2.0, // Optional: Set the line width
                                              lineColor: Colors
                                                  .blue, // Optional: Set the line color
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children:  const [
                                              SizedBox(width: 8,),
                                              Icon(
                                                Icons.water_drop,
                                                size: 14,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 14.0),
                                                child: Text('10% ',
                                                    style: TextStyle(
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.water_drop,
                                                size: 14,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 14.0),
                                                child: Text('10% ',
                                                    style: TextStyle(
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.water_drop,
                                                size: 14,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 14.0),
                                                child: Text('10% ',
                                                    style: TextStyle(
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.water_drop,
                                                size: 14,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 14.0),
                                                child: Text('10% ',
                                                    style: TextStyle(
                                                        fontSize: 10)),
                                              ),
                                              Icon(
                                                Icons.water_drop,
                                                size: 14,
                                              ),
                                              Text('10% ',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                              SizedBox(width: 8,),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 8),
                SizedBox(
                  height: 242,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            gradient: themeProvider.gradient2,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomLeft: Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            top: 10.0,
                          ),
                          child: Column(
                            children: [
                              Text('Horoscope', style: TextStyles.subheading()),
                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 66,
                                width: 66,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.amberAccent,
                                  child: ClipOval(
                                      child: Image.asset(
                                    'assets/images/aeries 1.png',
                                    fit: BoxFit.cover,
                                  )),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: 70,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const HoroScope(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.zero,
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    elevation:
                                        MaterialStateProperty.all<double>(0),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: themeProvider.tabColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '       All'
                                        '\nHoroscope',
                                        style: TextStyles.smallBody(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Icon(Icons.notifications_active_outlined,
                                  size: 24, color: themeProvider.tabColor),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Notification on \n    your time ',
                                style: TextStyles.smallBody(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              gradient: themeProvider.gradient2,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              )),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 38,
                                      child: TabBar(
                                        controller: _tabController,
                                        indicatorPadding: const EdgeInsets.only(
                                            left: 18, right: 18, bottom: 12),
                                        indicatorColor: themeProvider.tabColor,
                                        labelColor: themeProvider.textColor,
                                        unselectedLabelColor: Colors.grey,
                                        tabs: const [
                                          Tab(
                                            child: Text('Daily',
                                                style: TextStyle(fontSize: 10)),
                                          ),
                                          Tab(
                                            child: Text('Monthly',
                                                style: TextStyle(fontSize: 10)),
                                          ),
                                          Tab(
                                            child: Text('Weekly',
                                                style: TextStyle(fontSize: 10)),
                                          ),
                                          Tab(
                                            child: Text('Yearly',
                                                style: TextStyle(fontSize: 10)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: const [
                                    Tab1Content(),
                                    Center(child: Text('Content for Tab 2')),
                                    Center(child: Text('Content for Tab 3')),
                                    Center(child: Text('Content for Tab 4')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2),
                  child: ExpansionCard(
                    margin: const EdgeInsets.only(bottom: 8, top: 8),
                    trailing: SizedBox(
                        width: 11,
                        child: Divider(
                          color: themeProvider.tabColor,
                          thickness: 2,
                        )),
                    title: Column(
                      children: <Widget>[
                        Row(
                          children: [ 
                            Text('Events & to Do',
                                style: TextStyle(
                                    color:
                                        themeProvider.tabUnSelectedLabelColor,
                                    fontWeight: FontWeight.bold)),
                            const Spacer(),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: themeProvider.tabColor),
                              width: 60,
                              height: 20,
                              child: Center(
                                  child: Text(
                                'All Event',
                                style: TextStyle(
                                    color: themeProvider.whiteTextColor,
                                    fontSize: 11),
                              )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/MyEventsScreen');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: themeProvider.corner!)),
                                width: 60,
                                height: 20,
                                child: Center(
                                    child: Text(
                                  'My Event',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color:
                                        themeProvider.tabUnSelectedLabelColor,
                                  ),
                                )),
                              ),
                            ),

                            /*BorderedButton(
                              onPressed: () {
                                // Handle button press
                                Navigator.pushNamed(context, '/MyEventsScreen');
                                //Navigator.push(context, MaterialPageRoute(builder: (_)=>MyEventScreen()));
                              },
                              borderColor:
                                  Colors.red, // Pass the desired border color
                              textColor: themeProvider
                                  .textColor, // Pass the desired text color
                              width: 60, // Pass the desired width
                              height: 20,
                              text: 'My Events',
                            ),*/
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                      Border.all(color: themeProvider.corner!)),
                              width: 40,
                              height: 20,
                              child: Center(
                                  child: Text(
                                'To Do',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: themeProvider.tabUnSelectedLabelColor,
                                ),
                              )),
                            ),
                            /*Padding(
                              padding:
                              const EdgeInsets.only(left: 8.0, right: 4),
                              child: SizedBox(
                                  width: 11,
                                  child: Divider(
                                    color: themeProvider.tabColor,
                                    thickness: 2,
                                  )),
                            ),*/
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: Colors.red,
                                  )),
                              height: 20,
                              width: 40,
                              child: const Center(
                                  child: Text(
                                'Holiday',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red,
                                ),
                              )),
                            ),
                            const SizedBox(width: 4,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: Colors.green,
                                  )),
                              height: 20,
                              width: 38,
                              child: const Center(
                                  child: Text(
                                'Today',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                ),
                              )),
                            ),
                            const SizedBox(width: 2,),

                            Icon(
                              Icons.circle,
                              size: 10,
                              color: themeProvider.tabColor,
                            ),
                            Text(
                              ' Pahadma Holi',
                              style: TextStyle(
                                fontSize: 10,
                                color: themeProvider.tabUnSelectedLabelColor,
                              ),
                            ),
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: themeProvider.tabColor,
                            ),
                            Text(
                              ' Pahadma Holi',
                              style: TextStyle(
                                fontSize: 10,
                                color: themeProvider.tabUnSelectedLabelColor,
                              ),
                            ),
                            
                            const Icon(Icons.circle,
                                size: 10, color: Colors.grey),
                            Text(
                              ' Pahadma Holi',
                              style: TextStyle(
                                fontSize: 10,
                                color: themeProvider.tabUnSelectedLabelColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 70,
                              width: 120,
                              child: Image.asset(
                                'assets/images/Rectangle 1059.png',
                                fit: BoxFit.fill,
                                height: 100,
                                width: 150,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Pahadma Holi',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 1),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Barsai is a joyous festival that brings joy and happiness to the world through different colors of love, intimacy and harmony.',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2),
                  child: ExpansionCard(
                    margin: const EdgeInsets.only(bottom: 8, top: 8),
                    trailing: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 4),
                      child: SizedBox(
                          width: 11,
                          child: Divider(
                            color: themeProvider.tabColor,
                            thickness: 2,
                          )),
                    ),
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Suva Sait',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      themeProvider.tabUnSelectedLabelColor)),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Colors.grey,
                                  size: 12,
                                ),
                                SizedBox(
                                    width: 160,
                                    child: Text(
                                      '  Hom Garne Sait',
                                      style: TextStyle(
                                          color: themeProvider
                                              .tabUnSelectedLabelColor),
                                    )),
                                Container(
                                  height: 22,
                                  decoration: BoxDecoration(
                                      gradient: themeProvider.gradient,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Text(
                                        'Monthly',
                                        style: TextStyle(
                                            color:
                                                themeProvider.whiteTextColor),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 22,
                                    decoration: BoxDecoration(
                                        gradient: themeProvider.gradient,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: Text(
                                          'Yearly',
                                          style: TextStyle(
                                              color:
                                                  themeProvider.whiteTextColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.circle,
                                  color: Colors.grey,
                                  size: 12,
                                ),
                                SizedBox(
                                    width: 160,
                                    child: Text(
                                      '  Biwaha Garne Sait',
                                      style: TextStyle(
                                          color: themeProvider
                                              .tabUnSelectedLabelColor),
                                    )),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text('More Suva Sait in Details',
                                      style: TextStyle(
                                          color: themeProvider
                                              .bookAppointmentIconColors)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color:
                                      themeProvider.bookAppointmentIconColors,
                                  size: 12,
                                ),
                                Text('  No Sait and Muhurta Found Today.',
                                    style: TextStyle(
                                        color: themeProvider
                                            .tabUnSelectedLabelColor)),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2),
                  child: ExpansionCard(
                    margin: const EdgeInsets.only(bottom: 12, top: 8),
                    trailing: SizedBox(
                        width: 11,
                        child: Divider(
                          color: themeProvider.tabColor,
                          thickness: 2,
                        )),
                    title: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Foreign Exchange ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: themeProvider
                                          .tabUnSelectedLabelColor)),
                              Text('USD 130.85 | UK 130.85 | AUD 130.85',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: themeProvider
                                          .tabUnSelectedLabelColor)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('U.S. DOLLAR - TREND',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color:
                                    themeProvider.tabUnSelectedLabelColor)),
                            Text('Falgun 15, 2079 (27 February, 2023)',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: themeProvider
                                        .bookAppointmentIconColors)),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 33,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: themeProvider.corner!),
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: const [
                                        Text(' Select date range'),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                ),
                                Text('   1W',
                                    style: TextStyle(
                                        color: themeProvider
                                            .bookAppointmentIconColors)),
                                const Text('   1M'),
                                const Text('   1Y  '),
                                Row(
                                  children: [
                                    Icon(Icons.circle,
                                        size: 10,
                                        color: themeProvider.tabColor),
                                    const Text(' Buying  ',
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: themeProvider
                                          .bookAppointmentIconColors,
                                    ),
                                    const Text(' Selling',
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    SizedBox(
                                      height: 22,
                                    ),
                                    Text('134'),
                                    SizedBox(
                                      height: 33,
                                    ),
                                    Text('132'),
                                    SizedBox(
                                      height: 33,
                                    ),
                                    Text('130'),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 22.0, left: 8),
                                  child: Dash(
                                      direction: Axis.vertical,
                                      length: 108,
                                      dashLength: 8,
                                      dashColor: Colors.grey),
                                ),
                                Column(
                                  children: const [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                        width: 270,
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        )),
                                    SizedBox(
                                      height: 38,
                                    ),
                                    SizedBox(
                                        width: 270,
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        )),
                                    SizedBox(
                                      height: 38,
                                    ),
                                    SizedBox(
                                        width: 270,
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Row(
                                children: const [
                                  Text('Mar 1   '),
                                  Text('Mar 2   '),
                                  Text('Mar 3   '),
                                  Text('Mar 4   '),
                                  Text('Mar 5   '),
                                  Text('Mar 6   '),
                                  Text('Mar 7'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 33,
                            ),
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: themeProvider.gradient2),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0, top: 12, right: 22),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Currency conversion',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/usa-icon.png',
                                          height: 22,
                                          width: 22,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 26.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              showCurrencyPicker(
                                                context: context,
                                                showFlag: true,
                                                showCurrencyName: true,
                                                showCurrencyCode: true,
                                                //showSearchField: true,
                                                onSelect: (Currency currency) {
                                                  setState(() {
                                                    name = currency;
                                                  });
                                                },
                                              );

                                              /*showCountryPicker(
                                                context: context,
                                                showPhoneCode: true, // optional. Shows phone code before the country name.
                                                onSelect: (Country country) {
                                                  setState(() {
                                                    name=country;
                                                  });
                                                  print('Select country: ${country.displayName}');
                                                },
                                              );*/
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                border: Border.all(
                                                    color:
                                                    themeProvider.corner!),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '  ${name?.name ?? ''}',
                                                      style: const TextStyle(
                                                          fontSize: 11),
                                                    ),
                                                    const Icon(
                                                        Icons.arrow_drop_down),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                  width: 88,
                                                  child: TextField(
                                                    onSubmitted: (val) async {
                                                      //rate = await getRate(from,to);
                                                    },
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/nepal_icon.png',
                                          height: 22,
                                          width: 22,
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 0.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              showCurrencyPicker(
                                                context: context,
                                                showFlag: true,
                                                showCurrencyName: true,
                                                showCurrencyCode: true,
                                                //showSearchField: true,
                                                onSelect: (Currency currency) {
                                                  setState(() {
                                                    nepalName = currency;
                                                  });
                                                  print('Select currency: ${currency.name}');
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 130,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                border: Border.all(
                                                    color:
                                                    themeProvider.corner!),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '   ${nepalName?.name ?? ""}',
                                                        style: const TextStyle(
                                                            fontSize: 11)),
                                                    const Icon(Icons.arrow_drop_down),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: const [
                                            Text('Buy',
                                                style: TextStyle(fontSize: 10)),
                                            Text('130.85'),
                                            SizedBox(
                                                width: 30,
                                                child: Divider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                )),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: const [
                                            Text('Sell',
                                                style: TextStyle(fontSize: 10)),
                                            Text('131.45'),
                                            SizedBox(
                                                width: 30,
                                                child: Divider(
                                                  color: Colors.grey,
                                                  thickness: 1,
                                                )),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 33,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: themeProvider
                                          .bookAppointmentBackground,
                                    ),
                                    child: Row(
                                      children: const [
                                        Text('                       Currency'),
                                        Text('                Buy'),
                                        Text('                Sell'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(left: 22.0),
                                          child: Image.asset(
                                            'assets/images/usa-icon.png',
                                            height: 22,
                                            width: 22,
                                          ),
                                        ),
                                        const Text('        U.S.doller'),
                                        const Text('           130.85'),
                                        const Text('           131.45'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      showCountryPicker(
                                        context: context,
                                        showPhoneCode:
                                        true, // optional. Shows phone code before the country name.
                                        onSelect: (Country country) {
                                          setState(() {
                                            countryName = country;
                                          });
                                          print(
                                              'Select country: ${country.flagEmoji}');
                                        },
                                      );
                                    },
                                    child: Container(
                                        height: 33,
                                        width: 172,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                              color: themeProvider.corner!),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('   ${countryName?.name??''}'),
                                            Text(' ${countryName?.flagEmoji??""}'),
                                            const Icon(Icons.arrow_drop_down_sharp),
                                          ],
                                        )
                                    ),
                                  ),
                                  Text(
                                    'More Currency Information',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: themeProvider
                                            .bookAppointmentIconColors),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2),
                  child: ExpansionCard(
                    margin: const EdgeInsets.only(bottom: 12, top: 8),
                    trailing: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 4),
                      child: SizedBox(
                          width: 11,
                          child: Divider(
                            color: themeProvider.tabColor,
                            thickness: 2,
                          )),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Panchanga ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: themeProvider.tabUnSelectedLabelColor)),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          //height: height * 2.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: themeProvider.bookAppointmentBackground,
                              border: Border.all(color: themeProvider.corner!)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0, right: 22, top: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: const [
                                        Text('वि.सं.'),
                                        Text(
                                          'फागुन ११, २०७९',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Text('ई.सं.'),
                                        Text(
                                          '23 Feb,2023',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Text('शक संवत्'),
                                        Text(
                                          '११४३',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Text('नेपाल संवत्'),
                                        Text(
                                          '११४३ चिल्लाथ्व',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Table(
                                textDirection: TextDirection.ltr,
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.all(
                                  width: 1.5,
                                  color: Colors
                                      .grey, //themeProvider.reviewBackground2!),
                                ),
                                children: [
                                  TableRow(children: [
                                    SizedBox(
                                      height: 44,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 66.0,
                                            ),
                                            child: Text('बिहीवार'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 44,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 38.0,
                                            ),
                                            child: Text('फागुन शुक्ल पूर्णिमा'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 45,
                                            child: Row(
                                              children: const [
                                                Text('सूर्योदय'),
                                                Text('05:40:48:081'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: Row(
                                              children: const [
                                                Text('सूर्यास्त'),
                                                Text('05:40:48:081'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 45,
                                            child: Row(
                                              children: const [
                                                Text('चन्द्रोदय'),
                                                Text('05:40:48:081'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: Row(
                                              children: const [
                                                Text('चन्द्रास्त'),
                                                Text('05:40:48:081'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                              Container(
                                height: 33,
                                width: 108,
                                decoration: BoxDecoration(
                                    gradient: themeProvider.gradient,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8))),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('  View Details',
                                        style: TextStyle(
                                            color:
                                                themeProvider.whiteTextColor)),
                                    const Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              Container(
                                height: 577,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: themeProvider.reviewBackground2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Text('दिनमान ( घडीमा )'),
                                    const Text('31.959207388320000000'),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      height: 108,
                                      color: themeProvider.reviewBackground2,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: const [
                                                      Text(
                                                          'उदयकालीन सुर्यस्पष्ट'),
                                                      Text('11:29:52:55:3220')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: const [
                                                      Text(
                                                          'उदयकालीन चन्द्रस्पष्ट'),
                                                      Text('11:29:52:55:3220')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: const [
                                                      Text('सुर्यस्पष्ट गति'),
                                                      Text('11:29:52:55:3220')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: const [
                                                      Text('चन्द्रस्पष्ट गति'),
                                                      Text('11:29:52:55:3220')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text('वेलान्तर ( मिनेटमा )'),
                                        Text('0.676269440293595000')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 33,
                                      color: themeProvider.reviewBackground2,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Text('कल्पगत अहर्गण'),
                                          Text('0.676269440293595000')
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text('विक्रम अहर्गण'),
                                        Text('0.676269440293595000')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 33,
                                      color: themeProvider.reviewBackground2,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Text('अयनाम्श'),
                                          Text('0.676269440293595000')
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text('सायन सूर्य'),
                                        Text('0.676269440293595000')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 33,
                                      color: themeProvider.reviewBackground2,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Text('परम क्रान्ति'),
                                          Text('0.676269440293595000')
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text('क्रान्ति'),
                                        Text('0.676269440293595000')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 33,
                                      color: themeProvider.reviewBackground2,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Text('सूर्योदय ( घडीमा )'),
                                          Text('0.676269440293595000')
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text('सूर्योदय (घण्टामा )'),
                                        Text('0.676269440293595000')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 33,
                                      color: themeProvider.reviewBackground2,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Text('उदय कालिन स्पष्ट चन्द्र'),
                                          Text('0.676269440293595000')
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text('स्पष्टान्तर'),
                                        Text('0.676269440293595000')
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 33,
                                      color: themeProvider.reviewBackground2,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Text('गति अन्तर'),
                                          Text('0.676269440293595000')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text('तिथि'),
                                  ),
                                  const Text(
                                      'तृतीया , ०५:३७:४७ बजे सम्म उप्रान्त षष्ठी'),
                                  Container(
                                    height: 22,
                                    decoration: BoxDecoration(
                                        gradient: themeProvider.gradient),
                                    child: Row(
                                      children: [
                                        Text('थप जानकारी',
                                            style: TextStyle(
                                                color: themeProvider
                                                    .whiteTextColor)),
                                        Icon(Icons.arrow_drop_down,
                                            color:
                                                themeProvider.whiteTextColor),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: themeProvider.reviewBackground2),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('तृतीया'),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Table(
                                      textDirection: TextDirection.ltr,
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      border: TableBorder.all(
                                        width: 1.5,
                                        color: Colors.grey,
                                        //color: themeProvider.reviewBackground2,
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('घ: प: वि: प्र'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 38.0,
                                                  ),
                                                  child: Text('५६:२६:४२:२३'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('बजे सम्म'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 38.0,
                                                  ),
                                                  child: Text('५६:२६:४२:२३'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('भुक्त घडि'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '1.323625000077300000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('भोग्य घडि'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '56.445111110952000000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 44.0,
                                                  ),
                                                  child: Text(
                                                      'स्पस्ट तिथि ( घडिमा )'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '57.768736111029300000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text('नक्षत्र'),
                                  ),
                                  const Text(
                                      'उत्तर भाद्र , ९:०० बजे उप्रान्त रेवती'),
                                  Container(
                                    height: 22,
                                    decoration: BoxDecoration(
                                        gradient: themeProvider.gradient),
                                    child: Row(
                                      children: [
                                        Text('थप जानकारी',
                                            style: TextStyle(
                                                color: themeProvider
                                                    .whiteTextColor)),
                                        Icon(Icons.arrow_drop_down,
                                            color:
                                                themeProvider.whiteTextColor),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: themeProvider.reviewBackground2),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('उत्तर भाद्र'),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Table(
                                      textDirection: TextDirection.ltr,
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      border: TableBorder.all(
                                        width: 1.5,
                                        color: Colors.grey,

                                        //color: themeProvider.reviewBackground2!,
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('घ: प: वि: प्र'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 38.0,
                                                  ),
                                                  child: Text('५६:२६:४२:२३'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('बजे सम्म'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 38.0,
                                                  ),
                                                  child: Text('५६:२६:४२:२३'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('भुक्त घडि'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '1.323625000077300000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('भोग्य घडि'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '56.445111110952000000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 44.0,
                                                  ),
                                                  child: Text(
                                                      'स्पस्ट तिथि ( घडिमा )'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '57.768736111029300000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text('करण'),
                                  ),
                                  const Text(
                                      'गर , ०५:३७:४७ बजे सम्म उप्रान्त कौलव'),
                                  Container(
                                    height: 22,
                                    decoration: BoxDecoration(
                                        gradient: themeProvider.gradient),
                                    child: Row(
                                      children: [
                                        Text('थप जानकारी',
                                            style: TextStyle(
                                                color: themeProvider
                                                    .whiteTextColor)),
                                        Icon(Icons.arrow_drop_down,
                                            color: themeProvider.whiteTextColor)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: themeProvider.reviewBackground2),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('गर'),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Table(
                                      textDirection: TextDirection.ltr,
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      border: TableBorder.all(
                                        width: 1.5,
                                        color: Colors.grey,

                                        //color: themeProvider.reviewBackground2!,
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('घ: प: वि: प्र'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 38.0,
                                                  ),
                                                  child: Text('५६:२६:४२:२३'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('बजे सम्म'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 38.0,
                                                  ),
                                                  child: Text('५६:२६:४२:२३'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('भुक्त घडि'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '1.323625000077300000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('भोग्य घडि'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '56.445111110952000000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 44.0,
                                                  ),
                                                  child: Text(
                                                      'स्पस्ट तिथि ( घडिमा )'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '57.768736111029300000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Text('योग'),
                                  ),
                                  const Text(
                                      'शुभ, २५:२४:२४ बजे सम्म उप्रान्त शुक्ल'),
                                  Container(
                                    height: 22,
                                    decoration: BoxDecoration(
                                        gradient: themeProvider.gradient),
                                    child: Row(
                                      children: [
                                        Text('थप जानकारी',
                                            style: TextStyle(
                                                color: themeProvider
                                                    .whiteTextColor)),
                                        Icon(Icons.arrow_drop_down,
                                            color: themeProvider.whiteTextColor)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: themeProvider.reviewBackground2),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text('गर'),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Table(
                                      textDirection: TextDirection.ltr,
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      border: TableBorder.all(
                                        width: 1.5,
                                        color: Colors.grey,

                                        //color: themeProvider.reviewBackground2!,
                                      ),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('घ: प: वि: प्र'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 38.0,
                                                  ),
                                                  child: Text('५६:२६:४२:२३'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('बजे सम्म'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 38.0,
                                                  ),
                                                  child: Text('५६:२६:४२:२३'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('भुक्त घडि'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '1.323625000077300000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 66.0,
                                                  ),
                                                  child: Text('भोग्य घडि'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '56.445111110952000000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 44.0,
                                                  ),
                                                  child: Text(
                                                      'स्पस्ट तिथि ( घडिमा )'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                themeProvider.reviewBackground2,
                                            height: 33,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 8.0,
                                                  ),
                                                  child: Text(
                                                      '57.768736111029300000'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Table(
                                textDirection: TextDirection.ltr,
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.all(
                                  width: 1.5,
                                  color: Colors.grey,

                                  //color: themeProvider.reviewBackground2!,
                                ),
                                children: [
                                  TableRow(children: [
                                    SizedBox(
                                      height: 55,
                                      child: Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(top: 14.0),
                                            child: Text('बिहीवार'),
                                          ),
                                          Text('मीन')
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 55,
                                      child: Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(top: 14.0),
                                            child: Text('आनन्दादि योग'),
                                          ),
                                          Text('छत्र')
                                        ],
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Text('सूर्योदयकालीन स्पस्ट ग्रहहरू'),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Table(
                                textDirection: TextDirection.ltr,
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.all(
                                  width: 1.5,
                                  color: Colors.grey,

                                  //color: themeProvider.reviewBackground2!,
                                ),
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: Row(
                                              children: const [
                                                Text('मंगल'),
                                                Text('  १०:९:४९:५५'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: Row(
                                              children: const [
                                                Text('बुध'),
                                                Text('  १०:९:४९:५५'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: Row(
                                              children: const [
                                                Text('बृहस्पति'),
                                                Text('  १०:९:४९:५५'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: Row(
                                              children: const [
                                                Text('शुक्र'),
                                                Text('  १०:९:४९:५५'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: Row(
                                              children: const [
                                                Text('शनि'),
                                                Text('  १०:९:४९:५५'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 28.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: Row(
                                              children: const [
                                                Text('राहु'),
                                                Text('  १०:९:४९:५५'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 8),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: themeProvider.reviewBackground2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.arrow_back_ios_new_outlined),
                        Text('Home below event ADS'),
                        Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 99,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tab1Content extends StatelessWidget {
  const Tab1Content({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text('Mesh', style: TextStyle(fontWeight: FontWeight.w900)),
                  Text('(चु, चे, चो, ला, लि, लु, ले, लो, अ)')
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Expanded(
                  child: Container(
                    height: 18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: themeProvider.corner!)),
                    child: Row(
                      children: [
                        const Text(
                          "Audio Rashifal",
                          style: TextStyle(fontSize: 9),
                        ),
                        Icon(
                          Icons.play_arrow,
                          size: 16,
                          color: themeProvider.tabColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Text(
              'Today will be a full day of entertainment. Stopped work will be beneficial to try again. ',
              style: TextStyle(fontSize: 13)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
              child: Container(
                color: Colors.teal.shade200,
                height: 0,
                width: 264,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Aries Rashifal - Baishak,2079'),
                          Image.asset('assets/images/ico-info@2x.png',
                              width: 18, height: 18),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/play button.png'),
                      ],
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Image.asset(
                      'assets/images/timeline.png',
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 22.0, right: 22, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/ico-play.png'),
                          const Text('5:07 / 15:28'),
                          Image.asset('assets/images/ico-fullscreen.png'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
