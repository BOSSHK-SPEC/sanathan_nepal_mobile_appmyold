import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/view/widgets/about_aries.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../theme/theme_provider.dart';

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({Key? key}) : super(key: key);

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen>
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Horoscope',style: TextStyle(color: themeProvider.tabUnSelectedLabelColor)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 14, bottom: 14),
                child: Text('10 Falgun 2079 Wednesday, 22 February 2023',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/aeries 1.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.deepOrange,
                                        ))),
                                /* const Positioned(
                                  top: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: ExpandableMenu(
                                    width: 40.0,
                                    height: 40.0,
                                    items: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.access_alarm,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.accessible_forward,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.accessibility_new_sharp,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )),*/
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Material(
                                    elevation: 10,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(22)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient:
                                          themeProvider.containerBackground,
                                          borderRadius:
                                          BorderRadius.circular(22)),
                                      child: Column(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 2,
                                                top: 2,
                                                right: 8),
                                            child: Icon(Icons.share, size: 14),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 2,
                                                top: 2,
                                                right: 8),
                                            child: Icon(Icons.accessibility_new,
                                                size: 14),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 2,
                                                top: 2,
                                                right: 8),
                                            child:
                                            Icon(Icons.facebook, size: 14),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 2,
                                                top: 2,
                                                right: 8),
                                            child: Icon(Icons.install_mobile,
                                                size: 14),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 2,
                                                top: 2,
                                                right: 8),
                                            child:
                                            Icon(Icons.whatshot, size: 14),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 2,
                                                top: 2,
                                                right: 8),
                                            child: Icon(Icons.cancel_outlined,
                                                size: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Aries",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text("(चु,चे,चो,ला,लि,लू,ले,लो,अ)",style: TextStyle(fontSize: 13)),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 16.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work be benificial to try again.\nTasks will be completed",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 14.0, top: 12, bottom: 12),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "Lucky Number",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 22.0),
                              child:
                              Text("6,9", style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                                width: 100,
                                child: Text(
                                  "Lucky Color",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: Row(
                                children: const [
                                  Icon(Icons.circle,
                                      size: 8, color: Colors.red),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.0),
                                    child: Text(
                                      " Red",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "LuckyDays",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 22.0),
                              child: Text(
                                'Tuesdays,Saturdays,Fridays',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "Ruling Planet",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 22.0),
                              child: Text(
                                'Mars',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "Symbol",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 22.0),
                              child: Text(
                                'The Ram',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "Element",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 22.0),
                              child: Text(
                                'Fire',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                                width: 100,
                                child: Text(
                                  "Lucky Stones",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/RedCoral.png',
                                      width: 14, height: 14),
                                  const Text(
                                    " Red Coral",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      height: 15,
                                      width: 48,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          borderRadius:
                                          BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 0,
                                            bottom: 2,
                                            top: 2),
                                        child: Text("Shop Now",
                                            style: TextStyle(
                                                color:
                                                themeProvider.horosCopColor,
                                                fontSize: 9)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "UnLucky Stones",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 22.0),
                              child: Text(
                                'Emerald',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "Lucky Alphabet",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 22.0),
                              child: Text(
                                'M,Y,B,H,F,T',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                                width: 100,
                                child: Text(
                                  "Eventful Years",
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 22.0),
                              child: Text(
                                '9,18,27,36,45,54,63,72,81,90,99',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey)),
                  height: 160,
                  width: 260,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade200,
                      ),
                      height: 136,
                      width: 222,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                    ' Lucky Color, Number and Stone for Aries Sign'),
                                Image.asset('assets/images/ico-info@2x.png',
                                    width: 18, height: 18),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/play button.png'),
                            ],
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Image.asset(
                            'assets/images/timeline.png',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 22.0, right: 22, top: 8),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset('assets/images/ico-play.png'),
                                const Text('5:07 / 15:28'),
                                Image.asset(
                                    'assets/images/ico-fullscreen.png'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 544,
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, top: 12, bottom: 12, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Abouts Aries (RAM)",
                            style: TextStyle(
                                color: themeProvider.horosCopColor,
                                fontWeight: FontWeight.bold)),
                        const Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Text(
                              "Aries is the first sign of the zodiac indicated by a Ram with horns .The ruling planet for Aries sign is Mars ,symbolizing vitality, courage and strong will.Mars is a masculine planet and indicated, energy, competitive spirit, and power constructiveness of an individual. Hence, Aries is called a fire sign personifying a challenging and adventurous spirit. Aries are strong and passionate like fire and may speak strongly or have high self-esteem "),
                        ),

                        SizedBox(height:12,),
                        SizedBox(
                          height: 16,
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: themeProvider.horosCopColor,
                            labelColor: themeProvider.horosCopColor,
                            unselectedLabelColor: Colors.grey,

                            tabs: const [
                              Tab(
                                  child: Text(
                                      'मेध राशि को पुरुष',
                                      style: TextStyle(
                                          fontSize: 8))),
                              Tab(
                                  child: Text(
                                    'मेध राशि को व्यक्तित्व',
                                    style: TextStyle(fontSize: 8),
                                  )),
                              Tab(
                                  child: Text(
                                      'Aries Career Horoscope',
                                      style: TextStyle(
                                        fontSize: 7,))),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 316,
                          width: MediaQuery.of(context).size.width,
                          child: TabBarView(
                            controller: _tabController,
                            children: const [
                              AboutAries(),
                              Center(
                                  child: Text('Content for Tab 2')),
                              Center(
                                  child: Text('Content for Tab 3')),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/taurus 1.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                    elevation: 10,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(22),),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        gradient: themeProvider
                                            .containerBackground,
                                        borderRadius:
                                        BorderRadius.circular(22),),
                                      child: const Icon(Icons.share,
                                          size: 16),),),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color: themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: themeProvider
                                                  .whiteTextColor),),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Taurus",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text("(चु,चे,चो,ला,लि,लू,ले,लो,अ)",style: TextStyle(fontSize: 13),),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 6.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Good news will be heard today. You will get \nspecial help from friends. Complicated\nwhen using intelligence.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/gemini 1.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Gemini",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text("(का,कि,कु,घ,ङ,छ,के,को,हा)",style: TextStyle(fontSize: 13)),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 1.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Wishes and aspirations will be fulfilled.\nNew sources of income will be discovered.\nIncomplete works that have been stopped.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/cancer 1.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Cancer",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text(
                                        "(हि,हुए,हे,हा,डा,डि,डु,डे,डो)",style: TextStyle(fontSize: 13,),),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: themeProvider.containerBackground,
                      borderRadius: BorderRadius.circular(18),
                      border:
                      Border.all(color: themeProvider.calenderBorder!)),
                  height: 322,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: themeProvider.containerBackground,
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width,
                          height: 320,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                height: 66,
                                width: 66,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.amberAccent,
                                  child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/leo 1.png',
                                        fit: BoxFit.contain,
                                        width: 60,
                                        height: 60,
                                      )),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.deepOrange,
                                      ))),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Material(
                                    elevation: 10,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(22)),
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            gradient: themeProvider
                                                .containerBackground,
                                            borderRadius:
                                            BorderRadius.circular(22)),
                                        child: const Icon(Icons.share,
                                            size: 16))),
                              ),
                              const SizedBox(
                                height: 90,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: themeProvider.horosCopColor,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.0,
                                          right: 4,
                                          top: 2,
                                          bottom: 2),
                                      child: Text("Lucky Details",
                                          style:
                                          TextStyle(color: Colors.white)),
                                    )),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 33,
                                    width: 280,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            bottomLeft: Radius.circular(4)),
                                        border: Border.all(
                                            color:
                                            themeProvider.horosCopColor!),
                                        color:
                                        themeProvider.reviewBackground2),
                                    child: Row(
                                      children: [
                                        const Text('   6 , 9  |  ',
                                            style: TextStyle(fontSize: 10)),
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.red,
                                              size: 8,
                                            ),
                                            Text(
                                              ' Red ',
                                              style: TextStyle(fontSize: 10),
                                            )
                                          ],
                                        ),
                                        const Text(
                                          ' |  Tuesdays, Saturdays, Fridays  |',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        const Text(
                                          '      Red Coral',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 33,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(4),
                                            bottomRight: Radius.circular(4)),
                                        border: Border.all(
                                            color:
                                            themeProvider.horosCopColor!),
                                        gradient: themeProvider.luckyDetail),
                                    child: Center(
                                      child: Text('More\nDetails',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: themeProvider
                                                  .whiteTextColor)),
                                    ),
                                  ),
                                ],
                              )
                              /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 78,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Leo",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15),
                                    ),
                                    const Text(
                                        "(मा,मि,मु,मे,मो,टा,टि,टु,टे)",style: TextStyle(fontSize: 13)),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 36.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: themeProvider
                                                .containerBackground,
                                            borderRadius:
                                            BorderRadius.circular(6),
                                            border: Border.all(
                                                color:
                                                themeProvider.corner!)),
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding:
                                              EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                "Audio Rashifal",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Icon(
                                              Icons.play_arrow,
                                              color:
                                              themeProvider.horosCopColor,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Text(
                                  "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                  style: TextStyle(fontSize: 15),
                                ),

                                ///new youtube play
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                    color: Colors.teal.shade200,
                                    height: 130,
                                    width: 276,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              const Text(
                                                  'Aries Rashifal - Baishak,2079'),
                                              Image.asset(
                                                  'assets/images/ico-info@2x.png',
                                                  width: 18,
                                                  height: 18),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                'assets/images/play button.png'),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 22,
                                        ),
                                        Image.asset(
                                          'assets/images/timeline.png',
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 22.0, right: 22, top: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Image.asset(
                                                  'assets/images/ico-play.png'),
                                              const Text('5:07 / 15:28'),
                                              Image.asset(
                                                  'assets/images/ico-fullscreen.png'),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),

                                ///new youtube play
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/virgo 1.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                            style: TextStyle(fontSize: 10),),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Virgo",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text("(तो,पा,पि,पु,ष,ण,ठ,पे,पो)",style: TextStyle(fontSize: 13,)),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 22.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/libra 1.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Libra",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text(
                                          "(रा,रि,रु,रे,रो,ता,ति,तु,ते)",style: TextStyle(fontSize: 13)),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 32.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/scorpio 1.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Scorpio",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text(
                                          "(तो,ना,नि,नु,ने,नो,या,यि,यु,)",style: TextStyle(fontSize: 13,)),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/scorpio 1.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Scorpio",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text(
                                          "(तो,ना,नि,नु,ने,नो,या,यि,यु,)",style: TextStyle(fontSize: 13)),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/sagittra.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        "Sagittarius",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      Text("(ये,यो,भा,भि,भु,धा,फा,ढा,भे)",style: TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/capricorn 1.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        "Capricorn ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      Text("(भो,जा,जि,जु,जे,खु,खे,खो,गा,गि)",style: TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: themeProvider.containerBackground,
                        borderRadius: BorderRadius.circular(18),
                        border:
                        Border.all(color: themeProvider.calenderBorder!)),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/kumbh.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                              style: TextStyle(fontSize: 10)),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Aquarius",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text(
                                          "(गु,गे,गो,सा,सि,सु,से,सो,दा)",style: TextStyle(fontSize: 13)),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 1.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4),
                child: Container(
                    decoration: BoxDecoration(
                      gradient: themeProvider.containerBackground,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: themeProvider.calenderBorder!),),
                    height: 322,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: themeProvider.containerBackground,
                                borderRadius: BorderRadius.circular(10)),
                            width: MediaQuery.of(context).size.width,
                            height: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 66,
                                  width: 66,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.amberAccent,
                                    child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/pisces.png',
                                          fit: BoxFit.contain,
                                          width: 60,
                                          height: 60,
                                        )),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.deepOrange,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Material(
                                      elevation: 10,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(22)),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(22)),
                                          child: const Icon(Icons.share,
                                              size: 16))),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: themeProvider.horosCopColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        child: Text("Lucky Details",
                                            style:
                                            TextStyle(color: Colors.white)),
                                      )),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 33,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          color:
                                          themeProvider.reviewBackground2),
                                      child: Row(
                                        children: [
                                          const Text('   6 , 9  |  ',
                                            style: TextStyle(fontSize: 10),),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 8,
                                              ),
                                              Text(
                                                ' Red ',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            ],
                                          ),
                                          const Text(
                                            ' |  Tuesdays, Saturdays, Fridays  |',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Text(
                                            '      Red Coral',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 33,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4)),
                                          border: Border.all(
                                              color:
                                              themeProvider.horosCopColor!),
                                          gradient: themeProvider.luckyDetail),
                                      child: Center(
                                        child: Text('More\nDetails',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: themeProvider
                                                    .whiteTextColor)),
                                      ),
                                    ),
                                  ],
                                )
                                /*SizedBox(
                                height: 28,
                                width: 360,
                                child: ToggleSwitch(
                                  activeBgColor: [themeProvider.tabColor] ,
                                  cornerRadius: 4.0,
                                  //activeBgColor: [Colors.orangeAccent],
                                  //borderColor: [Colors.blueGrey],
                                  customWidths: const [
                                    44.0,
                                    66.0,
                                    120.0,
                                    55,
                                    71
                                  ],
                                  initialLabelIndex: 4,
                                  totalSwitches: 5,
                                  customIcons: const [
                                    null,
                                    Icon(Icons.circle,
                                        color: Colors.red, size: 12),
                                    null,
                                    null,
                                    null
                                  ],
                                  labels: const [
                                    '6 , 9',
                                    'Red',
                                    'Tuesdays,Saturdays,Fridays',
                                    "Red Coral",
                                    "More\nDetails"
                                  ],
                                  customTextStyles: const [
                                    TextStyle(
                                      fontSize: 9,
                                    )
                                  ],
                                  onToggle: (index) {},
                                ),
                              ),*/
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 78,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Pisces",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15),
                                      ),
                                      const Text(" (दि,दु,थ,झ,ञ,दे,दो,चा,चि)",style: TextStyle(fontSize: 13)),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: themeProvider
                                                  .containerBackground,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                              border: Border.all(
                                                  color:
                                                  themeProvider.corner!)),
                                          child: Row(
                                            children: [
                                              const Padding(
                                                padding:
                                                EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  "Audio Rashifal",
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color:
                                                themeProvider.horosCopColor,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text(
                                    "Today will be a full day of entertainment.\nStopped work will be beneficial to try\nagain. Tasks will be completed.",
                                    style: TextStyle(fontSize: 15),
                                  ),

                                  ///new youtube play
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                      color: Colors.teal.shade200,
                                      height: 130,
                                      width: 276,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Text(
                                                    'Aries Rashifal - Baishak,2079'),
                                                Image.asset(
                                                    'assets/images/ico-info@2x.png',
                                                    width: 18,
                                                    height: 18),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/play button.png'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Image.asset(
                                            'assets/images/timeline.png',
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0, right: 22, top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/ico-play.png'),
                                                const Text('5:07 / 15:28'),
                                                Image.asset(
                                                    'assets/images/ico-fullscreen.png'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),

                                  ///new youtube play
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
