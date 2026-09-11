import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

class NotificationsSettingScreen extends StatefulWidget {
  const NotificationsSettingScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsSettingScreen> createState() =>
      _NotificationsSettingScreenState();
}

class _NotificationsSettingScreenState
    extends State<NotificationsSettingScreen> {
  bool status = true;
  bool noStatus = false;
  bool isDaily = true;
  bool isMonthly = false;
  bool isYearly = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: themeProvider.gradient2,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Horoscope Notification Setting',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          FlutterSwitch(
                            width: 44.0,
                            height: 18.0,
                            valueFontSize: 12.0,
                            toggleSize: 18.0,
                            value: status,
                            activeColor: themeProvider.tabColor!,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: themeProvider.tabColor,
                              value: isDaily,
                              onChanged: (bool? value) {
                                setState(() {
                                  isDaily = value!;
                                });
                              },
                            ),
                            const Text('Daily')
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: isMonthly,
                              onChanged: (bool? value) {
                                setState(() {
                                  isMonthly = value!;
                                });
                              },
                            ),
                            const Text('Monthly')
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: themeProvider.tabColor,
                              checkColor: Colors.white,
                              value: isYearly,
                              onChanged: (bool? value) {
                                setState(() {
                                  isYearly = value!;
                                });
                              },
                            ),
                            const Text('Yearly')
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text('Notification Time',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.tabColor,

                                  fontSize: 12)),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: themeProvider.corner!, //color of border
                                width: 1, //width of border
                              ),
                            ),
                            height: 30,
                            width: 220,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('   6 : 30 AM'),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.lock_clock, size: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: themeProvider.gradient2,
                  borderRadius: BorderRadius.circular(6)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Festivals Notification Setting',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Important Hindu Festivals',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                          FlutterSwitch(
                            width: 44.0,
                            height: 18.0,
                            valueFontSize: 12.0,
                            toggleSize: 18.0,
                            activeColor: themeProvider.tabColor!,
                            value: status,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Common Festivals',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                          FlutterSwitch(
                            width: 44.0,
                            height: 18.0,
                            valueFontSize: 12.0,
                            toggleSize: 18.0,
                            value: noStatus,
                            activeColor: themeProvider.tabColor!,
                            onToggle: (val) {
                              setState(() {
                                noStatus = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Public Holidays',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                          FlutterSwitch(
                            width: 44.0,
                            height: 18.0,
                            valueFontSize: 12.0,
                            toggleSize: 18.0,
                            value: status,
                            activeColor: themeProvider.tabColor!,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                               Text('Remind me before',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: themeProvider.tabColor,
                                      fontSize: 13)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: themeProvider.corner!, //color of border
                                      width: 1, //width of border
                                    ),
                                  ),
                                  height: 30,
                                  width: 55,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('  1'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Text('Days at',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: themeProvider.corner!, //color of border
                                    width: 1, //width of border
                                  ),
                                ),
                                height: 30,
                                width: 99,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('   6 : 30 AM'),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.lock_clock, size: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: themeProvider.gradient2,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16.0, left: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Birthday Notification Setting',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          FlutterSwitch(
                            width: 44.0,
                            height: 18.0,
                            valueFontSize: 12.0,
                            activeColor: themeProvider.tabColor!,
                            toggleSize: 18.0,
                            value: status,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                               Text('Remind me before',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: themeProvider.tabColor,
                                      fontSize: 13)),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: themeProvider.corner!, //color of border
                                      width: 1, //width of border
                                    ),
                                  ),
                                  height: 30,
                                  width: 55,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text('  7'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Text('Days at',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: themeProvider.corner!, //color of border
                                    width: 1, //width of border
                                  ),
                                ),
                                height: 30,
                                width: 99,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('   6 : 30 AM'),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.lock_clock, size: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    )
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
