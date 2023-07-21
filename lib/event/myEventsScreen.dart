import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/event/festivals_screen.dart';
import 'package:sanathan_nepal_mobile_app/event/to_do_screen.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';
import 'package:sanathan_nepal_mobile_app/view/widgets/calender.dart';

import '../calendar/pages/feature_calendar.dart';
import '../calender/calender.dart';
import 'event_calender.dart';
import 'my_event.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> options = [
    'ALl',
    'Important',
    'Gov Holidays',
    'Hindu',
    'Buddism',
    'Islam',
    'kirat',
    'christinity'
  ];
  String? selectedOption;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void handleOptionChange(String? value) {
    setState(() {
      selectedOption = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Events',
            style: TextStyle(color: themeProvider.tabUnSelectedLabelColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                  height: 336,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: themeProvider.corner!,
                      )),
                  width: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: EventCalender(),
                  )),
            ),
            Card(
              color: Colors.transparent,
              elevation: 10,
              child: Container(
                height: 412,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: themeProvider.tabBackground,
                    borderRadius: BorderRadius.circular(6)),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: themeProvider.bookAppointmentBackground,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                                8), // Set the border radius for top left corner
                            topRight: Radius.circular(8),
                          )),
                      //color: Colors.grey,
                      child: TabBar(
                        indicatorPadding: const EdgeInsets.only(
                            left: 36, right: 36, bottom: 14),
                        controller: _tabController,
                        labelColor: themeProvider.tabColor,
                        indicatorColor: themeProvider.tabColor,
                        unselectedLabelColor:
                            themeProvider.tabUnSelectedLabelColor,
                        tabs: const [
                          Tab(
                            child: Text('Festivals',
                                style: TextStyle(fontSize: 13)),
                          ),
                          Tab(
                            child: Text('My Events',
                                style: TextStyle(fontSize: 13)),
                          ),
                          Tab(
                            child:
                                Text('To-Do', style: TextStyle(fontSize: 13)),
                          ),
                        ],
                      ),
                    ),
                    // Flexible(
                    //   child: Container(
                    //
                    //
                    //     child: Wrap(
                    //       alignment: WrapAlignment.start,
                    //       children: options.map((option) {
                    //         return Container(
                    //           width: 100,
                    //           child: SquareRadioButton<String>(
                    //             value: option,
                    //             groupValue: selectedOption,
                    //             onChanged: handleOptionChange,
                    //             label: option,
                    //           ),
                    //         );
                    //       }).toList(),
                    //     ),
                    //   ),
                    // ),
                    /*Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Wrap(
                            children: options.map((option) {
                              return SizedBox(
                                width: 120, // Adjust the width as needed
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0,right: 4,bottom: 4,left: 4),
                                  child: SquareRadioButton<String>(
                                    value: option,
                                    groupValue: selectedOption,
                                    onChanged: handleOptionChange,
                                    label: option,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),*/

                    Flexible(
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          // Contents of Tab 1
                          FestivalTabView(),
                          // Contents of Tab 2
                          MyEvent(),
                          // Contents of Tab 3
                          ToDoScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SquareRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String label;

  const SquareRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                width: 2,
                color: value == groupValue ? Colors.blue : Colors.grey,
              ),
            ),
            child: Center(
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: value == groupValue ? Colors.blue : Colors.transparent,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
