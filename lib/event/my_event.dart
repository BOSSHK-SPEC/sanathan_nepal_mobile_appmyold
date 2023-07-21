import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';

import '../dashboard/eventProvider.dart';

class MyEvent extends StatefulWidget {
  const MyEvent({Key? key}) : super(key: key);

  @override
  State<MyEvent> createState() => _MyEventState();
}

class _MyEventState extends State<MyEvent> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final eventProvider = Provider.of<EventProvider>(context);

    return ListView(
      children: [
        const SizedBox(
          height: 22,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration:
                            BoxDecoration(color: themeProvider.tabColor),
                      ),
                    ),
                  ),
                  const Text(
                    'All',
                    style: TextStyle(fontSize: 11),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: themeProvider.reviewBackground2!
                                ),),
                      ),
                    ),
                  ),
                  const Text(
                    'Personal',
                    style: TextStyle(fontSize: 11),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: themeProvider.reviewBackground2!
                                ),),
                      ),
                    ),
                  ),
                  const Text(
                    'Official',
                    style: TextStyle(fontSize: 11),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: themeProvider.reviewBackground2!
                                ),),
                      ),
                    ),
                  ),
                  const Text(
                    'Birthday',
                    style: TextStyle(fontSize: 11),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: themeProvider.reviewBackground2!
                                ),),
                      ),
                    ),
                  ),
                  const Text(
                    'Anniversary',
                    style: TextStyle(fontSize: 11),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            border: Border.all(
                                 color: themeProvider.reviewBackground2!
                                ),),
                      ),
                    ),
                  ),
                  const Text(
                    'Travel',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: themeProvider.reviewBackground2!
                              ),),
                    ),
                  ),
                ),
                const Text(
                  '  Picnic',
                  style: TextStyle(fontSize: 11),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: themeProvider.reviewBackground2!
                              ),),
                    ),
                  ),
                ),
                const Text(
                  '  Adventure',
                  style: TextStyle(fontSize: 11),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: themeProvider.reviewBackground2!
                              ),),
                    ),
                  ),
                ),
                const Text(
                  '  Sports',
                  style: TextStyle(fontSize: 11),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                        color: themeProvider.reviewBackground2!
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4),
                    child: Row(
                      children: [
                        Icon(Icons.add,
                            color: themeProvider.tabColor, size: 12),
                        const Text(' New Event',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 33,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Container(
                height: 33,
                decoration: BoxDecoration(
                    color: themeProvider.bookAppointmentBackground),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('       My Event'),
                    Text('Date       ')
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: SizedBox(
                height: 100,
                width: 342,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Birthday',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider
                                        .bottomNavigationIconColor!),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 4.0, right: 4),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Birthday',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: themeProvider.bottomNavigationIconColor))),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '24Days',
                              style: TextStyle(
                                  color: themeProvider.tabColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            const Text(
                              ' Remaining',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text('My Birthday Celeberate with my Friends and Family at',style: TextStyle(fontSize: 9),),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text('Drishya Lounge.  ',style: TextStyle(fontSize: 9),),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: themeProvider.reviewBackground2!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(' Invite guests  ',style: TextStyle(fontSize: 9),),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: themeProvider.reviewBackground2!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(' Cake Order',style: TextStyle(fontSize: 9),)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: themeProvider.reviewBackground2!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '  Party Decoration',
                                        style: TextStyle(fontSize: 9),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: themeProvider.reviewBackground2!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '  Venue Fix',
                                        style: TextStyle(fontSize: 9),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                       Text(
                                        '  View More',
                                        style: TextStyle(fontSize: 10,color: themeProvider.bottomNavigationIconColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4,),
                                  Container(
                                    color: themeProvider.bookAppointmentBackground,
                                    height: 22,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Icon(Icons.alarm,size: 12),
                                        ),
                                        Text(' Remainder: 1 day before at 6:00 AM',style: TextStyle(fontSize: 9),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 80,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                                  '  नवमी चैत्र शुक्लपक्ष  ',
                                                  style: TextStyle(fontSize: 9),
                                                ))),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.edit_note_outlined,
                                          color: themeProvider.panchangBackground,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 33,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: const [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text('   Chaitra 20, 2079',
                                                  style:
                                                  TextStyle(fontSize: 9)),
                                              Text('    नवमी चैत्र शुक्लपक्ष',
                                                  style:
                                                  TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: themeProvider.bottomNavigationIconColor!,
                                              size: 22,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 4),
              child: SizedBox(
                height: 100,
                width: 342,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Anniversary',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider
                                        .bottomNavigationIconColor!),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 4.0, right: 4),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Anniversary',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: themeProvider.bottomNavigationIconColor))),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '24Days',
                              style: TextStyle(
                                  color: themeProvider.tabColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            const Text(
                              ' Remaining',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text('Celebrate at home with family Members Inviting Relative and Friends',style: TextStyle(fontSize: 9),),
                                  const SizedBox(
                                    height: 3,
                                  ),

                                  SizedBox(height: 4,),
                                  Container(
                                    color: themeProvider.bookAppointmentBackground,
                                    height: 22,
                                    width: 194,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.alarm,size: 12),
                                        ),
                                        Text(' Remainder: 1 day before at 6:00 AM',style: TextStyle(fontSize: 9),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 80,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                                  '  नवमी चैत्र शुक्लपक्ष  ',
                                                  style: TextStyle(fontSize: 9),
                                                ))),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.edit_note_outlined,
                                          color: themeProvider.panchangBackground,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 33,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: const [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text('   Chaitra 20, 2079',
                                                  style:
                                                  TextStyle(fontSize: 9)),
                                              Text('    नवमी चैत्र शुक्लपक्ष',
                                                  style:
                                                  TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: themeProvider.bottomNavigationIconColor!,
                                              size: 22,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    Divider(),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 4),
              child: SizedBox(
                height: 100,
                width: 342,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Office Meeting',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider
                                        .bottomNavigationIconColor!),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 4.0, right: 4),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Official',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: themeProvider.bottomNavigationIconColor))),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '8Days',
                              style: TextStyle(
                                  color: themeProvider.tabColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            const Text(
                              ' Remaining',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text('About Progress Report Needs to prepare report and Presentation. Need help from ABC',style: TextStyle(fontSize: 9),),
                                  const SizedBox(
                                    height: 3,
                                  ),

                                  SizedBox(height: 4,),
                                  Container(
                                    color: themeProvider.bookAppointmentBackground,
                                    height: 22,
                                    width: 194,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.alarm,size: 12),
                                        ),
                                        Text(' Remainder: 1 day before at 6:00 AM',style: TextStyle(fontSize: 9),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 80,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                                  '  नवमी चैत्र शुक्लपक्ष  ',
                                                  style: TextStyle(fontSize: 9),
                                                ))),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.edit_note_outlined,
                                          color: themeProvider.panchangBackground,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 33,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: const [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text('   Chaitra 20, 2079',
                                                  style:
                                                  TextStyle(fontSize: 9)),
                                              Text('    नवमी चैत्र शुक्लपक्ष',
                                                  style:
                                                  TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: themeProvider.bottomNavigationIconColor!,
                                              size: 22,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    Divider(),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 4),
              child: SizedBox(
                height: 100,
                width: 342,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Rafting at Sukute Beach',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider
                                        .bottomNavigationIconColor!),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 4.0, right: 4),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Personal',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: themeProvider.bottomNavigationIconColor))),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '4Days',
                              style: TextStyle(
                                  color: themeProvider.tabColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            const Text(
                              ' Remaining',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text('Rafting Plan with Friends during Nepali New Year at Sukute Beach....',style: TextStyle(fontSize: 9),),
                                  const SizedBox(
                                    height: 3,
                                  ),

                                  SizedBox(height: 4,),
                                  Container(
                                    color: themeProvider.bookAppointmentBackground,
                                    height: 22,
                                    width: 194,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.add_circle_outline,size: 12),
                                        ),
                                        Text(' No Reminder set for this event.',style: TextStyle(fontSize: 9),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 80,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                                  '  नवमी चैत्र शुक्लपक्ष  ',
                                                  style: TextStyle(fontSize: 9),
                                                ))),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.edit_note_outlined,
                                          color: themeProvider.panchangBackground,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 33,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: const [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text('   Chaitra 20, 2079',
                                                  style:
                                                  TextStyle(fontSize: 9)),
                                              Text('    नवमी चैत्र शुक्लपक्ष',
                                                  style:
                                                  TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: themeProvider.bottomNavigationIconColor!,
                                              size: 22,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    Divider(),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 4),
              child: SizedBox(
                height: 100,
                width: 342,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Rafting at Sukute Beach',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider
                                        .bottomNavigationIconColor!),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 4.0, right: 4),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Personal',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: themeProvider.bottomNavigationIconColor))),
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '4Days',
                              style: TextStyle(
                                  color: themeProvider.tabColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                            const Text(
                              ' Remaining',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text('Rafting Plan with Friends during Nepali New Year at Sukute Beach....',style: TextStyle(fontSize: 9),),
                                  const SizedBox(
                                    height: 3,
                                  ),

                                  SizedBox(height: 4,),
                                  Container(
                                    color: themeProvider.bookAppointmentBackground,
                                    height: 22,
                                    width: 194,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Icon(Icons.add_circle_outline,size: 12),
                                        ),
                                        Text(' No Reminder set for this event.',style: TextStyle(fontSize: 9),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 80,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                                  '  नवमी चैत्र शुक्लपक्ष  ',
                                                  style: TextStyle(fontSize: 9),
                                                ))),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.edit_note_outlined,
                                          color: themeProvider.panchangBackground,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 33,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: const [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text('   Chaitra 20, 2079',
                                                  style:
                                                  TextStyle(fontSize: 9)),
                                              Text('    नवमी चैत्र शुक्लपक्ष',
                                                  style:
                                                  TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: themeProvider.bottomNavigationIconColor!,
                                              size: 22,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    Divider(),

                  ],
                ),
              ),
            ),

            /*ListView.builder(
              shrinkWrap: true,
              itemCount:eventProvider.events.length, // Adjust the itemCount based on your needs
              itemBuilder: (BuildContext context, int index) {
                Event event = eventProvider.events[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 106,
                        width: 230,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                 Text(
                                 event.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  height: 18,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.deepOrangeAccent,
                                    ),
                                  ),
                                  child:  Padding(
                                    padding:
                                        EdgeInsets.only(left: 4.0, right: 4),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        event.title,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.deepOrangeAccent),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  event.remindBeforeValue,
                                  style: TextStyle(
                                      color: themeProvider.tabColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                const Text(
                                  ' Remaining',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                             Text(
                            event.desc,
                              style: TextStyle(fontSize: 11),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  event.location,
                                  style: TextStyle(fontSize: 11),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            //color: themeProvider.reviewBackground2!
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  '  Invite guests',
                                  style: TextStyle(fontSize: 11),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            //color: themeProvider.reviewBackground2!
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  '  Cake Order',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            //color: themeProvider.reviewBackground2!
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  '  Sports',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            //color: themeProvider.reviewBackground2!
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  '  Sports',
                                  style: TextStyle(fontSize: 12),
                                ),
                                const Text(
                                  'View more',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 26,
                              color: themeProvider.reviewBackground2,
                              child: Row(
                                children: [
                                  Image.asset(
                                      'assets/images/icon _alarm on_.png'),
                                   Text(
                                    ' Remainder:  ${event.remindBeforeValue}day before at ${event.remindAtValue} AM',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 106,
                        width: 114,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: themeProvider.panchangBackground,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    '  नवमी चैत्र शुक्लपक्ष  ',
                                    style: TextStyle(fontSize: 11),
                                  )),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.edit_note_outlined,
                                  color: themeProvider.panchangBackground,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 44,
                              child: Row(
                                children: [
                                  Column(
                                    children:  [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text('         Chaitra 20, 2079',
                                          style: TextStyle(fontSize: 10)),
                                      Text(event.eventDate,
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                  Icon(
                                    Icons.delete_outline,
                                    color:
                                        themeProvider.bottomNavigationIconColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),*/

            SizedBox(height: 22),
          ],
        ),
      ],
    );
  }
}
