import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/event/attraction_place_screen_festivals.dart';
import 'package:sanathan_nepal_mobile_app/event/description_screen-festivals.dart';
import 'package:sanathan_nepal_mobile_app/event/video_screen_festival.dart';
import '../theme/theme_provider.dart';
import 'how_to_celebrate_screen_festivals.dart';

class FestivalsDetailsScreen extends StatefulWidget {
  const FestivalsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<FestivalsDetailsScreen> createState() => _FestivalsDetailsScreenState();
}

class _FestivalsDetailsScreenState extends State<FestivalsDetailsScreen>  with SingleTickerProviderStateMixin {
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
            title:  Text('Ram Nawami',style: TextStyle(color: themeProvider.tabUnSelectedLabelColor)),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 22,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: themeProvider.gradient2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('20 ',style: TextStyle(fontWeight: FontWeight.w500,color: themeProvider.tabColor,fontSize: 18)),
                      const Text('Days Left')
                    ],
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8,top: 16,bottom: 16),
            child: ListView(
              children: [
                const SizedBox(height: 12,),
                Row(
                  children: [
                    const SizedBox(
                      height: 33,
                      width: 286,
                        child: Align(
                          alignment: Alignment.centerLeft,
                            child: Text('16 Chaitra 2079 | 30 March, 2023, Wed | Nawami chaitra Suklapaksh',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)))),
                    SizedBox(
                      width: 80,
                        height: 33,
                        child: Align(
                          alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text('Panchanga & Suva Sait >',style: TextStyle(fontSize: 12,color: themeProvider.tabColor),),
                            )))
                  ],
                ),
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.red,
                            )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text('सार्वजनिक विदा',style: TextStyle(fontSize: 12,color: Colors.red)),
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: Colors.green,
                              )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text('हिन्दु चाड',style: TextStyle(fontSize: 12,color: Colors.green)),
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: Colors.yellow,
                              )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text('सार्वजनिक विदा',style: TextStyle(fontSize: 12,color: Colors.yellow)),
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(
                                color: themeProvider.bottomNavigationIconColor!,
                              )
                          ),
                          child:  Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text('िन्दु चाड',style: TextStyle(fontSize: 12,color: themeProvider.bottomNavigationIconColor)),
                          ),
                        ),

                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 0),
                        child: Container(
                          height: 22, // Adjust the height as needed
                          width: 68,
                          decoration: const BoxDecoration(
                              color: Colors
                                  .grey), // Adjust the width as needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .start, // Adjust the alignment as needed
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text('Add',
                                        style: TextStyle(
                                            fontSize: 5,
                                            color: Colors.black)),
                                    Text('Event/Reminder',
                                        style: TextStyle(
                                            fontSize: 5,
                                            color: Colors.black)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 0,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.event,
                                      color: Colors.black),
                                  iconSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    )
                  ],
                ),

                SizedBox(height: 16,),
                Container(
                  height: 33,
                  width: 350,
                  decoration: BoxDecoration(
                      color: themeProvider.bookAppointmentBackground,
                      borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6))),
                  child: TabBar(
                    controller: _tabController,
                    indicatorPadding: EdgeInsets.only(left: 16,right: 16),
                    indicatorColor: themeProvider.tabColor,
                    labelColor: themeProvider.tabUnSelectedLabelColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(child: Text('Video', style: TextStyle(fontSize: 8))),
                      Tab(
                          child: Text(
                            'Description',
                            style: TextStyle(fontSize: 8),
                          )),
                      Tab(
                          child: Text(
                            'How To Celebrate',
                            style: TextStyle(fontSize: 8),
                          )),
                      Tab(
                          child: Text(
                            'Attraction Places',
                            style: TextStyle(fontSize: 8),
                          )),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft: Radius.circular(6)),
                    color: themeProvider.bookAppointmentBackground
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: _tabController,
                    children:  [
                      VideoScreenFestivals(),
                      DescriptionScreenFestivals(),
                      HowToCelebrateScreenfestivals(),
                      AttractionPlaceScreenfestivals(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

}
