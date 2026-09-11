import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                                color: themeProvider.reviewBackground2!,
                            ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Medicine Time',
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
                                color: themeProvider.reviewBackground2!,
                            ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'House Rent',
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
                                color: themeProvider.reviewBackground2!,
                            ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Electricity Bill',
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
                                color: themeProvider.reviewBackground2!,
                            ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Gas',
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
                              color: themeProvider.reviewBackground2!,
                          ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  '  Bluebook Renew',
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
                              color: themeProvider.reviewBackground2!,
                          ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  '  Vehical Servicing',
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
                            color: themeProvider.reviewBackground2!,
                          ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  '  Interest',
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
                      color: themeProvider.reviewBackground2!,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4),
                    child: Row(
                      children: [
                        Icon(Icons.add,
                            color: themeProvider.tabColor, size: 12),
                        const Text(' New Reminder',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                ),
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
                    Text('       To-Do List'),
                    Text('Date       ')
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: SizedBox(
                height: 88,
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
                              child: const Padding(
                                padding: EdgeInsets.only(left: 4.0, right: 4),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Birthday',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.red))),
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
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Cake Order',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
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
                                        style: TextStyle(fontSize: 10),
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
                                        style: TextStyle(fontSize: 10),
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 9),
                                      ),
                                    ],
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
                                            height: 18,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                              '  नवमी चैत्र शुक्लपक्ष  ',
                                              style: TextStyle(fontSize: 10),
                                            ))),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.edit_note_outlined,
                                          color:themeProvider.panchangBackground,
                                          
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
                                              Text('   March 29, 2023',
                                                  style:
                                                      TextStyle(fontSize: 9)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: themeProvider.bottomNavigationIconColor,
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
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: SizedBox(
                height: 88,
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
                                            color: themeProvider
                                                .bottomNavigationIconColor))),
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
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Cake Order',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
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
                                        style: TextStyle(fontSize: 10),
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
                                                )),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
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
                                            height: 18,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                              '  March 29, 2023  ',
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
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: SizedBox(
                height: 88,
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
                                            color: themeProvider
                                                .bottomNavigationIconColor))),
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
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Cake Order',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
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
                                        style: TextStyle(fontSize: 10),
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
                                                )),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
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
                                            height: 18,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                                  '  March 29, 2023  ',
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
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: SizedBox(
                height: 88,
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
                                            color: themeProvider
                                                .bottomNavigationIconColor))),
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
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Cake Order',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
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
                                        style: TextStyle(fontSize: 10),
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
                                                )),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
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
                                            height: 18,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                                  '  March 29, 2023  ',
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
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
              child: SizedBox(
                height: 88,
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
                                            color: themeProvider
                                                .bottomNavigationIconColor))),
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
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 233,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Cake Order',
                                        style: TextStyle(fontSize: 10),
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
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
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
                                        style: TextStyle(fontSize: 10),
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
                                                )),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '  Invite guests',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
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
                                            height: 18,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(4),
                                                color: themeProvider
                                                    .panchangBackground),
                                            child: const Center(
                                                child: Text(
                                                  '  March 29, 2023  ',
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
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16),
              child: Divider(),
            ),
          ],
        ),
      ],
    );
  }
}
