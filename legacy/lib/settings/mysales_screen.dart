import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class MySaleScreen extends StatelessWidget {
  const MySaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: themeProvider.tabBackground2),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  height: 94,
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 4),
                            child: Text('New Order Received!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 11)),
                          ),
                          const Text('11 hours ago',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11)),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 6.0, top: 6),
                                child: Container(
                                    decoration: BoxDecoration(
                                      gradient: themeProvider.appointmentButtonColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.0,
                                          right: 4,
                                          top: 4,
                                          bottom: 4),
                                      child: Text(
                                        'Accept',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10.0, top: 6),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                            color: themeProvider.corner!)),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.0,
                                          right: 4,
                                          top: 4,
                                          bottom: 4),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Image.asset('assets/images/image 4.png'),
                        title: const Text('Iphone 14 Pro Max 245GB,5G',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Rs.8,000',
                                    style: TextStyle(
                                        color: themeProvider.tabColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12)),
                                const Padding(
                                  padding: EdgeInsets.only(left: 14.0),
                                  child: Text('S.P:Rs.10,000',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('From: Ram Bahadur',
                                    style: TextStyle(fontSize: 12)),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: themeProvider.appointmentButtonColor,
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0,
                                            right: 6,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.call, size: 12),
                                            Text('Call',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            gradient: themeProvider.appointmentButtonColor),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0,
                                              right: 4,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                  Icons
                                                      .messenger_outline_rounded,
                                                  size: 12),
                                              Text('Chat',
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 94,
                  decoration: BoxDecoration(
                      gradient: themeProvider.gradient2,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 4),
                            child: Text('Processing Order to Ram!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 11)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 0.0, top: 4),
                            child: Text('1 hours ago',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 11)),
                          ),
                          Row(
                            children:  [
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 6.0, top: 6),
                                child: Container(
                                    decoration: BoxDecoration(
                                      gradient: themeProvider.appointmentButtonColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.0,
                                          right: 4,
                                          top: 4,
                                          bottom: 4),
                                      child: Text(
                                        'Complete',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(right: 10.0, top: 6),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                            color: themeProvider.corner!)),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.0,
                                          right: 4,
                                          top: 4,
                                          bottom: 4),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Image.asset('assets/images/image 4.png'),
                        title: const Text('Iphone 14 Pro Max 245GB,5G',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children:  [
                                Text('Rs.8,000',
                                    style: TextStyle(
                                        color: themeProvider.tabColor,
                                        fontWeight: FontWeight.w500,fontSize: 12)),
                                const Padding(
                                  padding: EdgeInsets.only(left: 14.0),
                                  child: Text('S.P:Rs.10,000',
                                      style:
                                          TextStyle(fontWeight: FontWeight.w500,fontSize: 12)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('From: Ram Bahadur',style: TextStyle(fontSize: 12)),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: themeProvider.appointmentButtonColor,
                                          borderRadius:
                                          BorderRadius.circular(2)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6.0,
                                            right: 6,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.call, size: 12),
                                            Text('Call',
                                                style: TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(2),
                                            gradient: themeProvider.appointmentButtonColor),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0,
                                              right: 4,
                                              top: 5,
                                              bottom: 5),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                  Icons
                                                      .messenger_outline_rounded,
                                                  size: 12),
                                              Text('Chat',
                                                  style:
                                                  TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Container(
                height: 94,
                decoration: BoxDecoration(
                    gradient: themeProvider.gradient2,
                    borderRadius: BorderRadius.circular(4)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 4),
                          child: Text('Sold to Ram!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 11)),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 0.0, top: 4),
                          child: Text('15 min ago',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,right: 12),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 4.0,
                                    right: 4,
                                    top: 4,
                                    bottom: 4),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 4.0,right: 4),
                                  child: Text(
                                    'Sold',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Image.asset('assets/images/image 4.png'),
                      ),
                      title: const Text('Iphone 14 Pro Max 245GB,5G',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text('Rs.8,000',
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.w500,fontSize: 12)),
                              Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text('S.P:Rs.10,000',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500,fontSize: 12)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('From: Ram Bahadur',style: TextStyle(fontSize: 12)),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: themeProvider.appointmentButtonColor,
                                        borderRadius:
                                        BorderRadius.circular(2)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6.0,
                                          right: 6,
                                          top: 5,
                                          bottom: 5),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.call, size: 12),
                                          Text('Call',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(2),
                                          gradient: themeProvider.appointmentButtonColor),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4.0,
                                            right: 4,
                                            top: 5,
                                            bottom: 5),
                                        child: Row(
                                          children: const [
                                            Icon(
                                                Icons
                                                    .messenger_outline_rounded,
                                                size: 12),
                                            Text('Chat',
                                                style:
                                                TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
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
