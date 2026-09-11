/*
import 'package:flutter/material.dart';
import 'package:sanathan_nepal_mobile_app/view/helper/styles.dart';
import 'package:sanathan_nepal_mobile_app/view/widgets/calender.dart';
import 'package:sanathan_nepal_mobile_app/view/widgets/forExUi.dart';
import '../widgets/boarderdButton.dart';
import '../widgets/customBottomNavBar.dart';
import '../widgets/gradienteElevatedButton.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2>
    with SingleTickerProviderStateMixin {
  int selectedValue = 1;
  late TabController _tabController;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          centerTitle: true,
        ),
        bottomNavigationBar:
            CustomBottomNavBar(onItemSelected: _onNavBarItemTapped),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              SizedBox(height: 260, child: CustomCalendar()),
              SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bangalore',
                                    style: TextStyles.subheading(),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '71°',
                                        style: TextStyles.heading(),
                                      ),
                                      Image.asset(
                                        'assets/images/Group 3.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'party cloud',
                                    style: TextStyles.subheading(),
                                  ),
                                  Text(
                                    ' H:81° L:72°',
                                    style: TextStyles.subheading(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                  height: double.infinity,
                                  width: 250,
                                  child: Card(
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const Text('6;45'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                height: 30,
                                              ),
                                              const Text('29°C'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Icons.water_drop),
                                                  Text('10%'),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('6;45'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                height: 30,
                                              ),
                                              const Text('29°C'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Icons.water_drop),
                                                  Text('10%'),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('6;45'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                height: 30,
                                              ),
                                              const Text('29°C'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Icons.water_drop),
                                                  Text('10%'),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text('6;45'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/images/Group 3.png',
                                                height: 30,
                                              ),
                                              const Text('29°C'),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(Icons.water_drop),
                                                  Text('10%'),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        )),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 230,
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 10.0,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Horoscope',
                                  style: TextStyles.subheading(),
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
                                ElevatedButton(
                                  onPressed: () {
                                    print("object>>>>>>>>>>>>>>");
                                  },
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(100,
                                          40), // Set the desired width and height
                                    ),
                                  ),
                                  child: Text(
                                    'All Horoscope',
                                    style: TextStyles.body(),
                                  ),
                                ),
                                const Icon(Icons.notifications_active_outlined),
                                const Text('notification on your time '),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 270,
                          height: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TabBar(
                                      controller: _tabController,
                                      indicatorColor: Colors.blue,
                                      labelColor: Colors.blue,
                                      unselectedLabelColor: Colors.grey,
                                      tabs: const [
                                        Tab(text: 'Tab 1'),
                                        Tab(text: 'Tab 2'),
                                        Tab(text: 'Tab 3'),
                                        Tab(text: 'Tab 4'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
  Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Events to Do',
                                style: TextStyles.subheading(),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(70,
                                        10), // Set the desired width and height
                                  ),
                                ),
                                child: const Text('All events'),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              BorderedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/MyEventsScreen');
                                  // Handle button press
                                },
                                label: 'My Events',
                                fontSize: 14.0,
                                textColor: Colors.black,
                                borderColor: Colors.red,
                                borderWidth: 1.0,
                                borderRadius: 4.0,
                                horizontalPadding: 10.0,
                                verticalPadding: 6.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              BorderedButton(
                                onPressed: () {
                                  // Handle button press
                                },
                                label: 'To Do',
                                fontSize: 14.0,
                                textColor: Colors.black,
                                borderColor: Colors.red,
                                borderWidth: 1.0,
                                borderRadius: 4.0,
                                horizontalPadding: 12.0,
                                verticalPadding: 6.0,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.minimize))
                            ],
                          ),
                          Row(
                            children: [
                              BorderedButton(
                                onPressed: () {
                                  // Handle button press
                                },
                                label: 'Today',
                                fontSize: 14.0,
                                textColor: Colors.black,
                                borderColor: Colors.red,
                                borderWidth: 1.0,
                                borderRadius: 4.0,
                                horizontalPadding: 12.0,
                                verticalPadding: 6.0,
                              ),
                              BorderedButton(
                                onPressed: () {
                                  // Handle button press
                                },
                                label: 'Holiday',
                                fontSize: 14.0,
                                textColor: Colors.black,
                                borderColor: Colors.red,
                                borderWidth: 1.0,
                                borderRadius: 4.0,
                                horizontalPadding: 12.0,
                                verticalPadding: 6.0,
                              ),
                              Radio(
                                  value: 1,
                                  groupValue: 'null',
                                  onChanged: (index) {}),
                              const Text('Holi'),
                              Radio(
                                  value: 1,
                                  groupValue: 'null',
                                  onChanged: (index) {}),
                              const Text('Birthday'),
                              Radio(
                                  value: 1,
                                  groupValue: 'null',
                                  onChanged: (index) {}),
                              const Text('NA'),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/Rectangle 1059.png',
                                height: 100,
                                width: 100,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pahadma Holi',
                                        style: TextStyles.subheading,
                                      ),
                                      Text(
                                        'Barsai is a joyous festival that brings joy and happiness to the world through different colors of love, intimacy and harmony.',
                                        style: TextStyles.body,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: double.infinity,
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Suva Sait',
                                    style: TextStyles.subheading,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: 1,
                                          groupValue: 'null',
                                          onChanged: (index) {}),
                                      const Text('Hom Garne Sait'),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: 1,
                                          groupValue: 'null',
                                          onChanged: (index) {}),
                                      const Text('Biwaha Garne Sait'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: 1,
                                          groupValue: 'null',
                                          onChanged: (index) {}),
                                      const Flexible(
                                          child: Text(
                                              'No Sait and Muhurta Found Today.')),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.minimize)),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [
                                  GradientElevatedButton(
                                    buttonHeight: 20.0,
                                    buttonWidth: 80.0,
                                    buttonText: 'Monthly',
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GradientElevatedButton(
                                    buttonHeight: 20.0,
                                    buttonWidth: 70.0,
                                    buttonText: 'Yearly',
                                  ),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text('More Details'))
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 700,
                  width: double.infinity,
                  child: Card(
                      elevation: 10,
                      child: Center(
                        child: ForexUI(),
                      )),
                ),
              ),


              Card(
                elevation: 9,
                child: Container(
                    color: Colors.orange,
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 8,
                          child: Card(
                            elevation: 0,
                            child: SizedBox(
                              width: 100,
                              height: 232,
                              child: Column(
                                children: [
                                  Text("data"),
                                  Text("data"),
                                  Text("data"),
                                  ElevatedButton(onPressed: (){
                                    print("object>>>>>>>>>>>>>>>>>>>>>>");
                                  }, child: Text("dgtg"))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 111,
                          child: SizedBox(
                            width: 260,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: TabBar(
                                    controller: _tabController,
                                    indicatorColor: Colors.blue,
                                    labelColor: Colors.blue,
                                    unselectedLabelColor: Colors.grey,
                                    tabs: const [
                                      Tab(text: 'Tab 1'),
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
                            top: 49,
                            left: 111,
                            child: SizedBox(
                              height: 188,
                              width: 260,
                              child: TabBarView(
                                controller: _tabController,
                                children: const [
                                  Tab1Content(),
                                  Center(child: Text('Content for Tab 2')),
                                  Center(child: Text('Content for Tab 3')),
                                  Center(child: Text('Content for Tab 4')),
                                ],
                              ),
                            ))
                      ],
                    )),
              ),
              SizedBox(
                height: 22,
              )
            ],
          )),
        ));
  }
}

class Tab1Content extends StatelessWidget {
  const Tab1Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Mesh (चु, चे, चो, ला, लि, लु, ले, लो, अ)'),
          Text('Today will be a full day of entertainment. Stopped work will be beneficial to try again. '),

        ],
      ),
    );
  }
}
*/
