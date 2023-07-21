import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanathan_nepal_mobile_app/event/festival_details_screen.dart';
import 'package:sanathan_nepal_mobile_app/theme/style.dart';
import 'package:sanathan_nepal_mobile_app/theme/theme_provider.dart';
import 'package:sanathan_nepal_mobile_app/view/widgets/boarderdButton.dart';

class FestivalTabView extends StatefulWidget {
  const FestivalTabView({super.key});

  @override
  State<FestivalTabView> createState() => _FestivalTabViewState();
}

class _FestivalTabViewState extends State<FestivalTabView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ListView(
      children: [
        const SizedBox(height: 22,),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8),
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
                        decoration: BoxDecoration(
                          color: themeProvider.tabColor
                        ),
                      ),
                    ),
                  ),
                  const Text('All',style: TextStyle(fontSize: 11),),
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
                          )
                        ),
                      ),
                    ),
                  ),
                  const Text('Important',style: TextStyle(fontSize: 11),),
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
                            )
                        ),
                      ),
                    ),
                  ),
                  const Text('Government Holidays',style: TextStyle(fontSize: 11),),
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
                            )
                        ),
                      ),
                    ),
                  ),
                  const Text('Hindu',style: TextStyle(fontSize: 11),),
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
                            )
                        ),
                      ),
                    ),
                  ),
                  const Text('Buddhism',style: TextStyle(fontSize: 11),),
                ],
              ),
            ),
            const SizedBox(height: 12,),
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
                          )
                      ),
                    ),
                  ),
                ),
                const Text('  Islam',style: TextStyle(fontSize: 11),),
                const SizedBox(width: 8,),
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
                          )
                      ),
                    ),
                  ),
                ),
                const Text('  Kirat',style: TextStyle(fontSize: 11),),
                const SizedBox(width: 8,),

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
                          )
                      ),
                    ),
                  ),
                ),
                const Text('  Christianity',style: TextStyle(fontSize: 11),),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const FestivalsDetailsScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Image.asset('assets/images/Rectangle 2195.png',
                        width: 48, height: 48),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(' Ram Navami',
                                style: TextStyles.smallBody()),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: BorderedButton(
                                onPressed: () {
                                  // Handle button press
                                },
                                borderColor:
                                    Colors.red, // Pass the desired border color
                                textColor:
                                    Colors.red, // Pass the desired text color
                                width: 54, // Pass the desired width
                                height: 14,
                                text: 'Public holiday',
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            BorderedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              borderColor:
                                  Colors.green, // Pass the desired border color
                              textColor:
                                  Colors.green, // Pass the desired text color
                              width: 54, // Pass the desired width
                              height: 14,
                              text: ' Public Holiday ',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            BorderedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              borderColor:
                                  Colors.yellow, // Pass the desired border color
                              textColor:
                                  Colors.yellow, // Pass the desired text color
                              width: 33, // Pass the desired width
                              height: 14,
                              text: 'Others',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 180,
                              child: Text(
                                ' चैत १६, २०७९, बिहीवार - 30 Mar, 2023, Thu',
                                style: TextStyle(fontSize: 9),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 4),
                              child: Container(
                                height: 17, // Adjust the height as needed
                                width: 60,
                                decoration: const BoxDecoration(
                                    color: Colors.grey,), // Adjust the width as needed
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start, // Adjust the alignment as needed
                                  children: const [
                                    Text('            Add \n   Event/Reminder',style: TextStyle(fontSize: 6)),
                                    Icon(Icons.event,size: 11,)

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: themeProvider.gradient2,
                      ),
                      width: 52,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '20',
                            style: TextStyles.body(
                                color: themeProvider.tabColor,
                                fontweight: FontWeight.w500),
                          ),
                          Text(
                            'Days',
                            style: TextStyles.smallBody2(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8,
          ),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Image.asset('assets/images/Rectangle 2195.png',
                      width: 48, height: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(' रामनवमी', style: TextStyles.smallBody()),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: BorderedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              borderColor:
                                  Colors.red, // Pass the desired border color
                              textColor:
                                  Colors.red, // Pass the desired text color
                              width: 54, // Pass the desired width
                              height: 15,
                              text: 'Public holiday',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BorderedButton(
                            onPressed: () {
                              // Handle button press
                            },
                            borderColor:
                                Colors.green, // Pass the desired border color
                            textColor:
                                Colors.green, // Pass the desired text color
                            width: 54, // Pass the desired width
                            height: 15,
                            text: 'Public Holiday',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 180,
                            child: Text(
                              ' चैत १६, २०७९, बिहीवार - 30 Mar, 2023, Thu',
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 4),
                            child: Container(
                              height: 17, // Adjust the height as needed
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.grey,), // Adjust the width as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Adjust the alignment as needed
                                children: const [
                                  Text('            Add \n   Event/Reminder',style: TextStyle(fontSize: 6)),
                                  Icon(Icons.event,size: 11,)

                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2,
                    ),
                    width: 52,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '27',
                          style: TextStyles.body(
                              color: themeProvider.tabColor,
                              fontweight: FontWeight.w500),
                        ),
                        Text(
                          'Days',
                          style: TextStyles.smallBody2(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8,
          ),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Image.asset('assets/images/Rectangle 2195@2x.png',
                      width: 48, height: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(' लोकतन्त्र दिवस',
                              style: TextStyles.smallBody()),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: BorderedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              borderColor:
                                  Colors.red, // Pass the desired border color
                              textColor:
                                  Colors.red, // Pass the desired text color
                              width: 54, // Pass the desired width
                              height: 15,
                              text: 'Public holiday',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BorderedButton(
                            onPressed: () {
                              // Handle button press
                            },
                            borderColor:
                                Colors.green, // Pass the desired border color
                            textColor:
                                Colors.green, // Pass the desired text color
                            width: 54, // Pass the desired width
                            height: 15,
                            text: 'Public Holiday',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 180,
                            child: Text(
                              ' चवैशाख ११, २०८०, सोमवार - 24 April, 2023, Mon  ',
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 4),
                            child: Container(
                              height: 17, // Adjust the height as needed
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.grey,), // Adjust the width as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Adjust the alignment as needed
                                children: const [
                                  Text('            Add \n   Event/Reminder',style: TextStyle(fontSize: 6)),
                                  Icon(Icons.event,size: 11,)

                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2,
                    ),
                    width: 52,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '35',
                          style: TextStyles.body(
                              color: themeProvider.tabColor,
                              fontweight: FontWeight.w500),
                        ),
                        Text(
                          'Days',
                          style: TextStyles.smallBody2(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8,
          ),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Image.asset('assets/images/Rectangle 2195.png',
                      width: 48, height: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(' रामनवमी', style: TextStyles.smallBody()),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: BorderedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              borderColor:
                                  Colors.red, // Pass the desired border color
                              textColor:
                                  Colors.red, // Pass the desired text color
                              width: 54, // Pass the desired width
                              height: 15,
                              text: 'Public holiday',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BorderedButton(
                            onPressed: () {
                              // Handle button press
                            },
                            borderColor:
                                Colors.green, // Pass the desired border color
                            textColor:
                                Colors.green, // Pass the desired text color
                            width: 54, // Pass the desired width
                            height: 15,
                            text: 'Public Holiday',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 180,
                            child: Text(
                              ' चैत १६, २०७९, बिहीवार - 30 Mar, 2023, Thu',
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 4),
                            child: Container(
                              height: 17, // Adjust the height as needed
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.grey,), // Adjust the width as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Adjust the alignment as needed
                                children: const [
                                  Text('            Add \n   Event/Reminder',style: TextStyle(fontSize: 6)),
                                  Icon(Icons.event,size: 11,)

                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2,
                    ),
                    width: 52,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '41',
                          style: TextStyles.body(
                              color: themeProvider.tabColor,
                              fontweight: FontWeight.w500),
                        ),
                        Text(
                          'Days',
                          style: TextStyles.smallBody2(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8,
          ),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Image.asset('assets/images/Rectangle 2195@2x.png',
                      width: 48, height: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(' लोकतन्त्र दिवस',
                              style: TextStyles.smallBody()),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: BorderedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              borderColor:
                                  Colors.red, // Pass the desired border color
                              textColor:
                                  Colors.red, // Pass the desired text color
                              width: 54, // Pass the desired width
                              height: 15,
                              text: 'Public holiday',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BorderedButton(
                            onPressed: () {
                              // Handle button press
                            },
                            borderColor:
                                Colors.green, // Pass the desired border color
                            textColor:
                                Colors.green, // Pass the desired text color
                            width: 54, // Pass the desired width
                            height: 15,
                            text: 'Public Holiday',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 180,
                            child: Text(
                              ' चवैशाख ११, २०८०, सोमवार - 24 April, 2023, Mon  ',
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 4),
                            child: Container(
                              height: 17, // Adjust the height as needed
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.grey,), // Adjust the width as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Adjust the alignment as needed
                                children: const [
                                  Text('            Add \n   Event/Reminder',style: TextStyle(fontSize: 6)),
                                  Icon(Icons.event,size: 11,)

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2,
                    ),
                    width: 52,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '45',
                          style: TextStyles.body(
                              color: themeProvider.tabColor,
                              fontweight: FontWeight.w500),
                        ),
                        Text(
                          'Days',
                          style: TextStyles.smallBody2(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8,
          ),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Image.asset('assets/images/Rectangle 2195.png',
                      width: 48, height: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(' रामनवमी', style: TextStyles.smallBody()),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: BorderedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              borderColor:
                                  Colors.red, // Pass the desired border color
                              textColor:
                                  Colors.red, // Pass the desired text color
                              width: 54, // Pass the desired width
                              height: 15,
                              text: 'Public holiday',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BorderedButton(
                            onPressed: () {
                              // Handle button press
                            },
                            borderColor:
                                Colors.green, // Pass the desired border color
                            textColor:
                                Colors.green, // Pass the desired text color
                            width: 54, // Pass the desired width
                            height: 15,
                            text: 'Public Holiday',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 180,
                            child: Text(
                              ' चैत १६, २०७९, बिहीवार - 30 Mar, 2023, Thu',
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 4),
                            child: Container(
                              height: 17, // Adjust the height as needed
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.grey,), // Adjust the width as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Adjust the alignment as needed
                                children: const [
                                  Text('            Add \n   Event/Reminder',style: TextStyle(fontSize: 6)),
                                  Icon(Icons.event,size: 11,)

                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2,
                    ),
                    width: 52,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '50',
                          style: TextStyles.body(
                              color: themeProvider.tabColor,
                              fontweight: FontWeight.w500),
                        ),
                        Text(
                          'Days',
                          style: TextStyles.smallBody2(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8,
          ),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Image.asset('assets/images/Rectangle 2195@2x.png',
                      width: 48, height: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(' लोकतन्त्र दिवस',
                              style: TextStyles.smallBody()),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: BorderedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              borderColor:
                                  Colors.red, // Pass the desired border color
                              textColor:
                                  Colors.red, // Pass the desired text color
                              width: 54, // Pass the desired width
                              height: 15,
                              text: 'Public holiday',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BorderedButton(
                            onPressed: () {
                              // Handle button press
                            },
                            borderColor:
                                Colors.green, // Pass the desired border color
                            textColor:
                                Colors.green, // Pass the desired text color
                            width: 54, // Pass the desired width
                            height: 15,
                            text: 'Public Holiday',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 180,
                            child: Text(
                              ' चवैशाख ११, २०८०, सोमवार - 24 April, 2023, Mon',
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 4),
                            child: Container(
                              height: 17, // Adjust the height as needed
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.grey,), // Adjust the width as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Adjust the alignment as needed
                                children: const [
                                  Text('            Add \n   Event/Reminder',style: TextStyle(fontSize: 6)),
                                  Icon(Icons.event,size: 11,)

                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2,
                    ),
                    width: 52,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '111',
                          style: TextStyles.body(
                              color: themeProvider.tabColor,
                              fontweight: FontWeight.w500),
                        ),
                        Text(
                          'Days',
                          style: TextStyles.smallBody2(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8,
          ),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Image.asset('assets/images/Rectangle 2195.png',
                      width: 48, height: 48),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(' रामनवमी', style: TextStyles.smallBody()),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: BorderedButton(
                              onPressed: () {
                                // Handle button press
                              },
                              borderColor:
                                  Colors.red, // Pass the desired border color
                              textColor:
                                  Colors.red, // Pass the desired text color
                              width: 54, // Pass the desired width
                              height: 15,
                              text: 'Public holiday',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          BorderedButton(
                            onPressed: () {
                              // Handle button press
                            },
                            borderColor:
                                Colors.green, // Pass the desired border color
                            textColor:
                                Colors.green, // Pass the desired text color
                            width: 54, // Pass the desired width
                            height: 15,
                            text: 'Public Holiday',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 180,
                            child: Text(
                              ' चैत १६, २०७९, बिहीवार - 30 Mar, 2023, Thu',
                              style: TextStyle(fontSize: 9),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 4),
                            child: Container(
                              height: 17, // Adjust the height as needed
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Colors.grey,), // Adjust the width as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Adjust the alignment as needed
                                children: const [
                                  Text('            Add \n   Event/Reminder',style: TextStyle(fontSize: 6)),
                                  Icon(Icons.event,size: 11,)

                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: themeProvider.gradient2,
                    ),
                    width: 52,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '364',
                          style: TextStyles.body(
                              color: themeProvider.tabColor,
                              fontweight: FontWeight.w500),
                        ),
                        Text(
                          'Days',
                          style: TextStyles.smallBody2(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        )
      ],
    );
  }
}
